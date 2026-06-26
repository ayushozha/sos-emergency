import 'dart:async';

import 'package:sos_emergency/data/voice_session/voice_channel.dart';

/// A controllable [VoiceChannel] for testing reconnect/backoff without a server.
class FakeVoiceChannel implements VoiceChannel {
  final StreamController<String> _in = StreamController<String>();
  final List<String> sent = [];

  @override
  Stream<String> get incoming => _in.stream;

  @override
  void send(String raw) => sent.add(raw);

  /// Pushes an inbound frame to the session.
  void deliver(String raw) => _in.add(raw);

  /// Simulates a transport drop, triggering a reconnect.
  void drop() => _in.addError(StateError('socket dropped'));

  @override
  Future<void> close() => _in.close();
}
