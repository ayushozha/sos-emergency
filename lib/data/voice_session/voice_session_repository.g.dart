// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_session_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(voiceSessionRepository)
final voiceSessionRepositoryProvider = VoiceSessionRepositoryProvider._();

final class VoiceSessionRepositoryProvider
    extends
        $FunctionalProvider<
          VoiceSessionRepository,
          VoiceSessionRepository,
          VoiceSessionRepository
        >
    with $Provider<VoiceSessionRepository> {
  VoiceSessionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voiceSessionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$voiceSessionRepositoryHash();

  @$internal
  @override
  $ProviderElement<VoiceSessionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VoiceSessionRepository create(Ref ref) {
    return voiceSessionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VoiceSessionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VoiceSessionRepository>(value),
    );
  }
}

String _$voiceSessionRepositoryHash() =>
    r'1caee5e7cfcebff59c07cf05c19bbc1ca262d80b';
