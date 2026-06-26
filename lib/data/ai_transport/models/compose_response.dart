import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sos_emergency/data/api/api_enums.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';

part 'compose_response.freezed.dart';
part 'compose_response.g.dart';

/// `POST /v1/chat/stream` response when `stream:false` — the complete A2UI
/// surface in one body. [surface]'s root is always an `EmergencyRoot`.
@freezed
abstract class ComposeResponse with _$ComposeResponse {
  const factory ComposeResponse({
    required String requestId,
    required A2uiNode surface,
    String? catalogVersion,
    ComposeFinishReason? finishReason,
    ComposeUsage? usage,
  }) = _ComposeResponse;

  factory ComposeResponse.fromJson(Map<String, dynamic> json) =>
      _$ComposeResponseFromJson(json);
}

@freezed
abstract class ComposeUsage with _$ComposeUsage {
  const factory ComposeUsage({
    double? latencyMs,
    int? inputTokens,
    int? outputTokens,
  }) = _ComposeUsage;

  factory ComposeUsage.fromJson(Map<String, dynamic> json) =>
      _$ComposeUsageFromJson(json);
}
