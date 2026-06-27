import 'package:sos_emergency/domain/models/emergency_enums.dart';

/// Bundled, on-device guidance so first-aid and mechanical steps read perfectly
/// with zero network. Keyed by scenario; the deterministic composer and the
/// voice proxy both read from here when offline.
// Repository seam for DI/testing despite the single method.
// ignore: one_member_abstracts
abstract interface class OfflineGuidesRepository {
  /// Ordered steps for [scenario], or empty when none are bundled.
  List<GuideStep> stepsFor(ScenarioClass scenario);
}

/// One step of a bundled guide.
class GuideStep {
  const GuideStep(this.title, {this.detail});
  final String title;
  final String? detail;
}

/// The shipped guide set. Always available, never depends on connectivity.
class BundledOfflineGuides implements OfflineGuidesRepository {
  const BundledOfflineGuides();

  @override
  List<GuideStep> stepsFor(ScenarioClass scenario) => switch (scenario) {
    ScenarioClass.wontStart => const [
      GuideStep('Park both cars, engines off'),
      GuideStep(
        'Clamp red to the dead + and good battery + terminal',
        detail: 'Red = positive. Do not let the clamps touch.',
      ),
      GuideStep('Clamp black to good battery - terminal'),
      GuideStep('Ground black to bare metal on the dead car'),
      GuideStep('Start the good car, then the dead one'),
    ],
    ScenarioClass.flatTire => const [
      GuideStep('Pull onto a flat, firm shoulder'),
      GuideStep('Hazards on, parking brake set'),
      GuideStep('Loosen lug nuts before jacking'),
      GuideStep('Jack up, swap the wheel, lower, re-torque'),
    ],
    _ => const [],
  };
}
