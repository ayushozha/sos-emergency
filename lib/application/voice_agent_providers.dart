import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/application/escalation.dart';
import 'package:sos_emergency/application/voice_emergency_session.dart';
import 'package:sos_emergency/application/voice_session_controller.dart';
import 'package:sos_emergency/data/voice_session/backend_voice_agent_callbacks.dart';
import 'package:sos_emergency/data/voice_session/backend_voice_agent_session.dart';
import 'package:sos_emergency/data/voice_session/fake_voice_session.dart';
import 'package:sos_emergency/data/voice_session/voice_audio_io.dart';
import 'package:sos_emergency/data/voice_session/voice_session_repository.dart';

part 'voice_agent_providers.g.dart';

/// Routes voice-agent side effects into GenUI, TTS playback, and UI state.
class RiverpodVoiceAgentCallbacks implements BackendVoiceAgentCallbacks {
  RiverpodVoiceAgentCallbacks(this.ref);

  final Ref ref;

  @override
  void onA2uiDelta(String delta) {
    ref.read(voiceEmergencySessionProvider).ingestVoiceDelta(delta);
  }

  @override
  void onRenderDone() {
    final ids = ref
        .read(voiceEmergencySessionProvider)
        .controller
        .activeSurfaceIds;
    if (ids.isEmpty) return;
    ref.read(voiceSessionControllerProvider.notifier).setVoiceSurface(ids.last);
  }

  @override
  void onRenderStart(Map<String, Object?> info) {
    ref
        .read(voiceSessionControllerProvider.notifier)
        .setRendering(rendering: true);
  }

  @override
  void onTtsAudio(List<int> pcm16) {
    ref.read(voiceAudioIoProvider).playTtsPcm(pcm16);
  }

  @override
  void onCallEmergency() {
    ref.read(emergencyCallControllerProvider.notifier).callNow();
  }
}

@Riverpod(keepAlive: true)
VoiceAudioIo voiceAudioIo(Ref ref) {
  final io = createVoiceAudioIo();
  ref.onDispose(io.dispose);
  return io;
}

@Riverpod(keepAlive: true)
BackendVoiceAgentSession backendVoiceAgentSession(Ref ref) {
  return BackendVoiceAgentSession(
    wsUri: backendVoiceWsUri(),
    callbacks: RiverpodVoiceAgentCallbacks(ref),
  );
}

/// Live voice transport. Widget/unit tests get [FakeVoiceSession] unless
/// overridden.
@Riverpod(keepAlive: true)
VoiceSessionRepository voiceSession(Ref ref) {
  const inTest = bool.fromEnvironment('FLUTTER_TEST');
  if (inTest) return FakeVoiceSession();
  return ref.watch(backendVoiceAgentSessionProvider);
}
