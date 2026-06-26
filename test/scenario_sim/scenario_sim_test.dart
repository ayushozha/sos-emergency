import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/domain/engine/decision_engine.dart';
import 'package:sos_emergency/domain/orchestrator/deterministic_composer.dart';
import 'package:sos_emergency/domain/orchestrator/scenario_library.dart';

import '../golden/golden_harness.dart';

/// The scenario simulator: replays each MVP scenario's input context end-to-end
/// through the deterministic pipeline (classify → compose → render) and asserts
/// the right Surface lands on a landscape-tablet screen. This is the primary
/// Phase 2 acceptance gate.
void main() {
  const engine = DecisionEngine();
  const composer = DeterministicComposer();
  final contexts = scenarioContexts();

  group('all 8 MVP scenarios drive a deterministic Surface end-to-end', () {
    for (final entry in contexts.entries) {
      testWidgets('${entry.key.name} renders cleanly', (tester) async {
        final ctx = entry.value;

        // sense → classify → compose
        final classification = engine.classify(ctx);
        final surface = composer.compose(classification, ctx);

        expect(classification.scenario, entry.key);
        expect(surface.severity, classification.severity);

        // render the baseline on a landscape tablet
        await pumpSurface(tester, surface.root);
        expect(tester.takeException(), isNull);
        expect(find.byType(Scaffold), findsOneWidget);
      });
    }
  });

  test('baseline classify+compose is well under the 100ms budget', () {
    final ctx = contexts.values.first;
    final sw = Stopwatch()..start();
    for (var i = 0; i < 100; i++) {
      composer.compose(engine.classify(ctx), ctx);
    }
    sw.stop();
    // 100 full passes; per-pass budget is < 100ms with huge margin.
    expect(sw.elapsedMilliseconds, lessThan(100));
  });
}
