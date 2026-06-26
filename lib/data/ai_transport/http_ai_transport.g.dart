// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_ai_transport.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(aiTransportRepository)
final aiTransportRepositoryProvider = AiTransportRepositoryProvider._();

final class AiTransportRepositoryProvider
    extends
        $FunctionalProvider<
          AiTransportRepository,
          AiTransportRepository,
          AiTransportRepository
        >
    with $Provider<AiTransportRepository> {
  AiTransportRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiTransportRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiTransportRepositoryHash();

  @$internal
  @override
  $ProviderElement<AiTransportRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AiTransportRepository create(Ref ref) {
    return aiTransportRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AiTransportRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AiTransportRepository>(value),
    );
  }
}

String _$aiTransportRepositoryHash() =>
    r'7b3e7a4c411831c58e588dbac7f622533b70c0c3';
