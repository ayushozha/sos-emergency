import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/data/api/api_enums.dart';
import 'package:sos_emergency/data/voice_session/backend_voice_session.dart';
import 'package:sos_emergency/data/voice_session/fake_voice_session.dart';
import 'package:sos_emergency/data/voice_session/models/voice_client_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_server_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_session_config.dart';
import 'package:sos_emergency/data/voice_session/voice_session_repository.dart';
import 'package:sos_emergency/shared/backend_config.dart';

part 'voice_session_controller.g.dart';

/// The live voice session. Defaults to an in-memory fake (no server); when
/// `USE_BACKEND=true` a reconnecting WebSocket with TTS playback is wired in.
/// Independent of the composition path — a dropped socket here never blocks
/// the REST channel.
@Riverpod(keepAlive: true)
VoiceSessionRepository voiceSession(Ref ref) {
  if (BackendConfig.useBackend && BackendConfig.isConfigured) {
    final base = BackendConfig.baseUri;
    final scheme = base.scheme == 'https' ? 'wss' : 'ws';
    final uri = base.replace(
      scheme: scheme,
      path: '${base.path}/v1/voice/agent'.replaceAll('//', '/'),
    );
    final session = BackendVoiceSession(uri: uri);
    ref.onDispose(session.close);
    return session;
  }
  return FakeVoiceSession();
}

enum VoiceSessionStatus { idle, connecting, live, error }

/// Drives the voice session and surfaces its state, transcripts, and the latest
/// recognised intent (which the orchestrator can feed back into the loop as a
/// UserSignal).
typedef VoiceSessionState = ({
  VoiceSessionStatus status,
  VoiceIntent? lastIntent,
  String lastTranscript,
  String lastRole,
  String error,
});

@Riverpod(keepAlive: true)
class VoiceSessionController extends _$VoiceSessionController {
  StreamSubscription<VoiceServerFrame>? _sub;
  Completer<void>? _readyCompleter;

  @override
  VoiceSessionState build() {
    ref.onDispose(() {
      unawaited(_sub?.cancel());
    });
    return (
      status: VoiceSessionStatus.idle,
      lastIntent: null,
      lastTranscript: '',
      lastRole: '',
      error: '',
    );
  }

  void connect(VoiceSessionConfig config) {
    unawaited(_sub?.cancel());
    _readyCompleter = Completer<void>();
    state = (
      status: VoiceSessionStatus.connecting,
      lastIntent: state.lastIntent,
      lastTranscript: '',
      lastRole: '',
      error: '',
    );
    _sub = ref
        .read(voiceSessionProvider)
        .connect(config)
        .listen(
          _onFrame,
          onError: (Object error) {
            _readyCompleter?.completeError(error);
            _readyCompleter = null;
            state = (
              status: VoiceSessionStatus.error,
              lastIntent: state.lastIntent,
              lastTranscript: state.lastTranscript,
              lastRole: state.lastRole,
              error: error.toString(),
            );
          },
        );
  }

  /// Opens a backend voice session and sends a text utterance (debug / E2E).
  Future<void> connectAndSpeak(
    String text, {
    ApiSeverity tier = ApiSeverity.neutral,
  }) async {
    connect(
      VoiceSessionConfig(
        locale: 'en-US',
        sampleRate: 24000,
        codec: AudioCodec.pcm16,
        tier: tier,
      ),
    );
    try {
      await _readyCompleter!.future.timeout(const Duration(seconds: 20));
    } on Object catch (error) {
      state = (
        status: VoiceSessionStatus.error,
        lastIntent: state.lastIntent,
        lastTranscript: state.lastTranscript,
        lastRole: state.lastRole,
        error: error.toString(),
      );
      return;
    }
    send(VoiceClientFrame.text(text: text));
  }

  void send(VoiceClientFrame frame) =>
      ref.read(voiceSessionProvider).send(frame);

  /// Stops listening — unsubscribes and returns to idle.
  Future<void> disconnect() async {
    if (state.status == VoiceSessionStatus.live ||
        state.status == VoiceSessionStatus.connecting) {
      send(const VoiceClientFrame.sessionEnd());
    }
    await _sub?.cancel();
    _sub = null;
    _readyCompleter = null;
    state = (
      status: VoiceSessionStatus.idle,
      lastIntent: state.lastIntent,
      lastTranscript: state.lastTranscript,
      lastRole: state.lastRole,
      error: '',
    );
  }

  void _onFrame(VoiceServerFrame frame) {
    switch (frame) {
      case VoiceServerSessionReady():
        if (_readyCompleter != null && !_readyCompleter!.isCompleted) {
          _readyCompleter!.complete();
        }
        _readyCompleter = null;
        state = (
          status: VoiceSessionStatus.live,
          lastIntent: state.lastIntent,
          lastTranscript: state.lastTranscript,
          lastRole: state.lastRole,
          error: '',
        );
      case VoiceServerTranscript(:final role, :final text):
        state = (
          status: state.status,
          lastIntent: state.lastIntent,
          lastTranscript: text,
          lastRole: role.name,
          error: '',
        );
      case VoiceServerIntent(:final intent):
        state = (
          status: state.status,
          lastIntent: intent,
          lastTranscript: state.lastTranscript,
          lastRole: state.lastRole,
          error: '',
        );
      case VoiceServerError(:final message, :final fatal):
        if (!fatal && message.isNotEmpty) {
          state = (
            status: state.status,
            lastIntent: state.lastIntent,
            lastTranscript: state.lastTranscript,
            lastRole: state.lastRole,
            error: message,
          );
        }
        if (fatal) {
          _readyCompleter?.completeError(message);
          _readyCompleter = null;
          state = (
            status: VoiceSessionStatus.error,
            lastIntent: state.lastIntent,
            lastTranscript: state.lastTranscript,
            lastRole: state.lastRole,
            error: message,
          );
        }
      default:
        break;
    }
  }
}