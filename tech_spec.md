# In-Car SOS — Technical Specification & Phased Implementation Plan

**Project:** In-Car SOS — a Generative-UI emergency co-pilot for the vehicle infotainment display
**Platform:** Embedded automotive (Android Automotive OS primary; CarPlay/Android Auto projection as a constrained secondary surface)
**Stack:** Flutter · Dart · Flutter GenUI SDK (A2UI structured layout) · Riverpod 2.0 (codegen) · freezed · Repository pattern
**Status:** Engineering spec — concept to MVP
**Audience:** Mobile/automotive engineers, design-systems lead, product

---

## Table of contents

1. Goals & non-goals
2. The one architectural decision that shapes everything
3. System architecture
4. Module & package structure
5. Core domain model
6. The GenUI rendering layer
7. Context & signal fusion
8. The decision engine (deterministic core)
9. The AI orchestration layer
10. The Safety Supervisor (guardrails)
11. Safety-critical subsystems (telephony, location, voice proxy, offline)
12. Cross-cutting concerns
13. Testing strategy
14. Risks & mitigations
15. Phased implementation plan
16. Milestones & sequencing

---

## 1. Goals & non-goals

### Goals
- Render a single emergency **Surface** on the infotainment display whose content and layout are composed at runtime by an AI agent from a fixed, design-owned **Widget Catalog**.
- Guarantee that the safest action (911 + location) is always one tap away, regardless of what the AI does.
- Adapt to **vehicle state** (driving / stopped / parked / stuck) and **severity tier** (Moderate / High / Critical).
- Work **offline** for the core MVP scenarios.
- Ship the MVP scenario set: flat tire/blowout, won't-start, crash, medical, being-followed/road-rage, locked-out, out-of-gas/EV-low, unsafe-parked.

### Non-goals (v1)
- Full-matrix coverage of every scenario in the brainstorm docs (we expand post-MVP).
- A general-purpose conversational assistant. This is a narrow, safety-scoped agent.
- Replacing emergency services or giving medical/legal advice. The app routes and assists; it does not diagnose.
- Multi-app infotainment shell concerns (we are one app on the head unit, not the launcher).

---

## 2. The one architectural decision that shapes everything

> **Safety is deterministic. The AI only decorates.**

The LLM is treated as an *untrusted, best-effort, possibly-slow, possibly-offline* component. It proposes which catalog components to compose and the supporting copy. It is **never** on the critical path for:

- detecting a crash or severe event,
- presenting the 911 + share-location controls,
- enforcing the "never route home during a threat" rule,
- placing or cancelling an emergency call.

Those are owned by a **deterministic decision engine** and a **Safety Supervisor** that wrap every AI output. If the model is unavailable, slow, low-confidence, or returns an invalid layout, the app falls back to a hand-built deterministic screen for the classified scenario and loses *zero* safety capability.

Consequence for the plan: we build a **fully functional deterministic safety app first (Phases 0–2)**, then add the AI as an enhancement layer (Phase 3+). At no point does removing the AI break the product's core promise.

---

## 3. System architecture

Feature-first clean architecture. Three layers, dependency-inverted via the Repository pattern, wired with Riverpod codegen.

```
┌──────────────────────────────────────────────────────────────────┐
│ PRESENTATION                                                       │
│  • Surface host + A2UI Renderer                                    │
│  • Widget Catalog (registered emergency components)                │
│  • Riverpod providers (UI state, DataModel binding)                │
└───────────────▲──────────────────────────────────▲────────────────┘
                │ Surface (validated)               │ user interactions
┌───────────────┴──────────────────────────────────┴────────────────┐
│ APPLICATION / DOMAIN                                               │
│  • DecisionEngine  (classify → severity → mode)  [deterministic]   │
│  • SafetySupervisor (guardrail enforcement)      [deterministic]   │
│  • Orchestrator    (the sense→compose→render loop)                 │
│  • AiComposer      (LLM call, A2UI parsing)       [best-effort]    │
│  • Use cases: PlaceEmergencyCall, ShareLocation, NotifyContacts…   │
│  • freezed models, no Flutter imports                              │
└───────────────▲──────────────────────────────────▲────────────────┘
                │ streams / futures                 │
┌───────────────┴──────────────────────────────────┴────────────────┐
│ DATA (Repositories — abstract interface + impl)                    │
│  Sensor · Location · VehicleBus · Connectivity · Battery ·         │
│  Telephony · Contacts · Profile/MedicalID · AiTransport ·          │
│  OfflineGuides · Routing/SafePlaces                                │
└────────────────────────────────────────────────────────────────────┘
```

