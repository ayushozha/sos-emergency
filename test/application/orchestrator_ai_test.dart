// Tests read several providers off one container, interleaved with awaits and
// expects, where cascades don't compose cleanly.
// ignore_for_file: cascade_invocations
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/application/ai_orchestration.dart';
import 'package:sos_emergency/application/orchestrator.dart';
import 'package:sos_emergency/data/ai_transport/ai_transport_repository.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';

import '../support/fake_ai_transport.dart';
import '../support/node_finder.dart';

// A distinctive AI surface so we can tell it apart from any baseline.
const _aiSurface = A2uiNode(
  type: 'EmergencyRoot',
  children: [
    A2uiNode(
      type: 'GuidanceCallout',
      props: {'tier': 'critical', 'text': 'AI: pull over now'},
    ),
  ],
);

ProviderContainer _container(FakeAiTransport transport) {
  final container = ProviderContainer(
    overrides: [aiTransportProvider.overrideWithValue(transport)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('orchestrator AI enrichment + safe fallback', () {
    test('a valid AI surface replaces the baseline after enrichment', () async {
      final transport = FakeAiTransport(surface: _aiSurface);
      final container = _container(transport);
      container.listen(surfaceControllerProvider, (_, _) {});

      container.read(demoScenarioProvider.notifier).select(ScenarioClass.crash);
      await container.read(emergencyContextProvider.future);

      // Baseline renders immediately...
      expect(container.read(surfaceControllerProvider).isFallback, isTrue);

      // ...then enrichment swaps in the AI surface.
      await pumpEventQueue();
      final surface = container.read(surfaceControllerProvider);
      expect(surface.isFallback, isFalse);
      expect(containsType(surface.root, 'GuidanceCallout'), isTrue);
    });

    test('a failed compose call degrades cleanly to the baseline', () async {
      final transport = FakeAiTransport(
        error: const AiTransportException('boom', statusCode: 503),
      );
      final container = _container(transport);
      container.listen(surfaceControllerProvider, (_, _) {});

      container.read(demoScenarioProvider.notifier).select(ScenarioClass.crash);
      await container.read(emergencyContextProvider.future);
      await pumpEventQueue();

      final surface = container.read(surfaceControllerProvider);
      expect(surface.isFallback, isTrue);
      expect(containsType(surface.root, 'CountdownCard'), isTrue);
    });

    test(
      'offline never calls the AI and keeps the deterministic baseline',
      () async {
        final transport = FakeAiTransport(surface: _aiSurface);
        final container = _container(transport);
        container.listen(surfaceControllerProvider, (_, _) {});

        // wont_start is an offline scenario.
        container
            .read(demoScenarioProvider.notifier)
            .select(ScenarioClass.wontStart);
        await container.read(emergencyContextProvider.future);
        await pumpEventQueue();

        final surface = container.read(surfaceControllerProvider);
        expect(surface.isFallback, isTrue);
        expect(containsType(surface.root, 'OfflineBanner'), isTrue);
        expect(containsType(surface.root, 'GuidanceCallout'), isFalse);
      },
    );

    test('AI can be disabled to run the deterministic app only', () async {
      final transport = FakeAiTransport(surface: _aiSurface);
      final container = _container(transport);
      container.read(aiEnabledProvider.notifier).disable();
      container.listen(surfaceControllerProvider, (_, _) {});

      container.read(demoScenarioProvider.notifier).select(ScenarioClass.crash);
      await container.read(emergencyContextProvider.future);
      await pumpEventQueue();

      expect(container.read(surfaceControllerProvider).isFallback, isTrue);
      expect(transport.calls, 0);
    });
  });
}
