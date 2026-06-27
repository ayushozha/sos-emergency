# SOS Emergency — Backend

A thin **FastAPI proxy** that sits between the Flutter app and the AI providers.
It does two jobs:

1. **Chat / A2UI streaming** — forwards the client's system prompt + history to
   the model provider (**Featherless**, OpenAI-compatible) and streams the raw
   A2UI deltas back as NDJSON.
2. **Hands-free voice** — bridges one client WebSocket to **Deepgram's managed
   Voice Agent** (STT → "think" LLM → TTS), and when the agent decides visual
   guidance would help, it reuses the *same* A2UI pipeline to render UI.

The whole point of the proxy is that **API keys live server-side** and never
ship inside the app binary.

---

## Layout

```
backend/
  app/
    main.py            # FastAPI app: CORS, health, chat stream, voice agent bridge
    config.py          # Settings loaded from env / .env (API keys live here)
    schemas.py         # Request shapes (system prompt + history)
    featherless.py     # OpenAI-compatible streaming client (the only place the model key is sent)
    deepgram_agent.py  # Thin async wrapper around one Deepgram Voice Agent websocket
    voice_prompt.py    # Spoken emergency-dispatcher persona + render/call tool definitions
  scripts/
    ws_probe.py        # Ad-hoc probe for the voice websocket (dev only)
  spec/                # Voice agent + A2UI transport design notes
  VOICE_AGENT_SPEC.md  # Voice ↔ A2UI bridge specification
  voice_test.html      # Browser harness for both the chat and voice surfaces
  requirements.txt
  .env.example
```

---

## Setup

Requires **Python 3.10+**.

```sh
cd backend
python3 -m venv .venv && source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt

cp .env.example .env        # then add your keys (see Configuration below)
```

## Run

```sh
uvicorn app.main:app --reload --port 8000

# liveness + which keys are configured:
curl http://localhost:8000/health
```

---

