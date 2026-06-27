// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_emergency_session.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// GenUI session used for voice-triggered A2UI renders (`render_emergency_ui`).

@ProviderFor(voiceEmergencySession)
final voiceEmergencySessionProvider = VoiceEmergencySessionProvider._();

/// GenUI session used for voice-triggered A2UI renders (`render_emergency_ui`).

final class VoiceEmergencySessionProvider
    extends
        $FunctionalProvider<
          EmergencySession,
          EmergencySession,
          EmergencySession
        >
    with $Provider<EmergencySession> {
  /// GenUI session used for voice-triggered A2UI renders (`render_emergency_ui`).
  VoiceEmergencySessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voiceEmergencySessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$voiceEmergencySessionHash();

  @$internal
  @override
  $ProviderElement<EmergencySession> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EmergencySession create(Ref ref) {
    return voiceEmergencySession(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmergencySession value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmergencySession>(value),
    );
  }
}

String _$voiceEmergencySessionHash() =>
    r'88d2bd066e903acb76721de83a3e525aec6acbdb';
