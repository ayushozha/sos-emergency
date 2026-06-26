// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_session_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The live voice session. Defaults to an in-memory fake (no server); the
/// reconnecting WebSocket impl is wired in Phase 5. Independent of the
/// composition path — a dropped socket here never blocks the REST channel.

@ProviderFor(voiceSession)
final voiceSessionProvider = VoiceSessionProvider._();

/// The live voice session. Defaults to an in-memory fake (no server); the
/// reconnecting WebSocket impl is wired in Phase 5. Independent of the
/// composition path — a dropped socket here never blocks the REST channel.

final class VoiceSessionProvider
    extends
        $FunctionalProvider<
          VoiceSessionRepository,
          VoiceSessionRepository,
          VoiceSessionRepository
        >
    with $Provider<VoiceSessionRepository> {
  /// The live voice session. Defaults to an in-memory fake (no server); the
  /// reconnecting WebSocket impl is wired in Phase 5. Independent of the
  /// composition path — a dropped socket here never blocks the REST channel.
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

String _$voiceSessionHash() => r'33da6ac033d890c873e43358989e75a79ab94a1c';

/// Drives the voice session and surfaces its state + the latest recognised
/// intent (which the orchestrator can feed back into the loop as a UserSignal).

@ProviderFor(VoiceSessionController)
final voiceSessionControllerProvider = VoiceSessionControllerProvider._();

/// Drives the voice session and surfaces its state + the latest recognised
/// intent (which the orchestrator can feed back into the loop as a UserSignal).
final class VoiceSessionControllerProvider
    extends
        $NotifierProvider<
          VoiceSessionController,
          ({VoiceIntent? lastIntent, VoiceSessionStatus status})
        > {
  /// Drives the voice session and surfaces its state + the latest recognised
  /// intent (which the orchestrator can feed back into the loop as a UserSignal).
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
  Override overrideWithValue(
    ({VoiceIntent? lastIntent, VoiceSessionStatus status}) value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            ({VoiceIntent? lastIntent, VoiceSessionStatus status})
          >(value),
    );
  }
}

String _$voiceSessionControllerHash() =>
    r'5f01f17ef876086de30815606890a6bc51bc5fb1';

/// Drives the voice session and surfaces its state + the latest recognised
/// intent (which the orchestrator can feed back into the loop as a UserSignal).

abstract class _$VoiceSessionController
    extends $Notifier<({VoiceIntent? lastIntent, VoiceSessionStatus status})> {
  ({VoiceIntent? lastIntent, VoiceSessionStatus status}) build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              ({VoiceIntent? lastIntent, VoiceSessionStatus status}),
              ({VoiceIntent? lastIntent, VoiceSessionStatus status})
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ({VoiceIntent? lastIntent, VoiceSessionStatus status}),
                ({VoiceIntent? lastIntent, VoiceSessionStatus status})
              >,
              ({VoiceIntent? lastIntent, VoiceSessionStatus status}),
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
