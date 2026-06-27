// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'escalation.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(telephony)
final telephonyProvider = TelephonyProvider._();

final class TelephonyProvider
    extends
        $FunctionalProvider<
          TelephonyRepository,
          TelephonyRepository,
          TelephonyRepository
        >
    with $Provider<TelephonyRepository> {
  TelephonyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'telephonyProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$telephonyHash();

  @$internal
  @override
  $ProviderElement<TelephonyRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TelephonyRepository create(Ref ref) {
    return telephony(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TelephonyRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TelephonyRepository>(value),
    );
  }
}

String _$telephonyHash() => r'e1ae2faa2b91882b3df5ecc66463d71114328746';

@ProviderFor(emergencyNumber)
final emergencyNumberProvider = EmergencyNumberProvider._();

final class EmergencyNumberProvider
    extends
        $FunctionalProvider<
          EmergencyNumberRepository,
          EmergencyNumberRepository,
          EmergencyNumberRepository
        >
    with $Provider<EmergencyNumberRepository> {
  EmergencyNumberProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emergencyNumberProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emergencyNumberHash();

  @$internal
  @override
  $ProviderElement<EmergencyNumberRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EmergencyNumberRepository create(Ref ref) {
    return emergencyNumber(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmergencyNumberRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmergencyNumberRepository>(value),
    );
  }
}

String _$emergencyNumberHash() => r'4472eb62fec420c75e71086389c0d4910d0c0801';

/// The user's region — drives the emergency number. Overridden per locale.

@ProviderFor(region)
final regionProvider = RegionProvider._();

/// The user's region — drives the emergency number. Overridden per locale.

final class RegionProvider extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// The user's region — drives the emergency number. Overridden per locale.
  RegionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'regionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$regionHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return region(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$regionHash() => r'5b34790e5d01fe3cebf91f4d1e2d21693f6f2b45';

@ProviderFor(locationSharing)
final locationSharingProvider = LocationSharingProvider._();

final class LocationSharingProvider
    extends
        $FunctionalProvider<
          LocationSharingRepository,
          LocationSharingRepository,
          LocationSharingRepository
        >
    with $Provider<LocationSharingRepository> {
  LocationSharingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationSharingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationSharingHash();

  @$internal
  @override
  $ProviderElement<LocationSharingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocationSharingRepository create(Ref ref) {
    return locationSharing(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocationSharingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocationSharingRepository>(value),
    );
  }
}

String _$locationSharingHash() => r'ce288bb54a0a96bb7fb97288a17819f43a2c6719';

@ProviderFor(contacts)
final contactsProvider = ContactsProvider._();

final class ContactsProvider
    extends
        $FunctionalProvider<
          ContactsRepository,
          ContactsRepository,
          ContactsRepository
        >
    with $Provider<ContactsRepository> {
  ContactsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contactsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contactsHash();

  @$internal
  @override
  $ProviderElement<ContactsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ContactsRepository create(Ref ref) {
    return contacts(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContactsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContactsRepository>(value),
    );
  }
}

String _$contactsHash() => r'8245085c3a7681071180e37d410d65b443a08cc8';

@ProviderFor(contactAlerter)
final contactAlerterProvider = ContactAlerterProvider._();

final class ContactAlerterProvider
    extends
        $FunctionalProvider<ContactNotifier, ContactNotifier, ContactNotifier>
    with $Provider<ContactNotifier> {
  ContactAlerterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contactAlerterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contactAlerterHash();

  @$internal
  @override
  $ProviderElement<ContactNotifier> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ContactNotifier create(Ref ref) {
    return contactAlerter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContactNotifier value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContactNotifier>(value),
    );
  }
}

String _$contactAlerterHash() => r'9af236a95539e0417f92d5ba4e112b76b899c690';

@ProviderFor(actionQueue)
final actionQueueProvider = ActionQueueProvider._();

final class ActionQueueProvider
    extends $FunctionalProvider<ActionQueue, ActionQueue, ActionQueue>
    with $Provider<ActionQueue> {
  ActionQueueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'actionQueueProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$actionQueueHash();

  @$internal
  @override
  $ProviderElement<ActionQueue> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ActionQueue create(Ref ref) {
    return actionQueue(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActionQueue value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActionQueue>(value),
    );
  }
}

