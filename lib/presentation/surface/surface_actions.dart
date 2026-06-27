import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos_emergency/application/escalation.dart';
import 'package:sos_emergency/application/orchestrator.dart';
import 'package:sos_emergency/application/voice_session_controller.dart';
import 'package:sos_emergency/data/api/api_enums.dart';
import 'package:sos_emergency/data/voice_session/models/voice_session_config.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';

const _voiceConfig = VoiceSessionConfig(
  locale: 'en-US',
  sampleRate: 16000,
  codec: AudioCodec.pcm16,
);

/// Interaction handlers the catalog widgets dispatch on tap. Navigation in this
/// GenUI app means recomposing the Surface for a scenario — each scenario
/// screen is a "page".
extension SurfaceActions on WidgetRef {
  /// Navigates to the scenario "page" by selecting it; the orchestrator
  /// recomposes the Surface.
  void navigateToScenario(ScenarioClass scenario) =>
      read(demoScenarioProvider.notifier).select(scenario);

  /// Returns to the opening triage screen.
  void backToTriage() =>
      read(demoScenarioProvider.notifier).select(ScenarioClass.unknown);

  /// Parses a scenario name from a widget prop and navigates to it.
  void navigateToScenarioNamed(String? name) {
    if (name == null) return;
    final scenario = ScenarioClass.values.asNameMap()[name];
    if (scenario != null) navigateToScenario(scenario);
  }

  /// Places an emergency call immediately (the panic path).
  void callEmergencyNow() =>
      read(emergencyCallControllerProvider.notifier).callNow();

  /// Whether a voice session is currently open.
  bool get isVoiceActive {
    final status = read(voiceSessionControllerProvider).status;
    return status == VoiceSessionStatus.live ||
        status == VoiceSessionStatus.connecting;
  }

  /// Starts or stops the live voice session (the "tap to speak" control).
  void toggleVoice() {
    final controller = read(voiceSessionControllerProvider.notifier);
    if (isVoiceActive) {
      unawaited(controller.disconnect());
    } else {
      unawaited(controller.connect(_voiceConfig));
    }
  }

  /// Starts/stops the live location broadcast.
  void toggleLocationSharing() {
    final controller = read(shareLocationControllerProvider.notifier);
    if (read(shareLocationControllerProvider).isSharing) {
      unawaited(controller.stop());
    } else {
      unawaited(controller.start(const ['911']));
    }
  }
}
