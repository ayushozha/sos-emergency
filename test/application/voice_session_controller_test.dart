import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/application/ai_orchestration.dart';
import 'package:sos_emergency/application/orchestrator.dart';
import 'package:sos_emergency/application/voice_session_controller.dart';
import 'package:sos_emergency/data/api/api_enums.dart';
import 'package:sos_emergency/data/voice_session/fake_voice_session.dart';
import 'package:sos_emergency/data/voice_session/models/voice_server_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_session_config.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';

import '../support/node_finder.dart';

const _config = VoiceSessionConfig(
  locale: 'en-US',
  sampleRate: 16000,
  codec: AudioCodec.opus,
);

void main() {
  group('VoiceSessionController', () {
    test(
      'goes live on session.ready and surfaces recognised intents',
      () async {
        final fake = FakeVoiceSession();
        final c = ProviderContainer(
          overrides: [voiceSessionProvider.overrideWithValue(fake)],
        );
        addTearDown(c.dispose);

        c.read(voiceSessionControllerProvider.notifier).connect(_config);
        await pumpEventQueue();
        expect(
          c.read(voiceSessionControllerProvider).status,
          VoiceSessionStatus.live,
        );

        fake.emit(
          const VoiceServerFrame.intent(
            intent: VoiceIntent.carProblem,
            confidence: 0.9,
          ),
        );
        await pumpEventQueue();
        expect(
          c.read(voiceSessionControllerProvider).lastIntent,
          VoiceIntent.carProblem,
        );
      },
    );

    test('a failed voice session never blocks screen composition', () async {
      final fake = FakeVoiceSession();
      final c = ProviderContainer(
        overrides: [voiceSessionProvider.overrideWithValue(fake)],
      );
      addTearDown(c.dispose);
      c.read(aiEnabledProvider.notifier).disable();

      // Drive a fatal voice error.
      c.read(voiceSessionControllerProvider.notifier).connect(_config);
      await pumpEventQueue();
      fake.emit(
        const VoiceServerFrame.error(
          code: 'reconnect_failed',
          message: 'gone',
          fatal: true,
        ),
      );
      await pumpEventQueue();
      expect(
        c.read(voiceSessionControllerProvider).status,
        VoiceSessionStatus.error,
      );

      // The composition path is unaffected.
      c.listen(surfaceControllerProvider, (_, _) {});
      c.read(demoScenarioProvider.notifier).select(ScenarioClass.crash);
      await c.read(emergencyContextProvider.future);
      final surface = c.read(surfaceControllerProvider);
      expect(surface.mode, AppMode.crash);
      expect(containsType(surface.root, 'CountdownCard'), isTrue);
    });
  });
}
