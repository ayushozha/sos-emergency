"""PDF voice WebSocket frame protocol over Deepgram Voice Agent."""

from __future__ import annotations

import asyncio
import base64
import contextlib
import json
import logging
import re
from collections.abc import Awaitable, Callable
from typing import Any
from uuid import UUID, uuid4

import httpx
from fastapi import WebSocket, WebSocketDisconnect

from .api_models import (
    Classification,
    ComposeContext,
    ComposeRequest,
    VoiceAudioChunkIn,
    VoiceAudioChunkOut,
    VoiceControlIn,
    VoiceError,
    VoiceEvent,
    VoiceIntent,
    VoiceSessionClosed,
    VoiceSessionConfig,
    VoiceSessionEnd,
    VoiceSessionReady,
    VoiceSessionStart,
    VoiceTextIn,
    VoiceTranscript,
)
from .compose_service import build_compose_prompt, parse_surface
from .config import settings
from .deepgram_agent import DeepgramAgentSession
from .featherless import stream_deltas
from .schemas import ChatRequest, Message
from .voice_prompt import RENDER_FUNCTION_NAME

logger = logging.getLogger("sos.voice")

SendJson = Callable[[dict[str, Any]], Awaitable[None]]

_INTENT_PATTERNS: list[tuple[str, re.Pattern[str]]] = [
    ("crash", re.compile(r"\b(crash|accident|collision|hit)\b", re.I)),
    ("medical", re.compile(r"\b(heart|medical|pain|chest|breathe)\b", re.I)),
    ("beingFollowed", re.compile(r"\b(follow|stalk|threat|road rage)\b", re.I)),
    ("carProblem", re.compile(r"\b(tire|smoke|engine|overheat|broken)\b", re.I)),
    ("lockedOut", re.compile(r"\b(lock|locked out|keys)\b", re.I)),
    ("outOfGas", re.compile(r"\b(gas|fuel|charge|ev|empty)\b", re.I)),
]

_EVENT_MAP = {
    "UserStartedSpeaking": "vad_start",
    "AgentThinking": "thinking",
    "AgentStartedSpeaking": "vad_stop",
}


def _infer_intent(text: str) -> VoiceIntent | None:
    for name, pattern in _INTENT_PATTERNS:
        if pattern.search(text):
            slots: dict[str, Any] = {}
            if "smoke" in text.lower():
                slots["hazard"] = "smoke"
            return VoiceIntent(intent=name, confidence=0.85, slots=slots)
    return None


def _parse_client_frame(raw: dict[str, Any]) -> Any:
    frame_type = raw.get("type")
    if frame_type == "session.start":
        return VoiceSessionStart.model_validate(raw)
    if frame_type == "audio.chunk":
        return VoiceAudioChunkIn.model_validate(raw)
    if frame_type == "audio.commit":
        return raw
    if frame_type == "text":
        return VoiceTextIn.model_validate(raw)
    if frame_type == "control":
        return VoiceControlIn.model_validate(raw)
    if frame_type == "session.end":
        return VoiceSessionEnd.model_validate(raw)
    raise ValueError(f"Unknown client frame type: {frame_type!r}")


