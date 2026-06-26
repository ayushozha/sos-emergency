// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_transport.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
        isAutoDispose: true,
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

String _$aiTransportHash() => r'41aec84961ad0e03cbfbbf0810d3e0c448352323';

/// Loads the composed surface once. The renderer mounts this.

@ProviderFor(composedSurface)
final composedSurfaceProvider = ComposedSurfaceProvider._();

/// Loads the composed surface once. The renderer mounts this.

final class ComposedSurfaceProvider
    extends
        $FunctionalProvider<AsyncValue<A2uiNode>, A2uiNode, FutureOr<A2uiNode>>
    with $FutureModifier<A2uiNode>, $FutureProvider<A2uiNode> {
  /// Loads the composed surface once. The renderer mounts this.
  ComposedSurfaceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'composedSurfaceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$composedSurfaceHash();

  @$internal
  @override
  $FutureProviderElement<A2uiNode> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<A2uiNode> create(Ref ref) {
    return composedSurface(ref);
  }
}

String _$composedSurfaceHash() => r'409ff5b9dfb75b9a08909c1786df47d8f6839a9d';
