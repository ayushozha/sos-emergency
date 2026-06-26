import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';

void main() {
  group('A2uiNode.fromJson', () {
    test('parses a nested tree with props, bindings and children', () {
      const raw = '''
      {
        "type": "SurfaceColumn",
        "children": [
          {
            "type": "SeverityBanner",
            "props": { "tier": "high", "label": "High" }
          },
          {
            "type": "CountdownText",
            "props": { "label": "Calling in" },
            "bindings": { "seconds": "/demo/countdown" }
          }
        ]
      }
      ''';

      final node = A2uiNode.fromJson(jsonDecode(raw) as Map<String, dynamic>);

      expect(node.type, 'SurfaceColumn');
      expect(node.children, hasLength(2));

      final banner = node.children.first;
      expect(banner.type, 'SeverityBanner');
      expect(banner.props['tier'], 'high');
      expect(banner.props['label'], 'High');

      final countdown = node.children.last;
      expect(countdown.bindings['seconds'], '/demo/countdown');
      expect(countdown.children, isEmpty);
    });

    test('defaults props, bindings and children when absent', () {
      final node = A2uiNode.fromJson(const {'type': 'Gap'});

      expect(node.type, 'Gap');
      expect(node.props, isEmpty);
      expect(node.bindings, isEmpty);
      expect(node.children, isEmpty);
    });
  });
}
