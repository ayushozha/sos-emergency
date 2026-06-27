"""Async wrapper around one OpenAI Realtime API (gpt-realtime-2) WebSocket session.

OpenAI manages the full speech-to-speech loop over
``wss://api.openai.com/v1/realtime``. This module opens the socket, configures
the session (instructions, tools, audio formats), pumps mic audio up, and
forwards agent events to a single callback using the same pseudo-event shapes
that ``voice_protocol`` already expects from the legacy Deepgram bridge.
"""

from __future__ import annotations

import asyncio
import base64
import contextlib
import json
import logging
from collections.abc import Awaitable, Callable
from types import SimpleNamespace
from typing import Any

import websockets
from websockets.asyncio.client import ClientConnection

from .config import settings
from .voice_prompt import (
    DISPATCHER_PROMPT,
    RENDER_FUNCTION_NAME,
    render_function_definition,
)

logger = logging.getLogger("sos.openai_realtime")

EventCallback = Callable[[Any], Awaitable[None] | None]

_REALTIME_URL = "wss://api.openai.com/v1/realtime"


def _function_tool() -> dict[str, Any]:
    definition = render_function_definition()
    return {
        "type": "function",
        "name": definition["name"],
        "description": definition["description"],
        "parameters": definition["parameters"],
    }


def _session_update_event(*, instructions: str) -> dict[str, Any]:
    return {
        "type": "session.update",
        "session": {
            "type": "realtime",
            "model": settings.voice_realtime_model,
            "instructions": instructions,
            "output_modalities": ["audio"],
            "audio": {
                "input": {
                    "format": {
                        "type": "audio/pcm",
                        "rate": settings.voice_input_sample_rate,
                    },
                    "turn_detection": {"type": "semantic_vad"},
                },
                "output": {
                    "format": {"type": "audio/pcm", "rate": settings.voice_output_sample_rate},
                    "voice": settings.voice_realtime_voice,
                },
            },
            "tools": [_function_tool()],
            "tool_choice": "auto",
        },
    }


