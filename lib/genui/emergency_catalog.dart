import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/presentation/catalog/fallbacks.dart';
import 'package:sos_emergency/presentation/catalog/inputs.dart';
import 'package:sos_emergency/presentation/catalog/layout.dart';
import 'package:sos_emergency/presentation/catalog/panic.dart';
import 'package:sos_emergency/presentation/catalog/primitives.dart';
import 'package:sos_emergency/presentation/catalog/severity_banner.dart';
import 'package:sos_emergency/presentation/catalog/spatial.dart';
import 'package:sos_emergency/presentation/catalog/status.dart';
import 'package:sos_emergency/presentation/surface/catalog_registry.dart';

/// The catalog id the model names in `createSurface`. We extend
/// [BasicCatalogItems], so the combined catalog keeps genui's [basicCatalogId]
/// — and that is exactly the id `PromptBuilder` instructs the model to use.
/// Overriding it would desync the model's `createSurface` from our catalog.
const String kEmergencyCatalogId = basicCatalogId;

/// Severity tiers, shared across component schemas.
const List<String> _tiers = ['neutral', 'moderate', 'high', 'critical'];

/// The emergency widget [Catalog] for the genui SDK.
///
/// Each [CatalogItem] gives the model a real `dataSchema` (the contract it
/// fills in) and a `widgetBuilder` that renders the SOS component. genui
/// serializes these schemas into the system prompt via `PromptBuilder`, so the
/// model only ever names components this app can build.
///
/// Coverage: every **leaf** SOS component. Layout/containers (rows, columns,
/// cards) are provided by genui's [BasicCatalogItems] — the model composes SOS
/// leaves inside genui `Column`/`Card`. The always-on safety rail is app chrome
/// (it must never depend on the model), so there is no `EmergencyRoot` here.
Catalog buildEmergencyCatalog() => BasicCatalogItems.asCatalog().copyWith(
  newItems: [
    for (final e in _entries)
      CatalogItem(
        name: e.name,
        dataSchema: e.schema,
        widgetBuilder: (ctx) => _bridge(e.builder, ctx),
      ),
  ],
);

/// Bridges an existing SOS widget builder into a genui [CatalogItem].
///
/// genui hands each builder a [CatalogItemContext] whose `data` is the
/// component's property map. We wrap those props in an [A2uiNode] and a
/// [Consumer] (to supply a [WidgetRef]) so the existing builders — which read
/// `node.props` through the binding resolver — work unchanged.
Widget _bridge(CatalogBuilder builder, CatalogItemContext itemContext) {
  final props = Map<String, Object?>.from(itemContext.data as Map);
  final node = A2uiNode(type: itemContext.type, props: props);
  return Consumer(builder: (context, ref, _) => builder(context, ref, node));
}

/// One leaf component: the model-facing name, its data schema, and the existing
/// builder it renders through.
class _Entry {
  const _Entry(this.name, this.schema, this.builder);
  final String name;
  final Schema schema;
  final CatalogBuilder builder;
}

