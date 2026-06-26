import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos_emergency/app/theme/sos_tokens.dart';
import 'package:sos_emergency/application/orchestrator.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/models/surface_brightness.dart';
import 'package:sos_emergency/presentation/surface/a2ui_renderer.dart';
import 'package:sos_emergency/presentation/surface/surface_theme_providers.dart';

/// Hosts the renderer: paints the themed ground and renders the deterministic
/// Surface the orchestrator composes for the current scenario. A debug bar
/// switches scenario and day/night until live signals drive the loop (Phase 5).
class SurfaceHost extends ConsumerWidget {
  const SurfaceHost({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(surfacePaletteProvider);
    final surface = ref.watch(surfaceControllerProvider);

    return ColoredBox(
      color: palette.ground,
      child: SafeArea(
        child: Column(
          children: [
            const _DebugBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(SosTokens.space12),
                child: A2uiRenderer(node: surface.root),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DebugBar extends ConsumerWidget {
  const _DebugBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(surfacePaletteProvider);
    final scenario = ref.watch(demoScenarioProvider);
    final brightness = ref.watch(surfaceBrightnessControllerProvider);
    final isDay = brightness == SurfaceBrightness.day;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SosTokens.space12,
        SosTokens.space4,
        SosTokens.space12,
        0,
      ),
      child: Row(
        children: [
          Text('Scenario', style: TextStyle(color: palette.textMuted)),
          const SizedBox(width: SosTokens.space3),
          DropdownButton<ScenarioClass>(
            value: scenario,
            dropdownColor: palette.surface,
            onChanged: (value) {
              if (value != null) {
                ref.read(demoScenarioProvider.notifier).select(value);
              }
            },
            items: [
              for (final s in ScenarioClass.values)
                DropdownMenuItem(value: s, child: Text(s.name)),
            ],
          ),
          const Spacer(),
          FilledButton.tonalIcon(
            onPressed: () =>
                ref.read(surfaceBrightnessControllerProvider.notifier).toggle(),
            icon: Icon(
              isDay ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
            ),
            label: Text(isDay ? 'Night' : 'Day'),
          ),
        ],
      ),
    );
  }
}
