import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos_emergency/app/theme/sos_tokens.dart';
import 'package:sos_emergency/data/ai_transport/mock_transport.dart';
import 'package:sos_emergency/domain/models/surface_brightness.dart';
import 'package:sos_emergency/presentation/surface/a2ui_renderer.dart';
import 'package:sos_emergency/presentation/surface/data_model.dart';
import 'package:sos_emergency/presentation/surface/surface_theme_providers.dart';

/// Hosts the renderer: resolves the composed surface, paints the themed ground,
/// drives the Phase 0 live-binding demo (a ticking `/demo/countdown`), and
/// exposes a day/night toggle.
class SurfaceHost extends ConsumerStatefulWidget {
  const SurfaceHost({super.key});

  @override
  ConsumerState<SurfaceHost> createState() => _SurfaceHostState();
}

class _SurfaceHostState extends ConsumerState<SurfaceHost> {
  Timer? _ticker;
  static const int _start = 8;

  @override
  void initState() {
    super.initState();
    // Seed and tick the demo countdown to prove live data bindings.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dataModelProvider.notifier).write('/demo/countdown', _start);
      _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
        final current =
            ref.read(dataModelProvider.notifier).read('/demo/countdown')
                as int? ??
            _start;
        final next = current <= 0 ? _start : current - 1;
        ref.read(dataModelProvider.notifier).write('/demo/countdown', next);
      });
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = ref.watch(surfacePaletteProvider);
    final brightness = ref.watch(surfaceBrightnessControllerProvider);
    final surface = ref.watch(composedSurfaceProvider);

    return ColoredBox(
      color: palette.ground,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(SosTokens.space16),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 920),
                  child: switch (surface) {
                    AsyncData(:final value) => A2uiRenderer(node: value),
                    AsyncError(:final error) => Text('Compose failed: $error'),
                    _ => const Center(child: CircularProgressIndicator()),
                  },
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: _BrightnessToggle(
                  brightness: brightness,
                  onPressed: () => ref
                      .read(surfaceBrightnessControllerProvider.notifier)
                      .toggle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrightnessToggle extends StatelessWidget {
  const _BrightnessToggle({required this.brightness, required this.onPressed});

  final SurfaceBrightness brightness;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isDay = brightness == SurfaceBrightness.day;
    return FilledButton.tonalIcon(
      onPressed: onPressed,
      icon: Icon(isDay ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
      label: Text(isDay ? 'Night' : 'Day'),
    );
  }
}
