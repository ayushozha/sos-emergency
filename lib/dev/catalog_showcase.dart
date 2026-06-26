import 'dart:convert';

import 'package:sos_emergency/domain/models/a2ui_node.dart';

/// Scrollable surface that renders every registered catalog widget with sample data.
A2uiNode catalogShowcase() {
  return A2uiNode.fromJson(
    jsonDecode(_catalogShowcaseJson) as Map<String, dynamic>,
  );
}

const _catalogShowcaseJson = '''
{
  "type": "EmergencyRoot",
  "props": { "tier": "moderate", "carState": "parked" },
  "children": [
    { "type": "OfflineBanner", "props": { "title": "No signal", "detail": "Guidance still works offline" } },
    {
      "type": "SectionCard",
      "props": { "title": "Severity & guidance", "tier": "moderate" },
      "children": [
        { "type": "SeverityBanner", "props": { "tier": "moderate", "label": "Moderate", "context": "Catalog preview" } },
        { "type": "GuidanceCallout", "props": { "tier": "high", "kicker": "Do this now", "text": "Pull over and stop the car" } },
        { "type": "GuidanceText", "props": { "text": "Turn off the A/C and ease onto the shoulder.", "tier": "moderate" } },
        { "type": "Telemetry", "props": { "text": "37.7749, -122.4194 · ETA 6 MIN" } },
        { "type": "CountdownText", "props": { "secondsLeft": 8, "label": "Auto-call in" } }
      ]
    },
    {
      "type": "SectionCard",
      "props": { "title": "Panic actions", "tier": "critical" },
      "children": [
        { "type": "SOSCallButton", "props": { "emergencyNumber": "911", "callState": "idle" } },
        { "type": "ShareLocationAction", "props": { "isSharing": true, "recipients": ["Maya", "Dad"] } },
        {
          "type": "NotifyContactsAction",
          "props": {
            "contacts": [
              { "name": "Maya", "relation": "Sister", "status": "reached" },
              { "name": "Dad", "relation": "Emergency", "status": "sending" }
            ]
          }
        },
        { "type": "ImSafeCancel", "props": { "holdMs": 1200 } },
        { "type": "CountdownCard", "props": { "secondsLeft": 8, "totalSeconds": 15, "message": "Calling 911 automatically" } }
      ]
    },
    {
      "type": "SectionCard",
      "props": { "title": "Inputs", "tier": "neutral" },
      "children": [
        {
          "type": "ChoiceGrid",
          "props": { "columns": 4 },
          "children": [
            { "type": "BigChoiceCard", "props": { "label": "Crash", "icon": "crash" } },
            { "type": "BigChoiceCard", "props": { "label": "Medical", "icon": "medical", "selected": true } },
            { "type": "BigChoiceCard", "props": { "label": "Roadside", "icon": "roadside" } },
            { "type": "BigChoiceCard", "props": { "label": "Unsafe", "icon": "unsafe" } }
          ]
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
        {
          "type": "StepChecklist",
          "props": {
            "title": "Jump-start",
            "currentIndex": 1,
            "steps": [
              { "title": "Park both cars, engines off", "done": true },
              { "title": "Clamp red to positive terminal", "detail": "Do not let clamps touch.", "done": false }
            ]
          }
        },
        { "type": "PushToTalk", "props": { "state": "listening", "transcript": "I was in a crash" } }
      ]
    },
    {
      "type": "SectionCard",
      "props": { "title": "Status cards", "tier": "moderate" },
      "children": [
        {
          "type": "LocationCard",
          "props": {
            "address": "I-280 N, mile 42, Daly City",
            "coords": "37.7042, -122.4712",
            "accuracy": "±8m",
            "isSharing": true
          }
        },
        {
          "type": "ContactStatusList",
          "props": {
            "contacts": [
              { "name": "Maya", "relation": "Sister", "status": "reached", "reachedAt": "2m" },
              { "name": "Dad", "relation": "Emergency contact", "status": "sending" }
            ]
          }
        },
        {
          "type": "MedicalIdCard",
          "props": { "bloodType": "O+", "allergies": "Penicillin", "conditions": "Hypertension" }
        },
        {
          "type": "VehicleStatusCard",
          "props": {
            "metrics": [
              { "label": "Battery", "value": "Dead", "tier": "high" },
              { "label": "EV charge", "value": "18%", "tier": "moderate" }
            ],
            "profile": "2021 EV · roadside plan active"
          }
        }
      ]
    },
    {
      "type": "SectionCard",
      "props": { "title": "Spatial", "tier": "high" },
      "children": [
        {
          "type": "SafeRouteMap",
          "props": {
            "threatMode": true,
            "etaLabel": "4 min",
            "destinations": [
              { "type": "police", "name": "Daly City Police", "detail": "Open 24h", "distance": "1.2mi", "primary": true },
              { "type": "hospital", "name": "Seton Medical ER", "detail": "Emergency room", "distance": "3.4mi" }
            ]
          }
        },
        { "type": "ETACard", "props": { "provider": "AAA Roadside", "etaMinutes": 18, "progress": 0.35, "distance": "4.2 mi" } },
        {
          "type": "WeatherHazardCard",
          "props": {
            "condition": "Dense fog",
            "tier": "high",
            "advice": "Reduce speed · hazards on · stay in lane",
            "metrics": { "visibility": "200 ft", "temp": "48°F" },
            "cachedAt": "2m ago"
          }
        }
      ]
    },
    {
      "type": "SectionCard",
      "props": { "title": "Action stack", "tier": "high" },
      "children": [
        {
          "type": "ActionStack",
          "props": {
            "carState": "parked",
            "actions": [
              { "label": "Call 911", "icon": "call", "tier": "critical" },
              { "label": "Share location", "icon": "location" },
              { "label": "Drive to safety", "icon": "safe-route" }
            ]
          }
        }
      ]
    }
  ]
}
''';