import 'dart:async';

import 'package:sos_emergency/domain/models/emergency_context.dart';

/// Streams vehicle-bus / OBD-II snapshots (airbag, fuel/charge, tire pressure,
/// door locks). On AAOS this is backed by `CarPropertyManager`; in projection
/// mode many properties are unavailable and it degrades gracefully.
abstract interface class VehicleBusRepository {
  /// The latest snapshot whenever a monitored property changes.
  Stream<VehicleBusSnapshot> watch();

  Future<void> dispose();
}

/// A developer/test vehicle bus that can be driven by code — push snapshots to
/// simulate a crash, a low battery, etc. Stands in until the AAOS impl exists.
class SimulatedVehicleBusRepository implements VehicleBusRepository {
  SimulatedVehicleBusRepository([
    VehicleBusSnapshot initial = const VehicleBusSnapshot(),
  ]) {
    _latest = initial;
  }

  final StreamController<VehicleBusSnapshot> _controller =
      StreamController<VehicleBusSnapshot>.broadcast();
  late VehicleBusSnapshot _latest;

  VehicleBusSnapshot get latest => _latest;

  /// Emits a new snapshot to listeners.
  void push(VehicleBusSnapshot snapshot) {
    _latest = snapshot;
    _controller.add(snapshot);
  }

  @override
  Stream<VehicleBusSnapshot> watch() => _controller.stream;

  @override
  Future<void> dispose() => _controller.close();
}
