import 'dart:convert';

import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/domain/models/classification.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/models/severity.dart';

const catalogVersion = '2026.06.0';

Map<String, dynamic> composeRequestBody({
  required Classification classification,
  required EmergencyContext context,
  bool stream = false,
  int timeBudgetMs = 3000,
  String? requestId,
}) {
  return {
    'classification': _classificationJson(classification),
    'context': _contextJson(context),
    'catalogVersion': catalogVersion,
    'stream': stream,
    'timeBudgetMs': timeBudgetMs,
    if (requestId != null) 'requestId': requestId,
  };
}

Map<String, dynamic> _classificationJson(Classification clf) => {
  'scenario': _scenarioToken(clf.scenario),
  'severity': clf.severity.name,
  'mode': clf.mode.name,
  'confidence': clf.confidence,
  'hazards': clf.hazards.map((h) => h.name).toList(),
};

String _scenarioToken(ScenarioClass scenario) => switch (scenario) {
  ScenarioClass.beingFollowed => 'beingFollowed',
  ScenarioClass.flatTire => 'flatTire',
  ScenarioClass.wontStart => 'wontStart',
  ScenarioClass.lockedOut => 'lockedOut',
  ScenarioClass.outOfGas => 'outOfGas',
  ScenarioClass.unsafeParked => 'unsafeParked',
  _ => scenario.name,
};

Map<String, dynamic> _contextJson(EmergencyContext ctx) {
  final pos = ctx.position;
  return {
    'carState': ctx.vehicleState.carStateToken,
    'connectivity': ctx.connectivity.name,
    'isNight': ctx.isNight,
    'locale': 'en-US',
    'emergencyNumber': '911',
    if (pos != null)
      'position': {
        'latitude': pos.latitude,
        'longitude': pos.longitude,
        if (pos.address != null) 'address': pos.address,
      },
  };
}

A2uiNode parseSurfaceFromComposeResponse(String body) {
  final json = jsonDecode(body) as Map<String, dynamic>;
  final surface = json['surface'] as Map<String, dynamic>? ?? json;
  return A2uiNode.fromJson(surface);
}

A2uiNode? parseSurfaceFromSseEvent(String dataLine) {
  final json = jsonDecode(dataLine) as Map<String, dynamic>;
  if (json['type'] == 'node') {
    final node = json['node'] as Map<String, dynamic>;
    return A2uiNode.fromJson(node);
  }
  if (json['type'] == 'compose' && json['surface'] != null) {
    return A2uiNode.fromJson(json['surface'] as Map<String, dynamic>);
  }
  return null;
}

Severity severityFromClassification(Classification clf) => clf.severity;