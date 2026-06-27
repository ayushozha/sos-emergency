import 'dart:async';

import 'package:sos_emergency/domain/models/emergency_context.dart';

/// Streams optional vehicle snapshots (airbag, fuel/charge, tire pressure, door
/// locks). The tablet has no in-vehicle hardware, so a real source would be a
/// paired OBD dongle or manual triage entry; the engine degrades gracefully to
/// phone sensors + user triage when it's absent.
abstract interface class VehicleBusRepository {
  /// The latest snapshot whenever a monitored property changes.
  Stream<VehicleBusSnapshot> watch();

  Future<void> dispose();
}

/// A developer/test vehicle-signal source driven by code — push snapshots to
/// simulate a crash, a low battery, etc. The default vehicle-signal source.
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
