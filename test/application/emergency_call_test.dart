import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/application/escalation.dart';
import 'package:sos_emergency/data/telephony/telephony_repository.dart';
import 'package:sos_emergency/domain/models/emergency_call.dart';

ProviderContainer _container({String region = 'US'}) {
  final container = ProviderContainer(
    overrides: [regionProvider.overrideWithValue(region)],
  );
  addTearDown(container.dispose);
  return container;
}

SandboxTelephonyRepository _telephony(ProviderContainer c) =>
    c.read(telephonyProvider) as SandboxTelephonyRepository;

void main() {
  group('EmergencyCallController', () {
    test('the emergency number is locale data, not hard-coded', () {
      expect(_container().read(emergencyCallControllerProvider).number, '911');
      expect(
        _container(region: 'GB').read(emergencyCallControllerProvider).number,
        '999',
      );
      expect(
        _container(region: 'AU').read(emergencyCallControllerProvider).number,
        '000',
      );
    });

    test('arm() enters a visible countdown without dialing', () {
      final c = _container();
      c.read(emergencyCallControllerProvider.notifier).arm();
      final state = c.read(emergencyCallControllerProvider);
      expect(state.phase, CallPhase.countdown);
      expect(state.secondsLeft, 10);
      expect(_telephony(c).dialed, isEmpty);
    });

    test('the countdown auto-dials on expiry', () async {
      final c = _container();
      c
          .read(emergencyCallControllerProvider.notifier)
          .arm(total: const Duration(milliseconds: 40));
      await Future<void>.delayed(const Duration(milliseconds: 90));
      expect(_telephony(c).dialed, ['911']);
      expect(c.read(emergencyCallControllerProvider).phase, CallPhase.active);
    });

    test('cancel() aborts the countdown and never dials', () async {
      final c = _container();
      c
          .read(emergencyCallControllerProvider.notifier)
          .arm(total: const Duration(milliseconds: 40));
      c.read(emergencyCallControllerProvider.notifier).cancel();
      await Future<void>.delayed(const Duration(milliseconds: 90));
      expect(_telephony(c).dialed, isEmpty);
      expect(c.read(emergencyCallControllerProvider).phase, CallPhase.idle);
    });

    test('callNow() dials immediately, skipping the countdown', () async {
      final c = _container();
      c.read(emergencyCallControllerProvider.notifier).callNow();
      await Future<void>.delayed(Duration.zero);
      expect(_telephony(c).dialed, ['911']);
      expect(c.read(emergencyCallControllerProvider).phase, CallPhase.active);
    });

    test('hangUp() ends the call', () async {
      final c = _container();
      c.read(emergencyCallControllerProvider.notifier).callNow();
      await Future<void>.delayed(Duration.zero);
      await c.read(emergencyCallControllerProvider.notifier).hangUp();
      expect(_telephony(c).callActive, isFalse);
      expect(c.read(emergencyCallControllerProvider).phase, CallPhase.ended);
    });
  });
}
