import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos_emergency/app/theme/sos_tokens.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/presentation/catalog/shared/sos_chrome.dart';
import 'package:sos_emergency/presentation/catalog/shared/sos_icons.dart';
import 'package:sos_emergency/presentation/surface/binding_resolver.dart';
import 'package:sos_emergency/presentation/surface/surface_theme_providers.dart';

/// `OfflineBanner` — global, pinned notice that the car has no signal. Guidance
/// still works; 911 retries on reconnect. Never depends on network or streamed
/// state. Inputs: `title?`, `detail?`.
Widget buildOfflineBanner(BuildContext context, WidgetRef ref, A2uiNode node) {
  final palette = ref.watch(surfacePaletteProvider);
  const amber = SosTokens.moderate;
  final title =
      ref.resolveString(node, 'title') ?? 'No signal — offline mode active';
  final detail =
      ref.resolveString(node, 'detail') ??
      'Guidance still works. 911 will retry on reconnect; SMS fallback queued.';

  return Container(
    padding: const EdgeInsets.all(SosTokens.space4),
    decoration: BoxDecoration(
      color: amber.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(SosTokens.radiusMd),
      border: Border.all(color: amber, width: 2),
    ),
    child: Row(
      children: [
        Icon(SosIcons.resolve('offline'), color: SosTokens.moderateText),
        const SizedBox(width: SosTokens.space3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: SosText.title(SosTokens.moderateText)),
              Text(detail, style: SosText.body(palette.textMuted)),
            ],
          ),
        ),
      ],
    ),
  );
}
