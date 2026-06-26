import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sos_emergency/data/vehicle/vehicle_bus_repository.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';

/// AAOS-backed vehicle bus, reading `CarPropertyManager` over a platform
/// `EventChannel`. The native side (an Android Automotive plugin that
/// subscribes to airbag / fuel / EV-charge / tire-pressure properties and
/// forwards them as a map) is **not implemented in this repo** — this is the
/// Dart seam it plugs into. Falls back to silence when the channel is
/// unavailable (projection mode), so callers degrade gracefully.
class CarPropertyVehicleBus implements VehicleBusRepository {
  CarPropertyVehicleBus({
    this.channel = const EventChannel('sos_emergency/vehicle_bus'),
  });

  final EventChannel channel;

  @override
  Stream<VehicleBusSnapshot> watch() {
    return channel
        .receiveBroadcastStream()
        .map((event) => _fromPlatform((event as Map).cast<String, Object?>()))
        .handleError((Object _) {
          // Property channel unavailable (projection) — degrade to silence.
        });
  }

  VehicleBusSnapshot _fromPlatform(Map<String, Object?> p) =>
      VehicleBusSnapshot(
        airbagDeployed: p['airbagDeployed'] as bool? ?? false,
        engineCranksNoStart: p['engineCranksNoStart'] as bool? ?? false,
        tirePressureLow: p['tirePressureLow'] as bool? ?? false,
        doorsLocked: p['doorsLocked'] as bool? ?? false,
        fuelPercent: p['fuelPercent'] as int?,
        evChargePercent: p['evChargePercent'] as int?,
        profile: p['profile'] as String?,
      );

  @override
  Future<void> dispose() async {}
}
