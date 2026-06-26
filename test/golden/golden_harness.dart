import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/app/theme/surface_palette.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/domain/models/surface_brightness.dart';
import 'package:sos_emergency/presentation/surface/a2ui_renderer.dart';
import 'package:sos_emergency/presentation/surface/surface_theme_providers.dart';

bool _fontsLoaded = false;

/// Loads the bundled brand fonts into the test renderer so goldens show real
/// type (Hanken Grotesk / JetBrains Mono) rather than fallback glyphs.
Future<void> loadSosFonts() async {
  if (_fontsLoaded) return;
  Future<void> load(String family, String path) async {
    final bytes = File(path).readAsBytesSync().buffer.asByteData();
    await (FontLoader(family)..addFont(Future.value(bytes))).load();
  }

  await load('Hanken Grotesk', 'assets/fonts/HankenGrotesk.ttf');
  await load('JetBrains Mono', 'assets/fonts/JetBrainsMono.ttf');
  _fontsLoaded = true;
}

/// Mounts an A2UI [node] on a landscape-tablet surface (the canonical
/// breakpoint) with the requested day/night [brightness], ready for a golden
/// snapshot of the root `Scaffold`.
Future<void> pumpSurface(
  WidgetTester tester,
  A2uiNode node, {
  SurfaceBrightness brightness = SurfaceBrightness.day,
  Size size = const Size(1194, 834),
}) async {
  await loadSosFonts();
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final palette = SurfacePalette.of(brightness);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [surfacePaletteProvider.overrideWithValue(palette)],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: palette.ground,
          body: Padding(
            padding: const EdgeInsets.all(48),
            child: A2uiRenderer(node: node),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}
