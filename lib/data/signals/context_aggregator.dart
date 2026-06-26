import 'package:sos_emergency/data/signals/signal_repositories.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';

/// The fused-context boundary the orchestrator consumes. Concrete sources
/// either aggregate live signal repositories or, for the demo/sim, replay a
/// scripted scenario.
// ignore: one_member_abstracts
abstract interface class EmergencyContextRepository {
  Stream<EmergencyContext> watch();
}

/// Fuses the latest snapshot of every signal repository into a single
/// [EmergencyContext]. Pure and synchronous — the reactive plumbing that turns
/// signal changes into a stream lands with the platform impls in Phase 5.
class ContextAggregator {
  const ContextAggregator({
    required this.sensor,
    required this.location,
    required this.connectivity,
    required this.vehicleBus,
    required this.userSignal,
  });

  final SensorRepository sensor;
  final LocationRepository location;
  final ConnectivityRepository connectivity;
  final VehicleBusRepository vehicleBus;
  final UserSignalRepository userSignal;

  /// Builds the current fused context.
  EmergencyContext build({DateTime? at}) => EmergencyContext(
    vehicleState: sensor.vehicleState,
    speedMps: sensor.speedMps,
    connectivity: connectivity.status,
    isNight: location.isNight,
    crashImpulseDetected: sensor.crashImpulseDetected,
    position: location.position,
    bus: vehicleBus.snapshot,
    userSignals: userSignal.signals,
    timestamp: at ?? DateTime.now(),
  );
}
