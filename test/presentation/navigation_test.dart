import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/application/ai_orchestration.dart';
import 'package:sos_emergency/application/voice_agent_providers.dart';
import 'package:sos_emergency/data/voice_session/fake_voice_session.dart';
import 'package:sos_emergency/presentation/surface/surface_host.dart';

import '../golden/golden_harness.dart';

Future<void> _pumpApp(WidgetTester tester, ProviderContainer container) async {
  await loadSosFonts();
  tester.view.physicalSize = const Size(1400, 900);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(home: Scaffold(body: SurfaceHost())),
    ),
  );
}

void main() {
  testWidgets('tapping a triage choice navigates to that scenario page', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(aiEnabledProvider.notifier).disable();

    await _pumpApp(tester, container);

    // The opening triage page.
    expect(find.text("What's happening?"), findsOneWidget);
    expect(find.text('Crash'), findsOneWidget);

    // Tap "Crash" → navigate to the crash scenario page.
    await tester.tap(find.text('Crash'));
    await tester.pumpAndSettle();

    expect(find.text('Calling 911 automatically'), findsOneWidget);
    expect(find.text("What's happening?"), findsNothing);

    // The Back affordance returns to triage.
    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();
    expect(find.text("What's happening?"), findsOneWidget);
  });

  testWidgets('a different choice routes to its own page', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(aiEnabledProvider.notifier).disable();

    await _pumpApp(tester, container);

    await tester.tap(find.text('Being followed'));
    await tester.pumpAndSettle();

    // The being-followed page routes to safety.
    expect(find.text('Drive to the nearest police station'), findsOneWidget);
  });

  testWidgets('tap to speak starts the voice session', (tester) async {
    final fake = FakeVoiceSession();
    final container = ProviderContainer(
      overrides: [voiceSessionProvider.overrideWithValue(fake)],
    );
    addTearDown(container.dispose);
    container.read(aiEnabledProvider.notifier).disable();

    await _pumpApp(tester, container);

    expect(find.text('Tap to speak'), findsOneWidget);

    await tester.tap(find.text('Tap to speak'));
    await tester.pumpAndSettle();

    // The session goes live and the control reflects it.
    expect(find.text('Tap to speak'), findsNothing);
    expect(find.text('Listening…'), findsOneWidget);
  });
}
