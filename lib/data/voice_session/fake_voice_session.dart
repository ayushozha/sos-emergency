import 'dart:async';

import 'package:sos_emergency/data/voice_session/models/voice_client_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_server_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_session_config.dart';
import 'package:sos_emergency/data/voice_session/voice_session_repository.dart';

/// An in-memory voice session for the on-device demo and tests: emits a
/// `session.ready` on connect, records sent frames, and lets a test push server
/// frames via [emit].
class FakeVoiceSession implements VoiceSessionRepository {
  final StreamController<VoiceServerFrame> _out =
      StreamController<VoiceServerFrame>.broadcast();
  final List<VoiceClientFrame> sent = [];
  bool connected = false;

  @override
  Stream<VoiceServerFrame> connect(VoiceSessionConfig config) {
    connected = true;
    scheduleMicrotask(
      () => _out.add(const VoiceServerFrame.sessionReady(sessionId: 'fake')),
    );
    return _out.stream;
  }

  /// Pushes a server frame to listeners (test/demo scripting).
  void emit(VoiceServerFrame frame) => _out.add(frame);

  @override
  void send(VoiceClientFrame frame) => sent.add(frame);

  @override
  Future<void> close() async {
    connected = false;
    await _out.close();
  }
}
