import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/domain/models/classification.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/models/severity.dart';
import 'package:sos_emergency/domain/models/surface.dart';
import 'package:sos_emergency/domain/safety/safety_supervisor.dart';

import '../support/node_finder.dart';

const _supervisor = SafetySupervisor();
const _clf = Classification(
  scenario: ScenarioClass.crash,
  severity: Severity.critical,
  mode: AppMode.crash,
  confidence: 0.99,
);

const _baseline = Surface(
  mode: AppMode.crash,
  severity: Severity.critical,
  root: A2uiNode(
    type: 'EmergencyRoot',
    children: [A2uiNode(type: 'SeverityBanner')],
  ),
);

Surface _surface(String carState) => Surface(
  mode: AppMode.crash,
  severity: Severity.critical,
  isFallback: false,
  root: A2uiNode(
    type: 'EmergencyRoot',
    props: {'carState': carState},
    children: const [
      A2uiNode(type: 'SeverityBanner'),
      A2uiNode(type: 'GuidanceCallout'),
      A2uiNode(type: 'LocationCard'),
      A2uiNode(type: 'ContactStatusList'),
    ],
  ),
);

void main() {
  group('driving-mode enforcement (R6)', () {
    test('while driving, collapses to the banner + one primary action', () {
      final out = _supervisor.enforce(
        _surface('driving'),
        baseline: _baseline,
        classification: _clf,
      );
      expect(
        out.root.children.map((c) => c.type),
        ['SeverityBanner', 'GuidanceCallout'],
      );
      // The reading-heavy cards are dropped for the driver.
      expect(containsType(out.root, 'LocationCard'), isFalse);
      expect(containsType(out.root, 'ContactStatusList'), isFalse);
    });

    test('while parked, the full composition is preserved', () {
      final out = _supervisor.enforce(
        _surface('parked'),
        baseline: _baseline,
        classification: _clf,
      );
      expect(out.root.children, hasLength(4));
      expect(containsType(out.root, 'LocationCard'), isTrue);
    });
  });
}