String _$actionQueueHash() => r'ff7b992e31e6395ee9362215c0a3bd1dc74b9f59';

@ProviderFor(offlineGuides)
final offlineGuidesProvider = OfflineGuidesProvider._();

final class OfflineGuidesProvider
    extends
        $FunctionalProvider<
          OfflineGuidesRepository,
          OfflineGuidesRepository,
          OfflineGuidesRepository
        >
    with $Provider<OfflineGuidesRepository> {
  OfflineGuidesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'offlineGuidesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$offlineGuidesHash();

  @$internal
  @override
  $ProviderElement<OfflineGuidesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OfflineGuidesRepository create(Ref ref) {
    return offlineGuides(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OfflineGuidesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OfflineGuidesRepository>(value),
    );
  }
}

String _$offlineGuidesHash() => r'd253e0b74a009984b94c185182cb3933bd5bc33e';

/// Owns the emergency-call lifecycle. Auto-escalation arms a visible,
/// cancelable countdown before dialing — never a silent auto-dial — and the
/// number is resolved from locale data, never hard-coded.

@ProviderFor(EmergencyCallController)
final emergencyCallControllerProvider = EmergencyCallControllerProvider._();

/// Owns the emergency-call lifecycle. Auto-escalation arms a visible,
/// cancelable countdown before dialing — never a silent auto-dial — and the
/// number is resolved from locale data, never hard-coded.
final class EmergencyCallControllerProvider
    extends $NotifierProvider<EmergencyCallController, EmergencyCallState> {
  /// Owns the emergency-call lifecycle. Auto-escalation arms a visible,
  /// cancelable countdown before dialing — never a silent auto-dial — and the
  /// number is resolved from locale data, never hard-coded.
  EmergencyCallControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emergencyCallControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emergencyCallControllerHash();

  @$internal
  @override
  EmergencyCallController create() => EmergencyCallController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmergencyCallState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmergencyCallState>(value),
    );
  }
}

String _$emergencyCallControllerHash() =>
    r'e7fe010e6a782030cf89251d30198c10a7bcaea5';

/// Owns the emergency-call lifecycle. Auto-escalation arms a visible,
/// cancelable countdown before dialing — never a silent auto-dial — and the
/// number is resolved from locale data, never hard-coded.

abstract class _$EmergencyCallController extends $Notifier<EmergencyCallState> {
  EmergencyCallState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<EmergencyCallState, EmergencyCallState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EmergencyCallState, EmergencyCallState>,
              EmergencyCallState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ShareLocationController)
final shareLocationControllerProvider = ShareLocationControllerProvider._();

final class ShareLocationControllerProvider
    extends $NotifierProvider<ShareLocationController, ShareLocationState> {
  ShareLocationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shareLocationControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shareLocationControllerHash();

  @$internal
  @override
  ShareLocationController create() => ShareLocationController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShareLocationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShareLocationState>(value),
    );
  }
}

String _$shareLocationControllerHash() =>
    r'b3d397cfaafa432b0a2e95dc93d61f533a6b0200';

abstract class _$ShareLocationController extends $Notifier<ShareLocationState> {
  ShareLocationState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ShareLocationState, ShareLocationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ShareLocationState, ShareLocationState>,
              ShareLocationState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(NotifyContactsController)
final notifyContactsControllerProvider = NotifyContactsControllerProvider._();

final class NotifyContactsControllerProvider
    extends $NotifierProvider<NotifyContactsController, List<ContactDelivery>> {
  NotifyContactsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notifyContactsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notifyContactsControllerHash();

  @$internal
  @override
  NotifyContactsController create() => NotifyContactsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ContactDelivery> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ContactDelivery>>(value),
    );
  }
}

String _$notifyContactsControllerHash() =>
    r'e5b9d4c482251e7920593290041141b7dfca5e9a';

abstract class _$NotifyContactsController
    extends $Notifier<List<ContactDelivery>> {
  List<ContactDelivery> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<ContactDelivery>, List<ContactDelivery>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<ContactDelivery>, List<ContactDelivery>>,
              List<ContactDelivery>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
