import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos_emergency/app/theme/sos_tokens.dart';
import 'package:sos_emergency/application/orchestrator.dart';
import 'package:sos_emergency/data/voice_session/voice_session_repository.dart';
import 'package:sos_emergency/dev/catalog_showcase.dart';
import 'package:sos_emergency/dev/sos_screen_fixtures.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/models/surface_brightness.dart';
import 'package:sos_emergency/presentation/surface/a2ui_renderer.dart';
import 'package:sos_emergency/presentation/surface/surface_theme_providers.dart';
import 'package:sos_emergency/shared/backend_config.dart';

/// Hosts the renderer: paints the themed ground and renders the Surface the
/// orchestrator composes for the current scenario.
class SurfaceHost extends ConsumerWidget {
  const SurfaceHost({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(surfacePaletteProvider);
    final viewMode = ref.watch(surfaceViewModeControllerProvider);
    final surfaceAsync = ref.watch(surfaceControllerProvider);

    return ColoredBox(
      color: palette.ground,
      child: SafeArea(
        child: Column(
          children: [
            _DebugBar(viewMode: viewMode),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(SosTokens.space12),
                child: switch (viewMode) {
                  SurfaceViewMode.live => surfaceAsync.when(
                    data: (surface) => A2uiRenderer(node: surface.root),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, _) =>
                        Center(child: Text('Surface error: $error')),
                  ),
                  SurfaceViewMode.handoff => A2uiRenderer(
                    node: sosScreen(ref.watch(handoffScreenPickerProvider)),
                  ),
                  SurfaceViewMode.catalog => A2uiRenderer(
                    node: catalogShowcase(),
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class _DebugBar extends ConsumerWidget {
  const _DebugBar({required this.viewMode});

  final SurfaceViewMode viewMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(surfacePaletteProvider);
    final scenario = ref.watch(demoScenarioProvider);
    final handoff = ref.watch(handoffScreenPickerProvider);
    final brightness = ref.watch(surfaceBrightnessControllerProvider);
    final isDay = brightness == SurfaceBrightness.day;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SosTokens.space12,
        SosTokens.space4,
        SosTokens.space12,
        0,
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: SosTokens.space3,
        runSpacing: SosTokens.space2,
        children: [
          Text('View', style: TextStyle(color: palette.textMuted)),
          DropdownButton<SurfaceViewMode>(
            value: viewMode,
            dropdownColor: palette.surface,
            onChanged: (value) {
              if (value != null) {
                ref.read(surfaceViewModeControllerProvider.notifier).select(value);
              }
            },
            items: const [
              DropdownMenuItem(
                value: SurfaceViewMode.handoff,
                child: Text('Handoff screens'),
              ),
              DropdownMenuItem(
                value: SurfaceViewMode.catalog,
                child: Text('All components'),
              ),
              DropdownMenuItem(
                value: SurfaceViewMode.live,
                child: Text('Live scenarios'),
              ),
            ],
          ),
          if (viewMode == SurfaceViewMode.live) ...[
            Text('Scenario', style: TextStyle(color: palette.textMuted)),
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
          ],
          if (viewMode == SurfaceViewMode.handoff) ...[
            Text('Screen', style: TextStyle(color: palette.textMuted)),
            DropdownButton<String>(
              value: handoff,
              dropdownColor: palette.surface,
              onChanged: (value) {
                if (value != null) {
                  ref.read(handoffScreenPickerProvider.notifier).select(value);
                  if (value == 'being_followed_night') {
                    ref
                        .read(surfaceBrightnessControllerProvider.notifier)
                        .set(SurfaceBrightness.night);
                  }
                }
              },
              items: [
                for (final entry in handoffScreenLabels.entries)
                  DropdownMenuItem(
                    value: entry.key,
                    child: Text(entry.value),
                  ),
              ],
            ),
          ],
          FilledButton.tonalIcon(
            onPressed: () =>
                ref.read(surfaceBrightnessControllerProvider.notifier).toggle(),
            icon: Icon(
              isDay ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
            ),
            label: Text(isDay ? 'Night' : 'Day'),
          ),
          if (viewMode == SurfaceViewMode.live && BackendConfig.isConfigured)
            FilledButton.tonalIcon(
              onPressed: () async {
                final voice = ref.read(voiceSessionRepositoryProvider);
                await voice.connect();
                voice.sendText('I need emergency help');
              },
              icon: const Icon(Icons.mic_none),
              label: const Text('Voice'),
            ),
        ],
      ),
    );
  }
}