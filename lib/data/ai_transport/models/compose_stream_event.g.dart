// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compose_stream_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComposeStreamNode _$ComposeStreamNodeFromJson(Map<String, dynamic> json) =>
    ComposeStreamNode(
      node: A2uiNode.fromJson(json['node'] as Map<String, dynamic>),
      parentId: json['parentId'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ComposeStreamNodeToJson(ComposeStreamNode instance) =>
    <String, dynamic>{
      'node': instance.node.toJson(),
      'parentId': instance.parentId,
      'type': instance.$type,
    };

ComposeStreamDone _$ComposeStreamDoneFromJson(Map<String, dynamic> json) =>
    ComposeStreamDone(
      finishReason: $enumDecode(
        _$ComposeFinishReasonEnumMap,
        json['finishReason'],
      ),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ComposeStreamDoneToJson(ComposeStreamDone instance) =>
    <String, dynamic>{
      'finishReason': _$ComposeFinishReasonEnumMap[instance.finishReason]!,
      'type': instance.$type,
    };

const _$ComposeFinishReasonEnumMap = {
  ComposeFinishReason.complete: 'complete',
  ComposeFinishReason.timeout: 'timeout',
  ComposeFinishReason.refused: 'refused',
};

ComposeStreamError _$ComposeStreamErrorFromJson(Map<String, dynamic> json) =>
    ComposeStreamError(
      code: json['code'] as String,
      message: json['message'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ComposeStreamErrorToJson(ComposeStreamError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'type': instance.$type,
    };
