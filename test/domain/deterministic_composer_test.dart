import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/domain/engine/decision_engine.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/orchestrator/deterministic_composer.dart';
import 'package:sos_emergency/domain/orchestrator/scenario_library.dart';

import '../support/node_finder.dart';

void main() {
  const engine = DecisionEngine();
  const composer = DeterministicComposer();
  final contexts = scenarioContexts();

  group('DeterministicComposer builds a valid Surface for every scenario', () {
    for (final entry in contexts.entries) {
      test(
        '${entry.key.name} mounts an EmergencyRoot tagged with its tier',
        () {
          final clf = engine.classify(entry.value);
          final surface = composer.compose(clf, entry.value);

          expect(surface.root.type, 'EmergencyRoot');
          expect(surface.root.props['tier'], clf.severity.name);
          expect(surface.mode, clf.mode);
          expect(surface.severity, clf.severity);
          expect(surface.isFallback, isTrue);
        },
      );
    }
  });

  group('scenario-specific composition', () {
    test('crash includes a countdown paired with hold-to-abort', () {
      final ctx = contexts[ScenarioClass.crash]!;
      final root = composer.compose(engine.classify(ctx), ctx).root;
      expect(containsType(root, 'CountdownCard'), isTrue);
      expect(containsType(root, 'ImSafeCancel'), isTrue);
    });

    test('being-followed routes to safety in threat mode', () {
      final ctx = contexts[ScenarioClass.beingFollowed]!;
      final root = composer.compose(engine.classify(ctx), ctx).root;
      expect(containsType(root, 'SafeRouteMap'), isTrue);
    });

    test('an offline context injects the global OfflineBanner', () {
      final ctx = contexts[ScenarioClass.wontStart]!;
      expect(ctx.connectivity, Connectivity.offline);
      final root = composer.compose(engine.classify(ctx), ctx).root;
      expect(containsType(root, 'OfflineBanner'), isTrue);
      expect(containsType(root, 'StepChecklist'), isTrue);
    });

    test('triage offers the choice grid and voice entry', () {
      final ctx = contexts[ScenarioClass.unknown]!;
      final root = composer.compose(engine.classify(ctx), ctx).root;
      expect(containsType(root, 'ChoiceGrid'), isTrue);
      expect(containsType(root, 'PushToTalk'), isTrue);
    });
  });
}
