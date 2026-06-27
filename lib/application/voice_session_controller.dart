import 'dart:async';

import 'package:genui/genui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/application/voice_agent_providers.dart';
import 'package:sos_emergency/application/voice_emergency_session.dart';
import 'package:sos_emergency/data/api/api_enums.dart';
import 'package:sos_emergency/data/voice_session/backend_voice_agent_session.dart';
import 'package:sos_emergency/data/voice_session/models/voice_client_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_server_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_session_config.dart';
import 'package:sos_emergency/data/voice_session/voice_audio_io.dart';

part 'voice_session_controller.g.dart';

enum VoiceSessionStatus { idle, connecting, live, error }

/// Drives the live voice session: mic → backend agent WS → TTS + A2UI.
@Riverpod(keepAlive: true)
class VoiceSessionController extends _$VoiceSessionController {
  StreamSubscription<VoiceServerFrame>? _sub;
  StreamSubscription<ConversationEvent>? _surfaceSub;
  BackendVoiceAgentSession? _backend;
  VoiceAudioIo? _audio;

  @override
  ({
    VoiceSessionStatus status,
    VoiceIntent? lastIntent,
    String? transcript,
    String? voiceSurfaceId,
    bool isRendering,
  })
  build() {
    ref.onDispose(() {
      unawaited(_sub?.cancel());
      unawaited(_surfaceSub?.cancel());
      unawaited(_audio?.stopMic());
      if (_backend != null) unawaited(_backend!.disconnect());
    });
    return (
      status: VoiceSessionStatus.idle,
      lastIntent: null,
      transcript: null,
      voiceSurfaceId: null,
      isRendering: false,
    );
  }

  Future<void> connect(VoiceSessionConfig config) async {
    await _sub?.cancel();
    _sub = null;
    await _surfaceSub?.cancel();
    _surfaceSub = null;
    await _audio?.stopMic();
    _audio = null;
    if (_backend != null) {
      await _backend!.disconnect();
      _backend = null;
    }

    state = (
      status: VoiceSessionStatus.connecting,
      lastIntent: state.lastIntent,
      transcript: null,
      voiceSurfaceId: null,
      isRendering: false,
    );

    final repo = ref.read(voiceSessionProvider);
    if (repo is BackendVoiceAgentSession) {
      _backend = repo;
      final voiceSession = ref.read(voiceEmergencySessionProvider);
      repo.configure(
        systemPrompt: voiceSession.systemPrompt,
        model: kVoiceRenderModel.isEmpty ? null : kVoiceRenderModel,
      );
      // Reveal the voice surface the moment it's created mid-stream, rather
      // than waiting for the render's terminal `done` frame — the render model
      // can take many seconds, and the function-call may end before `done`.
      _surfaceSub = voiceSession.conversation.events.listen((event) {
        if (event is ConversationSurfaceAdded) {
          setVoiceSurface(event.surfaceId);
        }
      });
      _audio = ref.read(voiceAudioIoProvider);
      await _audio!.startMic(repo.sendAudio);
    }

    _sub = repo
        .connect(config)
        .listen(
          _onFrame,
          onError: (_) {
            state = (
              status: VoiceSessionStatus.error,
              lastIntent: state.lastIntent,
              transcript: state.transcript,
              voiceSurfaceId: state.voiceSurfaceId,
              isRendering: false,
            );
          },
        );
  }

  void send(VoiceClientFrame frame) =>
      ref.read(voiceSessionProvider).send(frame);

  Future<void> disconnect() async {
    await _sub?.cancel();
    _sub = null;
    await _surfaceSub?.cancel();
    _surfaceSub = null;
    await _audio?.stopMic();
    _audio = null;
    if (_backend != null) {
      await _backend!.disconnect();
      _backend = null;
    }
    state = (
      status: VoiceSessionStatus.idle,
      lastIntent: state.lastIntent,
      transcript: null,
      voiceSurfaceId: null,
      isRendering: false,
    );
  }

  void clearVoiceSurface() {
    state = (
      status: state.status,
      lastIntent: state.lastIntent,
      transcript: state.transcript,
      voiceSurfaceId: null,
      isRendering: state.isRendering,
    );
  }

  void setVoiceSurface(String surfaceId) {
    state = (
      status: state.status,
      lastIntent: state.lastIntent,
      transcript: state.transcript,
      voiceSurfaceId: surfaceId,
      isRendering: false,
    );
  }

  void setRendering({required bool rendering}) {
    state = (
      status: state.status,
      lastIntent: state.lastIntent,
      transcript: state.transcript,
      voiceSurfaceId: state.voiceSurfaceId,
      isRendering: rendering,
    );
  }

  void _onFrame(VoiceServerFrame frame) {
    switch (frame) {
      case VoiceServerSessionReady():
        state = (
          status: VoiceSessionStatus.live,
          lastIntent: state.lastIntent,
          transcript: state.transcript,
          voiceSurfaceId: state.voiceSurfaceId,
          isRendering: state.isRendering,
        );
      case VoiceServerTranscript(:final role, :final text):
        final line = role == TranscriptRole.agent ? 'Agent: $text' : text;
        state = (
          status: state.status,
          lastIntent: state.lastIntent,
          transcript: line,
          voiceSurfaceId: state.voiceSurfaceId,
          isRendering: state.isRendering,
        );
      case VoiceServerIntent(:final intent):
        state = (
          status: state.status,
          lastIntent: intent,
          transcript: state.transcript,
          voiceSurfaceId: state.voiceSurfaceId,
          isRendering: state.isRendering,
        );
      case VoiceServerError(:final fatal):
        if (fatal) {
          state = (
            status: VoiceSessionStatus.error,
            lastIntent: state.lastIntent,
            transcript: state.transcript,
            voiceSurfaceId: state.voiceSurfaceId,
            isRendering: false,
          );
        }
      case VoiceServerSessionClosed():
        unawaited(disconnect());
      default:
        break;
    }
  }
}
