import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/data/ai_transport/ai_transport_repository.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';

part 'mock_transport.g.dart';

/// Hand-authored A2UI layout used to de-risk the renderer before any real
/// catalog or AI exists. Demonstrates a tier banner, scream guidance, mono
/// telemetry, and a live data binding (`/demo/countdown`).
const String _demoSurfaceJson = '''
{
  "type": "SurfaceColumn",
  "children": [
    {
      "type": "SeverityBanner",
      "props": { "tier": "high", "label": "High", "context": "Act soon" }
    },
    {
      "type": "SurfaceCard",
      "children": [
        {
          "type": "GuidanceText",
          "props": {
            "kicker": "Do this now",
            "text": "Turn off the A/C and ease onto the shoulder"
          }
        },
        {
          "type": "Telemetry",
          "props": { "text": "37.7749, -122.4194 · ETA 6 MIN" }
        },
        {
          "type": "CountdownText",
          "props": { "label": "Auto-calling 911 in" },
          "bindings": { "seconds": "/demo/countdown" }
        }
      ]
    }
  ]
}
''';

/// Emits a hand-authored A2UI document. Stands in for the real transport.
class MockTransport implements AiTransportRepository {
  const MockTransport();

  @override
  Future<A2uiNode> compose() async {
    final json = jsonDecode(_demoSurfaceJson) as Map<String, dynamic>;
    return A2uiNode.fromJson(json);
  }
}

@riverpod
AiTransportRepository aiTransport(Ref ref) => const MockTransport();

/// Loads the composed surface once. The renderer mounts this.
@riverpod
Future<A2uiNode> composedSurface(Ref ref) {
  return ref.watch(aiTransportProvider).compose();
}
