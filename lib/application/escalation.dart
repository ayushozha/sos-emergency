import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/data/offline/action_queue.dart';
import 'package:sos_emergency/data/offline/offline_guides_repository.dart';
import 'package:sos_emergency/data/sharing/sharing_repositories.dart';
import 'package:sos_emergency/data/telephony/emergency_number_repository.dart';
import 'package:sos_emergency/data/telephony/telephony_repository.dart';
import 'package:sos_emergency/domain/models/contacts.dart';
import 'package:sos_emergency/domain/models/emergency_call.dart';

part 'escalation.g.dart';

// ---- repository providers (sandbox defaults; swapped in Phase 5) ----

@Riverpod(keepAlive: true)
TelephonyRepository telephony(Ref ref) => SandboxTelephonyRepository();

@Riverpod(keepAlive: true)
EmergencyNumberRepository emergencyNumber(Ref ref) =>
    const LocaleEmergencyNumberRepository();

/// The user's region — drives the emergency number. Overridden per locale.
@Riverpod(keepAlive: true)
String region(Ref ref) => 'US';

@Riverpod(keepAlive: true)
LocationSharingRepository locationSharing(Ref ref) =>
    SandboxLocationSharingRepository();

@Riverpod(keepAlive: true)
ContactsRepository contacts(Ref ref) => SandboxContactsRepository();

@Riverpod(keepAlive: true)
ContactNotifier contactAlerter(Ref ref) => SandboxContactNotifier();

@Riverpod(keepAlive: true)
ActionQueue actionQueue(Ref ref) => ActionQueue();

@Riverpod(keepAlive: true)
OfflineGuidesRepository offlineGuides(Ref ref) => const BundledOfflineGuides();

// ---- PlaceEmergencyCall ----

/// Owns the emergency-call lifecycle. Auto-escalation arms a visible,
/// cancelable countdown before dialing — never a silent auto-dial — and the
/// number is resolved from locale data, never hard-coded.
@Riverpod(keepAlive: true)
class EmergencyCallController extends _$EmergencyCallController {
  Timer? _deadline;
  Timer? _ticker;

  @override
  EmergencyCallState build() {
    ref.onDispose(_cancelTimers);
    final number = ref
        .watch(emergencyNumberProvider)
        .numberFor(ref.watch(regionProvider));
    return EmergencyCallState.idle(number);
  }

  /// Begins a cancelable countdown to an automatic call.
  void arm({Duration total = const Duration(seconds: 10)}) {
    _cancelTimers();
    state = state.copyWith(
      phase: CallPhase.countdown,
      secondsLeft: total.inSeconds,
    );
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      final left = state.secondsLeft - 1;
      if (left > 0) state = state.copyWith(secondsLeft: left);
    });
    _deadline = Timer(total, _place);
  }

  /// Calls immediately, skipping any countdown.
  void callNow() {
    _cancelTimers();
    unawaited(_place());
  }

  /// Aborts the countdown — the "I'm safe" path. Never dials.
  void cancel() {
    _cancelTimers();
    state = state.copyWith(phase: CallPhase.idle, secondsLeft: 0);
  }

  Future<void> hangUp() async {
    _cancelTimers();
    await ref.read(telephonyProvider).hangUp();
    state = state.copyWith(phase: CallPhase.ended);
  }

  Future<void> _place() async {
    _cancelTimers();
    state = state.copyWith(phase: CallPhase.connecting, secondsLeft: 0);
    await ref.read(telephonyProvider).dial(state.number);
    state = state.copyWith(phase: CallPhase.active);
  }

  void _cancelTimers() {
    _deadline?.cancel();
    _ticker?.cancel();
  }
}

// ---- ShareLocation ----

typedef ShareLocationState = ({bool isSharing, List<String> recipients});

@Riverpod(keepAlive: true)
class ShareLocationController extends _$ShareLocationController {
  @override
  ShareLocationState build() => (isSharing: false, recipients: const []);

  Future<void> start(List<String> recipients) async {
    await ref.read(locationSharingProvider).start(recipients);
    state = (isSharing: true, recipients: recipients);
  }

  Future<void> stop() async {
    await ref.read(locationSharingProvider).stop();
    state = (isSharing: false, recipients: const []);
  }
}

// ---- NotifyContacts ----

@Riverpod(keepAlive: true)
class NotifyContactsController extends _$NotifyContactsController {
  @override
  List<ContactDelivery> build() => const [];

  /// Alerts every trusted contact, advancing each through
  /// queued → sending → reached/failed so the user sees help is aware.
  Future<void> notify({
    String message = 'I need help — see my live location',
  }) async {
    final list = await ref.read(contactsProvider).contacts();
    state = [
      for (final c in list)
        ContactDelivery(contact: c, status: DeliveryStatus.queued),
    ];

    final notifier = ref.read(contactAlerterProvider);
    for (final c in list) {
      _set(c, DeliveryStatus.sending);
      final reached = await notifier.notify(c, message);
      _set(c, reached ? DeliveryStatus.reached : DeliveryStatus.failed);
    }
  }

  void _set(TrustedContact contact, DeliveryStatus status) {
    state = [
      for (final d in state)
        if (d.contact == contact) d.copyWith(status: status) else d,
    ];
  }
}
