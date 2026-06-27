import 'package:sos_emergency/data/voice_session/models/voice_client_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_server_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_session_config.dart';

/// The live-voice boundary (the WebSocket channel). Independent of screen
/// composition: a dropped voice socket never blocks the REST compose path.
abstract interface class VoiceSessionRepository {
  /// Opens the session and streams agent frames for its duration.
  Stream<VoiceServerFrame> connect(VoiceSessionConfig config);

  /// Sends a client frame (audio, control, text).
  void send(VoiceClientFrame frame);

  Future<void> close();
}

/// Raised when the voice session fails irrecoverably (e.g. reconnect budget
/// exhausted). Surfaced on the event stream as an error, never thrown across
/// the composition path.
class VoiceSessionException implements Exception {
  const VoiceSessionException(this.message);
  final String message;

  @override
  String toString() => 'VoiceSessionException: $message';
}