// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orchestrator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(decisionEngine)
final decisionEngineProvider = DecisionEngineProvider._();

final class DecisionEngineProvider
    extends $FunctionalProvider<DecisionEngine, DecisionEngine, DecisionEngine>
    with $Provider<DecisionEngine> {
  DecisionEngineProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'decisionEngineProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$decisionEngineHash();

  @$internal
  @override
  $ProviderElement<DecisionEngine> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DecisionEngine create(Ref ref) {
    return decisionEngine(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DecisionEngine value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DecisionEngine>(value),
    );
  }
}

String _$decisionEngineHash() => r'4bb56e3924c08ccf2406a3203009674ad97bf0d3';

@ProviderFor(deterministicComposer)
final deterministicComposerProvider = DeterministicComposerProvider._();

final class DeterministicComposerProvider
    extends
        $FunctionalProvider<
          DeterministicComposer,
          DeterministicComposer,
          DeterministicComposer
        >
    with $Provider<DeterministicComposer> {
  DeterministicComposerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deterministicComposerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deterministicComposerHash();

  @$internal
  @override
  $ProviderElement<DeterministicComposer> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeterministicComposer create(Ref ref) {
    return deterministicComposer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeterministicComposer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeterministicComposer>(value),
    );
  }
}

String _$deterministicComposerHash() =>
    r'6822b96d2d54d9752442951f8ad6eb7e4d61b151';

/// The scenario currently driving the on-device demo. A debug picker writes it;
/// in production this provider is replaced by live signal fusion.

@ProviderFor(DemoScenario)
final demoScenarioProvider = DemoScenarioProvider._();

/// The scenario currently driving the on-device demo. A debug picker writes it;
/// in production this provider is replaced by live signal fusion.
final class DemoScenarioProvider
    extends $NotifierProvider<DemoScenario, ScenarioClass> {
  /// The scenario currently driving the on-device demo. A debug picker writes it;
  /// in production this provider is replaced by live signal fusion.
  DemoScenarioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'demoScenarioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$demoScenarioHash();

  @$internal
  @override
  DemoScenario create() => DemoScenario();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScenarioClass value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScenarioClass>(value),
    );
  }
}

String _$demoScenarioHash() => r'344711caa6374697cec341d3e7126fce66e64b4a';

/// The scenario currently driving the on-device demo. A debug picker writes it;
/// in production this provider is replaced by live signal fusion.

abstract class _$DemoScenario extends $Notifier<ScenarioClass> {
  ScenarioClass build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ScenarioClass, ScenarioClass>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ScenarioClass, ScenarioClass>,
              ScenarioClass,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The fused-context source. Phase 2 uses a scripted scenario source; Phase 5
/// swaps in a live [ContextAggregator] without touching the orchestrator.

@ProviderFor(emergencyContextRepository)
final emergencyContextRepositoryProvider =
    EmergencyContextRepositoryProvider._();

/// The fused-context source. Phase 2 uses a scripted scenario source; Phase 5
/// swaps in a live [ContextAggregator] without touching the orchestrator.

final class EmergencyContextRepositoryProvider
    extends
        $FunctionalProvider<
          EmergencyContextRepository,
          EmergencyContextRepository,
          EmergencyContextRepository
        >
    with $Provider<EmergencyContextRepository> {
  /// The fused-context source. Phase 2 uses a scripted scenario source; Phase 5
  /// swaps in a live [ContextAggregator] without touching the orchestrator.
  EmergencyContextRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emergencyContextRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emergencyContextRepositoryHash();

  @$internal
  @override
  $ProviderElement<EmergencyContextRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EmergencyContextRepository create(Ref ref) {
    return emergencyContextRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmergencyContextRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmergencyContextRepository>(value),
    );
  }
}

String _$emergencyContextRepositoryHash() =>
    r'3aa250dbe4d8edfe411e2624a7ff01391a696761';

@ProviderFor(emergencyContext)
final emergencyContextProvider = EmergencyContextProvider._();

final class EmergencyContextProvider
    extends
        $FunctionalProvider<
          AsyncValue<EmergencyContext>,
          EmergencyContext,
          Stream<EmergencyContext>
        >
    with $FutureModifier<EmergencyContext>, $StreamProvider<EmergencyContext> {
  EmergencyContextProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emergencyContextProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emergencyContextHash();

  @$internal
  @override
  $StreamProviderElement<EmergencyContext> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<EmergencyContext> create(Ref ref) {
    return emergencyContext(ref);
  }
}

String _$emergencyContextHash() => r'5ff06726dea4dc19a23bf0a6d87fd0cf4bd2af9f';

/// The orchestrator's baseline loop: sense → classify → compose → render. Holds
/// the current deterministic [Surface] and recomputes it whenever the fused
/// context changes. No AI and no Safety Supervisor yet (Phase 3).

@ProviderFor(SurfaceController)
final surfaceControllerProvider = SurfaceControllerProvider._();

/// The orchestrator's baseline loop: sense → classify → compose → render. Holds
/// the current deterministic [Surface] and recomputes it whenever the fused
/// context changes. No AI and no Safety Supervisor yet (Phase 3).
final class SurfaceControllerProvider
    extends $NotifierProvider<SurfaceController, Surface> {
  /// The orchestrator's baseline loop: sense → classify → compose → render. Holds
  /// the current deterministic [Surface] and recomputes it whenever the fused
  /// context changes. No AI and no Safety Supervisor yet (Phase 3).
  SurfaceControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'surfaceControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$surfaceControllerHash();

  @$internal
  @override
  SurfaceController create() => SurfaceController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Surface value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Surface>(value),
    );
  }
}

String _$surfaceControllerHash() => r'26522680f6261129b3cff35c9a14ff3372909749';

/// The orchestrator's baseline loop: sense → classify → compose → render. Holds
/// the current deterministic [Surface] and recomputes it whenever the fused
/// context changes. No AI and no Safety Supervisor yet (Phase 3).

abstract class _$SurfaceController extends $Notifier<Surface> {
  Surface build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Surface, Surface>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Surface, Surface>,
              Surface,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
