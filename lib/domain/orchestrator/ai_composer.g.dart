// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_composer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(useBackendCompose)
final useBackendComposeProvider = UseBackendComposeProvider._();

final class UseBackendComposeProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  UseBackendComposeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'useBackendComposeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$useBackendComposeHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return useBackendCompose(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$useBackendComposeHash() => r'cb0b7ef4ac99c144b21ee9260a9caebd7a35f70b';

@ProviderFor(activeAiTransport)
final activeAiTransportProvider = ActiveAiTransportProvider._();

final class ActiveAiTransportProvider
    extends
        $FunctionalProvider<
          AiTransportRepository,
          AiTransportRepository,
          AiTransportRepository
        >
    with $Provider<AiTransportRepository> {
  ActiveAiTransportProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeAiTransportProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeAiTransportHash();

  @$internal
  @override
  $ProviderElement<AiTransportRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AiTransportRepository create(Ref ref) {
    return activeAiTransport(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AiTransportRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AiTransportRepository>(value),
    );
  }
}

String _$activeAiTransportHash() => r'9c2ea6eb8f15c2ff669282d1e60558c56673fee4';

/// Calls the compose API (or mock) and returns an A2UI root node.

@ProviderFor(AiComposer)
final aiComposerProvider = AiComposerProvider._();

/// Calls the compose API (or mock) and returns an A2UI root node.
final class AiComposerProvider
    extends $AsyncNotifierProvider<AiComposer, void> {
  /// Calls the compose API (or mock) and returns an A2UI root node.
  AiComposerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiComposerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiComposerHash();

  @$internal
  @override
  AiComposer create() => AiComposer();
}

String _$aiComposerHash() => r'c8e3781f4f509e546f3727393573b1b402bb8826';

/// Calls the compose API (or mock) and returns an A2UI root node.

abstract class _$AiComposer extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
