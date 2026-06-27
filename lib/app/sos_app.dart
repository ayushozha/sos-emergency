import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sos_emergency/l10n/app_localizations.dart';
import 'package:sos_emergency/presentation/surface/surface_host.dart';

/// Root of the SOS app. The emergency Surface is landscape-locked and renders
/// edge-to-edge; theming is handled per-surface by `SurfacePalette`. Copy is
/// localized (ARB), and the emergency number is resolved from locale data.
class SosApp extends StatelessWidget {
  const SosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(body: SurfaceHost()),
    );
  }
}
