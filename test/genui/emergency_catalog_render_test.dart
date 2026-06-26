import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genui/genui.dart';
import 'package:sos_emergency/genui/emergency_catalog.dart';

/// Proves the full genui path works against our catalog: a model-shaped A2UI
/// message stream (a genui `Column` root referencing our SOS leaf components)
/// is parsed by the [A2uiTransportAdapter], turned into a surface by the
/// [SurfaceController], and rendered by genui's [Surface] through our
/// [CatalogItem] builders — no live model or backend required.
void main() {
  testWidgets('renders an emergency surface from A2UI messages', (
    tester,
  ) async {
    final catalog = buildEmergencyCatalog();
    final controller = SurfaceController(catalogs: [catalog]);
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

    // 1. The model creates a surface bound to our catalog.
    // 2. The model fills it: a Column (from BasicCatalogItems) holding three
    //    SOS leaf components from our catalog.
    adapter
      ..addMessage(
        A2uiMessage.fromJson({
          'version': 'v0.9',
          'createSurface': {
            'surfaceId': 's1',
            'catalogId': kEmergencyCatalogId,
            'sendDataModel': true,
          },
        }),
      )
      ..addMessage(
        A2uiMessage.fromJson({
          'version': 'v0.9',
          'updateComponents': {
            'surfaceId': 's1',
            'components': [
              {
                'id': 'root',
                'component': 'Column',
                'children': ['banner', 'guidance', 'call'],
              },
              {
                'id': 'banner',
                'component': 'SeverityBanner',
                'tier': 'critical',
                'label': 'Critical',
                'context': 'Crash detected',
              },
              {
                'id': 'guidance',
                'component': 'GuidanceCallout',
                'tier': 'critical',
                'kicker': 'Do this now',
                'text': 'Stay still — help is coming',
              },
              {
                'id': 'call',
                'component': 'SOSCallButton',
                'emergencyNumber': '911',
                'callState': 'idle',
              },
            ],
          },
        }),
      );

    // Let the broadcast streams deliver to the controller.
    await tester.pump();
    expect(added, contains('s1'), reason: 'surface should be created');

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Surface(surfaceContext: controller.contextFor('s1')),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Every component rendered through our catalog builders.
    // (GuidanceCallout upper-cases its text at the critical tier.)
    expect(find.text('Critical'), findsOneWidget);
    expect(find.text('STAY STILL — HELP IS COMING'), findsOneWidget);
    expect(find.textContaining('911'), findsWidgets);
    expect(tester.takeException(), isNull);
  });
}
