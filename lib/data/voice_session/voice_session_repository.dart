import 'dart:async';
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/models/severity.dart';
import 'package:sos_emergency/data/voice_session/voice_tts_player.dart';
import 'package:sos_emergency/shared/backend_config.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'voice_session_repository.g.dart';

sealed class VoiceFrame {}

class VoiceTranscriptFrame extends VoiceFrame {
  VoiceTranscriptFrame({
    required this.role,
    required this.text,
    required this.isFinal,
  });
  final String role;
  final String text;
  final bool isFinal;
}

class VoiceIntentFrame extends VoiceFrame {
  VoiceIntentFrame({
    required this.intent,
    required this.confidence,
    this.slots = const {},
  });
  final UserIntent intent;
  final double confidence;
  final Map<String, Object?> slots;
}

class VoiceErrorFrame extends VoiceFrame {
  VoiceErrorFrame(this.message);
  final String message;
}

class VoiceSessionRepository {
  VoiceSessionRepository({Uri? baseUri, VoiceTtsPlayer? ttsPlayer})
    : _wsUri = _voiceWsUri(baseUri ?? BackendConfig.baseUri),
      _tts = ttsPlayer ?? VoiceTtsPlayer();

  final Uri _wsUri;
  final VoiceTtsPlayer _tts;
  WebSocketChannel? _channel;
  final _frames = StreamController<VoiceFrame>.broadcast();

  Stream<VoiceFrame> get frames => _frames.stream;

  static Uri _voiceWsUri(Uri base) {
    final scheme = base.scheme == 'https' ? 'wss' : 'ws';
    return base.replace(
      scheme: scheme,
      path: '${base.path}/v1/voice/agent'.replaceAll('//', '/'),
    );
  }

  Future<void> connect({Severity tier = Severity.neutral}) async {
    await disconnect();
    await _tts.ensureResumed();
    _tts.reset();
    _channel = WebSocketChannel.connect(_wsUri);
    _channel!.stream.listen(
      (message) {
        if (message is! String) return;
        final json = jsonDecode(message) as Map<String, dynamic>;
        _dispatch(json);
      },
      onError: (Object error) {
        _frames.add(VoiceErrorFrame(error.toString()));
      },
      onDone: () => _frames.add(VoiceErrorFrame('session closed')),
    );

    _channel!.sink.add(
      jsonEncode({
        'type': 'session.start',
        'config': {
          'locale': 'en-US',
          'sampleRate': 16000,
          'codec': 'pcm16',
          'tier': tier.name,
        },
      }),
    );
  }

  void sendText(String text) {
    _channel?.sink.add(jsonEncode({'type': 'text', 'text': text}));
  }

  Future<void> disconnect() async {
    if (_channel != null) {
      _channel!.sink.add(jsonEncode({'type': 'session.end'}));
      await _channel!.sink.close();
      _channel = null;
    }
  }

  void _dispatch(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'transcript':
        _frames.add(
          VoiceTranscriptFrame(
            role: json['role'] as String? ?? 'agent',
            text: json['text'] as String? ?? '',
            isFinal: json['isFinal'] as bool? ?? true,
          ),
        );
      case 'intent':
        _frames.add(
          VoiceIntentFrame(
            intent: _mapIntent(json['intent'] as String? ?? 'none'),
            confidence: (json['confidence'] as num?)?.toDouble() ?? 0,
            slots: (json['slots'] as Map<String, dynamic>?)?.cast() ?? {},
          ),
        );
      case 'error':
        _frames.add(
          VoiceErrorFrame(json['message'] as String? ?? 'voice error'),
        );
      case 'session.ready':
        _tts.reset();
      case 'audio.chunk':
        final audio = json['audio'] as String?;
        if (audio != null && audio.isNotEmpty) {
          unawaited(_tts.playBase64Pcm16(audio));
        }
      default:
        break;
    }
  }

  UserIntent _mapIntent(String raw) => switch (raw) {
    'crash' => UserIntent.crash,
    'medical' => UserIntent.medical,
    'beingFollowed' => UserIntent.beingFollowed,
    'carProblem' => UserIntent.carProblem,
    'lockedOut' => UserIntent.lockedOut,
    'outOfGas' => UserIntent.outOfGas,
    'roadside' => UserIntent.roadside,
    'document' => UserIntent.document,
    'feelUnsafe' => UserIntent.feelUnsafe,
    _ => UserIntent.none,
  };
}

@Riverpod(keepAlive: true)
VoiceSessionRepository voiceSessionRepository(Ref ref) {
  final repo = VoiceSessionRepository();
  ref.onDispose(repo.disconnect);
  return repo;
}