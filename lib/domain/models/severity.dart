/// Severity tier — the single context token every component themes itself from.
///
/// Set by the orchestrator from detected signals. Conveyed by hue + glyph +
/// border weight + motion together, never colour alone.
enum Severity {
  /// Opening triage / informational — no tier styling.
  neutral,

  /// Solvable, low time-pressure. Inform & guide. Amber, 2px border, static.
  moderate,

  /// Act soon. Escalation paths come forward. Orange, 3px border, edge breathe.
  high,

  /// Life-safety now. One action dominates. Red, 4px + hazard cap, soft pulse.
  critical;

  /// Parses the `tier` token used in A2UI JSON (e.g. `"high"`).
  static Severity fromToken(String? token) {
    return switch (token) {
      'moderate' => Severity.moderate,
      'high' => Severity.high,
      'critical' => Severity.critical,
      _ => Severity.neutral,
    };
  }
}