class OpenAIRealtimeSession:
    """One live OpenAI Realtime connection, used as an async context manager."""

    def __init__(
        self,
        *,
        on_event: EventCallback,
        dispatcher_prompt: str | None = None,
    ) -> None:
        self._on_event = on_event
        self._dispatcher_prompt = (
            dispatcher_prompt or settings.voice_dispatcher_prompt or DISPATCHER_PROMPT
        )
        self._ws: ClientConnection | None = None
        self._listen_task: asyncio.Task[None] | None = None
        self._send_lock = asyncio.Lock()
        self._response_active = False
        self._session_configured = False

    async def __aenter__(self) -> OpenAIRealtimeSession:
        if not settings.openai_api_key:
            raise RuntimeError("OPENAI_API_KEY is not configured.")
        url = f"{_REALTIME_URL}?model={settings.voice_realtime_model}"
        self._ws = await websockets.connect(
            url,
            additional_headers={"Authorization": f"Bearer {settings.openai_api_key}"},
            open_timeout=30,
        )
        self._listen_task = asyncio.create_task(self._listen_loop())
        return self

    async def __aexit__(self, *exc: object) -> None:
        await self.close()

    async def _send(self, event: dict[str, Any]) -> None:
        if self._ws is None:
            return
        async with self._send_lock:
            await self._ws.send(json.dumps(event, separators=(",", ":")))

    async def configure(self) -> None:
        """Send session.update and trigger the opening greeting."""
        if self._session_configured:
            return
        self._session_configured = True
        greeting = settings.voice_greeting.strip()
        instructions = self._dispatcher_prompt
        if greeting:
            instructions = (
                f"{instructions}\n\nWhen the session begins, greet the caller by "
                f"saying exactly: \"{greeting}\""
            )
        await self._send(_session_update_event(instructions=instructions))
        self._response_active = True
        await self._send({"type": "response.create"})

    async def send_audio(self, chunk: bytes) -> None:
        if not chunk:
            return
        await self._send(
            {
                "type": "input_audio_buffer.append",
                "audio": base64.b64encode(chunk).decode("ascii"),
            }
        )

    async def send_inject_user_message(self, content: str) -> None:
        await self._send(
            {
                "type": "conversation.item.create",
                "item": {
                    "type": "message",
                    "role": "user",
                    "content": [{"type": "input_text", "text": content}],
                },
            }
        )
        if not self._response_active:
            await self._send({"type": "response.create"})

    async def send_function_call_response(
        self, *, call_id: str, name: str, content: str
    ) -> None:
        await self._send(
            {
                "type": "conversation.item.create",
                "item": {
                    "type": "function_call_output",
                    "call_id": call_id,
                    "output": content,
                },
            }
        )
        if not self._response_active:
            self._response_active = True
            await self._send({"type": "response.create"})

    async def _listen_loop(self) -> None:
        assert self._ws is not None
        try:
            async for raw in self._ws:
                try:
                    event = json.loads(raw)
                except json.JSONDecodeError:
                    logger.warning("non-json realtime frame: %s", raw[:200])
                    continue
                await self._dispatch(event)
        except asyncio.CancelledError:
            raise
        except Exception as error:
            logger.exception("openai realtime listen loop failed")
            await self._emit(
                SimpleNamespace(
                    type="Error",
                    description=str(error),
                )
            )

    async def _dispatch(self, event: dict[str, Any]) -> None:
        event_type = event.get("type", "")

        if event_type == "session.created":
            await self.configure()
            return

        if event_type in {"response.audio.delta", "response.output_audio.delta"}:
            delta = event.get("delta") or ""
            if delta:
                await self._emit(base64.b64decode(delta))
            return

        if event_type in {
            "response.output_audio_transcript.done",
            "response.audio_transcript.done",
        }:
            text = (event.get("transcript") or "").strip()
            if text:
                await self._emit(
                    SimpleNamespace(
                        type="ConversationText",
                        role="agent",
                        content=text,
                    )
                )
            return

        if event_type == "conversation.item.input_audio_transcription.completed":
            text = (event.get("transcript") or "").strip()
            if text:
                await self._emit(
                    SimpleNamespace(
                        type="ConversationText",
                        role="user",
                        content=text,
                    )
                )
            return

        if event_type == "response.function_call_arguments.done":
            name = event.get("name") or ""
            if name == RENDER_FUNCTION_NAME:
                await self._emit(
                    SimpleNamespace(
                        type="FunctionCallRequest",
                        functions=[
                            SimpleNamespace(
                                id=event.get("call_id") or event.get("item_id") or "",
                                name=name,
                                arguments=event.get("arguments") or "{}",
                            )
                        ],
                    )
                )
            return

        if event_type == "input_audio_buffer.speech_started":
            await self._emit(SimpleNamespace(type="UserStartedSpeaking"))
            return

        if event_type == "input_audio_buffer.speech_stopped":
            await self._emit(SimpleNamespace(type="AgentThinking"))
            return

        if event_type == "response.created":
            self._response_active = True
            await self._emit(SimpleNamespace(type="AgentThinking"))
            return

        if event_type in {"response.done", "response.cancelled", "response.failed"}:
            self._response_active = False
            return

        if event_type == "response.output_audio.started":
            await self._emit(SimpleNamespace(type="AgentStartedSpeaking"))
            return

        if event_type == "error":
            err = event.get("error") or {}
            message = err.get("message") or event.get("message") or json.dumps(event)
            await self._emit(SimpleNamespace(type="Error", description=message))

    async def _emit(self, payload: Any) -> None:
        result = self._on_event(payload)
        if asyncio.iscoroutine(result):
            await result

    async def close(self) -> None:
        if self._listen_task is not None and not self._listen_task.done():
            self._listen_task.cancel()
            with contextlib.suppress(asyncio.CancelledError, Exception):
                await self._listen_task
        if self._ws is not None:
            with contextlib.suppress(Exception):
                await self._ws.close()
        self._ws = None
        self._listen_task = None