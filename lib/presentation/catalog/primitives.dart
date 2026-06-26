import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos_emergency/app/theme/sos_tokens.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/presentation/surface/a2ui_renderer.dart';
import 'package:sos_emergency/presentation/surface/binding_resolver.dart';
import 'package:sos_emergency/presentation/surface/surface_theme_providers.dart';

/// Renders every child of [node] through the registry.
List<Widget> _renderChildren(A2uiNode node) =>
    node.children.map((child) => A2uiRenderer(node: child)).toList();

/// `SurfaceColumn` — vertical layout with token gap between children.
Widget buildSurfaceColumn(BuildContext context, WidgetRef ref, A2uiNode node) {
  final children = _renderChildren(node);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: [
      for (var i = 0; i < children.length; i++) ...[
        if (i > 0) const SizedBox(height: SosTokens.space6),
        children[i],
      ],
    ],
  );
}

/// `SurfaceRow` — horizontal layout with token gap between children.
Widget buildSurfaceRow(BuildContext context, WidgetRef ref, A2uiNode node) {
  final children = _renderChildren(node);
  return Row(
    children: [
      for (var i = 0; i < children.length; i++) ...[
        if (i > 0) const SizedBox(width: SosTokens.space6),
        Expanded(child: children[i]),
      ],
    ],
  );
}

/// `Gap` — fixed vertical spacer. `props.size` (double, default 24).
Widget buildGap(BuildContext context, WidgetRef ref, A2uiNode node) {
  final size = (node.props['size'] as num?)?.toDouble() ?? SosTokens.space6;
  return SizedBox(height: size);
}

/// `SurfaceCard` — raised, rounded container the AI nests widgets inside.
Widget buildSurfaceCard(BuildContext context, WidgetRef ref, A2uiNode node) {
  final palette = ref.watch(surfacePaletteProvider);
  return DecoratedBox(
    decoration: BoxDecoration(
      color: palette.surface,
      borderRadius: BorderRadius.circular(SosTokens.radiusLg),
    ),
    child: Padding(
      padding: const EdgeInsets.all(SosTokens.space6),
      child: buildSurfaceColumn(context, ref, node),
    ),
  );
}

/// `GuidanceText` — the single most important instruction, scream-tier.
/// Inputs: `kicker?`, `text`.
Widget buildGuidanceText(BuildContext context, WidgetRef ref, A2uiNode node) {
  final palette = ref.watch(surfacePaletteProvider);
  final kicker = ref.resolveString(node, 'kicker');
  final text = ref.resolveString(node, 'text') ?? '';
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (kicker != null) ...[
        Text(
          kicker.toUpperCase(),
          style: TextStyle(
            fontFamily: SosTokens.fontMono,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.6,
            color: palette.textMuted,
          ),
        ),
        const SizedBox(height: SosTokens.space3),
      ],
      Text(
        text,
        style: TextStyle(
          fontFamily: SosTokens.fontDisplay,
          fontSize: 38,
          height: 1.02,
          fontWeight: FontWeight.w900,
          color: palette.text,
        ),
      ),
    ],
  );
}

/// `Telemetry` — mono read-out for coordinates, ETA, countdowns. Input: `text`.
Widget buildTelemetry(BuildContext context, WidgetRef ref, A2uiNode node) {
  final palette = ref.watch(surfacePaletteProvider);
  final text = ref.resolveString(node, 'text') ?? '';
  return Text(
    text,
    style: TextStyle(
      fontFamily: SosTokens.fontMono,
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: palette.text,
    ),
  );
}

/// `CountdownText` — proves a live data binding: shows `label` + the bound
/// `seconds` value. Binding: `seconds` → a DataModel path that ticks down.
Widget buildCountdownText(BuildContext context, WidgetRef ref, A2uiNode node) {
  final palette = ref.watch(surfacePaletteProvider);
  final label = ref.resolveString(node, 'label') ?? '';
  final seconds = ref.resolveInt(node, 'seconds');
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flexible(
        child: Text(
          label,
          style: TextStyle(
            fontFamily: SosTokens.fontDisplay,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: palette.text,
          ),
        ),
      ),
      const SizedBox(width: SosTokens.space3),
      Text(
        seconds == null ? '--' : seconds.toString().padLeft(2, '0'),
        style: const TextStyle(
          fontFamily: SosTokens.fontMono,
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: SosTokens.criticalText,
        ),
      ),
    ],
  );
}
