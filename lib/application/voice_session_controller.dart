import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/data/api/api_enums.dart';
import 'package:sos_emergency/data/voice_session/fake_voice_session.dart';
import 'package:sos_emergency/data/voice_session/models/voice_client_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_server_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_session_config.dart';
import 'package:sos_emergency/data/voice_session/voice_session_repository.dart';

part 'voice_session_controller.g.dart';

/// The live voice session. Defaults to an in-memory fake (no server); the
/// reconnecting WebSocket impl is wired in Phase 5. Independent of the
/// composition path — a dropped socket here never blocks the REST channel.
@Riverpod(keepAlive: true)
VoiceSessionRepository voiceSession(Ref ref) => FakeVoiceSession();

enum VoiceSessionStatus { idle, connecting, live, error }

/// Drives the voice session and surfaces its state + the latest recognised
/// intent (which the orchestrator can feed back into the loop as a UserSignal).
@Riverpod(keepAlive: true)
class VoiceSessionController extends _$VoiceSessionController {
  StreamSubscription<VoiceServerFrame>? _sub;

  @override
  ({VoiceSessionStatus status, VoiceIntent? lastIntent}) build() {
    ref.onDispose(() => _sub?.cancel());
    return (status: VoiceSessionStatus.idle, lastIntent: null);
  }

  void connect(VoiceSessionConfig config) {
    state = (
      status: VoiceSessionStatus.connecting,
      lastIntent: state.lastIntent,
    );
    _sub = ref
        .read(voiceSessionProvider)
        .connect(config)
        .listen(
          _onFrame,
          onError: (Object _) {
            state = (
              status: VoiceSessionStatus.error,
              lastIntent: state.lastIntent,
            );
          },
        );
  }

  void send(VoiceClientFrame frame) =>
      ref.read(voiceSessionProvider).send(frame);

  /// Stops listening — unsubscribes and returns to idle.
  void disconnect() {
    unawaited(_sub?.cancel());
    _sub = null;
    state = (status: VoiceSessionStatus.idle, lastIntent: state.lastIntent);
  }

  void _onFrame(VoiceServerFrame frame) {
    switch (frame) {
      case VoiceServerSessionReady():
        state = (status: VoiceSessionStatus.live, lastIntent: state.lastIntent);
      case VoiceServerIntent(:final intent):
        state = (status: state.status, lastIntent: intent);
      case VoiceServerError(:final fatal):
        if (fatal) {
          state = (
            status: VoiceSessionStatus.error,
            lastIntent: state.lastIntent,
          );
        }
      default:
        break;
    }
  }
}
