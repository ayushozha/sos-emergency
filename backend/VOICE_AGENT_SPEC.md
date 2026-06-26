# Voice Agent — Spec (v0.1)

A hands-free voice layer for the SOS Emergency GenUI app. The user speaks; the
app understands, drives the **same A2UI GenUI pipeline** that already exists, and
speaks a short confirmation back. This spec is deliberately small: ship the MVP,
then graduate.

## Goal & constraints

- **Goal:** let a person in distress talk to the app instead of typing — "I cut
  my hand, it won't stop bleeding" → app renders the right GenUI card(s) *and*
  says a calm, short instruction aloud.
- **Hard constraint:** the model emits **A2UI JSON**, not spoken prose. So the
  spoken reply is *derived*, not the model's raw output (see "The TTS source"
  below). This is why speech-to-speech models (Gemini Live / OpenAI Realtime)
  are **out of scope for v1** — they speak but don't reliably emit A2UI.
- **Latency budget (emergency):** target < 2.5 s from end-of-speech to first
  spoken word; < 1.5 s to first rendered widget.
- **Reuse:** the voice layer wraps the existing `/v1/chat/stream` pipeline. It
  adds two edges only: **audio-in → STT** and **reply → TTS**.

## Framework decision

**Voice orchestration: not LangChain.** LangChain/LangGraph solves LLM
orchestration, not audio/VAD/turn-taking/barge-in — which is the hard part of a
voice agent. The "LLM" in our sandwich already just emits A2UI, so no agentic
layer is needed.

- **MVP (v1): no framework — push-to-talk.** STT → existing `/v1/chat/stream`
  → TTS. One new endpoint, no new infra, reuses the whole pipeline.
- **v2: Pipecat** (open-source, Python) when we want continuous hands-free
  conversation with barge-in. Drops into FastAPI; pluggable STT/TTS.
- Rejected: LiveKit Agents (WebRTC infra overkill for MVP), speech-to-speech
  realtime (breaks the A2UI contract), LangChain (not a voice framework).

## Provider choices (swappable)

| Stage | MVP pick | Why | Alt |
|---|---|---|---|
| STT  | Deepgram `nova-2` (streaming) | low latency, cheap, good in noise | Whisper (local/OpenAI) |
| TTS  | Cartesia Sonic | fastest TTFB; good for emergencies | ElevenLabs (nicer voice) |
| LLM  | existing Featherless proxy | already built, emits A2UI | — |

Keys live **server-side** only (same rule as `FEATHERLESS_API_KEY`). New env:
`DEEPGRAM_API_KEY`, `CARTESIA_API_KEY`.

## v1 flow (push-to-talk MVP)

```
Flutter (hold-to-talk)
  │  mic audio (PCM/Opus)
  ▼
POST /v1/voice/turn   (multipart: audio + system + history)
  │
  ├─ 1. STT: audio ─► Deepgram ─► transcript text
  ├─ 2. append {role:"user", text: transcript} to history
  ├─ 3. LLM: reuse stream_deltas() ─► full A2UI JSON  (stream to client as today)
  ├─ 4. derive spoken_text from the A2UI (see below)
  └─ 5. TTS: spoken_text ─► Cartesia ─► audio
  ▼
NDJSON stream back to Flutter:
  {"transcript": "..."}       // 1, once, immediately after STT
  {"delta": "..."}            // 3, zero or more — renders GenUI live (unchanged)
  {"done": true}              // A2UI complete
  {"speech_url": "..."}  OR   {"speech_b64": "..."}   // 4-5, terminal audio
```

The `{"delta": ...}` / `{"done": true}` contract is **identical to today's**
`/v1/chat/stream`, so the GenUI rendering path needs zero changes. Voice only
adds the `transcript` (front) and `speech_*` (back) frames.

### The TTS source (the one non-obvious decision)

The model outputs A2UI JSON, which must **not** be read aloud. Pick one:

1. **Recommended:** add a small `spokenSummary` (string) field to the persona
   prompt's output contract — the model emits one short spoken line alongside the
   UI. We extract it from the A2UI and send only that to TTS.
2. Fallback: a second cheap LLM call — "summarize this UI as one calm spoken
   instruction, < 12 words." Costs latency + tokens; avoid if (1) works.

Spoken lines must be **short, calm, imperative**: "Apply firm pressure with a
clean cloth. I've shown the steps." Never read JSON, never list options.

## v2 flow (Pipecat, continuous)

Replace push-to-talk with a Pipecat pipeline running in the backend:
`Transport(audio) → VAD → STT → [our A2UI LLM service] → spokenSummary → TTS →
Transport`. Adds barge-in (user can interrupt TTS), endpointing, and
always-listening mode. The A2UI still streams to Flutter over a side channel for
rendering. Same providers, same `spokenSummary` contract — only the transport
and turn-taking change.

## API additions

```
POST /v1/voice/turn          # v1 — multipart audio in, NDJSON out (above)
GET  /v1/voice/health        # reports stt/tts key configuration, like /health
```

`ChatRequest` is reused for `system` + `messages`; audio is a separate multipart
part so we don't base64-bloat the JSON.

## Out of scope (v1)

- Wake-word / always-on listening (v2, Pipecat).
- Multi-language (Deepgram supports it; defer config).
- On-device STT/TTS (privacy win, but latency/size cost — revisit later).
- Speaker diarization, emotion detection.

## Open questions

- [ ] Confirm the persona model can reliably emit `spokenSummary` — if not, use
      the fallback summarizer and measure the latency hit.
- [ ] Audio codec from Flutter: PCM16 (simple, bigger) vs Opus (smaller, needs
      decode). Start with whatever the Flutter recorder gives cheapest.
- [ ] Return TTS as a URL (cacheable, needs storage) or inline base64 (simpler,
      one round trip)? MVP: inline base64.

## Rough effort (MVP)

- `app/stt.py` (Deepgram client)         — ~½ day
- `app/tts.py` (Cartesia client)         — ~½ day
- `/v1/voice/turn` route + `spokenSummary` extraction — ~½ day
- Flutter: hold-to-record + play returned audio — ~1 day
- Prompt change for `spokenSummary`      — ~1 hr
</content>
</invoke>
