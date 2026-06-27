import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sos_emergency/data/api/api_enums.dart';
import 'package:sos_emergency/data/voice_session/models/voice_session_config.dart';

part 'voice_server_frame.freezed.dart';
part 'voice_server_frame.g.dart';

/// A frame the agent sends over `WS /v1/voice/agent`, discriminated by `type`.
@Freezed(unionKey: 'type')
sealed class VoiceServerFrame with _$VoiceServerFrame {
  @FreezedUnionValue('session.ready')
  const factory VoiceServerFrame.sessionReady({
    required String sessionId,
    NegotiatedAudioConfig? config,
  }) = VoiceServerSessionReady;

  @FreezedUnionValue('transcript')
  const factory VoiceServerFrame.transcript({
    required TranscriptRole role,
    required String text,
    required bool isFinal,
  }) = VoiceServerTranscript;

  @FreezedUnionValue('audio.chunk')
  const factory VoiceServerFrame.audioChunk({
    required int seq,
    required String audio,
  }) = VoiceServerAudioChunk;

  /// A surfaced intent fed back into the orchestrator loop as a UserSignal.
  @FreezedUnionValue('intent')
  const factory VoiceServerFrame.intent({
    required VoiceIntent intent,
    required double confidence,
    Map<String, dynamic>? slots,
  }) = VoiceServerIntent;

  @FreezedUnionValue('event')
  const factory VoiceServerFrame.event({required VoiceEventName name}) =
      VoiceServerEvent;

  @FreezedUnionValue('error')
  const factory VoiceServerFrame.error({
    required String code,
    required String message,
    @Default(false) bool fatal,
  }) = VoiceServerError;

  @FreezedUnionValue('session.closed')
  const factory VoiceServerFrame.sessionClosed({
    required SessionCloseReason reason,
  }) = VoiceServerSessionClosed;

  factory VoiceServerFrame.fromJson(Map<String, dynamic> json) =>
      _$VoiceServerFrameFromJson(json);
}
