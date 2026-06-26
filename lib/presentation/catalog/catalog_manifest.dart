/// The catalog manifest — the AI-facing description of every component the
/// orchestrator may compose. Written warm and intent-oriented (what the widget
/// is *for*), per the GenUI guidance: the agent chooses components by reading
/// these, so the description doubles as the selection prompt.
///
/// Keys match `catalogRegistry`. Keep the two in sync — a name here that isn't
/// registered cannot render, and a registered name without an entry is
/// invisible to the AI. The Phase 3 `AiComposer` serializes this into the
/// model prompt.
library;

/// One entry per composable component.
class CatalogEntry {
  const CatalogEntry({
    required this.name,
    required this.family,
    required this.description,
    required this.inputs,
  });

  /// The registry key / A2UI `type`.
  final String name;

  /// Grouping shown to the model to aid selection.
  final String family;

  /// Warm, intent-oriented description of when to use it.
  final String description;

  /// The data keys it reads (props or bindings).
  final List<String> inputs;
}

/// The full MVP catalog manifest.
const List<CatalogEntry> catalogManifest = [
  // ---- Container · layout ----
  CatalogEntry(
    name: 'EmergencyRoot',
    family: 'layout',
    description:
        'The screen root. Mount every composition inside it — it guarantees '
        'the always-on safety rail (911, live location, voice). Put the '
        'scenario content in its children.',
    inputs: ['tier', 'theme', 'carState', 'children'],
  ),
  CatalogEntry(
    name: 'ActionStack',
    family: 'layout',
    description:
        'A stack of primary actions ranked by safety. Use it as the main '
        'choice surface; it shows one giant button while driving and a short '
        'ranked list when parked.',
    inputs: ['actions[]{label,icon,tier}', 'carState'],
  ),
  CatalogEntry(
    name: 'SectionCard',
    family: 'layout',
    description:
        'A titled, tier-accented grouping for related instructions or data. '
        'Nest any widgets inside to keep a screen legible.',
    inputs: ['title?', 'tier?', 'children'],
  ),
  CatalogEntry(
    name: 'ChoiceGrid',
    family: 'layout',
    description:
        'Arranges BigChoiceCards in a grid — the opening "What\'s happening?" '
        'surface.',
    inputs: ['columns', 'children'],
  ),

  // ---- Sticky global · panic ----
  CatalogEntry(
    name: 'SOSCallButton',
    family: 'panic',
    description:
        'The oversized one-tap call to emergency services. Reach for it as the '
        'single dominant action in any critical moment; it shows live call '
        'status once connected.',
    inputs: ['emergencyNumber', 'callState', 'callDuration'],
  ),
  CatalogEntry(
    name: 'ShareLocationAction',
    family: 'panic',
    description:
        'Starts or stops a live location broadcast. Offer it whenever someone '
        'needs help to find them; the on state is unmistakable.',
    inputs: ['isSharing', 'recipients'],
  ),
  CatalogEntry(
    name: 'NotifyContactsAction',
    family: 'panic',
    description:
        'Alerts trusted contacts with the situation and live location, showing '
        'per-person delivery so the user knows help is aware.',
    inputs: ['contacts[]{name,relation,status}'],
  ),
  CatalogEntry(
    name: 'ImSafeCancel',
    family: 'panic',
    description:
        'A hold-to-confirm "I\'m okay" control that aborts a countdown or '
        'auto-escalation. Always pair it with CountdownCard.',
    inputs: ['holdMs', 'target'],
  ),

  // ---- Interactive inputs ----
  CatalogEntry(
    name: 'BigChoiceCard',
    family: 'input',
    description:
        'A large, icon-led, single-select choice. One tap selects and advances '
        '— the building block of the opening triage grid.',
    inputs: ['label', 'icon', 'selected?'],
  ),
  CatalogEntry(
    name: 'YesNoLarge',
    family: 'input',
    description:
        'Two half-surface targets for one critical yes/no like "Are you '
        'injured?". Voice-answerable; "Yes" can route straight to the critical '
        'path.',
    inputs: ['question', 'yesLabel?', 'noLabel?', 'yesHint?', 'noHint?'],
  ),
  CatalogEntry(
    name: 'StepChecklist',
    family: 'input',
    description:
        'Guided steps with one hot step at a time — jump-start, FAST check, '
        'tire change. Works offline.',
    inputs: ['title?', 'steps[]{title,detail,done}', 'currentIndex'],
  ),
  CatalogEntry(
    name: 'PushToTalk',
    family: 'input',
    description:
        'Prominent voice entry — the primary input while driving. Shows an '
        'unmistakable listening state and a live transcript.',
    inputs: ['state', 'transcript?'],
  ),

  // ---- Read-only status & guidance ----
  CatalogEntry(
    name: 'SeverityBanner',
    family: 'status',
    description:
        'The tier indicator pinned to the top of the surface — colour, label, '
        'glyph and border together. Use it to set the emotional register.',
    inputs: ['tier', 'label', 'context?'],
  ),
  CatalogEntry(
    name: 'GuidanceCallout',
    family: 'status',
    description:
        'The single most important instruction, in warm imperative voice and '
        'scream-tier type. Use exactly one at a time — it owns the moment.',
    inputs: ['text', 'tier', 'kicker?'],
  ),
  CatalogEntry(
    name: 'LocationCard',
    family: 'status',
    description:
        'Address plus big mono coordinates and share status — the exact line a '
        'dispatcher needs read aloud.',
    inputs: ['address', 'coords', 'accuracy?', 'isSharing'],
  ),
  CatalogEntry(
    name: 'CountdownCard',
    family: 'status',
    description:
        'A ring counting down to an automatic 911 call so an unconscious '
        'driver still gets help. Always paired with ImSafeCancel.',
    inputs: ['secondsLeft', 'totalSeconds', 'message?'],
  ),
  CatalogEntry(
    name: 'ContactStatusList',
    family: 'status',
    description:
        'A read-only roster of trusted contacts and whether each was reached, '
        'so the user does not re-send in panic.',
    inputs: ['contacts[]{name,relation,status,reachedAt}'],
  ),
  CatalogEntry(
    name: 'VehicleStatusCard',
    family: 'status',
    description:
        'Relevant vehicle telemetry shown only when useful — EV charge for a '
        'stranded EV, fuel for out-of-gas, OBD for a fault.',
    inputs: ['metrics[]{label,value,tier}', 'profile?'],
  ),

  // ---- Visualization · spatial ----
  CatalogEntry(
    name: 'SafeRouteMap',
    family: 'spatial',
    description:
        'A map layer that only ever routes to safety — police, fire, hospital '
        'or a busy public place. In threat mode it hides home and private '
        'places. Use it for being-followed and threat scenarios.',
    inputs: ['origin', 'destinations[]{type,name,distance}', 'threatMode'],
  ),
  CatalogEntry(
    name: 'ETACard',
    family: 'spatial',
    description:
        'Tracks an inbound responder or roadside truck — who is coming and how '
        'far out. Turns waiting into something legible.',
    inputs: ['provider', 'etaMinutes', 'progress', 'distance?'],
  ),
  CatalogEntry(
    name: 'WeatherHazardCard',
    family: 'spatial',
    description:
        'Weather and road-hazard context that changes the advice — fog, ice, '
        'flooding, heat. Carries its own tier so a hazard can raise urgency.',
    inputs: ['condition', 'tier', 'advice?', 'metrics?', 'cachedAt?'],
  ),

  // ---- Cross-cutting states ----
  CatalogEntry(
    name: 'OfflineBanner',
    family: 'state',
    description:
        'A pinned notice that the car has no signal. Guidance still works and '
        '911 retries on reconnect. Never depends on network state.',
    inputs: ['title?', 'detail?'],
  ),
];
