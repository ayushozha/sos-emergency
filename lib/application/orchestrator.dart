import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/application/ai_orchestration.dart';
import 'package:sos_emergency/application/telemetry.dart';
import 'package:sos_emergency/data/signals/context_aggregator.dart';
import 'package:sos_emergency/data/signals/scenario_context_repository.dart';
import 'package:sos_emergency/domain/engine/decision_engine.dart';
import 'package:sos_emergency/domain/models/classification.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/models/surface.dart';
import 'package:sos_emergency/domain/orchestrator/deterministic_composer.dart';
import 'package:sos_emergency/domain/orchestrator/scenario_library.dart';

part 'orchestrator.g.dart';

/// How the running app chooses what to paint in [SurfaceHost].
enum SurfaceViewMode { live, handoff, catalog }

@Riverpod(keepAlive: true)
DecisionEngine decisionEngine(Ref ref) => const DecisionEngine();

@Riverpod(keepAlive: true)
DeterministicComposer deterministicComposer(Ref ref) =>
    const DeterministicComposer();

@Riverpod(keepAlive: true)
class DemoScenario extends _$DemoScenario {
  @override
  ScenarioClass build() => ScenarioClass.unknown;

  // ignore: use_setters_to_change_properties
  void select(ScenarioClass scenario) => state = scenario;
}

@Riverpod(keepAlive: true)
class SurfaceViewModeController extends _$SurfaceViewModeController {
  @override
  SurfaceViewMode build() => SurfaceViewMode.handoff;

  // ignore: use_setters_to_change_properties
  void select(SurfaceViewMode mode) => state = mode;
}

@Riverpod(keepAlive: true)
class HandoffScreenPicker extends _$HandoffScreenPicker {
  @override
  String build() => 'opening_triage';

  // ignore: use_setters_to_change_properties
  void select(String name) => state = name;
}

@Riverpod(keepAlive: true)
EmergencyContextRepository emergencyContextRepository(Ref ref) =>
    ScenarioContextRepository(ref.watch(demoScenarioProvider));

@Riverpod(keepAlive: true)
Stream<EmergencyContext> emergencyContext(Ref ref) =>
    ref.watch(emergencyContextRepositoryProvider).watch();

/// The orchestrator loop: sense → classify → compose → validate → render.
///
/// The deterministic baseline is enforced by the Safety Supervisor and rendered
/// immediately. Best-effort AI enrichment is then kicked off, time-boxed; if it
/// returns a valid surface in time it replaces the baseline (after passing the
/// Supervisor), otherwise the baseline stays. The AI is never on the critical
/// path and can never remove a safety capability.
@Riverpod(keepAlive: true)
class SurfaceController extends _$SurfaceController {
  int _generation = 0;

  @override
  Surface build() {
    final ctx =
        ref.watch(emergencyContextProvider).asData?.value ?? idleContext();
    final classification = ref.watch(decisionEngineProvider).classify(ctx);
    final baseline = ref
        .watch(deterministicComposerProvider)
        .compose(classification, ctx);
    final enforced = ref
        .watch(safetySupervisorProvider)
        .enforce(baseline, baseline: baseline, classification: classification);

    ref
        .read(telemetryProvider)
        .record(
          loopEventFor(
            classification,
            source: SurfaceSource.baseline,
            isFallback: enforced.isFallback,
          ),
        );

    final generation = ++_generation;
    final online = ctx.connectivity != Connectivity.offline;
    if (online && ref.watch(aiEnabledProvider)) {
      unawaited(_enrich(generation, classification, ctx, enforced));
    }
    return enforced;
  }

  /// Best-effort, time-boxed AI enrichment. Silently keeps the baseline on any
  /// timeout, transport failure, or supervisor rejection.
  Future<void> _enrich(
    int generation,
    Classification classification,
    EmergencyContext ctx,
    Surface baseline,
  ) async {
    try {
      final root = await ref
          .read(aiComposerProvider)
          .compose(classification, ctx)
          .timeout(aiTimeBudget);
      if (generation != _generation) return;
      final proposed = Surface(
        mode: classification.mode,
        severity: classification.severity,
        root: root,
        isFallback: false,
      );
      final enforced = ref
          .read(safetySupervisorProvider)
          .enforce(
            proposed,
            baseline: baseline,
            classification: classification,
          );
      state = enforced;
      ref
          .read(telemetryProvider)
          .record(
            loopEventFor(
              classification,
              source: SurfaceSource.ai,
              isFallback: enforced.isFallback,
            ),
          );
    } on Object {
      // Network drop / timeout / invalid layout — the baseline already renders.
    }
  }
}