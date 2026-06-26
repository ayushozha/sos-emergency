import 'package:web_socket_channel/web_socket_channel.dart';

/// A minimal duplex text channel — the transport seam under the reconnecting
/// voice session. Abstracting it keeps the reconnect/backoff logic testable
/// without a live WebSocket server.
abstract interface class VoiceChannel {
  /// Inbound raw frames (JSON text). Errors/closes here trigger a reconnect.
  Stream<String> get incoming;

  void send(String raw);

  Future<void> close();
}

/// Factory used by the session to (re)open a channel.
typedef VoiceChannelConnector = VoiceChannel Function(Uri uri);

/// A [VoiceChannel] backed by a real WebSocket.
class WebSocketVoiceChannel implements VoiceChannel {
  WebSocketVoiceChannel(this._channel);

  /// Connects to [uri] over WebSocket — the production connector.
  factory WebSocketVoiceChannel.connect(Uri uri) =>
      WebSocketVoiceChannel(WebSocketChannel.connect(uri));

  final WebSocketChannel _channel;

  @override
  Stream<String> get incoming => _channel.stream.map((e) => e.toString());

  @override
  void send(String raw) => _channel.sink.add(raw);

  @override
  Future<void> close() => _channel.sink.close();
}
