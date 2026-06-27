import 'dart:async';

import 'package:sos_emergency/data/voice_session/models/voice_client_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_server_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_session_config.dart';
import 'package:sos_emergency/data/voice_session/voice_channel.dart';
import 'package:sos_emergency/data/voice_session/voice_frame_codec.dart';
import 'package:sos_emergency/data/voice_session/voice_session_repository.dart';

/// Exponential backoff with a 16x cap (250ms, 500ms, 1s, 2s, …).
Duration _defaultBackoff(int attempt) =>
    Duration(milliseconds: 250 * (1 << (attempt.clamp(0, 4))));

/// A [VoiceSessionRepository] over a [VoiceChannel] that transparently
/// reconnects with backoff. Inbound frames are re-emitted on a single output
/// stream across reconnects; once the retry budget is exhausted it surfaces a
/// [VoiceSessionException] on that stream (never thrown across composition).
class ReconnectingVoiceSession implements VoiceSessionRepository {
  ReconnectingVoiceSession({
    required this.uri,
    VoiceChannelConnector? connector,
    Duration Function(int attempt)? backoff,
    this.maxAttempts = 5,
    this._codec = const VoiceFrameCodec(),
  }) : _connector = connector ?? WebSocketVoiceChannel.connect,
       _backoff = backoff ?? _defaultBackoff;

  final Uri uri;
  final int maxAttempts;
  final VoiceChannelConnector _connector;
  final Duration Function(int attempt) _backoff;
  final VoiceFrameCodec _codec;

  final StreamController<VoiceServerFrame> _out =
      StreamController<VoiceServerFrame>.broadcast();
  VoiceChannel? _channel;
  late VoiceSessionConfig _config;
  StreamSubscription<String>? _sub;
  int _attempt = 0;
  bool _closed = false;

  @override
  Stream<VoiceServerFrame> connect(VoiceSessionConfig config) {
    _config = config;
    if (_closed) {
      _closed = false;
      _attempt = 0;
    }
    unawaited(_reopen());
    return _out.stream;
  }

  Future<void> _resetChannel() async {
    await _sub?.cancel();
    _sub = null;
    await _channel?.close();
    _channel = null;
  }

  Future<void> _reopen() async {
    await _resetChannel();
    if (_closed) return;
    final channel = _connector(uri)
      ..send(
        _codec.encodeClient(VoiceClientFrame.sessionStart(config: _config)),
      );
    _channel = channel;
    _sub = channel.incoming.listen(
      (raw) {
        _attempt = 0; // a clean frame resets the backoff
        _out.add(_codec.decodeServer(raw));
      },
      onError: (Object _) => _scheduleReconnect(),
      onDone: _scheduleReconnect,
    );
  }

  void _scheduleReconnect() {
    if (_closed) return;
    unawaited(_sub?.cancel());
    if (_attempt >= maxAttempts) {
      _out.add(
        const VoiceServerFrame.error(
          code: 'reconnect_failed',
          message: 'voice session reconnect budget exhausted',
          fatal: true,
        ),
      );
      return;
    }
    Timer(_backoff(_attempt++), () => unawaited(_reopen()));
  }

  @override
  void send(VoiceClientFrame frame) =>
      _channel?.send(_codec.encodeClient(frame));

  @override
  Future<void> close() async {
    _closed = true;
    await _resetChannel();
    await _out.close();
  }
}
