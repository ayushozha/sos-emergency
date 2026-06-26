import 'package:flutter/material.dart';
import 'package:sos_emergency/app/theme/sos_tokens.dart';
import 'package:sos_emergency/app/theme/surface_palette.dart';
import 'package:sos_emergency/domain/models/severity.dart';

/// Shared visual chrome for catalog widgets: text roles, cards, skeleton
/// placeholders, status dots, and tier-aware containers.
///
/// Motion (pulse/blink/shimmer animation) is intentionally rendered static here
/// so the golden suite stays deterministic; animated variants are a later
/// polish pass keyed off `MediaQuery.disableAnimations`.
abstract final class SosText {
  static TextStyle scream(Color color) => TextStyle(
    fontFamily: SosTokens.fontDisplay,
    fontSize: 38,
    height: 1.02,
    fontWeight: FontWeight.w900,
    color: color,
  );

  static TextStyle headline(Color color) => TextStyle(
    fontFamily: SosTokens.fontDisplay,
    fontSize: 28,
    height: 1.05,
    fontWeight: FontWeight.w800,
    color: color,
  );

  static TextStyle title(Color color) => TextStyle(
    fontFamily: SosTokens.fontDisplay,
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: color,
  );

  static TextStyle body(Color color) => TextStyle(
    fontFamily: SosTokens.fontDisplay,
    fontSize: 17,
    height: 1.4,
    fontWeight: FontWeight.w500,
    color: color,
  );

  static TextStyle label(Color color) => TextStyle(
    fontFamily: SosTokens.fontMono,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.4,
    color: color,
  );

  static TextStyle telemetry(Color color) => TextStyle(
    fontFamily: SosTokens.fontMono,
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: color,
  );
}

/// A raised, rounded surface — the base container most widgets sit on. Optional
/// [tier] paints a left accent edge.
class SosCard extends StatelessWidget {
  const SosCard({
    required this.palette,
    required this.child,
    this.tier,
    this.padding = const EdgeInsets.all(SosTokens.space5),
    super.key,
  });

  final SurfacePalette palette;
  final Widget child;
  final Severity? tier;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final accent = tier == null ? null : TierStyle.of(tier!, palette).accent;
    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(SosTokens.radiusMd),
        border: accent == null
            ? Border.all(color: palette.textMuted.withValues(alpha: 0.16))
            : Border(left: BorderSide(color: accent, width: 4)),
      ),
      padding: padding,
      child: child,
    );
  }
}

/// A small status dot (live broadcast / reached / queued).
class StatusDot extends StatelessWidget {
  const StatusDot({required this.color, this.size = 11, super.key});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

/// A static skeleton placeholder block used by `loading` states. Matches the
/// final shape so layout doesn't jump when content lands.
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    required this.palette,
    this.width,
    this.height = 14,
    this.radius = 7,
    super.key,
  });

  final SurfacePalette palette;
  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: palette.tray,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

/// A calm empty state: states what's missing and offers one next step.
class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.palette,
    required this.message,
    this.action,
    super.key,
  });

  final SurfacePalette palette;
  final String message;
  final String? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SosTokens.space5),
      decoration: BoxDecoration(
        color: palette.tray.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(SosTokens.radiusMd),
        border: Border.all(
          color: palette.textMuted.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: SosText.body(palette.textMuted),
          ),
          if (action != null) ...[
            const SizedBox(height: SosTokens.space3),
            Text(action!, style: SosText.title(palette.info)),
          ],
        ],
      ),
    );
  }
}

/// Tier-keyed semantic colours that don't flip with day/night.
abstract final class SosStatus {
  static const Color reached = Color(0xFF2E7D58);
  static const Color sending = Color(0xFFC79318);
  static const Color queued = Color(0xFFA9A096);
  static const Color failed = Color(0xFFC63A33);

  static Color forContactStatus(String? status) => switch (status) {
    'reached' => reached,
    'sending' => sending,
    'failed' => failed,
    _ => queued,
  };
}
