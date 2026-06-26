# SOS Emergency — Backend

A thin **FastAPI proxy** in front of the model provider (Featherless). It holds
the API key server-side and streams the raw A2UI deltas to the Flutter app, so
the secret never ships inside the app binary.

```
backend/
  app/
    main.py        # FastAPI app, CORS, routes (/health, /v1/chat/stream)
    config.py      # settings from env / .env (the API key lives here)
    schemas.py     # request shapes (system prompt + history)
    featherless.py # OpenAI-compatible streaming client (only place the key is used)
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
