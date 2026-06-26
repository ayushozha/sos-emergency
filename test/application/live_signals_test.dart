import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/application/live_signals.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';

import '../support/node_finder.dart';

void main() {
  group('live signal fusion drives classification', () {
    test('starts at triage with no signals', () {
      final c = ProviderContainer();
      addTearDown(c.dispose);
      expect(
        c.read(liveClassificationProvider).scenario,
        ScenarioClass.unknown,
      );
    });

    test('an airbag signal reclassifies to crash and recomposes', () {
      final c = ProviderContainer();
      addTearDown(c.dispose);

      c
          .read(liveContextProvider.notifier)
          .onVehicleBus(const VehicleBusSnapshot(airbagDeployed: true));

      expect(c.read(liveClassificationProvider).scenario, ScenarioClass.crash);
      final surface = c.read(liveSurfaceProvider);
      expect(surface.mode, AppMode.crash);
      expect(containsType(surface.root, 'CountdownCard'), isTrue);
    });

    test('a low-fuel signal reclassifies to out-of-gas', () {
      final c = ProviderContainer();
      addTearDown(c.dispose);

      c
          .read(liveContextProvider.notifier)
          .onVehicleBus(const VehicleBusSnapshot(fuelPercent: 3));

      expect(
        c.read(liveClassificationProvider).scenario,
        ScenarioClass.outOfGas,
      );
    });

    test('a voice intent surfaces as being-followed', () {
      final c = ProviderContainer();
      addTearDown(c.dispose);

      c
          .read(liveContextProvider.notifier)
          .onUserSignal(const UserSignal(intent: UserIntent.beingFollowed));

      expect(
        c.read(liveClassificationProvider).scenario,
        ScenarioClass.beingFollowed,
      );
    });
  });
}
