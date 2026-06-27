import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sos_emergency/data/api/api_enums.dart';
import 'package:sos_emergency/data/voice_session/models/voice_session_config.dart';

part 'voice_client_frame.freezed.dart';
part 'voice_client_frame.g.dart';

/// A frame the client sends over `WS /v1/voice/agent`, discriminated by `type`.
@Freezed(unionKey: 'type')
sealed class VoiceClientFrame with _$VoiceClientFrame {
  @FreezedUnionValue('session.start')
  const factory VoiceClientFrame.sessionStart({
    required VoiceSessionConfig config,
  }) = VoiceClientSessionStart;

  @FreezedUnionValue('audio.chunk')
  const factory VoiceClientFrame.audioChunk({
    required int seq,
    required String audio,
  }) = VoiceClientAudioChunk;

  @FreezedUnionValue('audio.commit')
  const factory VoiceClientFrame.audioCommit() = VoiceClientAudioCommit;

  @FreezedUnionValue('text')
  const factory VoiceClientFrame.text({required String text}) = VoiceClientText;

  @FreezedUnionValue('control')
  const factory VoiceClientFrame.control({required VoiceControlAction action}) =
      VoiceClientControl;

  @FreezedUnionValue('session.end')
  const factory VoiceClientFrame.sessionEnd() = VoiceClientSessionEnd;

  factory VoiceClientFrame.fromJson(Map<String, dynamic> json) =>
      _$VoiceClientFrameFromJson(json);
}
