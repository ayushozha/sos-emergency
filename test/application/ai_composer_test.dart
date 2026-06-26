import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/application/ai_composer.dart';
import 'package:sos_emergency/data/api/api_enums.dart';
import 'package:sos_emergency/domain/engine/decision_engine.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/orchestrator/scenario_library.dart';

import '../support/fake_ai_transport.dart';

void main() {
  const engine = DecisionEngine();

  test(
    'maps the domain classification + context into the wire request',
    () async {
      final ctx = scenarioContexts()[ScenarioClass.beingFollowed]!;
      final clf = engine.classify(ctx);
      final transport = FakeAiTransport(
        surface: const A2uiNode(type: 'EmergencyRoot'),
      );
      final composer = AiComposer(transport);

      await composer.compose(clf, ctx);

      final req = transport.lastRequest!;
      expect(req.stream, isFalse);
      expect(req.catalogVersion, '2026.06.0');
      expect(req.classification.scenario, ApiScenarioClass.beingFollowed);
      expect(req.classification.severity, ApiSeverity.high);
      expect(req.classification.mode, ApiAppMode.threat);
      expect(req.context.carState, ApiCarState.driving);
      expect(req.context.connectivity, ApiConnectivity.online);
      expect(req.context.position?.address, isNotNull);
    },
  );
}