## API

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/health` | `GET` | Liveness; reports whether each provider key is configured |
| `/v1/chat/stream` | `POST` | Stream A2UI NDJSON deltas from Featherless |
| `/v1/voice/health` | `GET` | Voice-layer readiness (Deepgram + Featherless keys) |
| `/v1/voice/agent` | `WS` | Full-duplex voice: PCM mic in, TTS audio + A2UI events out |

### `POST /v1/chat/stream`

Request body:

```json
{
  "system": "…combined catalog + persona system prompt…",
  "messages": [{ "role": "user", "text": "I need help" }],
  "model": "Qwen/Qwen2.5-72B-Instruct",
  "catalogVersion": "2026.06.0"
}
```

- `system` (required) — the combined A2UI system prompt, built client-side
  because the widget catalog lives in the Flutter app.
- `messages` — running conversation, oldest first; each `role` is `"user"` or
  `"model"`.
- `model` (optional) — per-request override; falls back to the server default.
- `catalogVersion` (optional) — logged for observability; the backend stays
  catalog-agnostic and never acts on it.

Responds with **NDJSON** (one JSON object per line), streamed as the model
produces it:

```
{"delta": "..."}   // zero or more, in order
{"done": true}     // terminal success marker
{"error": "..."}   // terminal error marker (bad key, upstream/network failure)
```

Immediate upstream failures (401/400, etc.) surface as proper HTTP error codes
because the first chunk is pulled before the stream starts.

---

## Voice agent (hands-free layer)

`WS /v1/voice/agent` bridges the client to Deepgram's managed Voice Agent. The
client holds **one** socket; the backend holds a second socket to Deepgram and
relays audio both ways. When the think model decides visual guidance would help,
it calls `render_emergency_ui`; the backend runs the **same** A2UI pipeline
(`featherless.stream_deltas`) and pushes those deltas back down the client
socket — the UI JSON is never read aloud. See `VOICE_AGENT_SPEC.md` and `spec/`
for the full design.

Wire contract (client ↔ backend):

1. First frame (**text**): `{"system": "…A2UI prompt…", "model": "…optional…"}`.
2. Then **binary** mic frames — linear16 PCM @ 16 kHz.
3. Down frames:
   - **binary** = TTS audio (linear16 @ 24 kHz), play as it arrives.
   - **text** = NDJSON control/data:

```
{"render_start": {"situation": "...", "severity": "..."}}  // a render is beginning
{"delta": "..."}                                            // one A2UI chunk
{"done": true}                                              // the render's A2UI stream finished
{"transcript": {"role": "...", "content": "..."}}           // a spoken turn
{"event": "AgentThinking"}                                  // lightweight status passthrough
{"action": "call_emergency"}                                // user asked to call 911 — dial on device
{"error": "..."}                                            // recoverable / terminal error
```

Needs both `DEEPGRAM_API_KEY` and `FEATHERLESS_API_KEY`. Check readiness:

```sh
curl http://localhost:8000/v1/voice/health
```

---

## Configuration

Copy `.env.example` to `.env`. `.env` is gitignored — **never commit it.**

| Variable | Required | Default | Purpose |
|----------|----------|---------|---------|
| `FEATHERLESS_API_KEY` | Yes (chat + voice render) | — | OpenAI-compatible completions for A2UI |
| `DEEPGRAM_API_KEY` | Yes (voice) | — | Deepgram Voice Agent websocket |
| `FEATHERLESS_BASE_URL` | No | `https://api.featherless.ai/v1` | Provider base URL |
| `FEATHERLESS_MODEL` | No | `Qwen/Qwen2.5-72B-Instruct` | Default A2UI model |
| `CORS_ALLOW_ORIGINS` | No | `*` | Comma-separated allowed origins (lock down for prod) |
| `VOICE_LISTEN_MODEL` | No | `nova-3` | Deepgram STT model |
| `VOICE_THINK_MODEL` | No | `gpt-4o-mini` | Deepgram "think" LLM |
| `VOICE_THINK_TEMPERATURE` | No | `0.3` | Think model temperature |
| `VOICE_SPEAK_MODEL` | No | `aura-2-thalia-en` | Deepgram TTS voice |
| `VOICE_LANGUAGE` | No | `en` | Conversation language |
| `VOICE_GREETING` | No | (see config) | Spoken opening line |
| `VOICE_INPUT_SAMPLE_RATE` | No | `16000` | Mic PCM sample rate |
| `VOICE_OUTPUT_SAMPLE_RATE` | No | `24000` | TTS PCM sample rate |
| `VOICE_DISPATCHER_PROMPT` | No | built-in | Override the dispatcher "think" prompt |

---

## Test harness

`voice_test.html` exercises both surfaces from the browser with no Flutter build.
Serve it from `localhost` (required for mic access) with the server running:

```sh
cd backend && python3 -m http.server 7861
# open http://localhost:7861/voice_test.html
```

`scripts/ws_probe.py` is a lower-level check that the voice socket opens and emits
a greeting (binary TTS + assistant transcript) without any mic audio — useful for
isolating "no response" issues to the client/audio side. It needs the
`websockets` package:

```sh
pip install websockets
python scripts/ws_probe.py          # config only
python scripts/ws_probe.py --audio  # also pump a test tone
```

---

## How the Flutter app connects

The GenUI transport lives in `lib/genui/emergency_conversation.dart`. It POSTs
the system prompt + history to `/v1/chat/stream` and feeds streamed deltas into
the genui `A2uiTransportAdapter`. The voice layer connects to the WebSocket via
`lib/data/voice_session/`. Point the app at the backend with:

```sh
flutter run -d chrome --dart-define=BACKEND_BASE=http://localhost:8000
```

No `FEATHERLESS_API_KEY` is passed to `flutter run` — the backend owns it.

> **Android emulator note:** `localhost` points at the emulator itself. Use
> `--dart-define=BACKEND_BASE=http://10.0.2.2:8000` to reach the host machine.
