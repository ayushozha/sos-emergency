import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sos_emergency/data/api/api_enums.dart';

part 'voice_health.freezed.dart';
part 'voice_health.g.dart';

/// `GET /v1/voice/health` response.
@freezed
abstract class VoiceHealthResponse with _$VoiceHealthResponse {
  const factory VoiceHealthResponse({
    required HealthStatus status,
    required String version,
    required DateTime timestamp,
    double? uptimeSeconds,
    int? activeSessions,
    ModelHealth? model,
    List<DependencyHealth>? dependencies,
  }) = _VoiceHealthResponse;

  factory VoiceHealthResponse.fromJson(Map<String, dynamic> json) =>
      _$VoiceHealthResponseFromJson(json);
}

@freezed
abstract class ModelHealth with _$ModelHealth {
  const factory ModelHealth({required String id, required bool ready}) =
      _ModelHealth;

  factory ModelHealth.fromJson(Map<String, dynamic> json) =>
      _$ModelHealthFromJson(json);
}

@freezed
abstract class DependencyHealth with _$DependencyHealth {
  const factory DependencyHealth({
    required String name,
    required HealthStatus status,
    double? latencyMs,
  }) = _DependencyHealth;

  factory DependencyHealth.fromJson(Map<String, dynamic> json) =>
      _$DependencyHealthFromJson(json);
}
