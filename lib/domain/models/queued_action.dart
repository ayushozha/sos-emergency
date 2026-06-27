import 'package:freezed_annotation/freezed_annotation.dart';

part 'queued_action.freezed.dart';

/// An action deferred while offline, flushed when connectivity returns.
enum QueuedActionKind { roadsideRequest, notifyContacts, smsFallback }

@freezed
abstract class QueuedAction with _$QueuedAction {
  const factory QueuedAction({
    required String id,
    required QueuedActionKind kind,
    @Default(<String, Object?>{}) Map<String, Object?> payload,
  }) = _QueuedAction;
}
