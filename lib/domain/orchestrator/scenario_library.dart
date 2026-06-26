import 'package:sos_emergency/domain/models/emergency_context.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';

/// A neutral, signal-free context — the idle/triage starting point.
EmergencyContext idleContext() => EmergencyContext(
  vehicleState: VehicleState.parked,
  speedMps: 0,
  connectivity: Connectivity.online,
  isNight: false,
  timestamp: DateTime(2026),
);

const _sf = GeoPosition(
  latitude: 37.7065,
  longitude: -122.4630,
  address: 'I-280 N, near exit 43B',
  detail: 'Daly City, CA · northbound shoulder',
);

/// Representative input contexts for each MVP scenario. Crafted so the
/// `DecisionEngine` classifies each into its matching `ScenarioClass`; the
/// single source of truth for both the on-device demo and the scenario_sim
/// tests.
Map<ScenarioClass, EmergencyContext> scenarioContexts() => {
  ScenarioClass.crash: idleContext().copyWith(
    vehicleState: VehicleState.stopped,
    crashImpulseDetected: true,
    bus: const VehicleBusSnapshot(airbagDeployed: true),
    position: _sf,
  ),
  ScenarioClass.medical: idleContext().copyWith(
    userSignals: const [UserSignal(intent: UserIntent.medical)],
    position: _sf,
  ),
  ScenarioClass.beingFollowed: idleContext().copyWith(
    vehicleState: VehicleState.driving,
    speedMps: 18,
    userSignals: const [UserSignal(intent: UserIntent.beingFollowed)],
    position: _sf,
  ),
  ScenarioClass.unsafeParked: idleContext().copyWith(
    isNight: true,
    userSignals: const [UserSignal(intent: UserIntent.feelUnsafe)],
    position: _sf,
  ),
  ScenarioClass.flatTire: idleContext().copyWith(
    vehicleState: VehicleState.stopped,
    bus: const VehicleBusSnapshot(
      tirePressureLow: true,
      profile: '2021 EV · run-flat tires · roadside plan active',
    ),
    position: _sf,
  ),
  ScenarioClass.wontStart: idleContext().copyWith(
    connectivity: Connectivity.offline,
    bus: const VehicleBusSnapshot(
      engineCranksNoStart: true,
      profile: '2021 EV · roadside plan active',
    ),
    position: _sf,
  ),
  ScenarioClass.lockedOut: idleContext().copyWith(
    userSignals: const [UserSignal(intent: UserIntent.lockedOut)],
    position: _sf,
  ),
  ScenarioClass.outOfGas: idleContext().copyWith(
    bus: const VehicleBusSnapshot(evChargePercent: 6, profile: '2021 EV'),
    userSignals: const [UserSignal(intent: UserIntent.outOfGas)],
    position: _sf,
  ),
  ScenarioClass.severeWeather: idleContext().copyWith(
    userSignals: const [UserSignal(intent: UserIntent.severeWeather)],
    hazards: const {Hazard.weather, Hazard.lowVisibility},
    position: _sf,
  ),
  ScenarioClass.stranded: idleContext().copyWith(
    userSignals: const [UserSignal(intent: UserIntent.stranded)],
    position: _sf,
  ),
  ScenarioClass.harassment: idleContext().copyWith(
    userSignals: const [UserSignal(intent: UserIntent.harassment)],
    position: _sf,
  ),
  ScenarioClass.documentIncident: idleContext().copyWith(
    userSignals: const [UserSignal(intent: UserIntent.document)],
    position: _sf,
  ),
  ScenarioClass.unknown: idleContext(),
};