**The loop** (one iteration, runs continuously while an incident is active):

```
Sense ──► Aggregate context ──► Classify (scenario/state/severity)
   ▲                                     │
   │                                     ▼
React ◄── Render ◄── Validate ◄── Compose
        (Surface)  (Supervisor) (deterministic baseline + AI enrichment)
```

---

## 4. Module & package structure

Single app package with feature-first directories. Heavy modules (`genui_render`, `domain`) can graduate to local packages in a melos workspace once stable.

```
lib/
  app/
    app.dart                  # MaterialApp, theming, routing into the Surface
    theme/                    # design tokens: severity colors, type scale, day/night
  core/
    result.dart               # Result<T>/failures
    logging.dart
    di.dart                   # provider overrides for tests
  domain/
    models/                   # freezed: EmergencyContext, Classification, Surface…
    engine/
      decision_engine.dart
      severity_rules.dart
      mode_router.dart
    safety/
      safety_supervisor.dart
      guardrails.dart
    orchestrator/
      orchestrator.dart       # the loop, as a Riverpod Notifier
      ai_composer.dart
  data/
    sensors/                  # repo interface + platform impl
    location/
    vehicle_bus/
    telephony/
    contacts/
    profile/
    ai_transport/             # GenUI SDK / model streaming
    offline_guides/
    routing/
  presentation/
    surface/
      surface_host.dart       # hosts the renderer, listens to orchestrator
      a2ui_renderer.dart      # A2UI node tree -> Flutter widgets
      data_model.dart         # client-side DataModel + bindings
    catalog/                  # the Widget Catalog (one file per component)
      sos_call_button.dart
      severity_banner.dart
      guidance_callout.dart
      safe_route_map.dart
      step_checklist.dart
      ...
      catalog_registry.dart   # name -> builder map; the AI's vocabulary
  features/                   # scenario-specific deterministic flows
    crash/
    medical/
    threat/
    roadside/
test/
  unit/  golden/  scenario_sim/  integration/
```

**Riverpod conventions:** every repository exposes an interface in `domain` (or `data` boundary) and is provided via `@riverpod`. State holders are `@riverpod` Notifiers/AsyncNotifiers. No widget reads a repository directly — only providers.

---

## 5. Core domain model

All models are `freezed`, immutable, Flutter-free. Examples (abbreviated):

```dart
enum VehicleState { driving, stopped, parked, stuck, unknown }
enum Severity { none, moderate, high, critical }
enum AppMode { triage, crash, medical, threat, roadside, documentation }
enum Connectivity { online, degraded, offline }

@freezed
class EmergencyContext with _$EmergencyContext {
  const factory EmergencyContext({
    required VehicleState vehicleState,
    required double speedMps,
    required Connectivity connectivity,
    required bool isNight,
    GeoPosition? position,
    VehicleBusSnapshot? bus,        // airbag, OBD-II, temps, fuel/charge
    BiometricSnapshot? biometrics,  // wearable HR, etc.
    @Default(<UserSignal>[]) List<UserSignal> userSignals, // taps, voice, code word
    required DateTime timestamp,
  }) = _EmergencyContext;
  const EmergencyContext._();
}

@freezed
class Classification with _$Classification {
  const factory Classification({
    required ScenarioClass scenario,   // crash, wontStart, cardiac, beingFollowed…
    required Severity severity,
    required AppMode mode,
    required double confidence,        // 0..1 from the deterministic classifier
    @Default(<Hazard>{}) Set<Hazard> hazards,
  }) = _Classification;
}

/// What the renderer consumes. The AI proposes this; the Supervisor validates it.
@freezed
class Surface with _$Surface {
  const factory Surface({
    required AppMode mode,
    required Severity severity,
    required A2uiNode root,            // the layout tree, catalog components only
    required SafetyAffordances safety, // injected, non-negotiable controls
    @Default(false) bool isFallback,   // true when AI was bypassed
  }) = _Surface;
}
```

