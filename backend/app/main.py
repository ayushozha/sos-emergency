"""FastAPI app: a thin streaming proxy in front of the model provider.

The Flutter client POSTs its system prompt + history here and receives the raw
A2UI text deltas as NDJSON (one JSON object per line). NDJSON is used instead of
plain text so arbitrary content — including newlines inside the A2UI JSON — is
preserved exactly:

    {"delta": "..."}      # zero or more, in order
    {"done": true}        # terminal success marker
    {"error": "..."}      # terminal error marker (mid-stream failures)
"""

import json
from collections.abc import AsyncIterator
from contextlib import asynccontextmanager

import httpx
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse, StreamingResponse

from .config import settings
from .featherless import stream_deltas
from .schemas import ChatRequest

HTTP_TIMEOUT = httpx.Timeout(connect=10.0, read=300.0, write=10.0, pool=10.0)


@asynccontextmanager
async def lifespan(app: FastAPI):
    app.state.http_client = httpx.AsyncClient(timeout=HTTP_TIMEOUT)
    yield
    await app.state.http_client.aclose()


app = FastAPI(
    title="SOS Emergency — GenUI Backend",
    version="0.1.0",
    lifespan=lifespan,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origins_list(),
    allow_methods=["POST", "GET", "OPTIONS"],
    allow_headers=["*"],
)


@app.get("/health")
async def health() -> dict:
    """Liveness check; also reports whether the API key is configured."""
    return {"status": "ok", "model_key_configured": bool(settings.featherless_api_key)}


def _ndjson(obj: dict) -> str:
    return json.dumps(obj, separators=(",", ":")) + "\n"


def _upstream_error_response(error: httpx.HTTPStatusError) -> JSONResponse:
    status = error.response.status_code if error.response is not None else 502
    if status >= 500:
        status = 502
    return JSONResponse(
        status_code=status,
        content={"error": f"Upstream error: {error}"},
    )


@app.post("/v1/chat/stream")
async def chat_stream(req: ChatRequest, request: Request):
    if not settings.featherless_api_key:
        return JSONResponse(
            status_code=503,
            content={"error": "FEATHERLESS_API_KEY is not configured on the server."},
        )

    client = request.app.state.http_client
    deltas = stream_deltas(req, client)

    # Pull the first chunk before returning StreamingResponse so immediate
    # upstream failures (401, 400, etc.) surface as proper HTTP error codes.
    try:
        first_delta = await anext(deltas)
    except StopAsyncIteration:
        first_delta = None
    except httpx.HTTPStatusError as error:
        return _upstream_error_response(error)
    except httpx.HTTPError as error:
        return JSONResponse(
            status_code=502,
            content={"error": f"Request failed: {error}"},
        )

    async def body() -> AsyncIterator[str]:
        if first_delta is not None:
            yield _ndjson({"delta": first_delta})
        try:
            async for delta in deltas:
                yield _ndjson({"delta": delta})
            yield _ndjson({"done": True})
        except httpx.HTTPError as error:
            yield _ndjson({"error": f"Request failed: {error}"})

    return StreamingResponse(
        body(),
        media_type="application/x-ndjson",
        headers={"Cache-Control": "no-cache", "X-Accel-Buffering": "no"},
    )