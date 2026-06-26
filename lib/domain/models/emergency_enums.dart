/// The MVP scenario the deterministic engine classifies an incident into.
enum ScenarioClass {
  crash,
  medical,
  beingFollowed,
  flatTire,
  wontStart,
  lockedOut,
  outOfGas,
  unsafeParked,
  unknown,
}

/// The interaction mode a scenario maps to — drives which deterministic Surface
/// the composer builds.
enum AppMode { triage, crash, medical, threat, roadside }

/// Network state. The app degrades layout and queues actions when offline.
enum Connectivity { online, degraded, offline }

/// Vehicle motion state, richer than the UI's day/night `carState` token.
enum VehicleState { driving, stopped, parked, stuck, unknown }

/// Explicit user intent extracted from taps / voice / code words.
enum UserIntent {
  none,
  carProblem,
  crash,
  medical,
  feelUnsafe,
  beingFollowed,
  lockedOut,
  roadside,
  outOfGas,
  document,
}

/// Environmental hazards that can raise a scenario's urgency on their own.
enum Hazard { smoke, fire, weather, lowVisibility }

/// Maps the engine's [VehicleState] to the UI's binary `carState` token.
extension VehicleStateToken on VehicleState {
  String get carStateToken =>
      this == VehicleState.driving ? 'driving' : 'parked';
}
