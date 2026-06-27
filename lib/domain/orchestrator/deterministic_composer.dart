import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/domain/models/classification.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/models/severity.dart';
import 'package:sos_emergency/domain/models/surface.dart';

/// Builds the hand-authored deterministic Surface for a classified incident —
/// the baseline that renders when AI is off, slow, or unavailable. Pure Dart,
/// no Flutter imports. Every MVP scenario has a composition here, so the app
/// loses zero safety capability without the AI.
class DeterministicComposer {
  const DeterministicComposer();

  Surface compose(Classification clf, EmergencyContext ctx) {
    final children = switch (clf.scenario) {
      ScenarioClass.crash => _crash(clf, ctx),
      ScenarioClass.medical => _medical(clf, ctx),
      ScenarioClass.beingFollowed => _beingFollowed(clf, ctx),
      ScenarioClass.unsafeParked => _unsafeParked(clf, ctx),
      ScenarioClass.flatTire => _flatTire(clf, ctx),
      ScenarioClass.wontStart => _wontStart(clf, ctx),
      ScenarioClass.lockedOut => _lockedOut(clf, ctx),
      ScenarioClass.outOfGas => _outOfGas(clf, ctx),
      ScenarioClass.severeWeather => _severeWeather(clf, ctx),
      ScenarioClass.stranded => _stranded(clf, ctx),
      ScenarioClass.harassment => _harassment(clf, ctx),
      ScenarioClass.documentIncident => _documentIncident(clf, ctx),
      ScenarioClass.unknown => _triage(clf, ctx),
    };

    final root = _node(
      'EmergencyRoot',
      props: {
        'tier': clf.severity.name,
        'carState': ctx.vehicleState.carStateToken,
      },
      children: [
        if (ctx.connectivity == Connectivity.offline) _node('OfflineBanner'),
        ...children,
      ],
    );

    return Surface(mode: clf.mode, severity: clf.severity, root: root);
  }

  // ---- per-scenario compositions ----

  List<A2uiNode> _crash(Classification clf, EmergencyContext ctx) => [
    _banner(clf, 'Crash detected'),
    _node(
      'CountdownCard',
      props: {
        'secondsLeft': 8,
        'totalSeconds': 15,
        'message': 'Calling 911 automatically',
      },
    ),
    _node('ImSafeCancel', props: {'holdMs': 1200}),
    _locationCard(ctx, sharing: true),
  ];

  List<A2uiNode> _medical(Classification clf, EmergencyContext ctx) => [
    _banner(clf, 'Possible cardiac event'),
    _guidance(clf, 'Do this now', 'Pull over and stop the car'),
    _node(
      'MedicalIdCard',
      props: {
        'bloodType': 'O+',
        'allergies': 'Penicillin',
        'conditions': 'Hypertension',
      },
    ),
    _node(
      'YesNoLarge',
      props: {
        'question': 'Are you injured?',
        'yesLabel': 'Yes',
        'yesHint': 'Calls 911 now',
        'noLabel': 'No',
        'noHint': 'Continue triage',
      },
    ),
    _sosButton(),
  ];

  List<A2uiNode> _beingFollowed(Classification clf, EmergencyContext ctx) => [
    _banner(clf, 'Threat · being followed'),
    _guidance(clf, 'Do this now', 'Drive to the nearest police station'),
    _safeRouteMap(),
  ];

  List<A2uiNode> _unsafeParked(Classification clf, EmergencyContext ctx) => [
    _banner(clf, 'Stay alert'),
    _guidance(clf, 'If you feel threatened', 'Drive to a busy, lit place'),
    _node(
      'ActionStack',
      props: {
        'carState': ctx.vehicleState.carStateToken,
        'actions': [
          {'label': 'Call 911', 'icon': 'call', 'tier': 'critical'},
          {'label': 'Share location', 'icon': 'location'},
          {'label': 'Drive to safety', 'icon': 'safe-route'},
        ],
      },
    ),
  ];

  List<A2uiNode> _flatTire(Classification clf, EmergencyContext ctx) => [
    _banner(clf, 'Flat tire · I-280 N · narrow shoulder'),
    _guidance(clf, 'Stay safe', 'Move behind the guardrail, hazards on'),
    _node(
      'StepChecklist',
      props: {
        'title': 'Change a tire',
        'currentIndex': 0,
        'steps': [
          {'title': 'Pull onto a flat, firm shoulder', 'done': false},
          {'title': 'Hazards on, parking brake set', 'done': false},
          {'title': 'Loosen lug nuts before jacking', 'done': false},
          {'title': 'Jack up, swap wheel, lower, re-torque', 'done': false},
        ],
      },
    ),
    _vehicleStatus(ctx),
  ];

