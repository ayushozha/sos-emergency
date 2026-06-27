import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/models/severity.dart';

/// Baseline severity tier per scenario, as a data table. Hazards can escalate
/// it (see [escalateForHazards]).
const Map<ScenarioClass, Severity> baselineSeverityTable = {
  ScenarioClass.crash: Severity.critical,
  ScenarioClass.medical: Severity.critical,
  ScenarioClass.beingFollowed: Severity.high,
  ScenarioClass.unsafeParked: Severity.high,
  ScenarioClass.harassment: Severity.high,
  ScenarioClass.severeWeather: Severity.high,
  ScenarioClass.flatTire: Severity.moderate,
  ScenarioClass.wontStart: Severity.moderate,
  ScenarioClass.lockedOut: Severity.moderate,
  ScenarioClass.outOfGas: Severity.moderate,
  ScenarioClass.stranded: Severity.moderate,
  ScenarioClass.documentIncident: Severity.neutral,
  ScenarioClass.unknown: Severity.neutral,
};

/// The baseline tier for a scenario before hazard escalation.
Severity baselineSeverityFor(ScenarioClass scenario) =>
    baselineSeverityTable[scenario] ?? Severity.moderate;

/// Raises [base] by one tier when a life-threatening hazard (fire/smoke) is
/// present — a fire on a flat-tire scene is no longer "moderate".
Severity escalateForHazards(Severity base, Set<Hazard> hazards) {
  final lifeThreatening =
      hazards.contains(Hazard.fire) || hazards.contains(Hazard.smoke);
  if (!lifeThreatening) return base;
  return switch (base) {
    Severity.neutral => Severity.moderate,
    Severity.moderate => Severity.high,
    Severity.high => Severity.critical,
    Severity.critical => Severity.critical,
  };
}
