// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_server_frame.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoiceServerSessionReady _$VoiceServerSessionReadyFromJson(
  Map<String, dynamic> json,
) => VoiceServerSessionReady(
  sessionId: json['sessionId'] as String,
  config: json['config'] == null
      ? null
      : NegotiatedAudioConfig.fromJson(json['config'] as Map<String, dynamic>),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$VoiceServerSessionReadyToJson(
  VoiceServerSessionReady instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'config': instance.config?.toJson(),
  'type': instance.$type,
};

VoiceServerTranscript _$VoiceServerTranscriptFromJson(
  Map<String, dynamic> json,
) => VoiceServerTranscript(
  role: $enumDecode(_$TranscriptRoleEnumMap, json['role']),
  text: json['text'] as String,
  isFinal: json['isFinal'] as bool,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$VoiceServerTranscriptToJson(
  VoiceServerTranscript instance,
) => <String, dynamic>{
  'role': _$TranscriptRoleEnumMap[instance.role]!,
  'text': instance.text,
  'isFinal': instance.isFinal,
  'type': instance.$type,
};

const _$TranscriptRoleEnumMap = {
  TranscriptRole.user: 'user',
  TranscriptRole.agent: 'agent',
};

VoiceServerAudioChunk _$VoiceServerAudioChunkFromJson(
  Map<String, dynamic> json,
) => VoiceServerAudioChunk(
  seq: (json['seq'] as num).toInt(),
  audio: json['audio'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$VoiceServerAudioChunkToJson(
  VoiceServerAudioChunk instance,
) => <String, dynamic>{
  'seq': instance.seq,
  'audio': instance.audio,
  'type': instance.$type,
};

VoiceServerIntent _$VoiceServerIntentFromJson(Map<String, dynamic> json) =>
    VoiceServerIntent(
      intent: $enumDecode(_$VoiceIntentEnumMap, json['intent']),
      confidence: (json['confidence'] as num).toDouble(),
      slots: json['slots'] as Map<String, dynamic>?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$VoiceServerIntentToJson(VoiceServerIntent instance) =>
    <String, dynamic>{
      'intent': _$VoiceIntentEnumMap[instance.intent]!,
      'confidence': instance.confidence,
      'slots': instance.slots,
      'type': instance.$type,
    };

const _$VoiceIntentEnumMap = {
  VoiceIntent.carProblem: 'carProblem',
  VoiceIntent.crash: 'crash',
  VoiceIntent.medical: 'medical',
  VoiceIntent.feelUnsafe: 'feelUnsafe',
  VoiceIntent.beingFollowed: 'beingFollowed',
  VoiceIntent.lockedOut: 'lockedOut',
  VoiceIntent.roadside: 'roadside',
  VoiceIntent.outOfGas: 'outOfGas',
  VoiceIntent.document: 'document',
  VoiceIntent.none: 'none',
};

VoiceServerEvent _$VoiceServerEventFromJson(Map<String, dynamic> json) =>
    VoiceServerEvent(
      name: $enumDecode(_$VoiceEventNameEnumMap, json['name']),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$VoiceServerEventToJson(VoiceServerEvent instance) =>
    <String, dynamic>{
      'name': _$VoiceEventNameEnumMap[instance.name]!,
      'type': instance.$type,
    };

const _$VoiceEventNameEnumMap = {
  VoiceEventName.vadStart: 'vad_start',
  VoiceEventName.vadStop: 'vad_stop',
  VoiceEventName.bargeIn: 'barge_in',
  VoiceEventName.thinking: 'thinking',
};

VoiceServerError _$VoiceServerErrorFromJson(Map<String, dynamic> json) =>
    VoiceServerError(
      code: json['code'] as String,
      message: json['message'] as String,
      fatal: json['fatal'] as bool? ?? false,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$VoiceServerErrorToJson(VoiceServerError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'fatal': instance.fatal,
      'type': instance.$type,
    };

VoiceServerSessionClosed _$VoiceServerSessionClosedFromJson(
  Map<String, dynamic> json,
) => VoiceServerSessionClosed(
  reason: $enumDecode(_$SessionCloseReasonEnumMap, json['reason']),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$VoiceServerSessionClosedToJson(
  VoiceServerSessionClosed instance,
) => <String, dynamic>{
  'reason': _$SessionCloseReasonEnumMap[instance.reason]!,
  'type': instance.$type,
};

const _$SessionCloseReasonEnumMap = {
  SessionCloseReason.clientRequest: 'client_request',
  SessionCloseReason.timeout: 'timeout',
  SessionCloseReason.completed: 'completed',
  SessionCloseReason.error: 'error',
};
