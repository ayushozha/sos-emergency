import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/l10n/app_localizations.dart';

Widget _app(Locale locale) => MaterialApp(
  locale: locale,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Builder(
    builder: (context) {
      final l10n = AppLocalizations.of(context)!;
      return Scaffold(
        body: Column(
          children: [
            Text(l10n.callNow),
            Text(l10n.callingAutomatically('911')),
          ],
        ),
      );
    },
  ),
);

void main() {
  testWidgets('renders English copy', (tester) async {
    await tester.pumpWidget(_app(const Locale('en')));
    expect(find.text('Call now'), findsOneWidget);
    expect(find.text('Calling 911 automatically'), findsOneWidget);
  });

  testWidgets('renders Spanish copy', (tester) async {
    await tester.pumpWidget(_app(const Locale('es')));
    expect(find.text('Llamar ahora'), findsOneWidget);
    expect(find.text('Llamando a 911 automáticamente'), findsOneWidget);
  });
}
