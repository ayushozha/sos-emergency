import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sos_emergency/data/ai_transport/ai_transport_repository.dart';
import 'package:sos_emergency/data/ai_transport/models/compose_request.dart';
import 'package:sos_emergency/data/ai_transport/models/compose_response.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';

/// Posts a [ComposeRequest] to the fast REST composition endpoint and parses
/// the complete A2UI surface from the response. The non-streaming form is used
/// (`stream:false`) so the call is a single idempotent request/response.
class HttpAiTransport implements AiTransportRepository {
  HttpAiTransport(this._client, {required this.endpoint});

  final http.Client _client;
  final Uri endpoint;

  @override
  Future<A2uiNode> compose(ComposeRequest request) async {
    final http.Response response;
    try {
      response = await _client.post(
        endpoint,
        headers: const {'content-type': 'application/json'},
        body: jsonEncode(request.copyWith(stream: false).toJson()),
      );
    } on Exception catch (e) {
      throw AiTransportException('network error: $e');
    }

    if (response.statusCode != 200) {
      throw AiTransportException(
        'compose failed',
        statusCode: response.statusCode,
      );
    }

    try {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return ComposeResponse.fromJson(json).surface;
    } on Exception catch (e) {
      throw AiTransportException('invalid response body: $e');
    }
  }
}
