// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compose_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ComposeRequest _$ComposeRequestFromJson(Map<String, dynamic> json) =>
    _ComposeRequest(
      classification: ClassificationDto.fromJson(
        json['classification'] as Map<String, dynamic>,
      ),
      context: ComposeContext.fromJson(json['context'] as Map<String, dynamic>),
      catalogVersion: json['catalogVersion'] as String,
      stream: json['stream'] as bool? ?? true,
      timeBudgetMs: (json['timeBudgetMs'] as num?)?.toInt() ?? 3000,
      requestId: json['requestId'] as String?,
    );

Map<String, dynamic> _$ComposeRequestToJson(_ComposeRequest instance) =>
    <String, dynamic>{
      'classification': instance.classification.toJson(),
      'context': instance.context.toJson(),
      'catalogVersion': instance.catalogVersion,
      'stream': instance.stream,
      'timeBudgetMs': instance.timeBudgetMs,
      'requestId': instance.requestId,
    };

_ClassificationDto _$ClassificationDtoFromJson(Map<String, dynamic> json) =>
    _ClassificationDto(
      scenario: $enumDecode(_$ApiScenarioClassEnumMap, json['scenario']),
      severity: $enumDecode(_$ApiSeverityEnumMap, json['severity']),
      mode: $enumDecode(_$ApiAppModeEnumMap, json['mode']),
      confidence: (json['confidence'] as num).toDouble(),
      hazards:
          (json['hazards'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ApiHazardEnumMap, e))
              .toList() ??
          const <ApiHazard>[],
    );

Map<String, dynamic> _$ClassificationDtoToJson(_ClassificationDto instance) =>
    <String, dynamic>{
      'scenario': _$ApiScenarioClassEnumMap[instance.scenario]!,
      'severity': _$ApiSeverityEnumMap[instance.severity]!,
      'mode': _$ApiAppModeEnumMap[instance.mode]!,
      'confidence': instance.confidence,
      'hazards': instance.hazards.map((e) => _$ApiHazardEnumMap[e]!).toList(),
    };

const _$ApiScenarioClassEnumMap = {
  ApiScenarioClass.crash: 'crash',
  ApiScenarioClass.medical: 'medical',
  ApiScenarioClass.beingFollowed: 'beingFollowed',
  ApiScenarioClass.flatTire: 'flatTire',
  ApiScenarioClass.wontStart: 'wontStart',
  ApiScenarioClass.lockedOut: 'lockedOut',
  ApiScenarioClass.outOfGas: 'outOfGas',
  ApiScenarioClass.unsafeParked: 'unsafeParked',
  ApiScenarioClass.unknown: 'unknown',
};

const _$ApiSeverityEnumMap = {
  ApiSeverity.neutral: 'neutral',
  ApiSeverity.moderate: 'moderate',
  ApiSeverity.high: 'high',
  ApiSeverity.critical: 'critical',
};

const _$ApiAppModeEnumMap = {
  ApiAppMode.triage: 'triage',
  ApiAppMode.crash: 'crash',
  ApiAppMode.medical: 'medical',
  ApiAppMode.threat: 'threat',
  ApiAppMode.roadside: 'roadside',
};

const _$ApiHazardEnumMap = {
  ApiHazard.smoke: 'smoke',
  ApiHazard.fire: 'fire',
  ApiHazard.weather: 'weather',
  ApiHazard.lowVisibility: 'lowVisibility',
};

_ComposeContext _$ComposeContextFromJson(Map<String, dynamic> json) =>
    _ComposeContext(
      carState: $enumDecode(_$ApiCarStateEnumMap, json['carState']),
      connectivity: $enumDecode(_$ApiConnectivityEnumMap, json['connectivity']),
      isNight: json['isNight'] as bool,
      locale: json['locale'] as String,
      emergencyNumber: json['emergencyNumber'] as String?,
      position: json['position'] == null
          ? null
          : ComposePosition.fromJson(json['position'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComposeContextToJson(_ComposeContext instance) =>
    <String, dynamic>{
      'carState': _$ApiCarStateEnumMap[instance.carState]!,
      'connectivity': _$ApiConnectivityEnumMap[instance.connectivity]!,
      'isNight': instance.isNight,
      'locale': instance.locale,
      'emergencyNumber': instance.emergencyNumber,
      'position': instance.position?.toJson(),
    };

const _$ApiCarStateEnumMap = {
  ApiCarState.driving: 'driving',
  ApiCarState.parked: 'parked',
};

const _$ApiConnectivityEnumMap = {
  ApiConnectivity.online: 'online',
  ApiConnectivity.degraded: 'degraded',
  ApiConnectivity.offline: 'offline',
};

_ComposePosition _$ComposePositionFromJson(Map<String, dynamic> json) =>
    _ComposePosition(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      address: json['address'] as String?,
    );

Map<String, dynamic> _$ComposePositionToJson(_ComposePosition instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
    };
