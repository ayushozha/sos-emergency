import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/data/vehicle/vehicle_bus_repository.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';

void main() {
  test('SimulatedVehicleBusRepository streams pushed snapshots', () async {
    final repo = SimulatedVehicleBusRepository();
    addTearDown(repo.dispose);

    final received = <VehicleBusSnapshot>[];
    final sub = repo.watch().listen(received.add);

    repo
      ..push(const VehicleBusSnapshot(tirePressureLow: true))
      ..push(const VehicleBusSnapshot(fuelPercent: 5));
    await pumpEventQueue();

    expect(received, hasLength(2));
    expect(received.first.tirePressureLow, isTrue);
    expect(received.last.fuelPercent, 5);
    expect(repo.latest.fuelPercent, 5);

    await sub.cancel();
  });
}
