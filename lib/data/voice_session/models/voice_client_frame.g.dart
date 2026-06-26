// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_client_frame.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoiceClientSessionStart _$VoiceClientSessionStartFromJson(
  Map<String, dynamic> json,
) => VoiceClientSessionStart(
  config: VoiceSessionConfig.fromJson(json['config'] as Map<String, dynamic>),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$VoiceClientSessionStartToJson(
  VoiceClientSessionStart instance,
) => <String, dynamic>{
  'config': instance.config.toJson(),
  'type': instance.$type,
};

VoiceClientAudioChunk _$VoiceClientAudioChunkFromJson(
  Map<String, dynamic> json,
) => VoiceClientAudioChunk(
  seq: (json['seq'] as num).toInt(),
  audio: json['audio'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$VoiceClientAudioChunkToJson(
  VoiceClientAudioChunk instance,
) => <String, dynamic>{
  'seq': instance.seq,
  'audio': instance.audio,
  'type': instance.$type,
};

VoiceClientAudioCommit _$VoiceClientAudioCommitFromJson(
  Map<String, dynamic> json,
) => VoiceClientAudioCommit($type: json['type'] as String?);

Map<String, dynamic> _$VoiceClientAudioCommitToJson(
  VoiceClientAudioCommit instance,
) => <String, dynamic>{'type': instance.$type};

VoiceClientText _$VoiceClientTextFromJson(Map<String, dynamic> json) =>
    VoiceClientText(
      text: json['text'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$VoiceClientTextToJson(VoiceClientText instance) =>
    <String, dynamic>{'text': instance.text, 'type': instance.$type};

VoiceClientControl _$VoiceClientControlFromJson(Map<String, dynamic> json) =>
    VoiceClientControl(
      action: $enumDecode(_$VoiceControlActionEnumMap, json['action']),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$VoiceClientControlToJson(VoiceClientControl instance) =>
    <String, dynamic>{
      'action': _$VoiceControlActionEnumMap[instance.action]!,
      'type': instance.$type,
    };

const _$VoiceControlActionEnumMap = {
  VoiceControlAction.mute: 'mute',
  VoiceControlAction.unmute: 'unmute',
  VoiceControlAction.bargeIn: 'barge_in',
  VoiceControlAction.cancel: 'cancel',
};

VoiceClientSessionEnd _$VoiceClientSessionEndFromJson(
  Map<String, dynamic> json,
) => VoiceClientSessionEnd($type: json['type'] as String?);

Map<String, dynamic> _$VoiceClientSessionEndToJson(
  VoiceClientSessionEnd instance,
) => <String, dynamic>{'type': instance.$type};
