import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/presentation/surface/a2ui_renderer.dart';
import 'package:sos_emergency/presentation/surface/data_model.dart';

Widget _host(A2uiNode node) => ProviderScope(
  child: MaterialApp(
    home: Scaffold(body: A2uiRenderer(node: node)),
  ),
);

void main() {
  testWidgets('renders a registered component from the node tree', (
    tester,
  ) async {
    const node = A2uiNode(
      type: 'SeverityBanner',
      props: {'tier': 'high', 'label': 'High', 'context': 'Act soon'},
    );

    await tester.pumpWidget(_host(node));

    expect(find.text('High'), findsOneWidget);
    expect(find.text('Act soon'), findsOneWidget);
  });

  testWidgets('unknown component types render nothing', (tester) async {
    const node = A2uiNode(type: 'NotInTheCatalog');

    await tester.pumpWidget(_host(node));

    expect(find.byType(SizedBox), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a bound value updates the widget live', (tester) async {
    const node = A2uiNode(
      type: 'CountdownText',
      props: {'label': 'Calling in'},
      bindings: {'seconds': '/demo/countdown'},
    );

    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(dataModelProvider.notifier).write('/demo/countdown', 8);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(body: A2uiRenderer(node: node)),
        ),
      ),
    );

    expect(find.text('08'), findsOneWidget);

    container.read(dataModelProvider.notifier).write('/demo/countdown', 7);
    // Provider value updates synchronously...
    expect(container.read(dataPathProvider('/demo/countdown')), 7);
    // ...and the widget reflects it on the next frame.
    await tester.pump();

    expect(find.text('08'), findsNothing);
    expect(find.text('07'), findsOneWidget);
  });

  testWidgets('push-to-talk enters listening state when tapped', (
    tester,
  ) async {
    const node = A2uiNode(type: 'PushToTalk', props: {'state': 'idle'});

    await tester.pumpWidget(_host(node));

    expect(find.text('Tap to speak'), findsOneWidget);

    await tester.tap(find.text('Tap to speak'));
    await tester.pump();

    expect(find.text('Listening...'), findsOneWidget);
  });
}
