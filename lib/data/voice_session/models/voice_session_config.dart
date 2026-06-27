import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sos_emergency/data/api/api_enums.dart';

part 'voice_session_config.freezed.dart';
part 'voice_session_config.g.dart';

/// Audio/session parameters negotiated when opening a voice session.
@freezed
abstract class VoiceSessionConfig with _$VoiceSessionConfig {
  const factory VoiceSessionConfig({
    required String locale,
    required int sampleRate,
    required AudioCodec codec,
    String? incidentId,
    ApiSeverity? tier,
  }) = _VoiceSessionConfig;

  factory VoiceSessionConfig.fromJson(Map<String, dynamic> json) =>
      _$VoiceSessionConfigFromJson(json);
}

/// The server-confirmed audio config returned in `session.ready`.
@freezed
abstract class NegotiatedAudioConfig with _$NegotiatedAudioConfig {
  const factory NegotiatedAudioConfig({int? sampleRate, AudioCodec? codec}) =
      _NegotiatedAudioConfig;

  factory NegotiatedAudioConfig.fromJson(Map<String, dynamic> json) =>
      _$NegotiatedAudioConfigFromJson(json);
}
