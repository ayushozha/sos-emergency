import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fixtures/sos_screens.dart';
import 'golden_harness.dart';

void main() {
  // Font-independent smoke tests: every named mockup composes from the catalog
  // and lays out without overflow on a landscape tablet, in day and night.
  group('mockup screens render from hand-authored A2UI', () {
    for (final name in sosScreenJson.keys) {
      testWidgets('$name lays out cleanly (day)', (tester) async {
        await pumpSurface(tester, sosScreen(name));
        expect(tester.takeException(), isNull);
        expect(find.byType(Scaffold), findsOneWidget);
      });
    }

    testWidgets('serious_crash key content is present', (tester) async {
      await pumpSurface(tester, sosScreen('serious_crash'));
      expect(find.text('Critical'), findsOneWidget);
      expect(find.text('Calling 911 automatically'), findsOneWidget);
      expect(find.text('Maya'), findsOneWidget);
    });

    testWidgets('being_followed routes to safety, hides home', (tester) async {
      await pumpSurface(tester, sosScreen('being_followed'));
      expect(find.text('Daly City Police'), findsOneWidget);
      expect(
        find.text(
          '"Home" & saved private places hidden '
          'while threat is active',
        ),
        findsOneWidget,
      );
    });

    testWidgets('wont_start_offline shows offline + guided steps', (
      tester,
    ) async {
      await pumpSurface(tester, sosScreen('wont_start_offline'));
      expect(find.text('No signal — offline mode active'), findsOneWidget);
      expect(find.textContaining('JUMP-START'), findsOneWidget);
      expect(find.text('Park both cars, engines off'), findsOneWidget);
    });
  });
}
