import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';

import '../golden/golden_harness.dart';

void main() {
  testWidgets('SOSCallButton exposes a one-tap call semantics label', (
    tester,
  ) async {
    await pumpSurface(
      tester,
      const A2uiNode(
        type: 'SOSCallButton',
        props: {'emergencyNumber': '911', 'callState': 'idle'},
      ),
    );
    expect(
      find.bySemanticsLabel(RegExp('Call emergency services')),
      findsOneWidget,
    );
  });

  testWidgets('ImSafeCancel exposes a hold-to-cancel semantics label', (
    tester,
  ) async {
    await pumpSurface(
      tester,
      const A2uiNode(type: 'ImSafeCancel', props: {'holdMs': 1200}),
    );
    expect(
      find.bySemanticsLabel(RegExp("I'm safe")),
      findsOneWidget,
    );
  });
}
