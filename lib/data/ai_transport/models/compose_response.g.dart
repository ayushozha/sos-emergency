// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compose_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ComposeResponse _$ComposeResponseFromJson(Map<String, dynamic> json) =>
    _ComposeResponse(
      requestId: json['requestId'] as String,
      surface: A2uiNode.fromJson(json['surface'] as Map<String, dynamic>),
      catalogVersion: json['catalogVersion'] as String?,
      finishReason: $enumDecodeNullable(
        _$ComposeFinishReasonEnumMap,
        json['finishReason'],
      ),
      usage: json['usage'] == null
          ? null
          : ComposeUsage.fromJson(json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComposeResponseToJson(_ComposeResponse instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'surface': instance.surface.toJson(),
      'catalogVersion': instance.catalogVersion,
      'finishReason': _$ComposeFinishReasonEnumMap[instance.finishReason],
      'usage': instance.usage?.toJson(),
    };

const _$ComposeFinishReasonEnumMap = {
  ComposeFinishReason.complete: 'complete',
  ComposeFinishReason.timeout: 'timeout',
  ComposeFinishReason.refused: 'refused',
};

_ComposeUsage _$ComposeUsageFromJson(Map<String, dynamic> json) =>
    _ComposeUsage(
      latencyMs: (json['latencyMs'] as num?)?.toDouble(),
      inputTokens: (json['inputTokens'] as num?)?.toInt(),
      outputTokens: (json['outputTokens'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ComposeUsageToJson(_ComposeUsage instance) =>
    <String, dynamic>{
      'latencyMs': instance.latencyMs,
      'inputTokens': instance.inputTokens,
      'outputTokens': instance.outputTokens,
    };
