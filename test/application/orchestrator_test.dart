import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/application/orchestrator.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/models/severity.dart';

void main() {
  group('orchestrator baseline loop', () {
    test('starts on the triage surface before any signal', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final surface = container.read(surfaceControllerProvider);
      expect(surface.mode, AppMode.triage);
      expect(surface.isFallback, isTrue);
    });

    test(
      'selecting a scenario drives the matching deterministic Surface',
      () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);
        // Subscribe so the context stream starts emitting.
        container.listen(surfaceControllerProvider, (_, _) {});

        container
            .read(demoScenarioProvider.notifier)
            .select(ScenarioClass.crash);
        await container.read(emergencyContextProvider.future);

        final surface = container.read(surfaceControllerProvider);
        expect(surface.mode, AppMode.crash);
        expect(surface.severity, Severity.critical);
        expect(surface.root.props['tier'], 'critical');
      },
    );

    test('switching scenarios recomposes the Surface', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      container.listen(surfaceControllerProvider, (_, _) {});

      container
          .read(demoScenarioProvider.notifier)
          .select(ScenarioClass.flatTire);
      await container.read(emergencyContextProvider.future);
      expect(container.read(surfaceControllerProvider).mode, AppMode.roadside);

      container
          .read(demoScenarioProvider.notifier)
          .select(ScenarioClass.beingFollowed);
      await container.read(emergencyContextProvider.future);
      expect(container.read(surfaceControllerProvider).mode, AppMode.threat);
    });
  });
}
