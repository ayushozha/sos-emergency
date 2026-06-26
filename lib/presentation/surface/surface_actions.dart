import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos_emergency/application/escalation.dart';
import 'package:sos_emergency/application/orchestrator.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';

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
