// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_session_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Drives the live voice session: mic → backend agent WS → TTS + A2UI.

@ProviderFor(VoiceSessionController)
final voiceSessionControllerProvider = VoiceSessionControllerProvider._();

/// Drives the live voice session: mic → backend agent WS → TTS + A2UI.
final class VoiceSessionControllerProvider
    extends $NotifierProvider<VoiceSessionController, VoiceSessionState> {
  /// Drives the live voice session: mic → backend agent WS → TTS + A2UI.
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
    r'6abaca4f2ff884b8876b58dc58493a31b2c8e6c2';

/// Drives the live voice session: mic → backend agent WS → TTS + A2UI.

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
