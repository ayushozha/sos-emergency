import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/application/ai_orchestration.dart';
import 'package:sos_emergency/application/orchestrator.dart';
import 'package:sos_emergency/application/telemetry.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';

void main() {
  test('the orchestrator records a loop event per composed surface', () async {
    final sink = RecordingTelemetrySink();
    final container = ProviderContainer(
      overrides: [telemetryProvider.overrideWithValue(sink)],
    );
    addTearDown(container.dispose);
    container.read(aiEnabledProvider.notifier).disable();
    container.listen(surfaceControllerProvider, (_, _) {});

    container.read(demoScenarioProvider.notifier).select(ScenarioClass.crash);
    await container.read(emergencyContextProvider.future);
    // Force the rebuild on the latest context so its event is recorded.
    container.read(surfaceControllerProvider);

    expect(sink.events, isNotEmpty);
    final last = sink.events.last;
    expect(last.scenario, 'crash');
    expect(last.mode, 'crash');
    expect(last.source, SurfaceSource.baseline);
    expect(last.toString(), contains('scenario: crash'));
  });
}