`A2uiNode` is the parsed structured-layout tree (component `type`, `props`, `bindings`, `children`). It is the contract between the AI/transport and the renderer.

---

## 6. The GenUI rendering layer

Implements the four GenUI pillars: **Surface**, **Catalog**, **DataModel**, **Transport**.

### Catalog registry
The catalog is a static map from component name → builder. **If a name isn't registered, it cannot render** — this is the control surface over what the AI can ever produce.

```dart
typedef CatalogBuilder = Widget Function(
  BuildContext context, A2uiNode node, DataModel data, SurfaceTheme theme,
);

final catalogRegistry = <String, CatalogBuilder>{
  'SeverityBanner':  (c, n, d, t) => SeverityBanner.fromNode(n, t),
  'GuidanceCallout': (c, n, d, t) => GuidanceCallout.fromNode(n, t),
  'SOSCallButton':   (c, n, d, t) => SosCallButton.fromNode(n, d),
  'SafeRouteMap':    (c, n, d, t) => SafeRouteMap.fromNode(n, d),
  'StepChecklist':   (c, n, d, t) => StepChecklist.fromNode(n, d),
  // …container, input, status, and visualization families
};
```

### Renderer
Walks the validated `A2uiNode` tree and builds widgets, resolving data bindings against the `DataModel`. Every component **must** define loading and empty fallbacks (streamed JSON arrives in chunks) and must wrap/auto-scale text (LLM copy length is unpredictable).

```dart
class A2uiRenderer extends StatelessWidget {
  const A2uiRenderer({required this.node, required this.data, required this.theme});
  final A2uiNode node;
  final DataModel data;
  final SurfaceTheme theme;

  @override
  Widget build(BuildContext context) {
    final builder = catalogRegistry[node.type];
    if (builder == null) return const SizedBox.shrink(); // unknown == nothing
    return builder(context, node, data, theme);
  }
}
```

### DataModel & bindings
A client-side `DataModel` (a Riverpod Notifier holding a `Map<String, Object?>` keyed by data paths, e.g. `/incident/countdown`). Interactive widgets **only read/write declared paths**; they never call network actions directly — the orchestrator's interaction loop turns a write into the next compose pass. This matches the GenUI guidance on isolating side-effects.

### Theme
`SurfaceTheme` carries the severity tier, day/night, and driving-vs-parked density. Components style themselves from it; severity is conveyed by color **and** shape/iconography (never color alone).

---

## 7. Context & signal fusion

Each signal source is a repository exposing a `Stream`. A `contextAggregator` provider merges the latest of each into a single `EmergencyContext` stream (debounced, with backpressure).

```dart
@riverpod
SensorRepository sensorRepository(Ref ref) => PlatformSensorRepository();

@riverpod
Stream<EmergencyContext> emergencyContext(Ref ref) {
  final sensors  = ref.watch(sensorRepositoryProvider);
  final location = ref.watch(locationRepositoryProvider);
  final bus      = ref.watch(vehicleBusRepositoryProvider);
  final net      = ref.watch(connectivityRepositoryProvider);

  return Rx.combineLatest4(
    sensors.motion, location.position, bus.snapshot, net.status,
    EmergencyContext.fromStreams,
  ).debounceTime(const Duration(milliseconds: 250));
}
```

