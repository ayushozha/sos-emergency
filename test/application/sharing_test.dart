import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/application/escalation.dart';
import 'package:sos_emergency/data/sharing/sharing_repositories.dart';
import 'package:sos_emergency/domain/models/contacts.dart';

void main() {
  group('ShareLocationController', () {
    test('start/stop toggles the broadcast and recipients', () async {
      final c = ProviderContainer();
      addTearDown(c.dispose);

      await c.read(shareLocationControllerProvider.notifier).start([
        '911',
        'Maya',
      ]);
      final on = c.read(shareLocationControllerProvider);
      expect(on.isSharing, isTrue);
      expect(on.recipients, ['911', 'Maya']);
      expect(
        (c.read(locationSharingProvider) as SandboxLocationSharingRepository)
            .sharing,
        isTrue,
      );

      await c.read(shareLocationControllerProvider.notifier).stop();
      expect(c.read(shareLocationControllerProvider).isSharing, isFalse);
    });
  });

  group('NotifyContactsController', () {
    test('advances every contact to reached on success', () async {
      final c = ProviderContainer();
      addTearDown(c.dispose);

      await c.read(notifyContactsControllerProvider.notifier).notify();
      final state = c.read(notifyContactsControllerProvider);

      expect(state, hasLength(3));
      expect(
        state.every((d) => d.status == DeliveryStatus.reached),
        isTrue,
      );
    });

    test('marks an unreachable contact as failed', () async {
      final c = ProviderContainer(
        overrides: [
          contactAlerterProvider.overrideWithValue(
            SandboxContactNotifier(failFor: {'Dad'}),
          ),
        ],
      );
      addTearDown(c.dispose);

      await c.read(notifyContactsControllerProvider.notifier).notify();
      final dad = c
          .read(notifyContactsControllerProvider)
          .firstWhere((d) => d.contact.name == 'Dad');
      expect(dad.status, DeliveryStatus.failed);
    });

    test('handles the no-contacts case calmly', () async {
      final c = ProviderContainer(
        overrides: [
          contactsProvider.overrideWithValue(
            SandboxContactsRepository(const []),
          ),
        ],
      );
      addTearDown(c.dispose);

      await c.read(notifyContactsControllerProvider.notifier).notify();
      expect(c.read(notifyContactsControllerProvider), isEmpty);
    });
  });
}