async def handle_voice_session(
    ws: WebSocket,
    client: httpx.AsyncClient,
    *,
    on_session_start: Callable[[], None] | None = None,
    on_session_end: Callable[[], None] | None = None,
) -> None:
    await ws.accept()
    send_lock = asyncio.Lock()
    audio_out_seq = 0

    async def send_json(obj: dict[str, Any]) -> None:
        async with send_lock:
            await ws.send_text(json.dumps(obj, separators=(",", ":")))

    if not settings.deepgram_api_key or not settings.featherless_api_key:
        await send_json(
            VoiceError(
                code="unauthorized",
                message="Voice backend keys are not configured.",
                fatal=True,
            ).model_dump()
        )
        await ws.close()
        return

    session_id = uuid4()
    config: VoiceSessionConfig | None = None
    session: DeepgramAgentSession | None = None
    render_tasks: set[asyncio.Task[None]] = set()
    system_prompt = ""

    async def send_audio_b64(chunk: bytes) -> None:
        nonlocal audio_out_seq
        if not chunk:
            return
        await send_json(
            VoiceAudioChunkOut(
                seq=audio_out_seq,
                audio=base64.b64encode(chunk).decode("ascii"),
            ).model_dump()
        )
        audio_out_seq += 1

    async def render_ui(call: Any) -> None:
        try:
            args = json.loads(call.arguments) if call.arguments else {}
        except json.JSONDecodeError:
            args = {}
        situation = args.get("situation", "")
        try:
            chat = ChatRequest(
                system=system_prompt,
                messages=[
                    Message(
                        role="user",
                        text=situation or "Show emergency guidance.",
                    )
                ],
            )
            raw = ""
            async for delta in stream_deltas(chat, client):
                raw += delta
            surface = parse_surface(raw) if raw.strip() else None
            status = '{"status":"shown"}' if surface else '{"status":"error"}'
            if surface is not None:
                await send_json(
                    {
                        "type": "compose",
                        "surface": surface.model_dump(),
                    }
                )
        except Exception:
            logger.exception("voice render failed")
            status = '{"status":"error"}'
        finally:
            if session is not None:
                with contextlib.suppress(Exception):
                    await session.send_function_call_response(
                        call_id=call.id, name=call.name, content=status
                    )

    async def on_agent_event(msg: Any) -> None:
        if isinstance(msg, bytes):
            await send_audio_b64(msg)
            return

        msg_type = getattr(msg, "type", None)
        if msg_type == "FunctionCallRequest":
            for call in getattr(msg, "functions", []) or []:
                if call.name == RENDER_FUNCTION_NAME:
                    for task in list(render_tasks):
                        task.cancel()
                    task = asyncio.create_task(render_ui(call))
                    render_tasks.add(task)
                    task.add_done_callback(render_tasks.discard)
        elif msg_type == "ConversationText":
            role = getattr(msg, "role", "agent")
            content = getattr(msg, "content", "") or ""
            mapped_role = "user" if role == "user" else "agent"
            await send_json(
                VoiceTranscript(
                    role=mapped_role,
                    text=content,
                    isFinal=True,
                ).model_dump()
            )
            if mapped_role == "user":
                intent = _infer_intent(content)
                if intent is not None:
                    await send_json(intent.model_dump())
        elif msg_type in _EVENT_MAP:
            await send_json(VoiceEvent(name=_EVENT_MAP[msg_type]).model_dump())
        elif msg_type in ("Error", "Warning"):
            await send_json(
                VoiceError(
                    code="upstream_error",
                    message=str(getattr(msg, "description", msg)),
                ).model_dump()
            )

    closed_reason = "completed"
    try:
        if on_session_start:
            on_session_start()

        # Wait for session.start
        while config is None:
            frame = await ws.receive()
            if frame.get("type") == "websocket.disconnect":
                closed_reason = "client_request"
                return
            text = frame.get("text")
            if not text:
                continue
            try:
                parsed = _parse_client_frame(json.loads(text))
            except (ValueError, json.JSONDecodeError) as error:
                await send_json(
                    VoiceError(code="invalid_frame", message=str(error)).model_dump()
                )
                continue
            if isinstance(parsed, VoiceSessionStart):
                config = parsed.config
                system_prompt = build_compose_prompt(
                    ComposeRequest(
                        classification=Classification(
                            scenario="unknown",
                            severity=config.tier or "neutral",
                            mode="triage",
                            confidence=1.0,
                        ),
                        context=ComposeContext(
                            carState="parked",
                            connectivity="online",
                            isNight=False,
                            locale=config.locale,
                        ),
                        catalogVersion="2026.06.0",
                    )
                )
                await send_json(
                    VoiceSessionReady(
                        sessionId=session_id,
                        config={
                            "sampleRate": config.sampleRate,
                            "codec": config.codec,
                        },
                    ).model_dump()
                )
                break

        async with DeepgramAgentSession(on_event=on_agent_event) as opened:
            session = opened
            while True:
                frame = await ws.receive()
                if frame.get("type") == "websocket.disconnect":
                    closed_reason = "client_request"
                    break
                if (data := frame.get("bytes")) is not None:
                    await session.send_audio(data)
                    continue
                text = frame.get("text")
                if not text:
                    continue
                try:
                    parsed = _parse_client_frame(json.loads(text))
                except (ValueError, json.JSONDecodeError) as error:
                    await send_json(
                        VoiceError(
                            code="invalid_frame", message=str(error)
                        ).model_dump()
                    )
                    continue

                if isinstance(parsed, VoiceAudioChunkIn):
                    await session.send_audio(base64.b64decode(parsed.audio))
                elif isinstance(parsed, VoiceTextIn):
                    await send_json(
                        VoiceTranscript(
                            role="user", text=parsed.text, isFinal=True
                        ).model_dump()
                    )
                    intent = _infer_intent(parsed.text)
                    if intent is not None:
                        await send_json(intent.model_dump())
                elif isinstance(parsed, VoiceControlIn):
                    if parsed.action == "cancel":
                        closed_reason = "client_request"
                        break
                elif isinstance(parsed, VoiceSessionEnd):
                    closed_reason = "client_request"
                    break
    except WebSocketDisconnect:
        closed_reason = "client_request"
    except Exception as error:
        logger.exception("voice session failed")
        closed_reason = "error"
        with contextlib.suppress(Exception):
            await send_json(
                VoiceError(
                    code="session_failed",
                    message=str(error),
                    fatal=True,
                ).model_dump()
            )
    finally:
        for task in list(render_tasks):
            task.cancel()
        if render_tasks:
            await asyncio.gather(*render_tasks, return_exceptions=True)
        with contextlib.suppress(Exception):
            await send_json(
                VoiceSessionClosed(reason=closed_reason).model_dump()
            )
        if on_session_end:
            on_session_end()
        with contextlib.suppress(Exception):
            await ws.close()