| Signal source | Repository | Drives |
|---|---|---|
| GPS speed/trajectory | `LocationRepository` | driving vs stopped, route-tail detection |
| Accelerometer/gyro | `SensorRepository` | crash, hard braking, rollover |
| Vehicle bus / OBD-II | `VehicleBusRepository` | airbag deploy, temps, fuel/charge, warnings |
| Connectivity/battery | `ConnectivityRepository` | offline & low-power layout switches |
| Location type, time, weather | `LocationRepository` + provider | shoulder vs lot vs remote; night; storm/fire |
| Voice / code word | `VoiceRepository` | intent, discreet SOS, hands-free |
| Wearable HR | `BiometricRepository` | medical corroboration |
| Profile / Medical ID | `ProfileRepository` | EV vs ICE, contacts, allergies/conditions |

> **Platform note:** on AAOS, vehicle signals come from the Car/`CarPropertyManager` APIs; in projection mode many are unavailable, so `VehicleBusRepository` degrades gracefully and the engine relies more on phone sensors.

---

## 8. The decision engine (deterministic core)

Pure Dart, fully unit-testable, no AI. Maps `EmergencyContext` → `Classification`. This is the safety brain.

```dart
class DecisionEngine {
  Classification classify(EmergencyContext ctx) {
    // 1) hard triggers first (highest confidence)
    if (ctx.bus?.airbagDeployed == true || ctx.crashImpulseDetected) {
      return Classification(
        scenario: ScenarioClass.crash, severity: Severity.critical,
        mode: AppMode.crash, confidence: 0.99,
      );
    }
    // 2) explicit user intent
    final intent = _intentFrom(ctx.userSignals);
    if (intent == UserIntent.feelUnsafe || intent == UserIntent.beingFollowed) {
      return Classification(
        scenario: ScenarioClass.beingFollowed, severity: Severity.high,
        mode: AppMode.threat, confidence: 0.9,
      );
    }
    // 3) corroborated medical, mechanical, environmental …
    // 4) default: triage chooser
    return const Classification(
      scenario: ScenarioClass.unknown, severity: Severity.moderate,
      mode: AppMode.triage, confidence: 0.4,
    );
  }
}
```

`severity_rules.dart` and `mode_router.dart` hold the tier thresholds and mode mappings as data tables so they're auditable and testable. **For every MVP scenario there is a hand-built deterministic Surface** — this is what renders when AI is off or unavailable.

---

## 9. The AI orchestration layer

The Orchestrator is a Riverpod Notifier that drives the loop and holds the current `Surface`.

```dart
@riverpod
class SurfaceController extends _$SurfaceController {
  @override
  Surface build() => Surface.triageFallback();

  Future<void> onContext(EmergencyContext ctx) async {
    final clf = ref.read(decisionEngineProvider).classify(ctx);

    // 1) deterministic baseline is ready immediately — render it now.
    final baseline = ref.read(deterministicComposerProvider).compose(clf, ctx);
    state = ref.read(safetySupervisorProvider).enforce(baseline, clf, ctx);

    // 2) best-effort AI enrichment, time-boxed; never blocks safety.
    if (ref.read(connectivityProvider) != Connectivity.offline) {
      final proposed = await ref
          .read(aiComposerProvider)
          .compose(clf, ctx, ref.read(catalogManifestProvider))
          .timeout(const Duration(seconds: 3), onTimeout: () => baseline);

      state = ref.read(safetySupervisorProvider).enforce(proposed, clf, ctx);
    }
  }
}
```

`AiComposer` builds a structured prompt from `Classification` + a **catalog manifest** (the AI-facing descriptions of each component — written warm and intent-oriented, per the GenUI guidance), calls the model via `AiTransportRepository` with structured-output/streaming, and parses A2UI chunks into an `A2uiNode` tree. Streaming chunks update the Surface progressively; the renderer shows skeletons for not-yet-arrived nodes.

