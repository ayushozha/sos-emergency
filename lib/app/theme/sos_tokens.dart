import 'package:flutter/widgets.dart';

/// Design tokens distilled from the SOS catalog handoff. Raw, theme-agnostic
/// values (spacing, radii, durations, touch sizes, severity hues, type roles).
///
/// See `docs/design/sos_design_system.md`. Colour roles that flip with day/night
/// live in `SurfacePalette`; these are the constants that do not.
abstract final class SosTokens {
  // ---- Spacing · 4px base grid ----
  static const double space1 = 4;
  static const double space2 = 8;
  static const double space3 = 12;
  static const double space4 = 16; // control padding
  static const double space5 = 20;
  static const double space6 = 24; // gap between actions
  static const double space8 = 32;
  static const double space12 = 48; // section rhythm
  static const double space16 = 64; // surface edge inset

  // ---- Radii ----
  static const double radiusSm = 12;
  static const double radiusMd = 16;
  static const double radiusLg = 20;
  static const double radiusXl = 28;

  // ---- Touch targets (tuned for a moving vehicle) ----
  static const double touchMin = 44;
  static const double touchTap = 88;
  static const double touchPrimary = 120;
  static const double touchPanic = 200;

  // ---- Motion ----
  static const Duration motionFast = Duration(milliseconds: 150);
  static const Duration motionBase = Duration(milliseconds: 240);
  static const Duration sosPulse = Duration(milliseconds: 1800);
  static const Cubic motionEase = Cubic(0.2, 0.7, 0.2, 1);

  // ---- Font families ----
  static const String fontDisplay = 'Hanken Grotesk';
  static const String fontMono = 'JetBrains Mono';

  // ---- Severity hues (shared across day/night; never washed out) ----
  static const Color moderate = Color(0xFFE8B032);
  static const Color moderateText = Color(0xFF9C7414);
  static const Color high = Color(0xFFE07B3C);
  static const Color highText = Color(0xFFB86B22);
  static const Color critical = Color(0xFFDD453D);
  static const Color criticalText = Color(0xFFC63A33);
  static const Color brandRedLight = Color(0xFFEE5A52);
  static const Color brandRedDark = Color(0xFFDD453D);
}
