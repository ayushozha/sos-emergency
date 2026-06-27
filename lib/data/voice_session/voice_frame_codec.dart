import 'dart:convert';

import 'package:sos_emergency/data/voice_session/models/voice_client_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_server_frame.dart';

/// Encodes/decodes voice frames to the JSON text wire format used on the socket.
class VoiceFrameCodec {
  const VoiceFrameCodec();

  String encodeClient(VoiceClientFrame frame) => jsonEncode(frame.toJson());

  VoiceServerFrame decodeServer(String raw) =>
      VoiceServerFrame.fromJson(jsonDecode(raw) as Map<String, dynamic>);
}