`AiTransportRepository` is an interface (`composeStream(prompt) -> Stream<A2uiChunk>`) so we can target the Flutter GenUI SDK / Gemini structured output now and swap providers later without touching domain code.

---

## 10. The Safety Supervisor (guardrails)

Every Surface — baseline **and** AI-proposed — passes through `enforce()` before it can render. The Supervisor is deterministic and cannot be overridden by model output.

```dart
class SafetySupervisor {
  Surface enforce(Surface s, Classification clf, EmergencyContext ctx) {
    var out = s;

    // R1: 911 + live-location are always present and reachable in ≤1 tap.
    out = _ensureSafetyAffordances(out, clf.severity);

    // R2: in a threat, strip/replace any routing destination that isn't a
    //     police/fire/public place. NEVER route home.
    if (clf.mode == AppMode.threat) out = _restrictRouting(out);

    // R3: irreversible actions (place call, send alerts) must expose a labeled
    //     cancel and honor the countdown contract.
    out = _ensureCancelable(out);

    // R4: reject unknown components / overflowing/empty critical nodes.
    out = _validateAgainstCatalog(out);

    // R5: if validation stripped something essential, fall back to baseline.
    if (_isDegradedBelowSafetyFloor(out, clf)) {
      return _baselineFor(clf, ctx).copyWith(isFallback: true);
    }
    return out;
  }
}
```

This layer is the single most important thing to get right and the most heavily tested (see §13).

---

## 11. Safety-critical subsystems

### Telephony / emergency calling
- **No silent auto-dial of 911.** Auto-escalation uses a visible, cancelable **countdown** (`CountdownCard`) before placing a call; the user can always cancel or call immediately.
- Calling is a use case (`PlaceEmergencyCall`) behind `TelephonyRepository`, abstracting platform dialer intents/`url_launcher`/AAOS telephony.
- **Regulatory:** emergency-number behavior varies by region; integrate with platform emergency services and location relay (e.g. eCall/Advanced Mobile Location where available) rather than reinventing. **Treat the local emergency number as data**, never hard-coded `911`.
- **Testing constraint:** you cannot test against live emergency services. Provide a `FakeTelephonyRepository` and a "test mode" that exercises the full flow against a sandbox number/log sink.

### Live location sharing & contacts
- `ShareLocation` and `NotifyContacts` use cases; share is a revocable, clearly-indicated "on" state. Outbound channels (SMS/deeplink) behind repositories.

### Voice proxy (incapacitated user)
- TTS reads location + medical profile to dispatch; STT/wake-word for hands-free and code words. Behind `VoiceRepository`. Armed but never speaks PII until a call is active.

### Offline-first
- On-device catalog + cached first-aid/mechanical guides + a lightweight on-device fallback classifier. A persistent **action queue** (e.g. roadside request) flushes when connectivity returns. Offline state is explicit in the UI.

---

## 12. Cross-cutting concerns

- **Driving-vs-parked enforcement:** density and interaction depth are gated by `VehicleState`; while driving, the renderer collapses to the minimal/voice-first variant automatically (also a Supervisor rule).
- **Day/night + contrast:** theme-driven; meets automotive legibility at distance.
- **Localization:** all copy is parameterized; the AI injects localized strings, deterministic baselines use ARB. Emergency numbers and rights info are locale data.
- **Accessibility:** large targets, semantics labels on every catalog component, voice as a first-class input.
- **Observability:** structured event logging for each loop iteration (context → classification → which composer won → supervisor actions → render latency). Crash/ANR reporting. Redact PII. This is essential for debugging non-deterministic AI behavior in the field.
- **Performance budget:** baseline Surface renders < 100 ms from classification; AI enrichment time-boxed at 3 s; 60 fps on target head-unit hardware.

---

## 13. Testing strategy

