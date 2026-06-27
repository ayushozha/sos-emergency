import 'dart:async';

import 'package:sos_emergency/data/voice_session/models/voice_client_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_server_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_session_config.dart';
import 'package:sos_emergency/data/voice_session/reconnecting_voice_session.dart';
import 'package:sos_emergency/data/voice_session/voice_session_repository.dart';
import 'package:sos_emergency/data/voice_session/voice_tts_player.dart';

/// Live backend voice session with reconnect backoff and TTS playback for
/// `audio.chunk` frames from the agent.
class BackendVoiceSession implements VoiceSessionRepository {
  BackendVoiceSession({required Uri uri, VoiceTtsPlayer? tts})
    : _session = ReconnectingVoiceSession(uri: uri),
      _tts = tts ?? VoiceTtsPlayer();

  final ReconnectingVoiceSession _session;
  final VoiceTtsPlayer _tts;
  StreamSubscription<VoiceServerFrame>? _tap;

  @override
  Stream<VoiceServerFrame> connect(VoiceSessionConfig config) {
    unawaited(_tts.ensureResumed());
    _tts.reset();
    final stream = _session.connect(config);
    unawaited(_tap?.cancel());
    _tap = stream.listen((frame) {
      switch (frame) {
        case VoiceServerSessionReady():
          _tts.reset();
        case VoiceServerAudioChunk(:final audio):
          if (audio.isNotEmpty) {
            unawaited(_tts.playBase64Pcm16(audio));
          }
        default:
          break;
      }
    });
    return stream;
  }

  @override
  void send(VoiceClientFrame frame) => _session.send(frame);

  @override
  Future<void> close() async {
    await _tap?.cancel();
    await _session.close();
  }
}