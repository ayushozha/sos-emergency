import 'package:flutter/material.dart';
import 'package:sos_emergency/presentation/surface/surface_host.dart';

/// Root of the SOS app. The emergency Surface is landscape-locked and renders
/// edge-to-edge; theming is handled per-surface by `SurfacePalette`.
class SosApp extends StatelessWidget {
  const SosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SOS Emergency',
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: SurfaceHost()),
    );
  }
}
