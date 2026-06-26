import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos_emergency/app/theme/sos_tokens.dart';
import 'package:sos_emergency/application/orchestrator.dart';
import 'package:sos_emergency/data/voice_session/voice_session_repository.dart';
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
    final surfaceAsync = ref.watch(surfaceControllerProvider);

    return ColoredBox(
      color: palette.ground,
      child: SafeArea(
        child: Column(
          children: [
            const _DebugBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(SosTokens.space12),
                child: surfaceAsync.when(
                  data: (surface) => A2uiRenderer(node: surface.root),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(child: Text('Surface error: $error')),
                ),
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
    final backend = BackendConfig.url;

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
          const SizedBox(width: SosTokens.space4),
          Text(
            backend,
            style: TextStyle(color: palette.textMuted, fontSize: 11),
          ),
          const Spacer(),
          if (BackendConfig.isConfigured)
            FilledButton.tonalIcon(
              onPressed: () async {
                final voice = ref.read(voiceSessionRepositoryProvider);
                await voice.connect();
                voice.sendText('I need emergency help');
              },
              icon: const Icon(Icons.mic_none),
              label: const Text('Voice'),
            ),
          const SizedBox(width: SosTokens.space3),
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