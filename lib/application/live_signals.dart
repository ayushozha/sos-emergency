import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/application/ai_orchestration.dart';
import 'package:sos_emergency/application/orchestrator.dart';
import 'package:sos_emergency/data/vehicle/vehicle_bus_repository.dart';
import 'package:sos_emergency/domain/models/classification.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/models/surface.dart';
import 'package:sos_emergency/domain/orchestrator/scenario_library.dart';

part 'live_signals.g.dart';

/// The (optional) vehicle-signal source. Defaults to a simulated bus; on a
/// tablet there is no in-vehicle hardware, so a real source would be a paired
/// OBD dongle or manual triage entry.
@Riverpod(keepAlive: true)
VehicleBusRepository vehicleBus(Ref ref) {
  final repo = SimulatedVehicleBusRepository();
  ref.onDispose(repo.dispose);
  return repo;
}

/// The live fused [EmergencyContext], mutated by signal sources as they fire.
/// This is the production replacement for the scripted scenario source: feed it
/// real sensor/bus/intent signals and the classification follows automatically.
@Riverpod(keepAlive: true)
class LiveContext extends _$LiveContext {
  StreamSubscription<VehicleBusSnapshot>? _busSub;

  @override
  EmergencyContext build() {
    // Fuse the vehicle bus stream into the context as it ticks.
    _busSub = ref.watch(vehicleBusProvider).watch().listen(onVehicleBus);
    ref.onDispose(() => _busSub?.cancel());
    return idleContext();
  }

  void onVehicleBus(VehicleBusSnapshot bus) =>
      state = state.copyWith(bus: bus, timestamp: DateTime.now());

  void onCrashImpulse() => state = state.copyWith(
    crashImpulseDetected: true,
    timestamp: DateTime.now(),
  );

  void onUserSignal(UserSignal signal) => state = state.copyWith(
    userSignals: [...state.userSignals, signal],
    timestamp: DateTime.now(),
  );

  void onConnectivity(Connectivity connectivity) => state = state.copyWith(
    connectivity: connectivity,
    timestamp: DateTime.now(),
  );

  void onMotion({
    required VehicleState vehicleState,
    required double speedMps,
  }) => state = state.copyWith(
    vehicleState: vehicleState,
    speedMps: speedMps,
    timestamp: DateTime.now(),
  );

  void onNight({required bool isNight}) =>
      state = state.copyWith(isNight: isNight, timestamp: DateTime.now());
}

/// The classification of the live context — recomputes whenever a signal fires.
@Riverpod(keepAlive: true)
Classification liveClassification(Ref ref) {
  final ctx = ref.watch(liveContextProvider);
  return ref.watch(decisionEngineProvider).classify(ctx);
}

/// The deterministic Surface for the live context, Supervisor-enforced.
@Riverpod(keepAlive: true)
Surface liveSurface(Ref ref) {
  final ctx = ref.watch(liveContextProvider);
  final classification = ref.watch(liveClassificationProvider);
  final baseline = ref
      .watch(deterministicComposerProvider)
      .compose(classification, ctx);
  return ref
      .watch(safetySupervisorProvider)
      .enforce(baseline, baseline: baseline, classification: classification);
}
