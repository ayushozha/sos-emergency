// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_orchestration.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(httpClient)
final httpClientProvider = HttpClientProvider._();

final class HttpClientProvider
    extends $FunctionalProvider<http.Client, http.Client, http.Client>
    with $Provider<http.Client> {
  HttpClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'httpClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$httpClientHash();

  @$internal
  @override
  $ProviderElement<http.Client> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  http.Client create(Ref ref) {
    return httpClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(http.Client value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<http.Client>(value),
    );
  }
}

String _$httpClientHash() => r'7ec49beae0f15115de79f9aa98dbd250130e26d8';

@ProviderFor(aiTransport)
final aiTransportProvider = AiTransportProvider._();

final class AiTransportProvider
    extends
        $FunctionalProvider<
          AiTransportRepository,
          AiTransportRepository,
          AiTransportRepository
        >
    with $Provider<AiTransportRepository> {
  AiTransportProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiTransportProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiTransportHash();

  @$internal
  @override
  $ProviderElement<AiTransportRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AiTransportRepository create(Ref ref) {
    return aiTransport(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AiTransportRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AiTransportRepository>(value),
    );
  }
}

String _$aiTransportHash() => r'e514a36856cbbd1996eecda15d5635a73cd30a85';

@ProviderFor(aiComposer)
final aiComposerProvider = AiComposerProvider._();

final class AiComposerProvider
    extends $FunctionalProvider<AiComposer, AiComposer, AiComposer>
    with $Provider<AiComposer> {
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
  $ProviderElement<AiComposer> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AiComposer create(Ref ref) {
    return aiComposer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AiComposer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AiComposer>(value),
    );
  }
}

String _$aiComposerHash() => r'9ec4927a6ecda111d0ba8efd0382ea625309985f';

@ProviderFor(safetySupervisor)
final safetySupervisorProvider = SafetySupervisorProvider._();

final class SafetySupervisorProvider
    extends
        $FunctionalProvider<
          SafetySupervisor,
          SafetySupervisor,
          SafetySupervisor
        >
    with $Provider<SafetySupervisor> {
  SafetySupervisorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'safetySupervisorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$safetySupervisorHash();

  @$internal
  @override
  $ProviderElement<SafetySupervisor> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SafetySupervisor create(Ref ref) {
    return safetySupervisor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SafetySupervisor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SafetySupervisor>(value),
    );
  }
}

String _$safetySupervisorHash() => r'f824d3ca3c7de723dfeca3d4fbb0cedda4669088';

/// Master switch for the legacy bespoke AI enrichment path (the non-streaming
/// [HttpAiTransport] → [composeEndpoint]). Off by default: that endpoint is a
/// placeholder and the path predates the genui/backend transport, so leaving it
/// on makes every compose hit a dead host. The deterministic baseline (the
/// Phase 2 product) renders every scenario without it; voice-triggered GenUI
/// renders go through the separate genui transport. Re-enable once the composer
/// is re-targeted to the genui pipeline (Phase 5).

@ProviderFor(AiEnabled)
final aiEnabledProvider = AiEnabledProvider._();

/// Master switch for the legacy bespoke AI enrichment path (the non-streaming
/// [HttpAiTransport] → [composeEndpoint]). Off by default: that endpoint is a
/// placeholder and the path predates the genui/backend transport, so leaving it
/// on makes every compose hit a dead host. The deterministic baseline (the
/// Phase 2 product) renders every scenario without it; voice-triggered GenUI
/// renders go through the separate genui transport. Re-enable once the composer
/// is re-targeted to the genui pipeline (Phase 5).
final class AiEnabledProvider extends $NotifierProvider<AiEnabled, bool> {
  /// Master switch for the legacy bespoke AI enrichment path (the non-streaming
  /// [HttpAiTransport] → [composeEndpoint]). Off by default: that endpoint is a
  /// placeholder and the path predates the genui/backend transport, so leaving it
  /// on makes every compose hit a dead host. The deterministic baseline (the
  /// Phase 2 product) renders every scenario without it; voice-triggered GenUI
  /// renders go through the separate genui transport. Re-enable once the composer
  /// is re-targeted to the genui pipeline (Phase 5).
  AiEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiEnabledProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiEnabledHash();

  @$internal
  @override
  AiEnabled create() => AiEnabled();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$aiEnabledHash() => r'a944b628df4384d77801b4983dcc85ce172ec67a';

/// Master switch for the legacy bespoke AI enrichment path (the non-streaming
/// [HttpAiTransport] → [composeEndpoint]). Off by default: that endpoint is a
/// placeholder and the path predates the genui/backend transport, so leaving it
/// on makes every compose hit a dead host. The deterministic baseline (the
/// Phase 2 product) renders every scenario without it; voice-triggered GenUI
/// renders go through the separate genui transport. Re-enable once the composer
/// is re-targeted to the genui pipeline (Phase 5).

abstract class _$AiEnabled extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