  List<A2uiNode> _wontStart(Classification clf, EmergencyContext ctx) => [
    _banner(clf, 'Roadside · no injuries'),
    _node(
      'StepChecklist',
      props: {
        'title': 'Jump-start',
        'currentIndex': 1,
        'steps': [
          {'title': 'Park both cars, engines off', 'done': true},
          {
            'title': 'Clamp red to the dead + and good battery + terminal',
            'detail': 'Red = positive. Do not let clamps touch.',
            'done': false,
          },
          {'title': 'Clamp black to good battery - terminal', 'done': false},
          {
            'title': 'Ground black to bare metal on the dead car',
            'done': false,
          },
        ],
      },
    ),
    _vehicleStatus(ctx),
  ];

  List<A2uiNode> _lockedOut(Classification clf, EmergencyContext ctx) => [
    _banner(clf, 'Locked out'),
    _guidance(clf, 'Options', 'Roadside can unlock most cars in ~30 min'),
    _node(
      'ActionStack',
      props: {
        'carState': ctx.vehicleState.carStateToken,
        'actions': [
          {'label': 'Call roadside help', 'icon': 'roadside'},
          {'label': 'Call a contact', 'icon': 'contacts'},
        ],
      },
    ),
  ];

  List<A2uiNode> _outOfGas(Classification clf, EmergencyContext ctx) => [
    _banner(clf, 'Low on energy'),
    _vehicleStatus(ctx),
    _node(
      'ActionStack',
      props: {
        'carState': ctx.vehicleState.carStateToken,
        'actions': [
          {'label': 'Find nearest fuel/charge', 'icon': 'navigate'},
          {'label': 'Call roadside help', 'icon': 'roadside'},
        ],
      },
    ),
  ];

  // ---- expansion scenarios ----

  List<A2uiNode> _severeWeather(Classification clf, EmergencyContext ctx) => [
    _banner(clf, 'Severe weather'),
    _guidance(
      clf,
      'Do this now',
      'Shelter in place or move away from the hazard',
    ),
    _node(
      'WeatherHazardCard',
      props: {
        'condition': 'Severe weather in your area',
        'tier': clf.severity.name,
        'advice': 'Avoid flooded roads and downed lines. Stay informed.',
      },
    ),
    _node(
      'ActionStack',
      props: {
        'carState': ctx.vehicleState.carStateToken,
        'actions': [
          {'label': 'Call 911', 'icon': 'call', 'tier': 'critical'},
          {'label': 'Share location', 'icon': 'location'},
        ],
      },
    ),
  ];

  List<A2uiNode> _stranded(Classification clf, EmergencyContext ctx) => [
    _banner(clf, 'Stranded'),
    _guidance(
      clf,
      'Stay safe',
      'Stay put, stay visible, conserve phone battery',
    ),
    _locationCard(ctx, sharing: true),
    _node(
      'ActionStack',
      props: {
        'carState': ctx.vehicleState.carStateToken,
        'actions': [
          {'label': 'Call roadside help', 'icon': 'roadside'},
          {'label': 'Notify a contact', 'icon': 'contacts'},
        ],
      },
    ),
  ];

  List<A2uiNode> _harassment(Classification clf, EmergencyContext ctx) => [
    _banner(clf, 'Threat · harassment'),
    _guidance(clf, 'Do this now', 'Get to a busy, public place or the police'),
    _safeRouteMap(),
    _node(
      'NotifyContactsAction',
      props: {
        'contacts': [
          {'name': 'Maya', 'relation': 'Sister', 'status': 'queued'},
          {'name': 'Dad', 'relation': 'Emergency contact', 'status': 'queued'},
        ],
      },
    ),
  ];

  List<A2uiNode> _documentIncident(
    Classification clf,
    EmergencyContext ctx,
  ) => [
    _banner(clf, 'Documenting'),
    _guidance(clf, 'Recording', 'Time, place and details are being captured'),
    _locationCard(ctx, sharing: false),
    _node(
      'SectionCard',
      props: {'title': 'What happened'},
      children: [
        _node(
          'GuidanceText',
          props: {
            'kicker': 'Notes',
            'text': 'Describe the incident — who, what, where, when.',
          },
        ),
      ],
    ),
  ];

