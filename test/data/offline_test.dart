import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/data/offline/action_queue.dart';
import 'package:sos_emergency/data/offline/offline_guides_repository.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/models/queued_action.dart';

void main() {
  group('ActionQueue', () {
    test('flushes queued actions in order when connectivity returns', () async {
      final queue = ActionQueue()
        ..enqueue(
          const QueuedAction(id: '1', kind: QueuedActionKind.roadsideRequest),
        )
        ..enqueue(
          const QueuedAction(id: '2', kind: QueuedActionKind.smsFallback),
        );
      expect(queue.pending, hasLength(2));

      final ran = <String>[];
      final flushed = await queue.flush((a) async => ran.add(a.id));

      expect(flushed, 2);
      expect(ran, ['1', '2']);
      expect(queue.isEmpty, isTrue);
    });

    test('a failing action stays queued for the next attempt', () async {
      final queue = ActionQueue()
        ..enqueue(
          const QueuedAction(
            id: 'keep',
            kind: QueuedActionKind.roadsideRequest,
          ),
        )
        ..enqueue(
          const QueuedAction(id: 'ok', kind: QueuedActionKind.smsFallback),
        );

      await queue.flush((a) async {
        if (a.id == 'keep') throw Exception('still offline');
      });

      expect(queue.pending.map((a) => a.id), ['keep']);
    });
  });

  group('BundledOfflineGuides', () {
    const guides = BundledOfflineGuides();

    test('mechanical guides read with zero network', () {
      expect(guides.stepsFor(ScenarioClass.wontStart), isNotEmpty);
      expect(guides.stepsFor(ScenarioClass.flatTire), isNotEmpty);
    });

    test('returns empty for scenarios with no bundled guide', () {
      expect(guides.stepsFor(ScenarioClass.crash), isEmpty);
    });
  });
}
