// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_session_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The live voice session. Defaults to an in-memory fake (no server); when
/// `USE_BACKEND=true` a reconnecting WebSocket with TTS playback is wired in.
/// Independent of the composition path — a dropped socket here never blocks
/// the REST channel.

@ProviderFor(voiceSession)
final voiceSessionProvider = VoiceSessionProvider._();

/// The live voice session. Defaults to an in-memory fake (no server); when
/// `USE_BACKEND=true` a reconnecting WebSocket with TTS playback is wired in.
/// Independent of the composition path — a dropped socket here never blocks
/// the REST channel.

final class VoiceSessionProvider
    extends
        $FunctionalProvider<
          VoiceSessionRepository,
          VoiceSessionRepository,
          VoiceSessionRepository
        >
    with $Provider<VoiceSessionRepository> {
  /// The live voice session. Defaults to an in-memory fake (no server); when
  /// `USE_BACKEND=true` a reconnecting WebSocket with TTS playback is wired in.
  /// Independent of the composition path — a dropped socket here never blocks
  /// the REST channel.
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

String _$voiceSessionHash() => r'575c68f2099c68408d4eb519991021a09f4ef75d';

@ProviderFor(VoiceSessionController)
final voiceSessionControllerProvider = VoiceSessionControllerProvider._();

final class VoiceSessionControllerProvider
    extends $NotifierProvider<VoiceSessionController, VoiceSessionState> {
  VoiceSessionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voiceSessionControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$voiceSessionControllerHash();

  @$internal
  @override
  VoiceSessionController create() => VoiceSessionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VoiceSessionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VoiceSessionState>(value),
    );
  }
}

String _$voiceSessionControllerHash() =>
    r'dc71e44db955d256d31a1490b9f4456cd0cb8c56';

abstract class _$VoiceSessionController extends $Notifier<VoiceSessionState> {
  VoiceSessionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<VoiceSessionState, VoiceSessionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<VoiceSessionState, VoiceSessionState>,
              VoiceSessionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