| Layer | Approach |
|---|---|
| Decision engine | Exhaustive unit tests: context fixtures → expected `Classification`. Table-driven. |
| Safety Supervisor | The crown jewels. Property/fuzz tests feeding **adversarial AI Surfaces** (unknown components, home-routing in threat mode, missing 911) and asserting every guardrail holds. |
| Catalog widgets | Golden tests for every component × state (default/active/loading/empty) × day/night × driving/parked. |
| Renderer | Parse-and-build tests from hand-authored A2UI JSON, including malformed/partial streams. |
| Orchestrator loop | Integration tests with fake repositories; assert baseline renders before AI and AI never blocks safety. |
| Scenario simulator | A `scenario_sim` harness that replays signal traces for each MVP scenario end-to-end (the primary acceptance gate per phase). |
| AI composer | Contract tests against recorded model responses; verify graceful handling of timeouts, invalid JSON, and refusal. |

---

## 14. Risks & mitigations

| Risk | Mitigation |
|---|---|
| LLM latency/unavailability on the critical path | Deterministic baseline renders first; AI is time-boxed and optional (Phase-2 app is fully functional without it). |
| LLM produces unsafe/invalid layout | Safety Supervisor validates and can bypass AI entirely; catalog allow-list. |
| Emergency-calling regulation & inability to test live | Treat emergency number as data; integrate platform emergency APIs; countdown + cancel; fake telephony + test mode. |
| False crash detection from sensor noise | Require corroboration (impulse + speed delta + bus signal); cancelable countdown before any auto-action. |
| AAOS / head-unit fragmentation & certification | Abstract all platform access behind repositories; target a reference head unit first; projection mode as graceful-degraded path. |
| Driver distraction / safety review | Driving-mode density limits enforced in renderer + Supervisor; design review against automotive HMI guidelines. |
| PII handling (medical ID, location, contacts) | On-device by default; explicit consent; redact in logs; share only when an incident is active and user-authorized. |

---

## 15. Phased implementation plan

Each phase ends with a **demoable artifact** and explicit **exit criteria**. The ordering deliberately delivers a working safety app *before* any AI.

### Phase 0 — Foundations & rendering harness *(de-risk the renderer)*
**Goal:** Prove the GenUI rendering pipeline with a mock transport, before any real catalog or AI.
**Build:** Repo + melos workspace, CI (analyze/test/golden), `freezed`/`riverpod_generator` codegen pipeline, design tokens (`SurfaceTheme`), `A2uiNode` model, `A2uiRenderer`, `DataModel`, a `MockTransport` that emits hand-authored A2UI JSON.
**Exit:** A hard-coded JSON layout renders on a tablet/AAOS emulator in landscape, day/night themes switch, data bindings update a value live.

