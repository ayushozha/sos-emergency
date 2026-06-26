import 'package:sos_emergency/domain/models/queued_action.dart';

/// A persistent queue of actions deferred while offline (roadside request, SMS
/// fallback, contact alerts). Flushed when connectivity returns so nothing is
/// lost when the car has no signal.
class ActionQueue {
  final List<QueuedAction> _pending = [];

  List<QueuedAction> get pending => List.unmodifiable(_pending);
  bool get isEmpty => _pending.isEmpty;

  void enqueue(QueuedAction action) => _pending.add(action);

  /// Runs [execute] for each pending action in order, removing those that
  /// succeed. Returns how many were flushed. An action that throws stays queued
  /// for the next attempt.
  Future<int> flush(Future<void> Function(QueuedAction) execute) async {
    var flushed = 0;
    for (final action in List<QueuedAction>.of(_pending)) {
      try {
        await execute(action);
        _pending.remove(action);
        flushed++;
      } on Object {
        // Keep it queued; retry on the next flush.
      }
    }
    return flushed;
  }
}
