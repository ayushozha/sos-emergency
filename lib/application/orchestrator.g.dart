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

@ProviderFor(DemoScenario)
final demoScenarioProvider = DemoScenarioProvider._();

final class DemoScenarioProvider
    extends $NotifierProvider<DemoScenario, ScenarioClass> {
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

@ProviderFor(SurfaceViewModeController)
final surfaceViewModeControllerProvider = SurfaceViewModeControllerProvider._();

final class SurfaceViewModeControllerProvider
    extends $NotifierProvider<SurfaceViewModeController, SurfaceViewMode> {
  SurfaceViewModeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'surfaceViewModeControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$surfaceViewModeControllerHash();

  @$internal
  @override
  SurfaceViewModeController create() => SurfaceViewModeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SurfaceViewMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SurfaceViewMode>(value),
    );
  }
}

String _$surfaceViewModeControllerHash() =>
    r'b5312ffbf27495e000c3bc745df056156d106b0b';

abstract class _$SurfaceViewModeController extends $Notifier<SurfaceViewMode> {
  SurfaceViewMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SurfaceViewMode, SurfaceViewMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SurfaceViewMode, SurfaceViewMode>,
              SurfaceViewMode,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(HandoffScreenPicker)
final handoffScreenPickerProvider = HandoffScreenPickerProvider._();

final class HandoffScreenPickerProvider
    extends $NotifierProvider<HandoffScreenPicker, String> {
  HandoffScreenPickerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'handoffScreenPickerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$handoffScreenPickerHash();

  @$internal
  @override
  HandoffScreenPicker create() => HandoffScreenPicker();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$handoffScreenPickerHash() =>
    r'c03ca2662289ef645e5b1c228706a946fda88ea1';

abstract class _$HandoffScreenPicker extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(emergencyContextRepository)
final emergencyContextRepositoryProvider =
    EmergencyContextRepositoryProvider._();

final class EmergencyContextRepositoryProvider
    extends
        $FunctionalProvider<
          EmergencyContextRepository,
          EmergencyContextRepository,
          EmergencyContextRepository
        >
    with $Provider<EmergencyContextRepository> {
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

/// Sense → classify → compose (AI with deterministic fallback) → render.

@ProviderFor(SurfaceController)
final surfaceControllerProvider = SurfaceControllerProvider._();

/// Sense → classify → compose (AI with deterministic fallback) → render.
final class SurfaceControllerProvider
    extends $AsyncNotifierProvider<SurfaceController, Surface> {
  /// Sense → classify → compose (AI with deterministic fallback) → render.
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
}

String _$surfaceControllerHash() => r'b3d4fa5fb8253bf02cf71a16977440985d9cd15b';

/// Sense → classify → compose (AI with deterministic fallback) → render.

abstract class _$SurfaceController extends $AsyncNotifier<Surface> {
  FutureOr<Surface> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Surface>, Surface>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Surface>, Surface>,
              AsyncValue<Surface>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
