import 'package:sos_emergency/data/signals/context_aggregator.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/orchestrator/scenario_library.dart';

/// A demo/sim context source that replays the scripted [EmergencyContext] for a
/// chosen scenario. Drives the on-device deterministic app (via a scenario
/// picker) and the scenario_sim harness, standing in for live signal fusion
/// until the platform repositories exist.
class ScenarioContextRepository implements EmergencyContextRepository {
  ScenarioContextRepository(this.scenario);

  final ScenarioClass scenario;

  @override
  Stream<EmergencyContext> watch() async* {
    yield scenarioContexts()[scenario]!;
  }
}
