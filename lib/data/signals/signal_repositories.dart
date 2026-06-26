import 'package:sos_emergency/domain/models/emergency_context.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';

/// Signal-source boundaries. Each exposes the latest snapshot of one input; the
/// context aggregator fuses them into an `EmergencyContext`. Real platform
/// impls (AAOS CarPropertyManager, GPS, etc.) arrive in Phase 5; Phase 2 ships
/// fakes.

abstract interface class SensorRepository {
  /// Whether a crash impulse has been detected (accelerometer/gyro).
  bool get crashImpulseDetected;

  /// Motion-derived vehicle state.
  VehicleState get vehicleState;

  /// Current speed in metres per second.
  double get speedMps;
}

abstract interface class LocationRepository {
  GeoPosition? get position;

  /// Whether it is night (cabin-light / clock derived).
  bool get isNight;
}

abstract interface class ConnectivityRepository {
  Connectivity get status;
}

abstract interface class VehicleBusRepository {
  /// The latest OBD-II / vehicle-bus snapshot, or null when unavailable.
  VehicleBusSnapshot? get snapshot;
}

abstract interface class UserSignalRepository {
  /// Discrete user signals collected this incident (taps, voice, code words).
  List<UserSignal> get signals;
}
