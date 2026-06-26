import 'dart:convert';

import 'package:sos_emergency/domain/models/a2ui_node.dart';

/// Hand-authored A2UI documents reproducing the design-handoff example screens,
/// composed entirely from registered catalog components. Proves the Phase 1
/// exit criterion: every mockup is reproducible from A2UI.
const Map<String, String> sosScreenJson = {
  'opening_triage': '''
  {
    "type": "EmergencyRoot",
    "props": { "tier": "neutral", "carState": "parked" },
    "children": [
      {
        "type": "ChoiceGrid",
        "props": { "columns": 4 },
        "children": [
          { "type": "BigChoiceCard", "props": { "label": "Car problem", "icon": "vehicle" } },
          { "type": "BigChoiceCard", "props": { "label": "Crash", "icon": "crash" } },
          { "type": "BigChoiceCard", "props": { "label": "Medical", "icon": "medical" } },
          { "type": "BigChoiceCard", "props": { "label": "I feel unsafe", "icon": "unsafe" } },
          { "type": "BigChoiceCard", "props": { "label": "Being followed", "icon": "followed" } },
          { "type": "BigChoiceCard", "props": { "label": "Locked out", "icon": "locked-out" } },
          { "type": "BigChoiceCard", "props": { "label": "Roadside help", "icon": "roadside" } },
          { "type": "BigChoiceCard", "props": { "label": "Document it", "icon": "document" } }
        ]
      },
      { "type": "PushToTalk", "props": { "state": "idle" } }
    ]
  }
  ''',
  'serious_crash': '''
  {
    "type": "EmergencyRoot",
    "props": { "tier": "critical", "carState": "parked" },
    "children": [
      {
        "type": "SeverityBanner",
        "props": { "tier": "critical", "label": "Critical", "context": "Crash detected" }
      },
      {
        "type": "CountdownCard",
        "props": { "secondsLeft": 8, "totalSeconds": 15, "message": "Calling 911 automatically" }
      },
      { "type": "ImSafeCancel", "props": { "holdMs": 1200 } },
      {
        "type": "ContactStatusList",
        "props": {
          "contacts": [
            { "name": "Maya", "relation": "Sister", "status": "reached", "reachedAt": "2m" },
            { "name": "Dad", "relation": "Emergency contact", "status": "sending" }
          ]
        }
      }
    ]
  }
  ''',
  'being_followed': '''
  {
    "type": "EmergencyRoot",
    "props": { "tier": "high", "carState": "driving" },
    "children": [
      {
        "type": "SeverityBanner",
        "props": { "tier": "high", "label": "High", "context": "Threat · being followed" }
      },
      {
        "type": "GuidanceCallout",
        "props": { "tier": "high", "kicker": "Do this now", "text": "Drive to the nearest police station" }
      },
      {
        "type": "SafeRouteMap",
        "props": {
          "threatMode": true,
          "etaLabel": "4 min",
          "destinations": [
            { "type": "police", "name": "Daly City Police", "detail": "Open 24h · staffed", "distance": "1.2mi", "primary": true },
            { "type": "fire", "name": "Fire Station 92", "detail": "Always staffed", "distance": "2.0mi" },
            { "type": "hospital", "name": "Seton Medical ER", "detail": "Emergency room", "distance": "3.4mi" }
          ]
        }
      }
    ]
  }
  ''',
  'suspected_heart_attack': '''
  {
    "type": "EmergencyRoot",
    "props": { "tier": "critical", "carState": "parked" },
    "children": [
      {
        "type": "SeverityBanner",
        "props": { "tier": "critical", "label": "Critical", "context": "Possible cardiac event" }
      },
      {
        "type": "GuidanceCallout",
        "props": { "tier": "critical", "kicker": "Do this now", "text": "Pull over and stop the car" }
      },
      {
        "type": "YesNoLarge",
        "props": {
          "question": "Are you injured?",
          "yesLabel": "Yes",
          "yesHint": "Calls 911 now",
          "noLabel": "No",
          "noHint": "Continue triage"
        }
      },
      { "type": "SOSCallButton", "props": { "emergencyNumber": "911", "callState": "idle" } }
    ]
  }
  ''',
  'wont_start_offline': '''
  {
    "type": "EmergencyRoot",
    "props": { "tier": "moderate", "carState": "parked" },
    "children": [
      { "type": "OfflineBanner", "props": {} },
      {
        "type": "SeverityBanner",
        "props": { "tier": "moderate", "label": "Moderate", "context": "Roadside · no injuries" }
      },
      {
        "type": "StepChecklist",
        "props": {
          "title": "Jump-start",
          "currentIndex": 1,
          "steps": [
            { "title": "Park both cars, engines off", "done": true },
            { "title": "Clamp red to the dead + and good battery + terminal", "detail": "Red = positive. Do not let clamps touch.", "done": false },
            { "title": "Clamp black to good battery - terminal", "done": false },
            { "title": "Ground black to bare metal on the dead car", "done": false }
          ]
        }
      },
      {
        "type": "VehicleStatusCard",
        "props": {
          "metrics": [
            { "label": "Battery", "value": "Dead", "tier": "high", "detail": "no crank" },
            { "label": "OBD link", "value": "Connected", "detail": "No fault codes" }
          ],
          "profile": "2021 EV · run-flat tires · roadside plan active"
        }
      }
    ]
  }
  ''',
};

/// Parses a named screen fixture into a node tree.
A2uiNode sosScreen(String name) {
  final raw = sosScreenJson[name]!;
  return A2uiNode.fromJson(jsonDecode(raw) as Map<String, dynamic>);
}
