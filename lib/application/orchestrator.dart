import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/data/signals/context_aggregator.dart';
import 'package:sos_emergency/data/signals/scenario_context_repository.dart';
import 'package:sos_emergency/domain/engine/decision_engine.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/models/surface.dart';
import 'package:sos_emergency/domain/orchestrator/ai_composer.dart';
import 'package:sos_emergency/domain/orchestrator/deterministic_composer.dart';
import 'package:sos_emergency/domain/orchestrator/scenario_library.dart';

part 'orchestrator.g.dart';

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
EmergencyContextRepository emergencyContextRepository(Ref ref) =>
    ScenarioContextRepository(ref.watch(demoScenarioProvider));

@Riverpod(keepAlive: true)
Stream<EmergencyContext> emergencyContext(Ref ref) =>
    ref.watch(emergencyContextRepositoryProvider).watch();

/// Sense → classify → compose (AI with deterministic fallback) → render.
@Riverpod(keepAlive: true)
class SurfaceController extends _$SurfaceController {
  @override
  Future<Surface> build() async {
    final ctx =
        ref.watch(emergencyContextProvider).asData?.value ?? idleContext();
    final classification = ref.watch(decisionEngineProvider).classify(ctx);
    final baseline = ref
        .watch(deterministicComposerProvider)
        .compose(classification, ctx);

    if (ref.watch(useBackendComposeProvider)) {
      final aiRoot = await ref
          .read(aiComposerProvider.notifier)
          .tryCompose(classification, ctx);
      if (aiRoot != null) {
        return Surface(
          mode: classification.mode,
          severity: classification.severity,
          root: aiRoot,
        );
      }
    }

    return baseline;
  }
}