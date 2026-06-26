# SOS Emergency — Backend

FastAPI service implementing the **SOS API schemas** (`docs/brainstorm/sos_api_schemas.pdf`):
screen composition (`POST /v1/chat/stream`), voice health (`GET /v1/voice/health`), and the
PDF WebSocket voice frame protocol (`WS /v1/voice/agent`). API keys stay server-side.

```
backend/
  app/
    main.py            # FastAPI routes + lifespan
    api_models.py      # Pydantic models (ComposeRequest, voice frames)
    compose_service.py # Compose prompt, Featherless streaming, fallbacks
    voice_protocol.py  # PDF voice WebSocket handler
    config.py          # settings from env / .env
    featherless.py     # OpenAI-compatible streaming client
    deepgram_agent.py  # Deepgram Voice Agent websocket wrapper
    voice_prompt.py    # spoken persona + render function
  tests/
    test_api.py        # contract tests (no live API keys)
  voice_test.html      # browser harness for compose + voice
  requirements.txt
  .env.example
```

## Setup

```sh
cd backend
python3 -m venv .venv && source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt

cp .env.example .env        # FEATHERLESS_API_KEY + DEEPGRAM_API_KEY
```

## Run

```sh
uvicorn app.main:app --reload --port 8000
curl http://localhost:8000/health
```

## API

### `POST /v1/chat/stream` — screen composition

Accepts a `ComposeRequest` body. When `stream=true` (default), responds with **SSE**
(`text/event-stream`) frames:

```
data: {"type":"node","parentId":null,"node":{...}}
data: {"type":"done","finishReason":"complete"}
```

When `stream=false`, returns a JSON `ComposeResponse` with the full surface tree.

Example (non-streaming):

```json
{
  "classification": {
    "scenario": "crash",
    "severity": "critical",
    "mode": "crash",
    "confidence": 0.95,
    "hazards": []
  },
  "context": {
    "carState": "parked",
    "connectivity": "online",
    "isNight": false,
    "locale": "en-US",
    "emergencyNumber": "911"
  },
  "catalogVersion": "2026.06.0",
  "stream": false,
  "timeBudgetMs": 3000
}
```

Without `FEATHERLESS_API_KEY`, returns `503` with `{"type":"error","code":"model_unavailable",...}`.
When the model is unavailable or times out, the service falls back to deterministic surfaces.

### `POST /v1/chat/legacy` — hackathon NDJSON chat

Legacy `system` + `messages` → NDJSON `{"delta":...}` / `{"done":true}` for older clients.

### `GET /v1/voice/health`

Returns `VoiceHealthResponse`: `status`, `version`, `timestamp`, `uptimeSeconds`,
`activeSessions`, `model`, and optional `dependencies` when `?verbose=true`.

```sh
curl http://localhost:8000/v1/voice/health
curl "http://localhost:8000/v1/voice/health?verbose=true"
```

## Voice agent (`WS /v1/voice/agent`)

Typed **JSON text frames** only (no legacy binary PCM on the wire). Client flow:

1. Send `session.start` with `config` (`locale`, `sampleRate`, `codec`, optional `tier`).
2. Receive `session.ready` with `sessionId`.
3. Stream mic audio as `audio.chunk` frames (`seq` + base64 PCM16).
4. Optional: `text`, `control` (`mute` / `barge_in` / `cancel`), `session.end`.

Server frames: `transcript`, `audio.chunk` (TTS base64), `intent`, `compose` (A2UI surface),
`event` (`vad_start`, `thinking`, …), `error`, `session.closed`.

Requires `DEEPGRAM_API_KEY` and `FEATHERLESS_API_KEY`. See `VOICE_AGENT_SPEC.md` for design notes.

### Test harness

`voice_test.html` exercises compose SSE and the PDF voice protocol from the browser.
Serve from `localhost` (mic permission) with the API running:

```sh
cd backend && python3 -m http.server 7861
# open http://localhost:7861/voice_test.html
```

## Tests

```sh
cd backend
pytest -q
```

Contract tests use `TestClient` with app lifespan — no live Featherless/Deepgram keys required.

## Flutter app integration

Point the app at this backend with compile-time defines:

```sh
flutter run -d macos \
  --dart-define=BACKEND_URL=http://localhost:8000 \
  --dart-define=USE_BACKEND=true
```

- `BACKEND_URL` — base URL (default `http://localhost:8000`)
- `USE_BACKEND=true` — enables HTTP compose + voice WebSocket transport (`lib/shared/backend_config.dart`)

No `FEATHERLESS_API_KEY` in the Flutter binary — the backend owns provider keys.

> **Android emulator:** use `--dart-define=BACKEND_URL=http://10.0.2.2:8000` to reach the host.