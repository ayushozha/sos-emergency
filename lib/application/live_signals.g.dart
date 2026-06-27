// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_signals.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The (optional) vehicle-signal source. Defaults to a simulated bus; on a
/// tablet there is no in-vehicle hardware, so a real source would be a paired
/// OBD dongle or manual triage entry.

@ProviderFor(vehicleBus)
final vehicleBusProvider = VehicleBusProvider._();

/// The (optional) vehicle-signal source. Defaults to a simulated bus; on a
/// tablet there is no in-vehicle hardware, so a real source would be a paired
/// OBD dongle or manual triage entry.

final class VehicleBusProvider
    extends
        $FunctionalProvider<
          VehicleBusRepository,
          VehicleBusRepository,
          VehicleBusRepository
        >
    with $Provider<VehicleBusRepository> {
  /// The (optional) vehicle-signal source. Defaults to a simulated bus; on a
  /// tablet there is no in-vehicle hardware, so a real source would be a paired
  /// OBD dongle or manual triage entry.
  VehicleBusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vehicleBusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vehicleBusHash();

  @$internal
  @override
  $ProviderElement<VehicleBusRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VehicleBusRepository create(Ref ref) {
    return vehicleBus(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VehicleBusRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VehicleBusRepository>(value),
    );
  }
}

String _$vehicleBusHash() => r'6bd4e3b91feb967abd87d3d8ddc4da549f7aef82';

/// The live fused [EmergencyContext], mutated by signal sources as they fire.
/// This is the production replacement for the scripted scenario source: feed it
/// real sensor/bus/intent signals and the classification follows automatically.

@ProviderFor(LiveContext)
final liveContextProvider = LiveContextProvider._();

/// The live fused [EmergencyContext], mutated by signal sources as they fire.
/// This is the production replacement for the scripted scenario source: feed it
/// real sensor/bus/intent signals and the classification follows automatically.
final class LiveContextProvider
    extends $NotifierProvider<LiveContext, EmergencyContext> {
  /// The live fused [EmergencyContext], mutated by signal sources as they fire.
  /// This is the production replacement for the scripted scenario source: feed it
  /// real sensor/bus/intent signals and the classification follows automatically.
  LiveContextProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveContextProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveContextHash();

  @$internal
  @override
  LiveContext create() => LiveContext();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmergencyContext value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmergencyContext>(value),
    );
  }
}

String _$liveContextHash() => r'cb38204bb87c57bb62e41a1cb61d9eaaa65efd25';

/// The live fused [EmergencyContext], mutated by signal sources as they fire.
/// This is the production replacement for the scripted scenario source: feed it
/// real sensor/bus/intent signals and the classification follows automatically.

abstract class _$LiveContext extends $Notifier<EmergencyContext> {
  EmergencyContext build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<EmergencyContext, EmergencyContext>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EmergencyContext, EmergencyContext>,
              EmergencyContext,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The classification of the live context — recomputes whenever a signal fires.

@ProviderFor(liveClassification)
final liveClassificationProvider = LiveClassificationProvider._();

/// The classification of the live context — recomputes whenever a signal fires.

final class LiveClassificationProvider
    extends $FunctionalProvider<Classification, Classification, Classification>
    with $Provider<Classification> {
  /// The classification of the live context — recomputes whenever a signal fires.
  LiveClassificationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveClassificationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveClassificationHash();

  @$internal
  @override
  $ProviderElement<Classification> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Classification create(Ref ref) {
    return liveClassification(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Classification value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Classification>(value),
    );
  }
}

String _$liveClassificationHash() =>
    r'825478da47ef3d679b1dc023a667e6038e555e61';

/// The deterministic Surface for the live context, Supervisor-enforced.

@ProviderFor(liveSurface)
final liveSurfaceProvider = LiveSurfaceProvider._();

/// The deterministic Surface for the live context, Supervisor-enforced.

final class LiveSurfaceProvider
    extends $FunctionalProvider<Surface, Surface, Surface>
    with $Provider<Surface> {
  /// The deterministic Surface for the live context, Supervisor-enforced.
  LiveSurfaceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveSurfaceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveSurfaceHash();

  @$internal
  @override
  $ProviderElement<Surface> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Surface create(Ref ref) {
    return liveSurface(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Surface value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Surface>(value),
    );
  }
}

String _$liveSurfaceHash() => r'27e09f3ec305b5f299dad218743767c177d01352';