final List<_Entry> _entries = [
  // ---- status & guidance ----
  _Entry(
    'SeverityBanner',
    S.object(
      description:
          'Tier indicator pinned to the top of the surface — colour, label, '
          'glyph and border together. Sets the emotional register.',
      properties: {
        'tier': S.string(description: 'Severity tier.', enumValues: _tiers),
        'label': S.string(description: 'Short tier label, e.g. "Critical".'),
        'context': S.string(description: 'Optional one-line context.'),
      },
      required: ['tier', 'label'],
    ),
    buildSeverityBanner,
  ),
  _Entry(
    'GuidanceCallout',
    S.object(
      description:
          'The single most important instruction, in warm imperative voice '
          'and scream-tier type. Use exactly one at a time.',
      properties: {
        'tier': S.string(description: 'Severity tier.', enumValues: _tiers),
        'kicker': S.string(description: 'Small label above the instruction.'),
        'text': S.string(description: 'The imperative instruction.'),
      },
      required: ['tier', 'text'],
    ),
    buildGuidanceCallout,
  ),
  _Entry(
    'LocationCard',
    S.object(
      description:
          'Address plus big mono coordinates and share status — the exact '
          'line a dispatcher needs read aloud.',
      properties: {
        'address': S.string(description: 'Street address, if known.'),
        'coords': S.string(description: 'Lat, lng as a short string.'),
        'detail': S.string(description: 'Extra locating detail.'),
        'isSharing': S.boolean(description: 'Whether live sharing is on.'),
      },
      required: ['coords'],
    ),
    buildLocationCard,
  ),
  _Entry(
    'CountdownCard',
    S.object(
      description:
          'A ring counting down to an automatic 911 call. Always pair with an '
          'ImSafeCancel control.',
      properties: {
        'secondsLeft': S.integer(description: 'Seconds remaining.'),
        'totalSeconds': S.integer(description: 'Total length, for ring fill.'),
        'message': S.string(description: 'Caption under the ring.'),
      },
      required: ['secondsLeft', 'totalSeconds'],
    ),
    buildCountdownCard,
  ),
  _Entry(
    'ContactStatusList',
    S.object(
      description:
          'A read-only roster of trusted contacts and whether each was '
          'reached, so the user does not re-send in panic.',
      properties: {
        'contacts': S.list(
          description: 'The trusted contacts and their reach status.',
          items: S.object(
            properties: {
              'name': S.string(),
              'relation': S.string(),
              'status': S.string(
                description: 'pending | reached | failed.',
              ),
              'reachedAt': S.string(description: 'When reached, if known.'),
            },
            required: ['name', 'status'],
          ),
        ),
      },
      required: ['contacts'],
    ),
    buildContactStatusList,
  ),
  _Entry(
    'VehicleStatusCard',
    S.object(
      description:
          'Relevant vehicle telemetry shown only when useful — EV charge, '
          'fuel, OBD fault.',
      properties: {
        'metrics': S.list(
          description: 'The telemetry rows to show.',
          items: S.object(
            properties: {
              'label': S.string(),
              'value': S.string(),
              'tier': S.string(enumValues: _tiers),
              'detail': S.string(),
            },
            required: ['label', 'value'],
          ),
        ),
        'profile': S.string(description: 'Vehicle profile label, if any.'),
      },
      required: ['metrics'],
    ),
    buildVehicleStatusCard,
  ),

  // ---- panic ----
  _Entry(
    'SOSCallButton',
    S.object(
      description:
          'The oversized one-tap call to emergency services — the single '
          'dominant action in a critical moment.',
      properties: {
        'emergencyNumber': S.string(description: 'Number to dial, e.g. "911".'),
        'callState': S.string(
          description: 'Call state.',
          enumValues: ['idle', 'dialing', 'connected'],
        ),
        'callDuration': S.string(description: 'Elapsed time mm:ss.'),
      },
      required: ['emergencyNumber', 'callState'],
    ),
    buildSosCallButton,
  ),
  _Entry(
    'ShareLocationAction',
    S.object(
      description:
          'Starts or stops a live location broadcast. Offer whenever someone '
          'needs help to find the user.',
      properties: {
        'isSharing': S.boolean(description: 'Whether sharing is active.'),
        'recipients': S.string(description: 'Who can see the location.'),
      },
      required: ['isSharing'],
    ),
    buildShareLocationAction,
  ),
  _Entry(
    'NotifyContactsAction',
    S.object(
      description:
          'Alerts trusted contacts with the situation and live location, '
          'showing per-person delivery.',
      properties: {
        'contacts': S.list(
          description: 'Contacts to notify.',
          items: S.object(
            properties: {
              'name': S.string(),
              'relation': S.string(),
              'status': S.string(description: 'pending | reached | failed.'),
            },
            required: ['name'],
          ),
        ),
      },
      required: ['contacts'],
    ),
    buildNotifyContactsAction,
  ),
  _Entry(
    'ImSafeCancel',
    S.object(
      description:
          'A hold-to-confirm "I\'m okay" control that aborts a countdown or '
          'auto-escalation. Always pair with CountdownCard.',
      properties: {
        'holdMs': S.integer(description: 'Hold duration to confirm, in ms.'),
        'target': S.string(description: 'What it cancels, for context.'),
      },
      required: [],
    ),
    buildImSafeCancel,
  ),

  // ---- inputs ----
  _Entry(
    'BigChoiceCard',
    S.object(
      description:
          'A large, icon-led, single-select choice. One tap selects and '
          'advances — the building block of the triage grid.',
      properties: {
        'label': S.string(description: 'The choice label.'),
        'icon': S.string(description: 'Icon token, e.g. "crash", "medical".'),
        'selected': S.boolean(description: 'Whether currently selected.'),
      },
      required: ['label'],
    ),
    buildBigChoiceCard,
  ),
  _Entry(
    'YesNoLarge',
    S.object(
      description:
          'Two half-surface targets for one critical yes/no like "Are you '
          'injured?". Voice-answerable.',
      properties: {
        'question': S.string(description: 'The yes/no question.'),
        'yesLabel': S.string(),
        'yesHint': S.string(),
        'noLabel': S.string(),
        'noHint': S.string(),
      },
      required: ['question'],
    ),
    buildYesNoLarge,
  ),
  _Entry(
    'StepChecklist',
    S.object(
      description:
          'Guided steps with one hot step at a time — jump-start, FAST check, '
          'tire change. Works offline.',
      properties: {
        'title': S.string(),
        'currentIndex': S.integer(description: 'Index of the active step.'),
        'steps': S.list(
          description: 'The ordered steps.',
          items: S.object(
            properties: {
              'title': S.string(),
              'detail': S.string(),
              'done': S.boolean(),
            },
            required: ['title'],
          ),
        ),
      },
      required: ['steps', 'currentIndex'],
    ),
    buildStepChecklist,
  ),
  _Entry(
    'PushToTalk',
    S.object(
      description:
          'Prominent voice entry — the primary input while driving. Shows a '
          'listening state and a live transcript.',
      properties: {
        'state': S.string(
          description: 'Mic state.',
          enumValues: ['idle', 'listening', 'processing'],
        ),
        'transcript': S.string(description: 'Live transcript, if any.'),
      },
      required: ['state'],
    ),
    buildPushToTalk,
  ),

  // ---- spatial ----
  _Entry(
    'SafeRouteMap',
    S.object(
      description:
          'A map that only ever routes to safety — police, fire, hospital or '
          'a busy public place. In threat mode it hides private places.',
      properties: {
        'threatMode': S.boolean(description: 'Hide home/private when true.'),
        'etaLabel': S.string(description: 'ETA to the primary destination.'),
        'destinations': S.list(
          description: 'Safe destinations, nearest first.',
          items: S.object(
            properties: {
              'type': S.string(description: 'police | fire | hospital | busy.'),
              'name': S.string(),
              'detail': S.string(),
              'distance': S.string(),
              'primary': S.boolean(),
            },
            required: ['type', 'name'],
          ),
        ),
      },
      required: ['destinations'],
    ),
    buildSafeRouteMap,
  ),
  _Entry(
    'ETACard',
    S.object(
      description:
          'Tracks an inbound responder or roadside truck — who is coming and '
          'how far out.',
      properties: {
        'provider': S.string(description: 'Who is coming.'),
        'etaMinutes': S.integer(),
        'progress': S.number(description: 'Arrival progress 0..1.'),
        'distance': S.string(),
        'driver': S.string(),
      },
      required: ['provider', 'etaMinutes'],
    ),
    buildEtaCard,
  ),
  _Entry(
    'WeatherHazardCard',
    S.object(
      description:
          'Weather and road-hazard context that changes the advice — fog, '
          'ice, flooding, heat. Carries its own tier.',
      properties: {
        'condition': S.string(),
        'tier': S.string(description: 'Severity tier.', enumValues: _tiers),
        'advice': S.string(),
        'cachedAt': S.string(),
        'metrics': S.list(
          items: S.object(
            properties: {'label': S.string(), 'value': S.string()},
          ),
        ),
      },
      required: ['condition', 'tier'],
    ),
    buildWeatherHazardCard,
  ),

  // ---- actions & primitives ----
  _Entry(
    'ActionStack',
    S.object(
      description:
          'A stack of primary actions ranked by safety. One giant button '
          'while driving; a short ranked list when parked.',
      properties: {
        'carState': S.string(
          description: 'driving | parked.',
          enumValues: ['driving', 'parked'],
        ),
        'actions': S.list(
          description: 'Actions, most important first.',
          items: S.object(
            properties: {
              'label': S.string(),
              'icon': S.string(),
              'tier': S.string(enumValues: _tiers),
            },
            required: ['label'],
          ),
        ),
      },
      required: ['actions'],
    ),
    buildActionStack,
  ),
  _Entry(
    'GuidanceText',
    S.object(
      description: 'A kicker + body instruction block.',
      properties: {
        'kicker': S.string(),
        'text': S.string(),
      },
      required: ['text'],
    ),
    buildGuidanceText,
  ),
  _Entry(
    'Telemetry',
    S.object(
      description: 'A small mono telemetry line.',
      properties: {'text': S.string()},
      required: ['text'],
    ),
    buildTelemetry,
  ),
  _Entry(
    'CountdownText',
    S.object(
      description: 'A labelled numeric countdown line.',
      properties: {
        'label': S.string(),
        'seconds': S.integer(),
      },
      required: ['label'],
    ),
    buildCountdownText,
  ),

  // ---- cross-cutting ----
  _Entry(
    'OfflineBanner',
    S.object(
      description:
          'A pinned notice that the car has no signal. Guidance still works '
          'and 911 retries on reconnect.',
      properties: {
        'title': S.string(),
        'detail': S.string(),
      },
      required: [],
    ),
    buildOfflineBanner,
  ),
];
