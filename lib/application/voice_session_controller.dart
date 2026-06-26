import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/data/voice_session/voice_session_repository.dart';
import 'package:sos_emergency/domain/models/severity.dart';

part 'voice_session_controller.g.dart';

/// Debug/status surface for the active voice WebSocket session.
class VoiceSessionStatus {
  const VoiceSessionStatus({
    this.connected = false,
    this.lastTranscript = '',
    this.lastRole = '',
    this.error = '',
  });

  final bool connected;
  final String lastTranscript;
  final String lastRole;
  final String error;

  VoiceSessionStatus copyWith({
    bool? connected,
    String? lastTranscript,
    String? lastRole,
    String? error,
  }) => VoiceSessionStatus(
    connected: connected ?? this.connected,
    lastTranscript: lastTranscript ?? this.lastTranscript,
    lastRole: lastRole ?? this.lastRole,
    error: error ?? this.error,
  );
}

@Riverpod(keepAlive: true)
class VoiceSessionController extends _$VoiceSessionController {
  StreamSubscription<VoiceFrame>? _sub;

  @override
  VoiceSessionStatus build() {
    ref.onDispose(() => _sub?.cancel());
    return const VoiceSessionStatus();
  }

  Future<void> connectAndSpeak(
    String text, {
    Severity tier = Severity.neutral,
  }) async {
    final repo = ref.read(voiceSessionRepositoryProvider);
    await _sub?.cancel();
    state = const VoiceSessionStatus(connected: true);

    _sub = repo.frames.listen((frame) {
      switch (frame) {
        case VoiceTranscriptFrame(:final role, :final text):
          state = state.copyWith(
            lastRole: role,
            lastTranscript: text,
            error: '',
          );
        case VoiceErrorFrame(:final message):
          state = state.copyWith(error: message, connected: false);
        case VoiceIntentFrame():
          break;
      }
    });

    try {
      await repo.connect(tier: tier);
      repo.sendText(text);
    } on Object catch (error) {
      state = state.copyWith(
        connected: false,
        error: error.toString(),
      );
    }
  }
}