  List<A2uiNode> _triage(Classification clf, EmergencyContext ctx) => [
    _node(
      'GuidanceText',
      props: {'kicker': 'Emergency assistant', 'text': "What's happening?"},
    ),
    _node(
      'ChoiceGrid',
      props: {'columns': 4},
      children: const [
        _ChoiceData('Car problem', 'vehicle', 'wontStart'),
        _ChoiceData('Crash', 'crash', 'crash'),
        _ChoiceData('Medical', 'medical', 'medical'),
        _ChoiceData('I feel unsafe', 'unsafe', 'unsafeParked'),
        _ChoiceData('Being followed', 'followed', 'beingFollowed'),
        _ChoiceData('Locked out', 'locked-out', 'lockedOut'),
        _ChoiceData('Roadside help', 'roadside', 'flatTire'),
        _ChoiceData('Document it', 'document', 'documentIncident'),
      ].map(_choiceCard).toList(),
    ),
    _node('PushToTalk', props: {'state': 'idle'}),
  ];

  // ---- shared component builders ----

  A2uiNode _banner(Classification clf, String context) => _node(
    'SeverityBanner',
    props: {
      'tier': clf.severity.name,
      'label': _tierLabel(clf.severity),
      'context': context,
    },
  );

  A2uiNode _guidance(Classification clf, String kicker, String text) => _node(
    'GuidanceCallout',
    props: {'tier': clf.severity.name, 'kicker': kicker, 'text': text},
  );

  A2uiNode _sosButton() => _node(
    'SOSCallButton',
    props: {'emergencyNumber': '911', 'callState': 'idle'},
  );

  A2uiNode _safeRouteMap() => _node(
    'SafeRouteMap',
    props: {
      'threatMode': true,
      'etaLabel': '4 min',
      'destinations': [
        {
          'type': 'police',
          'name': 'Nearest police station',
          'detail': 'Open 24h · staffed',
          'distance': '1.2mi',
          'primary': true,
        },
        {
          'type': 'hospital',
          'name': 'Emergency room',
          'detail': 'Always staffed',
          'distance': '3.4mi',
        },
      ],
    },
  );

  A2uiNode _locationCard(EmergencyContext ctx, {required bool sharing}) {
    final pos = ctx.position;
    return _node(
      'LocationCard',
      props: {
        'isSharing': sharing,
        if (pos?.address != null) 'address': pos!.address,
        if (pos?.detail != null) 'detail': pos!.detail,
        if (pos != null)
          'coords':
              '${pos.latitude.toStringAsFixed(4)}, '
              '${pos.longitude.toStringAsFixed(4)}',
      },
    );
  }

  A2uiNode _vehicleStatus(EmergencyContext ctx) {
    final bus = ctx.bus;
    final metrics = <Map<String, Object?>>[
      if (bus?.evChargePercent != null)
        {
          'label': 'EV charge',
          'value': '${bus!.evChargePercent}%',
          'tier': (bus.evChargePercent ?? 100) <= 10 ? 'high' : 'neutral',
        },
      if (bus?.fuelPercent != null)
        {
          'label': 'Fuel',
          'value': '${bus!.fuelPercent}%',
          'tier': (bus.fuelPercent ?? 100) <= 10 ? 'high' : 'neutral',
        },
      if (bus?.engineCranksNoStart ?? false)
        {
          'label': 'Battery',
          'value': 'Dead',
          'tier': 'high',
          'detail': 'no crank',
        },
    ];
    return _node(
      'VehicleStatusCard',
      props: {
        'metrics': metrics.isEmpty
            ? [
                {'label': 'OBD link', 'value': 'Connected'},
              ]
            : metrics,
        if (bus?.profile != null) 'profile': bus!.profile,
      },
    );
  }

  A2uiNode _choiceCard(_ChoiceData data) => _node(
    'BigChoiceCard',
    props: {
      'label': data.label,
      'icon': data.icon,
      'scenario': data.scenario,
    },
  );

  A2uiNode _node(
    String type, {
    Map<String, Object?> props = const {},
    List<A2uiNode> children = const [],
  }) => A2uiNode(type: type, props: props, children: children);

  String _tierLabel(Severity s) => switch (s) {
    Severity.moderate => 'Moderate',
    Severity.high => 'High',
    Severity.critical => 'Critical',
    Severity.neutral => 'Info',
  };
}

class _ChoiceData {
  const _ChoiceData(this.label, this.icon, this.scenario);
  final String label;
  final String icon;

  /// The scenario this choice navigates to.
  final String scenario;
}
