# Deepgram Voice Agent — Implementation TODO

Tracks building **Design A** (client-side function calling) from
`deepgram-voice-agent-spec.md`. Check items off as you go.

## Phase 0 — Verify docs & access (do first)

- [x] Get a `DEEPGRAM_API_KEY`; add to `.env` and `.env.example` (commented).
      *(env.example done; drop a real key into `.env` to run.)*
- [x] Pin the `deepgram-sdk` version that exposes `agent.v1.connect()`.
      *(`deepgram-sdk>=7.3` in `pyproject.toml`; `requirements.txt` removed — uv now.)*
- [x] Confirm against the live reference (SDK 7.3.1 introspection):
      - [x] exact `Settings` keys — `listen.model=nova-3`, `speak.model=aura-2-thalia-en`,
            via `AgentV1Settings` / `ThinkSettingsV1` / `SpeakSettingsV1` typed models.
      - [x] `FunctionCallRequest` — `type` + `functions: [{id, name, arguments, client_side}]`.
      - [x] `FunctionCallResponse` — `AgentV1SendFunctionCallResponse(type, id, name, content)`.
      - [x] event list confirmed: Welcome, SettingsApplied, ConversationText,
            UserStartedSpeaking, AgentThinking, AgentStartedSpeaking,
            AgentAudioDone, FunctionCallRequest, Warning, Error + binary audio.
- [ ] Spike: live connect with ~5s of WAV audio against a real key (needs a key;
      SDK surface already verified by introspection — see notes above).

## Phase 1 — Backend config & health

- [x] `app/config.py`: `deepgram_api_key` + voice defaults
      (listen/think/speak/greeting/sample rates/dispatcher prompt), env-overridable.
- [x] `GET /v1/voice/health`: reports `deepgram` + `featherless` key configured.

## Phase 2 — Deepgram agent session wrapper

- [x] `app/deepgram_agent.py`: opens the agent websocket, builds `Settings` from
      config (incl. `render_emergency_ui`), exposes async `DeepgramAgentSession`
      with `send_audio(chunk)`, `on_event` callback, `send_function_call_response`,
      `close()` (async context manager).
- [x] Keepalive loop (~5s) + clean task cancellation / socket close on disconnect.
- [x] Relays binary TTS audio and parsed text events out via the `on_event` callback.

## Phase 3 — A2UI bridge (the GenUI tie-in)

- [x] On `FunctionCallRequest(render_emergency_ui)`: builds a `ChatRequest`
      (system = client persona+catalog prompt, messages = situation) and calls
      the existing `featherless.stream_deltas`.
- [x] Streams the A2UI deltas to Flutter, reusing the `{"delta":...}` /
      `{"done":true}` contract (preceded by a `{"render_start":...}` marker).
- [x] Replies with `FunctionCallResponse` (`{"status":"shown"}`) so the agent
      speaks a short confirmation.
- [x] Catalog/persona system prompt arrives in the initial connect frame
      (`{"system": ...}`), like `/v1/chat/stream`.

## Phase 4 — Client websocket endpoint

- [x] `WS /v1/voice/agent` in `app/main.py`: accepts the connection, reads the
      initial `{"system":...}` frame, then bridges mic audio up and TTS audio +
      transcript + status + A2UI deltas down (sends serialized via a lock).
- [x] Per-connection session lifecycle (open on connect, cancel render tasks +
      close on disconnect); errors surface as `{"error":...}` frames.

## Phase 5 — Prompt

- [x] Emergency-dispatcher `think` prompt in `app/voice_prompt.py`: calm, short,
      one question at a time, **never reads JSON**, calls `render_emergency_ui`
      when visual help applies. (Tone aligned with `lib/prompt.dart`.)

## Phase 6 — Flutter (separate, app side)

- [ ] Hold-to-talk (or open-mic) recorder producing linear16 PCM @ 16 kHz.
- [ ] Connect to `WS /v1/voice/agent`; send system prompt frame, stream mic audio.
- [ ] Play received TTS audio (24 kHz wav); render A2UI deltas through the
      existing GenUI surface.

## Phase 7 — Test & harden

- [ ] Manual end-to-end: speak an emergency → hear calm reply + see rendered UI.
- [ ] Latency check vs spec budget (<2.5s to first spoken word).
- [ ] `think` fallback chain (second provider) for resilience.
- [ ] Failure paths: bad/missing keys, upstream error, mid-stream disconnect.
- [ ] Update `backend/README.md` with voice setup + run instructions.

## Stretch / later

- [ ] Design B wrapper `think` endpoint (single-brain) — see spec.
- [ ] Barge-in tuning, wake-word, multi-language.
</content>
