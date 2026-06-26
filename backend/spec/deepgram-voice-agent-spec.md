# Deepgram Voice Agent — Spec (v0.2)

A hands-free voice layer for the SOS Emergency GenUI app, built on **Deepgram's
Voice Agent API**. The user speaks; Deepgram manages the full STT → LLM → TTS
loop (with VAD, turn-taking, barge-in); and our existing **A2UI / GenUI
pipeline** renders the emergency UI on screen in parallel.

> Supersedes the framework comparison in `../VOICE_AGENT_SPEC.md`. Deepgram Voice
> Agent replaces both the push-to-talk MVP and the Pipecat v2 from that doc with
> one managed websocket.

## Why Deepgram Voice Agent

- **One managed websocket** (`agent.v1.connect()`) handles STT + LLM + TTS + VAD
  + endpointing + barge-in + greeting. Far less glue than Pipecat or a
  hand-rolled sandwich.
- **Custom OpenAI-compatible `think` endpoint** is supported, and **client-side
  function calling** is supported — either is enough to keep our Featherless
  A2UI pipeline in the loop.
- **`think` fallback chain** (array of providers) — valuable for an emergency
  app: fall back to a second LLM if the primary fails.

## The core constraint (unchanged)

Deepgram **speaks whatever the `think` LLM returns as text.** Our A2UI model
returns **structured UI JSON**, which must never be read aloud. The whole design
below exists to separate the **spoken** channel from the **rendered UI** channel.

## Architecture

The backend sits in the middle and holds two connections at once:

```
 Flutter app  ◄───────────────►  FastAPI backend  ◄───────────────►  Deepgram Agent (cloud)
   mic audio  ──(our WS)──────►     relays audio   ──(agent WS)────►   STT → LLM → TTS
   TTS audio  ◄──(our WS)──────     relays audio   ◄──(agent WS)────   (managed loop)
   A2UI JSON  ◄──(our WS)──────     A2UI side channel
                                         │
                                         ▼  on FunctionCallRequest
                                   existing A2UI pipeline
                                   (featherless.stream_deltas)
```

- Flutter connects to **our** backend websocket (`/v1/voice/agent`), streams mic
  audio up, plays TTS audio down, and renders A2UI deltas pushed down the same
  socket.
- The backend opens the Deepgram Agent websocket, forwards audio both ways, and
  watches for agent events.

## Recommended design — client-side function calling (Design A)

The idiomatic Deepgram pattern, and the one that needs **no publicly reachable
backend endpoint**:

1. `think` provider = a Deepgram-**managed** conversational model
   (e.g. `gpt-4o-mini` / a Claude Haiku model) with an **emergency-dispatcher
   prompt** (calm, short, asks one clarifying question, never reads JSON).
2. Register a **client-side function** in `agent.think.functions`, e.g.
   `render_emergency_ui(situation: string, severity: string)` — *no* endpoint
   URL, so Deepgram routes the call back to us.
3. When the conversational model decides to show UI, Deepgram emits a
   **`FunctionCallRequest`** on the agent websocket → our backend.
4. Backend calls the **existing A2UI pipeline** (`featherless.stream_deltas`)
   with the situation, streams the resulting A2UI deltas to Flutter over our
   websocket (rendering path **unchanged**), and replies with a
   **`FunctionCallResponse`** (e.g. `{"status":"shown"}`) so the agent speaks a
   short confirmation.

**Two decoupled brains:** Deepgram's managed LLM = the *conversation/voice*;
our Featherless pipeline = the *UI*. Featherless is still used (for A2UI); we add
a cheap managed model only for turn-by-turn talking.

## Alternative — wrapper `think` endpoint (Design B)

Single-brain reuse: point `agent.think.endpoint.url` at a **new** backend route
that speaks the OpenAI Chat Completions streaming format. It calls the A2UI
pipeline, returns **only the `spokenSummary`** as the assistant text (Deepgram
speaks it), and side-channels the A2UI to Flutter.

- Pro: one model, maximal reuse of the existing prompt/pipeline.
- Con: **Deepgram cloud must reach our backend** (public URL / ngrok in dev), and
  the route must emit OpenAI-compatible SSE. More moving parts than Design A.
- Note: with a custom endpoint the `model` field is ignored — **the model is
  encoded in the endpoint URL**.

**Decision: build Design A first.** Revisit B only if we want a single brain or
the managed conversational model proves unreliable at deciding *when* to render.

## Settings message (Design A, starting point)

```jsonc
{
  "type": "Settings",
  "audio": {
    "input":  { "encoding": "linear16", "sample_rate": 16000 },
    "output": { "encoding": "linear16", "sample_rate": 24000, "container": "wav" }
  },
  "agent": {
    "language": "en",
    "greeting": "Emergency assistant here. Tell me what's happening.",
    "listen": { "provider": { "type": "deepgram", "model": "nova-3" } },
    "think": {
      "provider": { "type": "open_ai", "model": "gpt-4o-mini", "temperature": 0.3 },
      "prompt": "<emergency dispatcher persona — see lib/prompt.dart tone>",
      "functions": [
        {
          "name": "render_emergency_ui",
          "description": "Show step-by-step first-aid / emergency UI on the user's screen. Call this whenever visual guidance would help.",
          "parameters": {
            "type": "object",
            "properties": {
              "situation": { "type": "string", "description": "What the user is facing, in their words" },
              "severity":  { "type": "string", "enum": ["info","urgent","critical"] }
            },
            "required": ["situation"]
          }
        }
      ]
    },
    "speak": { "provider": { "type": "deepgram", "model": "aura-2-thalia-en" } }
  }
}
```

> Exact `listen.model` (e.g. `nova-3` vs `flux-general-en`) and function-message
> field names must be confirmed against the live reference (see TODO).

## API additions (backend)

```
WS   /v1/voice/agent        # Flutter <-> backend; relays audio, pushes A2UI + TTS
GET  /v1/voice/health       # reports deepgram + featherless key configuration
```

New env (server-side only, same rule as FEATHERLESS_API_KEY):
`DEEPGRAM_API_KEY`.

## Out of scope (v1)

- Design B wrapper endpoint (documented above; not built first).
- Wake-word / always-on listening, multi-language, on-device STT/TTS.
- Telephony / phone-number inbound.

## Open questions

- [ ] Confirm exact `FunctionCallRequest` / `FunctionCallResponse` field names
      and the agent event set against the live reference.
- [ ] Confirm `deepgram-sdk` version that exposes `agent.v1` and the Python
      connect/send API surface.
- [ ] Audio relay path: does Flutter talk to Deepgram via our backend (chosen
      here) or directly? Backend-mediated keeps the key server-side — confirm
      latency is acceptable.
- [ ] Codec from Flutter recorder: linear16 PCM (simple) vs Opus (smaller).
</content>
