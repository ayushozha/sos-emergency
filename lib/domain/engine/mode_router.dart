import 'package:sos_emergency/domain/models/emergency_enums.dart';

/// Scenario → interaction mode. Held as a data table so the mapping is
/// auditable and testable, not buried in control flow.
const Map<ScenarioClass, AppMode> scenarioModeTable = {
  ScenarioClass.crash: AppMode.crash,
  ScenarioClass.medical: AppMode.medical,
  ScenarioClass.beingFollowed: AppMode.threat,
  ScenarioClass.unsafeParked: AppMode.threat,
  ScenarioClass.harassment: AppMode.threat,
  ScenarioClass.flatTire: AppMode.roadside,
  ScenarioClass.wontStart: AppMode.roadside,
  ScenarioClass.lockedOut: AppMode.roadside,
  ScenarioClass.outOfGas: AppMode.roadside,
  ScenarioClass.stranded: AppMode.roadside,
  ScenarioClass.severeWeather: AppMode.roadside,
  ScenarioClass.documentIncident: AppMode.documentation,
  ScenarioClass.unknown: AppMode.triage,
};

/// The mode a scenario routes to.
AppMode modeFor(ScenarioClass scenario) =>
    scenarioModeTable[scenario] ?? AppMode.triage;
