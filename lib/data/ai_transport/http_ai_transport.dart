import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/data/ai_transport/ai_transport_repository.dart';
import 'package:sos_emergency/data/api/compose_api.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/domain/models/classification.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';
import 'package:sos_emergency/shared/backend_config.dart';

part 'http_ai_transport.g.dart';

class HttpAiTransportRepository implements AiTransportRepository {
  HttpAiTransportRepository({http.Client? client, Uri? baseUri})
    : _client = client ?? http.Client(),
      _base = baseUri ?? BackendConfig.baseUri;

  final http.Client _client;
  final Uri _base;

  @override
  Future<A2uiNode> compose({
    required Classification classification,
    required EmergencyContext context,
    bool stream = false,
  }) async {
    final uri = _base.replace(path: '${_base.path}/v1/chat/stream');
    final body = composeRequestBody(
      classification: classification,
      context: context,
      stream: stream,
    );

    final response = await _client
        .post(
          uri,
          headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 8));

    if (response.statusCode >= 400) {
      throw AiTransportException(
        'Compose failed: HTTP ${response.statusCode}',
      );
    }

    if (stream) {
      return _parseSseSurface(response.body);
    }
    return parseSurfaceFromComposeResponse(response.body);
  }

  A2uiNode _parseSseSurface(String raw) {
    A2uiNode? root;
    final childrenByParent = <String, List<A2uiNode>>{};
    final ids = <A2uiNode, String>{};

    for (final line in const LineSplitter().convert(raw)) {
      if (!line.startsWith('data:')) continue;
      final payload = line.substring(5).trim();
      if (payload.isEmpty) continue;
      final json = jsonDecode(payload) as Map<String, dynamic>;
      if (json['type'] == 'error') {
        throw AiTransportException(json['message']?.toString() ?? 'compose error');
      }
      if (json['type'] != 'node') continue;
      final node = A2uiNode.fromJson(json['node'] as Map<String, dynamic>);
      final parentId = json['parentId'] as String?;
      final nodeId = node.props['id']?.toString() ?? node.type;
      ids[node] = nodeId;
      if (parentId == null) {
        root = node;
      } else {
        childrenByParent.putIfAbsent(parentId, () => []).add(node);
      }
    }

    if (root == null) {
      throw AiTransportException('SSE stream contained no root node');
    }
    return root;
  }
}

@Riverpod(keepAlive: true)
AiTransportRepository aiTransportRepository(Ref ref) {
  if (!BackendConfig.isConfigured) {
    throw StateError('BACKEND_URL is not configured');
  }
  return HttpAiTransportRepository();
}