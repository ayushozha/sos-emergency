import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos_emergency/app/theme/sos_tokens.dart';
import 'package:sos_emergency/app/theme/surface_palette.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/domain/models/severity.dart';
import 'package:sos_emergency/presentation/surface/binding_resolver.dart';
import 'package:sos_emergency/presentation/surface/surface_theme_providers.dart';

/// `SeverityBanner` — the tier indicator pinned to the top of the surface.
/// Colour + label + border weight together (glyph + motion added in Phase 1).
///
/// Inputs: `tier` (token), `label`, `context?`.
Widget buildSeverityBanner(BuildContext context, WidgetRef ref, A2uiNode node) {
  final palette = ref.watch(surfacePaletteProvider);
  final tier = Severity.fromToken(ref.resolveString(node, 'tier'));
  final style = TierStyle.of(tier, palette);
  final label = ref.resolveString(node, 'label') ?? '';
  final statusContext = ref.resolveString(node, 'context');

  return Container(
    height: 62,
    padding: const EdgeInsets.symmetric(horizontal: SosTokens.space5),
    decoration: BoxDecoration(
      color: style.accent.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(SosTokens.radiusMd),
      border: Border.all(color: style.accent, width: style.borderWidth),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: SosTokens.fontDisplay,
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: style.text,
          ),
        ),
        const Spacer(),
        if (statusContext != null)
          Text(
            statusContext,
            style: TextStyle(
              fontFamily: SosTokens.fontDisplay,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: palette.textMuted,
            ),
          ),
      ],
    ),
  );
}
