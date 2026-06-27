import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sos_emergency/data/api/api_enums.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';

part 'compose_stream_event.freezed.dart';
part 'compose_stream_event.g.dart';

/// One SSE event from a streaming `POST /v1/chat/stream` response. Discriminated
/// by `type`: a `node` to merge, a terminal `done`, or an `error`.
@Freezed(unionKey: 'type')
sealed class ComposeStreamEvent with _$ComposeStreamEvent {
  /// A node to merge into the surface under [parentId] (root when absent).
  @FreezedUnionValue('node')
  const factory ComposeStreamEvent.node({
    required A2uiNode node,
    String? parentId,
  }) = ComposeStreamNode;

  /// Terminal event with the reason composition finished.
  @FreezedUnionValue('done')
  const factory ComposeStreamEvent.done({
    required ComposeFinishReason finishReason,
  }) = ComposeStreamDone;

  /// A stream-level failure; the client falls back to the baseline.
  @FreezedUnionValue('error')
  const factory ComposeStreamEvent.error({
    required String code,
    required String message,
  }) = ComposeStreamError;

  factory ComposeStreamEvent.fromJson(Map<String, dynamic> json) =>
      _$ComposeStreamEventFromJson(json);
}
