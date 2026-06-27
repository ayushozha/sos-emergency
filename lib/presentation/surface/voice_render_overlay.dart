import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:genui/genui.dart';
import 'package:sos_emergency/app/theme/sos_tokens.dart';
import 'package:sos_emergency/application/voice_emergency_session.dart';
import 'package:sos_emergency/application/voice_session_controller.dart';

/// Renders the latest voice-triggered GenUI surface above the deterministic
/// dashboard when the backend agent calls `render_emergency_ui`.
class VoiceRenderOverlay extends ConsumerWidget {
  const VoiceRenderOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voice = ref.watch(voiceSessionControllerProvider);
    final surfaceId = voice.voiceSurfaceId;
    if (surfaceId == null) return const SizedBox.shrink();

    final session = ref.watch(voiceEmergencySessionProvider);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        elevation: 12,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(SosTokens.radiusLg),
        ),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 360,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        voice.isRendering
                            ? 'Composing guidance…'
                            : 'Voice guidance',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      tooltip: 'Dismiss',
                      onPressed: () => ref
                          .read(voiceSessionControllerProvider.notifier)
                          .clearVoiceSurface(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Surface(
                    surfaceContext: session.controller.contextFor(surfaceId),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
