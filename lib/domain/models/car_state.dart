/// Vehicle state token. Gates UI density and interaction depth: while driving
/// the surface collapses to the minimal/voice-first variant.
enum CarState {
  /// Moving — minimal density, one primary action, voice-first.
  driving,

  /// Stationary — the full ranked composition is allowed.
  parked,
}
