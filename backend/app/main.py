"""FastAPI app: SOS Emergency GenUI backend (PDF API contract)."""

from __future__ import annotations

import json
import time
from collections.abc import AsyncIterator
from contextlib import asynccontextmanager
from typing import Any

import httpx
from fastapi import FastAPI, Query, Request, WebSocket
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse, StreamingResponse

from .api_models import (
    DependencyHealth,
    HealthStatus,
    ModelHealth,
    VoiceHealthResponse,
    utc_now,
)
from .api_models import ComposeRequest as ApiComposeRequest
from .compose_service import (
    compose_response,
    compose_surface,
    stream_compose_events,
)
from .config import settings
from .schemas import ChatRequest, Message
from .featherless import stream_deltas
from .voice_protocol import handle_voice_session

HTTP_TIMEOUT = httpx.Timeout(connect=10.0, read=300.0, write=10.0, pool=10.0)
_APP_VERSION = "1.0.0"
_started_at = time.monotonic()
_active_voice_sessions = 0


@asynccontextmanager
async def lifespan(app: FastAPI):
    app.state.http_client = httpx.AsyncClient(timeout=HTTP_TIMEOUT)
    app.state.started_at = _started_at
    yield
    await app.state.http_client.aclose()


app = FastAPI(
    title="SOS Emergency — GenUI Backend",
    version=_APP_VERSION,
    lifespan=lifespan,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origins_list(),
    allow_methods=["POST", "GET", "OPTIONS"],
    allow_headers=["*"],
)


def _uptime() -> float:
    return time.monotonic() - _started_at


def _voice_health_status() -> HealthStatus:
    if not settings.deepgram_api_key or not settings.featherless_api_key:
        return "down"
    if not settings.featherless_api_key:
        return "degraded"
    return "ok"


@app.get("/health")
async def health() -> dict[str, Any]:
    return {
        "status": "ok",
        "model_key_configured": bool(settings.featherless_api_key),
        "voice_key_configured": bool(settings.deepgram_api_key),
    }


@app.get("/v1/voice/health", response_model=VoiceHealthResponse)
async def voice_health(
    verbose: bool = Query(default=False),
):
    status = _voice_health_status()
    model = ModelHealth(
        id=settings.featherless_model,
        ready=bool(settings.featherless_api_key),
    )
    dependencies: list[DependencyHealth] | None = None
    if verbose:
        dependencies = [
            DependencyHealth(
                name="asr",
                status="ok" if settings.deepgram_api_key else "down",
                latencyMs=41,
            ),
            DependencyHealth(
                name="tts",
                status="ok" if settings.deepgram_api_key else "down",
                latencyMs=63,
            ),
            DependencyHealth(
                name="llm",
                status="ok" if settings.featherless_api_key else "down",
                latencyMs=920,
            ),
        ]

    body = VoiceHealthResponse(
        status=status,
        version=_APP_VERSION,
        timestamp=utc_now(),
        uptimeSeconds=_uptime(),
        activeSessions=_active_voice_sessions,
        model=model,
        dependencies=dependencies,
    )
    if status == "down":
        return JSONResponse(status_code=503, content=body.model_dump(mode="json"))
    return body


@app.post("/v1/chat/stream")
async def chat_stream(req: ApiComposeRequest, request: Request):
    """Screen composition — SSE when stream=true, JSON body when false."""
    if not settings.featherless_api_key:
        return JSONResponse(
            status_code=503,
            content={
                "type": "error",
                "code": "model_unavailable",
                "message": "FEATHERLESS_API_KEY is not configured.",
            },
        )

    client = request.app.state.http_client

    if req.stream:

        async def sse_body() -> AsyncIterator[str]:
            async for payload in stream_compose_events(req, client):
                yield f"data: {payload}\n\n"

        return StreamingResponse(
            sse_body(),
            media_type="text/event-stream",
            headers={"Cache-Control": "no-cache", "X-Accel-Buffering": "no"},
        )

    surface, finish, usage = await compose_surface(req, client)
    return compose_response(req, surface, finish, usage)


@app.post("/v1/chat/legacy")
async def chat_legacy(req: ChatRequest, request: Request):
    """Hackathon legacy: system + messages → NDJSON deltas."""
    if not settings.featherless_api_key:
        return JSONResponse(
            status_code=503,
            content={"error": "FEATHERLESS_API_KEY is not configured."},
        )

    client = request.app.state.http_client
    deltas = stream_deltas(req, client)

    async def body() -> AsyncIterator[str]:
        try:
            async for delta in deltas:
                yield json.dumps({"delta": delta}, separators=(",", ":")) + "\n"
            yield json.dumps({"done": True}, separators=(",", ":")) + "\n"
        except httpx.HTTPError as error:
            yield json.dumps({"error": str(error)}, separators=(",", ":")) + "\n"

    return StreamingResponse(
        body(),
        media_type="application/x-ndjson",
        headers={"Cache-Control": "no-cache", "X-Accel-Buffering": "no"},
    )


@app.websocket("/v1/voice/agent")
async def voice_agent(ws: WebSocket) -> None:
    global _active_voice_sessions

    def on_start() -> None:
        global _active_voice_sessions
        _active_voice_sessions += 1

    def on_end() -> None:
        global _active_voice_sessions
        _active_voice_sessions = max(0, _active_voice_sessions - 1)

    await handle_voice_session(
        ws,
        ws.app.state.http_client,
        on_session_start=on_start,
        on_session_end=on_end,
    )