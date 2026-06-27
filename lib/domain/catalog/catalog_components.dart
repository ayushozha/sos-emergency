/// The canonical set of component names the renderer can ever build — the AI's
/// vocabulary, as a pure-Dart allow-list. The Safety Supervisor validates every
/// surface against this; the presentation registry must stay in sync (enforced
/// by a test).
const Set<String> knownComponents = {
  // Layout primitives
  'SurfaceColumn', 'SurfaceRow', 'Gap', 'SurfaceCard',
  'GuidanceText', 'Telemetry', 'CountdownText',
  // Container · layout
  'EmergencyRoot', 'ActionStack', 'SectionCard',
  // Sticky global · panic
  'SOSCallButton',
  'ShareLocationAction',
  'NotifyContactsAction',
  'ImSafeCancel',
  // Interactive inputs
  'BigChoiceCard', 'ChoiceGrid', 'YesNoLarge', 'StepChecklist', 'PushToTalk',
  // Read-only status & guidance
  'SeverityBanner', 'GuidanceCallout', 'LocationCard', 'CountdownCard',
  'ContactStatusList', 'VehicleStatusCard', 'MedicalIdCard',
  // Visualization · spatial
  'SafeRouteMap', 'ETACard', 'WeatherHazardCard',
  // Cross-cutting states
  'OfflineBanner',
};

/// Destination types `SafeRouteMap` may route to. Anything else (e.g. "home" or
/// a saved private place) is stripped during a threat.
const Set<String> safeDestinationTypes = {
  'police',
  'fire',
  'hospital',
  'public',
};
