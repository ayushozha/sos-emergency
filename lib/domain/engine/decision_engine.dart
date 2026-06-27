import 'package:sos_emergency/domain/engine/mode_router.dart';
import 'package:sos_emergency/domain/engine/severity_rules.dart';
import 'package:sos_emergency/domain/models/classification.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';

/// The deterministic safety brain. Pure Dart, fully unit-testable, no AI. Maps
/// an [EmergencyContext] to a [Classification].
///
/// Ordering matters: hard sensor triggers (highest confidence) win first, then
/// explicit user intent, then corroborated vehicle-bus signals, then a triage
/// fallback. The AI never participates here.
class DecisionEngine {
  const DecisionEngine();

  Classification classify(EmergencyContext ctx) {
    final scenario = _scenarioFor(ctx);
    final severity = escalateForHazards(
      baselineSeverityFor(scenario),
      ctx.hazards,
    );
    return Classification(
      scenario: scenario,
      severity: severity,
      mode: modeFor(scenario),
      confidence: _confidenceFor(scenario, ctx),
      hazards: ctx.hazards,
    );
  }

  ScenarioClass _scenarioFor(EmergencyContext ctx) {
    final bus = ctx.bus;

    // 1) Hard triggers — airbag / detected crash impulse.
    if (ctx.crashImpulseDetected || (bus?.airbagDeployed ?? false)) {
      return ScenarioClass.crash;
    }

    // 2) Explicit user intent.
    switch (ctx.latestIntent) {
      case UserIntent.crash:
        return ScenarioClass.crash;
      case UserIntent.medical:
        return ScenarioClass.medical;
      case UserIntent.beingFollowed:
      case UserIntent.feelUnsafe:
        // At night while parked, "feel unsafe" is the unsafe-parked scenario;
        // otherwise it's an active being-followed threat.
        if (ctx.latestIntent == UserIntent.feelUnsafe &&
            ctx.vehicleState == VehicleState.parked &&
            ctx.isNight) {
          return ScenarioClass.unsafeParked;
        }
        return ScenarioClass.beingFollowed;
      case UserIntent.lockedOut:
        return ScenarioClass.lockedOut;
      case UserIntent.outOfGas:
        return ScenarioClass.outOfGas;
      case UserIntent.harassment:
        return ScenarioClass.harassment;
      case UserIntent.severeWeather:
        return ScenarioClass.severeWeather;
      case UserIntent.stranded:
        return ScenarioClass.stranded;
      case UserIntent.document:
        return ScenarioClass.documentIncident;
      case UserIntent.roadside:
      case UserIntent.carProblem:
        return _vehicleScenario(bus) ?? ScenarioClass.unknown;
      case UserIntent.none:
        break;
    }

    // 3) Corroborated vehicle-bus signals (no explicit intent).
    final vehicle = _vehicleScenario(bus);
    if (vehicle != null) return vehicle;

    // 4) Triage fallback.
    return ScenarioClass.unknown;
  }

  /// Derives a mechanical scenario from bus signals, most-urgent first.
  ScenarioClass? _vehicleScenario(VehicleBusSnapshot? bus) {
    if (bus == null) return null;
    if (bus.engineCranksNoStart) return ScenarioClass.wontStart;
    if (bus.tirePressureLow) return ScenarioClass.flatTire;
    if ((bus.fuelPercent ?? 100) <= 5 || (bus.evChargePercent ?? 100) <= 8) {
      return ScenarioClass.outOfGas;
    }
    return null;
  }

  double _confidenceFor(ScenarioClass scenario, EmergencyContext ctx) {
    if (scenario == ScenarioClass.crash &&
        (ctx.crashImpulseDetected || (ctx.bus?.airbagDeployed ?? false))) {
      return 0.99;
    }
    if (scenario == ScenarioClass.unknown) return 0.4;
    if (ctx.latestIntent != UserIntent.none) return 0.9;
    return 0.75;
  }
}
