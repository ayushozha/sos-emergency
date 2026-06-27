import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sos_emergency/data/api/api_enums.dart';

part 'compose_request.freezed.dart';
part 'compose_request.g.dart';

/// `POST /v1/chat/stream` request body. The deterministic classification plus
/// the render context the AI composes a surface for.
@freezed
abstract class ComposeRequest with _$ComposeRequest {
  const factory ComposeRequest({
    required ClassificationDto classification,
    required ComposeContext context,
    required String catalogVersion,
    @Default(true) bool stream,
    @Default(3000) int timeBudgetMs,
    String? requestId,
  }) = _ComposeRequest;

  factory ComposeRequest.fromJson(Map<String, dynamic> json) =>
      _$ComposeRequestFromJson(json);
}

/// The engine's verdict, in wire form.
@freezed
abstract class ClassificationDto with _$ClassificationDto {
  const factory ClassificationDto({
    required ApiScenarioClass scenario,
    required ApiSeverity severity,
    required ApiAppMode mode,
    required double confidence,
    @Default(<ApiHazard>[]) List<ApiHazard> hazards,
  }) = _ClassificationDto;

  factory ClassificationDto.fromJson(Map<String, dynamic> json) =>
      _$ClassificationDtoFromJson(json);
}

/// Render context: vehicle/theme state, locale, and an optional position.
@freezed
abstract class ComposeContext with _$ComposeContext {
  const factory ComposeContext({
    required ApiCarState carState,
    required ApiConnectivity connectivity,
    required bool isNight,
    required String locale,
    String? emergencyNumber,
    ComposePosition? position,
  }) = _ComposeContext;

  factory ComposeContext.fromJson(Map<String, dynamic> json) =>
      _$ComposeContextFromJson(json);
}

@freezed
abstract class ComposePosition with _$ComposePosition {
  const factory ComposePosition({
    double? latitude,
    double? longitude,
    String? address,
  }) = _ComposePosition;

  factory ComposePosition.fromJson(Map<String, dynamic> json) =>
      _$ComposePositionFromJson(json);
}
