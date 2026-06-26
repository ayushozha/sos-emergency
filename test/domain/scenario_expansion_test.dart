import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/domain/engine/decision_engine.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/models/severity.dart';
import 'package:sos_emergency/domain/orchestrator/deterministic_composer.dart';
import 'package:sos_emergency/domain/orchestrator/scenario_library.dart';

import '../support/node_finder.dart';

void main() {
  const engine = DecisionEngine();
  const composer = DeterministicComposer();
  final contexts = scenarioContexts();

  EmergencyContext fromIntent(UserIntent intent) =>
      idleContext().copyWith(userSignals: [UserSignal(intent: intent)]);

  group('Phase 6 scenario expansion', () {
    test('severe weather → roadside mode + weather hazard card', () {
      final clf = engine.classify(fromIntent(UserIntent.severeWeather));
      expect(clf.scenario, ScenarioClass.severeWeather);
      expect(clf.severity, Severity.high);
      final root = composer
          .compose(clf, contexts[ScenarioClass.severeWeather]!)
          .root;
      expect(containsType(root, 'WeatherHazardCard'), isTrue);
    });

    test('stranded → roadside, shows location + roadside actions', () {
      final clf = engine.classify(fromIntent(UserIntent.stranded));
      expect(clf.scenario, ScenarioClass.stranded);
      expect(clf.mode, AppMode.roadside);
      final root = composer
          .compose(clf, contexts[ScenarioClass.stranded]!)
          .root;
      expect(containsType(root, 'LocationCard'), isTrue);
      expect(containsType(root, 'ActionStack'), isTrue);
    });

    test('harassment → threat mode, routes to safety + notifies contacts', () {
      final clf = engine.classify(fromIntent(UserIntent.harassment));
      expect(clf.scenario, ScenarioClass.harassment);
      expect(clf.mode, AppMode.threat);
      final root = composer
          .compose(clf, contexts[ScenarioClass.harassment]!)
          .root;
      expect(containsType(root, 'SafeRouteMap'), isTrue);
      expect(containsType(root, 'NotifyContactsAction'), isTrue);
    });

    test('document intent → documentation mode', () {
      final clf = engine.classify(fromIntent(UserIntent.document));
      expect(clf.scenario, ScenarioClass.documentIncident);
      expect(clf.mode, AppMode.documentation);
      expect(clf.severity, Severity.neutral);
      final root = composer
          .compose(clf, contexts[ScenarioClass.documentIncident]!)
          .root;
      expect(containsType(root, 'SectionCard'), isTrue);
    });
  });
}
