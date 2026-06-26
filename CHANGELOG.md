# Changelog

All notable changes to SOS Emergency. This project targets **iPad and Android
tablets** in landscape.

## 0.2.0 — Scenario expansion & release readiness (Phase 6)

### Added
- Expanded the scenario set beyond the MVP 8: **severe weather**, **stranded**,
  **harassment** (personal threat), and a **documentation mode** for recording an
  incident — each wired end-to-end (classification → deterministic composition →
  scenario library → tests).
- `documentation` app mode and matching deterministic Surface.

### Changed
- Repositioned as an **iPad / Android tablet** app: removed all in-car /
  Android Automotive / CarPlay / head-unit / `CarPropertyManager` requirements
  from the spec and code. The vehicle-signal source is now optional
  (simulated / manual / future OBD), not in-vehicle hardware.

## 0.1.0 — MVP foundations (Phases 0–5)

- **Phase 0** — GenUI rendering harness: A2UI node model, renderer, DataModel
  bindings, mock transport, landscape-locked app.
- **Phase 1** — Full MVP widget catalog with states, registry, AI-facing
  manifest, and golden tests reproducing the design mockups.
- **Phase 2** — Deterministic safety app: decision engine, deterministic
  composer for all 8 MVP scenarios, signal repositories, orchestrator baseline
  loop, scenario simulator.
- **Phase 3** — AI orchestration + Safety Supervisor: REST composition
  transport, time-boxed AI enrichment, the guardrail suite, clean fallback.
- **Phase 4** — Safety-critical subsystems: emergency calling (countdown/cancel,
  number-as-data), location sharing, contact notification, the voice-session
  WebSocket (codec + reconnect), and the offline action queue.
- **Phase 5** — Live signals & hardening: live signal fusion drives
  classification, minimal-density enforcement, telemetry, localization (en/es),
  and accessibility.
