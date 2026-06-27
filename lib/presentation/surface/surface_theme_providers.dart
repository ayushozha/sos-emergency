import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/app/theme/surface_palette.dart';
import 'package:sos_emergency/domain/models/surface_brightness.dart';

part 'surface_theme_providers.g.dart';

/// Holds the current day/night brightness. In production this is derived from
/// cabin-light signals; in the Phase 0 harness it is toggled manually.
@Riverpod(keepAlive: true)
class SurfaceBrightnessController extends _$SurfaceBrightnessController {
  @override
  SurfaceBrightness build() => SurfaceBrightness.day;

  void toggle() {
    state = state == SurfaceBrightness.day
        ? SurfaceBrightness.night
        : SurfaceBrightness.day;
  }

  // ignore: use_setters_to_change_properties
  void set(SurfaceBrightness brightness) => state = brightness;
}

/// The resolved colour palette for the current brightness. Catalog builders
/// watch this so a day/night switch re-themes the whole surface at once.
@Riverpod(keepAlive: true)
SurfacePalette surfacePalette(Ref ref) {
  final brightness = ref.watch(surfaceBrightnessControllerProvider);
  return SurfacePalette.of(brightness);
}
