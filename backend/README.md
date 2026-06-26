# SOS Emergency — Backend

A thin **FastAPI proxy** in front of the model provider (Featherless). It holds
the API key server-side and streams the raw A2UI deltas to the Flutter app, so
the secret never ships inside the app binary.

```
backend/
  app/
    main.py          # FastAPI app, CORS, routes (chat + voice agent)
    config.py        # settings from env / .env (API keys live here)
    schemas.py       # request shapes (system prompt + history)
    featherless.py   # OpenAI-compatible streaming client (only place the key is used)
    deepgram_agent.py# thin wrapper around one Deepgram Voice Agent websocket
    voice_prompt.py  # the spoken emergency-dispatcher persona + render function
  voice_test.html    # browser test harness for both the chat and voice surfaces
  requirements.txt
  .env.example
```

## Setup

```sh
cd backend
python3 -m venv .venv && source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt

cp .env.example .env        # then put your FEATHERLESS_API_KEY in .env
```

## Run

```sh
uvicorn app.main:app --reload --port 8000
# health check:
curl http://localhost:8000/health
```

## API

`POST /v1/chat/stream` — body:

```json
{
  "system": "…combined catalog + persona system prompt…",
  "messages": [{ "role": "user", "text": "I need help" }],
  "model": "Qwen/Qwen2.5-72B-Instruct"
}
```

Responds with **NDJSON** (one JSON object per line), streamed as the model
produces it:

```
{"delta": "..."}   // zero or more, in order
{"done": true}     // terminal success marker
{"error": "..."}   // terminal error marker (bad key, upstream/network failure)
```

## Voice agent (hands-free layer)

`WS /v1/voice/agent` bridges the client to Deepgram's managed Voice Agent
(STT → "think" LLM → TTS over one socket). When the think model decides visual
guidance would help, it calls `render_emergency_ui`; the backend runs the
**existing** A2UI pipeline (`featherless.stream_deltas`) and pushes the deltas
back down the same socket — the UI JSON is never read aloud. See
`VOICE_AGENT_SPEC.md` and `spec/` for the full design.

Wire contract (client ↔ backend):

1. First frame (text): `{"system": "…A2UI prompt…", "model": "…optional…"}`.
2. Then **binary** mic frames — linear16 PCM @ 16 kHz.
3. Down frames: **binary** = TTS audio (linear16/WAV @ 24 kHz); **text** = NDJSON
   (`render_start` / `delta` / `done` / `transcript` / `event` / `error`).

Needs a `DEEPGRAM_API_KEY` (see `.env.example`). Check readiness:

```sh
curl http://localhost:8000/v1/voice/health
```

### Test harness

`voice_test.html` exercises both surfaces from the browser with no Flutter build.
Serve it from `localhost` (required for mic access) with the server running:

```sh
cd backend && python3 -m http.server 7861
# open http://localhost:7861/voice_test.html
```

## How the Flutter app connects

`lib/model/backend_model_client.dart` is a `ModelClient` that POSTs the system
prompt + history here and yields each `delta`. Point the app at the backend with
a compile-time constant (defaults to `http://localhost:8000`):

```sh
flutter run -d macos --dart-define=BACKEND_URL=http://localhost:8000
```

No `FEATHERLESS_API_KEY` is passed to `flutter run` anymore — the backend owns it.

> **Android emulator note:** `localhost` points at the emulator itself. Use
> `--dart-define=BACKEND_URL=http://10.0.2.2:8000` to reach the host machine.
