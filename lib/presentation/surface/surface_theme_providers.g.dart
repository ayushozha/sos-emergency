// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surface_theme_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds the current day/night brightness. In production this is derived from
/// cabin-light signals; in the Phase 0 harness it is toggled manually.

@ProviderFor(SurfaceBrightnessController)
final surfaceBrightnessControllerProvider =
    SurfaceBrightnessControllerProvider._();

/// Holds the current day/night brightness. In production this is derived from
/// cabin-light signals; in the Phase 0 harness it is toggled manually.
final class SurfaceBrightnessControllerProvider
    extends $NotifierProvider<SurfaceBrightnessController, SurfaceBrightness> {
  /// Holds the current day/night brightness. In production this is derived from
  /// cabin-light signals; in the Phase 0 harness it is toggled manually.
  SurfaceBrightnessControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'surfaceBrightnessControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$surfaceBrightnessControllerHash();

  @$internal
  @override
  SurfaceBrightnessController create() => SurfaceBrightnessController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SurfaceBrightness value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SurfaceBrightness>(value),
    );
  }
}

String _$surfaceBrightnessControllerHash() =>
    r'6616aab830806ce5ff779342e92ed1a0d96783c6';

/// Holds the current day/night brightness. In production this is derived from
/// cabin-light signals; in the Phase 0 harness it is toggled manually.

abstract class _$SurfaceBrightnessController
    extends $Notifier<SurfaceBrightness> {
  SurfaceBrightness build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SurfaceBrightness, SurfaceBrightness>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SurfaceBrightness, SurfaceBrightness>,
              SurfaceBrightness,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The resolved colour palette for the current brightness. Catalog builders
/// watch this so a day/night switch re-themes the whole surface at once.

@ProviderFor(surfacePalette)
final surfacePaletteProvider = SurfacePaletteProvider._();

/// The resolved colour palette for the current brightness. Catalog builders
/// watch this so a day/night switch re-themes the whole surface at once.

final class SurfacePaletteProvider
    extends $FunctionalProvider<SurfacePalette, SurfacePalette, SurfacePalette>
    with $Provider<SurfacePalette> {
  /// The resolved colour palette for the current brightness. Catalog builders
  /// watch this so a day/night switch re-themes the whole surface at once.
  SurfacePaletteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'surfacePaletteProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$surfacePaletteHash();

  @$internal
  @override
  $ProviderElement<SurfacePalette> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SurfacePalette create(Ref ref) {
    return surfacePalette(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SurfacePalette value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SurfacePalette>(value),
    );
  }
}

String _$surfacePaletteHash() => r'a1933732c3546cc24adf0381d48bbb1b206ac674';
