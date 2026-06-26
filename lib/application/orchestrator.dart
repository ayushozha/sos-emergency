import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/data/signals/context_aggregator.dart';
import 'package:sos_emergency/data/signals/scenario_context_repository.dart';
import 'package:sos_emergency/domain/engine/decision_engine.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/models/surface.dart';
import 'package:sos_emergency/domain/orchestrator/deterministic_composer.dart';
import 'package:sos_emergency/domain/orchestrator/scenario_library.dart';

part 'orchestrator.g.dart';

@Riverpod(keepAlive: true)
DecisionEngine decisionEngine(Ref ref) => const DecisionEngine();

@Riverpod(keepAlive: true)
DeterministicComposer deterministicComposer(Ref ref) =>
    const DeterministicComposer();

/// The scenario currently driving the on-device demo. A debug picker writes it;
/// in production this provider is replaced by live signal fusion.
@Riverpod(keepAlive: true)
class DemoScenario extends _$DemoScenario {
  @override
  ScenarioClass build() => ScenarioClass.unknown;

  // A named command reads better than a setter on a Notifier.
  // ignore: use_setters_to_change_properties
  void select(ScenarioClass scenario) => state = scenario;
}

/// The fused-context source. Phase 2 uses a scripted scenario source; Phase 5
/// swaps in a live [ContextAggregator] without touching the orchestrator.
@Riverpod(keepAlive: true)
EmergencyContextRepository emergencyContextRepository(Ref ref) =>
    ScenarioContextRepository(ref.watch(demoScenarioProvider));

@Riverpod(keepAlive: true)
Stream<EmergencyContext> emergencyContext(Ref ref) =>
    ref.watch(emergencyContextRepositoryProvider).watch();

/// The orchestrator's baseline loop: sense → classify → compose → render. Holds
/// the current deterministic [Surface] and recomputes it whenever the fused
/// context changes. No AI and no Safety Supervisor yet (Phase 3).
@Riverpod(keepAlive: true)
class SurfaceController extends _$SurfaceController {
  @override
  Surface build() {
    final ctx =
        ref.watch(emergencyContextProvider).asData?.value ?? idleContext();
    final classification = ref.watch(decisionEngineProvider).classify(ctx);
    return ref
        .watch(deterministicComposerProvider)
        .compose(classification, ctx);
  }
}
