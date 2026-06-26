"""Deepgram Voice Agent WebSocket proxy.

The Flutter client connects to /v1/voice/agent without a Deepgram API key. This
module opens the upstream agent socket with server-side credentials, injects
Settings from environment config, and relays JSON events and binary audio both
ways.
"""

import asyncio
import json
import logging
from typing import Any

import websockets
from fastapi import WebSocket, WebSocketDisconnect
from starlette.websockets import WebSocketState

from .config import settings

logger = logging.getLogger(__name__)

DEEPGRAM_AGENT_URL = "wss://agent.deepgram.com/v1/agent/converse"

DEFAULT_DISPATCHER_PROMPT = """You are an emergency dispatcher assistant for SOS Emergency.
Stay calm, speak in short clear sentences, and gather: location, nature of the emergency,
number of people involved, immediate dangers, and whether emergency services are needed.
Do not provide medical diagnoses. Prioritize safety and urge the user to call local
emergency services when appropriate."""


def build_agent_settings() -> dict[str, Any]:
    prompt = settings.voice_dispatcher_prompt.strip() or DEFAULT_DISPATCHER_PROMPT
    return {
        "type": "Settings",
        "audio": {
            "input": {
                "encoding": "linear16",
                "sample_rate": settings.voice_input_sample_rate,
            },
            "output": {
                "encoding": "linear16",
                "sample_rate": settings.voice_output_sample_rate,
                "container": "none",
            },
        },
        "agent": {
            "language": settings.voice_language,
            "listen": {
                "provider": {
                    "type": "deepgram",
                    "model": settings.voice_listen_model,
                }
            },
            "think": {
                "provider": {
                    "type": "open_ai",
                    "model": settings.voice_think_model,
                    "temperature": settings.voice_think_temperature,
                },
                "prompt": prompt,
            },
            "speak": {
                "provider": {
                    "type": "deepgram",
                    "model": settings.voice_speak_model,
                }
            },
            "greeting": settings.voice_greeting,
        },
    }


async def _relay_upstream(
    upstream: websockets.ClientConnection,
    client_ws: WebSocket,
    *,
    settings_sent: asyncio.Event,
) -> None:
    async for message in upstream:
        if isinstance(message, bytes):
            await client_ws.send_bytes(message)
            continue

        await client_ws.send_text(message)
        try:
            payload = json.loads(message)
        except json.JSONDecodeError:
            continue

        if payload.get("type") == "Welcome" and not settings_sent.is_set():
            await upstream.send(json.dumps(build_agent_settings()))
            settings_sent.set()


async def _relay_client(
    upstream: websockets.ClientConnection,
    client_ws: WebSocket,
) -> None:
    while client_ws.client_state == WebSocketState.CONNECTED:
        message = await client_ws.receive()
        if message["type"] == "websocket.disconnect":
            break

        data = message.get("bytes")
        if data is not None:
            await upstream.send(data)
            continue

        text = message.get("text")
        if not text:
            continue

        # Server owns agent Settings so the Deepgram key never reaches the client.
        try:
            payload = json.loads(text)
        except json.JSONDecodeError:
            await upstream.send(text)
            continue

        if payload.get("type") == "Settings":
            continue

        await upstream.send(text)


async def proxy_voice_session(client_ws: WebSocket) -> None:
    if not settings.deepgram_api_key:
        await client_ws.accept()
        await client_ws.send_json(
            {
                "type": "Error",
                "description": "DEEPGRAM_API_KEY is not configured on the server.",
                "code": "VOICE_NOT_CONFIGURED",
            }
        )
        await client_ws.close(code=1011)
        return

    headers = {"Authorization": f"Token {settings.deepgram_api_key}"}
    try:
        upstream = await websockets.connect(
            DEEPGRAM_AGENT_URL,
            additional_headers=headers,
            open_timeout=15,
            max_size=None,
        )
    except Exception as error:
        logger.exception("Deepgram voice agent connection failed")
        await client_ws.accept()
        await client_ws.send_json(
            {
                "type": "Error",
                "description": f"Failed to connect to voice provider: {error}",
                "code": "UPSTREAM_CONNECT_FAILED",
            }
        )
        await client_ws.close(code=1011)
        return

    await client_ws.accept()
    settings_sent = asyncio.Event()

    try:
        await asyncio.gather(
            _relay_upstream(upstream, client_ws, settings_sent=settings_sent),
            _relay_client(upstream, client_ws),
        )
    except WebSocketDisconnect:
        pass
    except websockets.ConnectionClosed:
        pass
    finally:
        await upstream.close()
        if client_ws.client_state == WebSocketState.CONNECTED:
            await client_ws.close()