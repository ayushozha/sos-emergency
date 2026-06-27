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
    extends
        $NotifierProvider<
          VoiceSessionController,
          ({
            bool isRendering,
            VoiceIntent? lastIntent,
            VoiceSessionStatus status,
            String? transcript,
            String? voiceSurfaceId,
          })
        > {
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
  Override overrideWithValue(
    ({
      bool isRendering,
      VoiceIntent? lastIntent,
      VoiceSessionStatus status,
      String? transcript,
      String? voiceSurfaceId,
    })
    value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            ({
              bool isRendering,
              VoiceIntent? lastIntent,
              VoiceSessionStatus status,
              String? transcript,
              String? voiceSurfaceId,
            })
          >(value),
    );
  }
}

String _$voiceSessionControllerHash() =>
    r'b2a40a3a42bc1333173de4b5592c5f1e416c33db';

/// Drives the live voice session: mic → backend agent WS → TTS + A2UI.

abstract class _$VoiceSessionController
    extends
        $Notifier<
          ({
            bool isRendering,
            VoiceIntent? lastIntent,
            VoiceSessionStatus status,
            String? transcript,
            String? voiceSurfaceId,
          })
        > {
  ({
    bool isRendering,
    VoiceIntent? lastIntent,
    VoiceSessionStatus status,
    String? transcript,
    String? voiceSurfaceId,
  })
  build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              ({
                bool isRendering,
                VoiceIntent? lastIntent,
                VoiceSessionStatus status,
                String? transcript,
                String? voiceSurfaceId,
              }),
              ({
                bool isRendering,
                VoiceIntent? lastIntent,
                VoiceSessionStatus status,
                String? transcript,
                String? voiceSurfaceId,
              })
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ({
                  bool isRendering,
                  VoiceIntent? lastIntent,
                  VoiceSessionStatus status,
                  String? transcript,
                  String? voiceSurfaceId,
                }),
                ({
                  bool isRendering,
                  VoiceIntent? lastIntent,
                  VoiceSessionStatus status,
                  String? transcript,
                  String? voiceSurfaceId,
                })
              >,
              ({
                bool isRendering,
                VoiceIntent? lastIntent,
                VoiceSessionStatus status,
                String? transcript,
                String? voiceSurfaceId,
              }),
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
