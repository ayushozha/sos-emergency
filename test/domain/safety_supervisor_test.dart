import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/domain/models/classification.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/models/severity.dart';
import 'package:sos_emergency/domain/models/surface.dart';
import 'package:sos_emergency/domain/safety/safety_supervisor.dart';

import '../support/node_finder.dart';

const _supervisor = SafetySupervisor();

const _baseline = Surface(
  mode: AppMode.crash,
  severity: Severity.critical,
  root: A2uiNode(
    type: 'EmergencyRoot',
    children: [
      A2uiNode(type: 'SeverityBanner'),
      A2uiNode(type: 'SOSCallButton'),
    ],
  ),
);

const _crashClf = Classification(
  scenario: ScenarioClass.crash,
  severity: Severity.critical,
  mode: AppMode.crash,
  confidence: 0.99,
);

const _threatClf = Classification(
  scenario: ScenarioClass.beingFollowed,
  severity: Severity.high,
  mode: AppMode.threat,
  confidence: 0.9,
);

Surface _candidate(A2uiNode root, {AppMode mode = AppMode.crash}) =>
    Surface(mode: mode, severity: Severity.high, root: root, isFallback: false);

void main() {
  group('SafetySupervisor — adversarial guardrails', () {
    test('R1: a non-EmergencyRoot root is bypassed for the baseline', () {
      final evil = _candidate(
        const A2uiNode(
          type: 'SurfaceColumn',
          children: [A2uiNode(type: 'SOSCallButton')],
        ),
      );
      final out = _supervisor.enforce(
        evil,
        baseline: _baseline,
        classification: _crashClf,
      );
      expect(out.isFallback, isTrue);
      expect(out.root.type, 'EmergencyRoot');
    });

    test('R4: unknown components are stripped, known siblings survive', () {
      final candidate = _candidate(
        const A2uiNode(
          type: 'EmergencyRoot',
          children: [
            A2uiNode(type: 'GuidanceCallout'),
            A2uiNode(type: 'CryptoMinerWidget'),
          ],
        ),
      );
      final out = _supervisor.enforce(
        candidate,
        baseline: _baseline,
        classification: _crashClf,
      );
      expect(containsType(out.root, 'CryptoMinerWidget'), isFalse);
      expect(containsType(out.root, 'GuidanceCallout'), isTrue);
      expect(out.isFallback, isFalse);
    });

    test('R4: an all-unknown surface degrades to the baseline', () {
      final candidate = _candidate(
        const A2uiNode(
          type: 'EmergencyRoot',
          children: [
            A2uiNode(type: 'Bogus1'),
            A2uiNode(type: 'Bogus2'),
          ],
        ),
      );
      final out = _supervisor.enforce(
        candidate,
        baseline: _baseline,
        classification: _crashClf,
      );
      expect(out.isFallback, isTrue);
      expect(out.root, _baseline.root);
    });

    test('R2: a threat surface strips "home" / private destinations', () {
      final candidate = _candidate(
        const A2uiNode(
          type: 'EmergencyRoot',
          children: [
            A2uiNode(
              type: 'SafeRouteMap',
              props: {
                'destinations': [
                  {'type': 'home', 'name': 'Home'},
                  {'type': 'police', 'name': 'Daly City Police'},
                  {'type': 'work', 'name': 'Office'},
                ],
              },
            ),
          ],
        ),
        mode: AppMode.threat,
      );
      final out = _supervisor.enforce(
        candidate,
        baseline: _baseline,
        classification: _threatClf,
      );
      final map = out.root.children.first;
      final destinations = (map.props['destinations']! as List)
          .cast<Map<String, Object?>>();
      final dests = destinations.map((d) => d['type']).toList();
      expect(dests, ['police']);
      expect(map.props['threatMode'], isTrue);
    });

    test('R3: a countdown without a cancel gets one injected', () {
      final candidate = _candidate(
        const A2uiNode(
          type: 'EmergencyRoot',
          children: [A2uiNode(type: 'CountdownCard')],
        ),
      );
      final out = _supervisor.enforce(
        candidate,
        baseline: _baseline,
        classification: _crashClf,
      );
      expect(containsType(out.root, 'ImSafeCancel'), isTrue);
    });

    test('a valid surface passes through unchanged and stays non-fallback', () {
      final candidate = _candidate(
        const A2uiNode(
          type: 'EmergencyRoot',
          children: [
            A2uiNode(type: 'SeverityBanner'),
            A2uiNode(type: 'GuidanceCallout'),
            A2uiNode(type: 'SOSCallButton'),
          ],
        ),
      );
      final out = _supervisor.enforce(
        candidate,
        baseline: _baseline,
        classification: _crashClf,
      );
      expect(out.isFallback, isFalse);
      expect(collectTypes(out.root), collectTypes(candidate.root));
    });

    test('enforcing the deterministic baseline is a safe no-op', () {
      final out = _supervisor.enforce(
        _baseline,
        baseline: _baseline,
        classification: _crashClf,
      );
      expect(out.root, _baseline.root);
    });
  });
}
