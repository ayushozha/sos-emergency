import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/data/signals/context_aggregator.dart';
import 'package:sos_emergency/data/signals/signal_repositories.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';

class _FakeSensor implements SensorRepository {
  _FakeSensor({
    this.crashImpulseDetected = false,
    this.vehicleState = VehicleState.parked,
    this.speedMps = 0,
  });
  @override
  final bool crashImpulseDetected;
  @override
  final VehicleState vehicleState;
  @override
  final double speedMps;
}

class _FakeLocation implements LocationRepository {
  _FakeLocation({this.position, this.isNight = false});
  @override
  final GeoPosition? position;
  @override
  final bool isNight;
}

class _FakeConnectivity implements ConnectivityRepository {
  _FakeConnectivity(this.status);
  @override
  final Connectivity status;
}

class _FakeBus implements VehicleBusRepository {
  _FakeBus(this.snapshot);
  @override
  final VehicleBusSnapshot? snapshot;
}

class _FakeUserSignal implements UserSignalRepository {
  _FakeUserSignal(this.signals);
  @override
  final List<UserSignal> signals;
}

void main() {
  test('ContextAggregator fuses every signal snapshot into one context', () {
    final aggregator = ContextAggregator(
      sensor: _FakeSensor(
        crashImpulseDetected: true,
        vehicleState: VehicleState.driving,
        speedMps: 20,
      ),
      location: _FakeLocation(
        position: const GeoPosition(latitude: 1, longitude: 2),
        isNight: true,
      ),
      connectivity: _FakeConnectivity(Connectivity.offline),
      vehicleBus: _FakeBus(const VehicleBusSnapshot(fuelPercent: 4)),
      userSignal: _FakeUserSignal(
        const [UserSignal(intent: UserIntent.medical)],
      ),
    );

    final ctx = aggregator.build(at: DateTime(2026));

    expect(ctx.crashImpulseDetected, isTrue);
    expect(ctx.vehicleState, VehicleState.driving);
    expect(ctx.speedMps, 20);
    expect(ctx.isNight, isTrue);
    expect(ctx.connectivity, Connectivity.offline);
    expect(ctx.bus?.fuelPercent, 4);
    expect(ctx.latestIntent, UserIntent.medical);
    expect(ctx.position?.latitude, 1);
  });
}
