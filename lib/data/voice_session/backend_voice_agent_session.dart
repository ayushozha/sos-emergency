import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:sos_emergency/data/api/api_enums.dart';
import 'package:sos_emergency/data/voice_session/backend_voice_agent_callbacks.dart';
import 'package:sos_emergency/data/voice_session/models/voice_client_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_server_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_session_config.dart';
import 'package:sos_emergency/data/voice_session/voice_session_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Live client for the FastAPI voice bridge (`WS /v1/voice/agent`).
///
/// Wire contract (mirrors [backend/voice_test.html]):
/// 1. First text frame: `{"system": "…", "model": "…optional…"}`.
/// 2. Mic up: **binary** linear16 PCM @ 16 kHz (little-endian int16).
/// 3. Down: **binary** = TTS (linear16/WAV @ 24 kHz); **text** = NDJSON control.
class BackendVoiceAgentSession implements VoiceSessionRepository {
  BackendVoiceAgentSession({
    required this.wsUri,
    this.callbacks = const NoOpBackendVoiceAgentCallbacks(),
  });

  final Uri wsUri;
  final BackendVoiceAgentCallbacks callbacks;

  final StreamController<VoiceServerFrame> _out =
      StreamController<VoiceServerFrame>.broadcast();

  WebSocketChannel? _channel;
  String? _systemPrompt;
  String? _model;
  bool _closed = false;

  /// Must be called before [connect] so the backend receives the A2UI prompt.
  void configure({required String systemPrompt, String? model}) {
    _systemPrompt = systemPrompt;
    _model = model;
  }

  @override
  Stream<VoiceServerFrame> connect(VoiceSessionConfig config) {
    if (_closed) {
      throw StateError('BackendVoiceAgentSession is closed');
    }
    final prompt = _systemPrompt;
    if (prompt == null || prompt.isEmpty) {
      throw StateError('Call configure(systemPrompt: …) before connect()');
    }

    // Close any prior socket, then assign the new one *synchronously*. We must
    // not route this through `disconnect()`: its post-await `_channel = null`
    // would run on a later microtask and clobber the channel we set below,
    // which would make `sendAudio` silently drop every mic frame.
    final previous = _channel;
    if (previous != null) unawaited(previous.sink.close());

    final channel = WebSocketChannel.connect(wsUri);
    _channel = channel;
    channel.sink.add(
      jsonEncode({
        'system': prompt,
        if (_model != null && _model!.isNotEmpty) 'model': _model,
      }),
    );

    scheduleMicrotask(
      () => _out.add(
        const VoiceServerFrame.sessionReady(sessionId: 'backend-voice'),
      ),
    );

    channel.stream.listen(
      _onRaw,
      onError: (Object error) {
        _out.add(
          VoiceServerFrame.error(
            code: 'websocket_error',
            message: '$error',
            fatal: true,
          ),
        );
      },
      onDone: () {
        if (!_closed) {
          _out.add(
            const VoiceServerFrame.sessionClosed(
              reason: SessionCloseReason.completed,
            ),
          );
        }
      },
    );

    return _out.stream;
  }

  @override
  void send(VoiceClientFrame frame) {
    // Continuous mic uses [sendAudio]; typed client frames are not on this
    // wire.
  }

  /// Forwards one chunk of mic PCM to the backend as a binary frame.
  ///
  /// [pcm16] must be raw linear16 **bytes** (16 kHz, mono, little-endian,
  /// 2 bytes/sample) — not a list of sample values, which the socket would
  /// truncate to one byte each and corrupt the stream.
  void sendAudio(List<int> pcm16) {
    if (pcm16.isEmpty || _channel == null) return;
    _channel!.sink.add(
      pcm16 is Uint8List ? pcm16 : Uint8List.fromList(pcm16),
    );
  }

  /// Closes the live socket but keeps this session reusable for another
  /// connect.
  Future<void> disconnect() async {
    final channel = _channel;
    _channel = null;
    await channel?.sink.close();
  }

  @override
  Future<void> close() async {
    _closed = true;
    await disconnect();
    await _out.close();
  }

  void _onRaw(dynamic raw) {
    if (raw is List<int>) {
      callbacks.onTtsAudio(raw);
      return;
    }
    if (raw is String) {
      _onText(raw);
      return;
    }
    // web_socket_channel may deliver Uint8List for binary frames.
    if (raw is Iterable<int>) {
      callbacks.onTtsAudio(raw.toList());
    }
  }

  void _onText(String raw) {
    Map<String, Object?> obj;
    try {
      obj = jsonDecode(raw) as Map<String, Object?>;
    } on FormatException {
      _out.add(
        VoiceServerFrame.error(
          code: 'parse_error',
          message: 'Unparseable voice frame: $raw',
        ),
      );
      return;
    }

    if (obj.containsKey('error')) {
      _out.add(
        VoiceServerFrame.error(
          code: 'agent_error',
          message: '${obj['error']}',
          fatal: true,
        ),
      );
      return;
    }

    final renderStart = obj['render_start'];
    if (renderStart is Map) {
      callbacks.onRenderStart(renderStart.cast<String, Object?>());
      return;
    }

    final delta = obj['delta'];
    if (delta is String) {
      callbacks.onA2uiDelta(delta);
      return;
    }

    if (obj['done'] == true) {
      callbacks.onRenderDone();
      return;
    }

    final transcript = obj['transcript'];
    if (transcript is Map) {
      final role = transcript['role']?.toString() ?? 'user';
      final content = transcript['content']?.toString() ?? '';
      _out.add(
        VoiceServerFrame.transcript(
          role: role == 'assistant'
              ? TranscriptRole.agent
              : TranscriptRole.user,
          text: content,
          isFinal: true,
        ),
      );
      return;
    }

    final event = obj['event'];
    if (event is String) {
      _out.add(VoiceServerFrame.event(name: _mapEvent(event)));
      return;
    }

    final action = obj['action'];
    if (action == 'call_emergency') {
      callbacks.onCallEmergency();
    }
  }

  static VoiceEventName _mapEvent(String name) => switch (name) {
    'UserStartedSpeaking' => VoiceEventName.vadStart,
    'AgentAudioDone' => VoiceEventName.vadStop,
    'AgentThinking' || 'AgentStartedSpeaking' => VoiceEventName.thinking,
    _ => VoiceEventName.thinking,
  };
}