### Phase 1 — Widget Catalog *(the vocabulary)*
**Goal:** Implement the full MVP catalog with all states; validate against the design mockups.
**Build:** All five component families (`SeverityBanner`, `GuidanceCallout`, `SOSCallButton`, `ShareLocationAction`, `CountdownCard`, `LocationCard`, `SafeRouteMap`, `StepChecklist`, `BigChoiceCard`, `MedicalIDCard`, containers…), each with default/active/loading/empty + golden tests; `catalogRegistry`; catalog manifest (AI-facing descriptions) authored.
**Exit:** Every design mockup (crash / being-followed / won't-start / medical) reproducible from hand-authored A2UI; golden suite green.

### Phase 2 — Deterministic safety app *(works with zero AI)*
**Goal:** A shippable, AI-free emergency app driven by sensors and the decision engine.
**Build:** Signal repositories (sensor, location, connectivity, battery; vehicle bus stubbed), `contextAggregator`, `DecisionEngine` + severity/mode tables, `DeterministicComposer` (hand-built Surface per MVP scenario), the Orchestrator loop (baseline only), `scenario_sim` harness for all 8 MVP scenarios.
**Exit:** All 8 MVP scenarios drive correct deterministic Surfaces end-to-end in the simulator and on-device; < 100 ms baseline render.

### Phase 3 — AI orchestration + Safety Supervisor
**Goal:** Layer AI enrichment on top, safely.
**Build:** `AiTransportRepository` against the Flutter GenUI SDK / model with streaming structured output, `AiComposer` (prompt from classification + manifest, A2UI parsing, progressive render), `SafetySupervisor` with full guardrail set, time-boxing + fallback wiring.
**Exit:** AI-composed Surfaces render and stream; Supervisor adversarial test suite passes; pulling the network mid-incident degrades cleanly to baseline with no safety loss.

### Phase 4 — Safety-critical subsystems
**Goal:** Real escalation capability.
**Build:** `TelephonyRepository` + `PlaceEmergencyCall` with countdown/cancel and emergency-number-as-data, `ShareLocation` + `NotifyContacts`, `VoiceRepository` (TTS proxy + STT/code word), offline guides + action queue.
**Exit:** Full escalation flow works against fake/sandbox endpoints in test mode; offline flat-tire and won't-start flows complete with queued actions; voice proxy reads location/medical ID on an active (sandbox) call.

### Phase 5 — Automotive integration & hardening
**Goal:** Run as a real infotainment app.
**Build:** AAOS embedding, `VehicleBusRepository` against `CarPropertyManager` (airbag/temps/fuel/charge), driving-vs-parked enforcement end-to-end, projection-mode degradation, day/night/contrast tuning, localization (ARB + locale emergency data), accessibility pass, observability/telemetry, performance tuning to 60 fps on reference hardware.
**Exit:** Runs on the reference head unit; vehicle signals drive classification; HMI distraction review passes; telemetry dashboards live.

### Phase 6 — Scenario expansion, QA & release
**Goal:** Broaden coverage and ship.
**Build:** Expand catalog + deterministic baselines + manifests beyond MVP (environmental, passenger-specific, crime/suspicious), documentation mode, hardening, beta, store/OEM submission.
**Exit:** Expanded scenario set passes the simulator + field beta; release candidate signed off.

---

## 16. Milestones & sequencing

| Milestone | Phases | Demoable outcome |
|---|---|---|
| **M1 — Renderer proven** | 0–1 | Any mockup rendered from JSON; full catalog with goldens. |
| **M2 — Safety app (no AI)** | 2 | 8 MVP scenarios fully working deterministically, on-device. |
| **M3 — AI on, safely** | 3 | AI enriches the screen; supervisor guarantees safety; clean offline fallback. |
| **M4 — It can actually call for help** | 4 | End-to-end escalation, location share, contacts, voice proxy, offline queue. |
| **M5 — In the car** | 5 | Running on the head unit with real vehicle signals; hardened. |
| **M6 — Shippable** | 6 | Expanded scenarios; beta-validated release candidate. |

**Critical path / parallelization:** Phases 0→1→2 are sequential (each depends on the last). Within Phase 2, signal repositories and the decision engine can be built in parallel. Phase 3's Supervisor work can start as soon as Phase 2's deterministic Surfaces exist (it needs a baseline to fall back to). Phase 4 telephony/regulatory research should begin early (long lead time) even while Phase 2–3 are in flight.

---

### Appendix — stack & key dependencies

| Concern | Choice |
|---|---|
| State management | Riverpod 2.0 + `riverpod_generator` (`@riverpod`) |
| Immutable models | `freezed` + `json_serializable` |
| Architecture | Feature-first clean architecture, Repository pattern |
| Reactive streams | `rxdart` for signal fusion |
| GenUI | Flutter GenUI SDK (A2UI structured layout) behind `AiTransportRepository` |
| Maps/routing | Pluggable behind `RoutingRepository` (safe-places only) |
| Telephony/location | Platform APIs behind repositories; emergency number as locale data |
| Testing | `flutter_test`, golden tests, custom `scenario_sim` harness |
| Workspace | `melos` (graduate `genui_render` + `domain` to packages once stable) |