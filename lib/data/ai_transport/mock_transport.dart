import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/data/ai_transport/ai_transport_repository.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/domain/models/classification.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';
import 'package:sos_emergency/domain/orchestrator/deterministic_composer.dart';

part 'mock_transport.g.dart';

/// Offline transport: returns the deterministic composer surface root.
@Riverpod(keepAlive: true)
AiTransportRepository mockAiTransportRepository(Ref ref) =>
    _MockAiTransportRepository(const DeterministicComposer());

class _MockAiTransportRepository implements AiTransportRepository {
  _MockAiTransportRepository(this._composer);

  final DeterministicComposer _composer;

  @override
  Future<A2uiNode> compose({
    required Classification classification,
    required EmergencyContext context,
    bool stream = false,
  }) async {
    return _composer.compose(classification, context).root;
  }
}

/// Hand-authored demo surface for renderer smoke tests.
const String demoSurfaceJson = '''
{
  "type": "SurfaceColumn",
  "children": [
    {
      "type": "SeverityBanner",
      "props": { "tier": "high", "label": "High", "context": "Act soon" }
    }
  ]
}
''';

A2uiNode demoSurface() =>
    A2uiNode.fromJson(jsonDecode(demoSurfaceJson) as Map<String, dynamic>);