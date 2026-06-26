// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_session_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VoiceSessionController)
final voiceSessionControllerProvider = VoiceSessionControllerProvider._();

final class VoiceSessionControllerProvider
    extends $NotifierProvider<VoiceSessionController, VoiceSessionStatus> {
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
  Override overrideWithValue(VoiceSessionStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VoiceSessionStatus>(value),
    );
  }
}

String _$voiceSessionControllerHash() =>
    r'05fbd53ef66ee97cb08575bd1304d75586dadf0f';

abstract class _$VoiceSessionController extends $Notifier<VoiceSessionStatus> {
  VoiceSessionStatus build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<VoiceSessionStatus, VoiceSessionStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<VoiceSessionStatus, VoiceSessionStatus>,
              VoiceSessionStatus,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
