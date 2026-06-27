// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_agent_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(voiceAudioIo)
final voiceAudioIoProvider = VoiceAudioIoProvider._();

final class VoiceAudioIoProvider
    extends $FunctionalProvider<VoiceAudioIo, VoiceAudioIo, VoiceAudioIo>
    with $Provider<VoiceAudioIo> {
  VoiceAudioIoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voiceAudioIoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$voiceAudioIoHash();

  @$internal
  @override
  $ProviderElement<VoiceAudioIo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VoiceAudioIo create(Ref ref) {
    return voiceAudioIo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VoiceAudioIo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VoiceAudioIo>(value),
    );
  }
}

String _$voiceAudioIoHash() => r'ad4f3ec5cfc9380490ff963e58eb667b5946d6bc';

@ProviderFor(backendVoiceAgentSession)
final backendVoiceAgentSessionProvider = BackendVoiceAgentSessionProvider._();

final class BackendVoiceAgentSessionProvider
    extends
        $FunctionalProvider<
          BackendVoiceAgentSession,
          BackendVoiceAgentSession,
          BackendVoiceAgentSession
        >
    with $Provider<BackendVoiceAgentSession> {
  BackendVoiceAgentSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backendVoiceAgentSessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backendVoiceAgentSessionHash();

  @$internal
  @override
  $ProviderElement<BackendVoiceAgentSession> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BackendVoiceAgentSession create(Ref ref) {
    return backendVoiceAgentSession(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackendVoiceAgentSession value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackendVoiceAgentSession>(value),
    );
  }
}

String _$backendVoiceAgentSessionHash() =>
    r'b548eca323faec8d050ef1fc88c5dfcf9f725813';

/// Live voice transport. Widget/unit tests get [FakeVoiceSession] unless
/// overridden.

@ProviderFor(voiceSession)
final voiceSessionProvider = VoiceSessionProvider._();

/// Live voice transport. Widget/unit tests get [FakeVoiceSession] unless
/// overridden.

final class VoiceSessionProvider
    extends
        $FunctionalProvider<
          VoiceSessionRepository,
          VoiceSessionRepository,
          VoiceSessionRepository
        >
    with $Provider<VoiceSessionRepository> {
  /// Live voice transport. Widget/unit tests get [FakeVoiceSession] unless
  /// overridden.
  VoiceSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voiceSessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$voiceSessionHash();

  @$internal
  @override
  $ProviderElement<VoiceSessionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VoiceSessionRepository create(Ref ref) {
    return voiceSession(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VoiceSessionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VoiceSessionRepository>(value),
    );
  }
}

String _$voiceSessionHash() => r'ca2d6c0a074dd16e8a922deb2ae3f5280a7a6ad3';
