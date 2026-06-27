import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genui/genui.dart';
import 'package:sos_emergency/genui/emergency_catalog.dart';

/// Real GLM-5.2 output captured from a live `/v1/chat/stream` round-trip for
/// "I was just in a car crash and I think I'm hurt". Kept verbatim — including
/// the conversational prose and ```json fences the model wraps around the A2UI
/// — so this test proves the genui parser (`addChunk` path) recovers a valid
/// surface from real, messy model output, not just clean canned JSON.
const String _liveModelOutput = '''
I'm here with you. Help is coming. Let's get you connected to emergency services right away.

```json
{
  "version": "v0.9",
  "createSurface": {
    "surfaceId": "crash_emergency",
    "catalogId": "https://a2ui.org/specification/v0_9/basic_catalog.json",
    "sendDataModel": true
  }
}
```

```json
{
  "version": "v0.9",
  "updateComponents": {
    "surfaceId": "crash_emergency",
    "components": [
      {
        "id": "root",
        "component": "Column",
        "justify": "start",
        "align": "stretch",
        "children": ["severityBanner", "guidanceCallout", "sosButton"]
      },
      {
        "id": "severityBanner",
        "component": "SeverityBanner",
        "tier": "critical",
        "label": "Critical — Crash Detected",
        "context": "Stay still. Help is one tap away."
      },
      {
        "id": "guidanceCallout",
        "component": "GuidanceCallout",
        "tier": "critical",
        "kicker": "Do this first",
        "text": "Tap the button below to call 911."
      },
      {
        "id": "sosButton",
        "component": "SOSCallButton",
        "emergencyNumber": "911",
        "callState": "idle"
      }
    ]
  }
}
```

**You're not alone.** Tap the large 911 button now.
''';

void main() {
  testWidgets('parses and renders a surface from real model output', (
    tester,
  ) async {
    // The app's canonical surface is a landscape tablet (per CLAUDE.md).
    tester.view.physicalSize = const Size(1366, 1024);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final controller = SurfaceController(catalogs: [buildEmergencyCatalog()]);
    final adapter = A2uiTransportAdapter();
    final conversation = Conversation(
      controller: controller,
      transport: adapter,
    );
    addTearDown(conversation.dispose);

    final added = <String>[];
    conversation.events.listen((event) {
      if (event is ConversationSurfaceAdded) added.add(event.surfaceId);
    });

    // Feed the raw model text exactly as the transport would, from deltas.
    adapter.addChunk(_liveModelOutput);
    await tester.pump();

    expect(
      added,
      contains('crash_emergency'),
      reason: 'parser should recover the surface from prose + fenced JSON',
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Surface(
                surfaceContext: controller.contextFor('crash_emergency'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Critical — Crash Detected'), findsOneWidget);
    expect(find.textContaining('911'), findsWidgets);
    expect(tester.takeException(), isNull);
  });
}
