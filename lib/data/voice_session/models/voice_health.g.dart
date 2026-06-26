// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_health.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VoiceHealthResponse _$VoiceHealthResponseFromJson(Map<String, dynamic> json) =>
    _VoiceHealthResponse(
      status: $enumDecode(_$HealthStatusEnumMap, json['status']),
      version: json['version'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      uptimeSeconds: (json['uptimeSeconds'] as num?)?.toDouble(),
      activeSessions: (json['activeSessions'] as num?)?.toInt(),
      model: json['model'] == null
          ? null
          : ModelHealth.fromJson(json['model'] as Map<String, dynamic>),
      dependencies: (json['dependencies'] as List<dynamic>?)
          ?.map((e) => DependencyHealth.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VoiceHealthResponseToJson(
  _VoiceHealthResponse instance,
) => <String, dynamic>{
  'status': _$HealthStatusEnumMap[instance.status]!,
  'version': instance.version,
  'timestamp': instance.timestamp.toIso8601String(),
  'uptimeSeconds': instance.uptimeSeconds,
  'activeSessions': instance.activeSessions,
  'model': instance.model?.toJson(),
  'dependencies': instance.dependencies?.map((e) => e.toJson()).toList(),
};

const _$HealthStatusEnumMap = {
  HealthStatus.ok: 'ok',
  HealthStatus.degraded: 'degraded',
  HealthStatus.down: 'down',
};

_ModelHealth _$ModelHealthFromJson(Map<String, dynamic> json) =>
    _ModelHealth(id: json['id'] as String, ready: json['ready'] as bool);

Map<String, dynamic> _$ModelHealthToJson(_ModelHealth instance) =>
    <String, dynamic>{'id': instance.id, 'ready': instance.ready};

_DependencyHealth _$DependencyHealthFromJson(Map<String, dynamic> json) =>
    _DependencyHealth(
      name: json['name'] as String,
      status: $enumDecode(_$HealthStatusEnumMap, json['status']),
      latencyMs: (json['latencyMs'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DependencyHealthToJson(_DependencyHealth instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': _$HealthStatusEnumMap[instance.status]!,
      'latencyMs': instance.latencyMs,
    };
