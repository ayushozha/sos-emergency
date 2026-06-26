import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/data/api/api_enums.dart';
import 'package:sos_emergency/data/voice_session/models/voice_client_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_server_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_session_config.dart';
import 'package:sos_emergency/data/voice_session/reconnecting_voice_session.dart';
import 'package:sos_emergency/data/voice_session/voice_frame_codec.dart';

import '../support/fake_voice_channel.dart';

const _config = VoiceSessionConfig(
  locale: 'en-US',
  sampleRate: 16000,
  codec: AudioCodec.opus,
);

void main() {
  group('VoiceFrameCodec', () {
    const codec = VoiceFrameCodec();

    test('encodes a client frame to JSON text', () {
      final raw = codec.encodeClient(
        const VoiceClientFrame.control(action: VoiceControlAction.bargeIn),
      );
      expect(jsonDecode(raw), {'type': 'control', 'action': 'barge_in'});
    });

    test('decodes a server frame from JSON text', () {
      final frame = codec.decodeServer(
        '{"type":"intent","intent":"carProblem","confidence":0.9}',
      );
      expect(frame, isA<VoiceServerIntent>());
      expect((frame as VoiceServerIntent).intent, VoiceIntent.carProblem);
    });
  });

  group('ReconnectingVoiceSession', () {
    test('sends session.start and forwards decoded frames', () async {
      late FakeVoiceChannel channel;
      final session = ReconnectingVoiceSession(
        uri: Uri.parse('wss://test/voice'),
        connector: (_) => channel = FakeVoiceChannel(),
        backoff: (_) => Duration.zero,
      );
      addTearDown(session.close);

      final frames = <VoiceServerFrame>[];
      session.connect(_config).listen(frames.add);
      await pumpEventQueue();

      expect((jsonDecode(channel.sent.single) as Map)['type'], 'session.start');

      channel.deliver('{"type":"session.ready","sessionId":"s1"}');
      await pumpEventQueue();
      expect(frames.single, isA<VoiceServerSessionReady>());
    });

    test('reconnects with backoff after a dropped socket', () async {
      final channels = <FakeVoiceChannel>[];
      final session = ReconnectingVoiceSession(
        uri: Uri.parse('wss://test/voice'),
        connector: (_) {
          final c = FakeVoiceChannel();
          channels.add(c);
          return c;
        },
        backoff: (_) => Duration.zero,
        maxAttempts: 3,
      );
      addTearDown(session.close);

      final frames = <VoiceServerFrame>[];
      session.connect(_config).listen(frames.add);
      await pumpEventQueue();

      // Drop the first socket → triggers a reconnect onto a fresh channel.
      channels.first.drop();
      await pumpEventQueue();
      expect(channels.length, greaterThanOrEqualTo(2));

      // Frames flow again on the new channel.
      channels.last.deliver('{"type":"session.ready","sessionId":"s2"}');
      await pumpEventQueue();
      expect(frames.whereType<VoiceServerSessionReady>(), isNotEmpty);
    });

    test('surfaces a fatal error once the retry budget is exhausted', () async {
      final session = ReconnectingVoiceSession(
        uri: Uri.parse('wss://test/voice'),
        connector: (_) => FakeVoiceChannel()..drop(),
        backoff: (_) => Duration.zero,
        maxAttempts: 2,
      );
      addTearDown(session.close);

      final frames = <VoiceServerFrame>[];
      session.connect(_config).listen(frames.add);
      await pumpEventQueue();

      final error = frames.whereType<VoiceServerError>().toList();
      expect(error, isNotEmpty);
      expect(error.last.fatal, isTrue);
    });
  });
}
