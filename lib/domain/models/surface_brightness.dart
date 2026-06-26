/// Day / night theme token. Auto-derived from cabin light in production; in the
/// Phase 0 harness it is toggled manually.
enum SurfaceBrightness {
  /// Soft off-white ground — the default.
  day,

  /// Warm dimmed variant for night driving; same hierarchy, AAA body contrast.
  night,
}
