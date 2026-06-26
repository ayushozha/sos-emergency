import 'package:flutter/widgets.dart';
import 'package:sos_emergency/domain/models/severity.dart';
import 'package:sos_emergency/domain/models/surface_brightness.dart';

/// The colour roles that flip between day and night. Resolved from
/// [SurfaceBrightness] and handed to every catalog builder so no component
/// hand-colours itself.
@immutable
class SurfacePalette {
  const SurfacePalette({
    required this.brightness,
    required this.ground,
    required this.surface,
    required this.tray,
    required this.text,
    required this.textMuted,
    required this.safe,
    required this.info,
  });

  final SurfaceBrightness brightness;

  /// The base ground behind the surface.
  final Color ground;

  /// Raised card surface.
  final Color surface;

  /// Sunken tray inside a surface.
  final Color tray;

  final Color text;
  final Color textMuted;

  /// Safe / confirmation green.
  final Color safe;

  /// Informational blue.
  final Color info;

  static const SurfacePalette day = SurfacePalette(
    brightness: SurfaceBrightness.day,
    ground: Color(0xFFE7E2DB),
    surface: Color(0xFFFBF9F6),
    tray: Color(0xFFECE7E0),
    text: Color(0xFF36322E),
    textMuted: Color(0xFF8A8276),
    safe: Color(0xFF2E9E6B),
    info: Color(0xFF3A7BD0),
  );

  static const SurfacePalette night = SurfacePalette(
    brightness: SurfaceBrightness.night,
    ground: Color(0xFF1A1714),
    surface: Color(0xFF262320),
    tray: Color(0xFF322D27),
    text: Color(0xFFEDE7DD),
    textMuted: Color(0xFFA89F92),
    safe: Color(0xFF4FC78E),
    info: Color(0xFF5BA3F0),
  );

  static SurfacePalette of(SurfaceBrightness brightness) =>
      brightness == SurfaceBrightness.day ? day : night;
}

/// Per-tier styling cues, derived from a [Severity]. Carries the four redundant
/// signals: accent hue, border weight, text colour, and a pulse flag.
@immutable
class TierStyle {
  const TierStyle({
    required this.accent,
    required this.text,
    required this.borderWidth,
    required this.pulses,
  });

  factory TierStyle.of(Severity tier, SurfacePalette palette) {
    return switch (tier) {
      Severity.moderate => const TierStyle(
        accent: Color(0xFFE8B032),
        text: Color(0xFF9C7414),
        borderWidth: 2,
        pulses: false,
      ),
      Severity.high => const TierStyle(
        accent: Color(0xFFE07B3C),
        text: Color(0xFFB86B22),
        borderWidth: 3,
        pulses: false,
      ),
      Severity.critical => const TierStyle(
        accent: Color(0xFFDD453D),
        text: Color(0xFFC63A33),
        borderWidth: 4,
        pulses: true,
      ),
      Severity.neutral => TierStyle(
        accent: palette.textMuted,
        text: palette.text,
        borderWidth: 1,
        pulses: false,
      ),
    };
  }

  final Color accent;
  final Color text;
  final double borderWidth;
  final bool pulses;
}
