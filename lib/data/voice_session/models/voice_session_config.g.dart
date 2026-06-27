// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_session_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VoiceSessionConfig _$VoiceSessionConfigFromJson(Map<String, dynamic> json) =>
    _VoiceSessionConfig(
      locale: json['locale'] as String,
      sampleRate: (json['sampleRate'] as num).toInt(),
      codec: $enumDecode(_$AudioCodecEnumMap, json['codec']),
      incidentId: json['incidentId'] as String?,
      tier: $enumDecodeNullable(_$ApiSeverityEnumMap, json['tier']),
    );

Map<String, dynamic> _$VoiceSessionConfigToJson(_VoiceSessionConfig instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'sampleRate': instance.sampleRate,
      'codec': _$AudioCodecEnumMap[instance.codec]!,
      'incidentId': instance.incidentId,
      'tier': _$ApiSeverityEnumMap[instance.tier],
    };

const _$AudioCodecEnumMap = {
  AudioCodec.pcm16: 'pcm16',
  AudioCodec.opus: 'opus',
};

const _$ApiSeverityEnumMap = {
  ApiSeverity.neutral: 'neutral',
  ApiSeverity.moderate: 'moderate',
  ApiSeverity.high: 'high',
  ApiSeverity.critical: 'critical',
};

_NegotiatedAudioConfig _$NegotiatedAudioConfigFromJson(
  Map<String, dynamic> json,
) => _NegotiatedAudioConfig(
  sampleRate: (json['sampleRate'] as num?)?.toInt(),
  codec: $enumDecodeNullable(_$AudioCodecEnumMap, json['codec']),
);

Map<String, dynamic> _$NegotiatedAudioConfigToJson(
  _NegotiatedAudioConfig instance,
) => <String, dynamic>{
  'sampleRate': instance.sampleRate,
  'codec': _$AudioCodecEnumMap[instance.codec],
};
