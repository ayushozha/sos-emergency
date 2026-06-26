import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/domain/models/surface_brightness.dart';

import '../fixtures/sos_screens.dart';
import 'golden_harness.dart';

void main() {
  // Pixel goldens locking the catalog's rendering of each design mockup.
  // Regenerate with: flutter test --update-goldens
  group('mockup screen goldens (day)', () {
    for (final name in sosScreenJson.keys) {
      testWidgets(name, (tester) async {
        await pumpSurface(tester, sosScreen(name));
        await expectLater(
          find.byType(Scaffold),
          matchesGoldenFile('goldens/${name}_day.png'),
        );
      });
    }
  });

  group('mockup screen goldens (night)', () {
    // Night theming is proven on the critical crash screen.
    testWidgets('serious_crash', (tester) async {
      await pumpSurface(
        tester,
        sosScreen('serious_crash'),
        brightness: SurfaceBrightness.night,
      );
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('goldens/serious_crash_night.png'),
      );
    });
  });
}
