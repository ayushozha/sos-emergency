import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:sos_emergency/data/ai_transport/ai_transport_repository.dart';
import 'package:sos_emergency/data/ai_transport/http_ai_transport.dart';
import 'package:sos_emergency/data/ai_transport/models/compose_request.dart';
import 'package:sos_emergency/data/api/api_enums.dart';

final Uri _endpoint = Uri.parse('https://api.sos.local/v1/chat/stream');

const _request = ComposeRequest(
  classification: ClassificationDto(
    scenario: ApiScenarioClass.crash,
    severity: ApiSeverity.critical,
    mode: ApiAppMode.crash,
    confidence: 0.99,
  ),
  context: ComposeContext(
    carState: ApiCarState.parked,
    connectivity: ApiConnectivity.online,
    isNight: false,
    locale: 'en-US',
  ),
  catalogVersion: '2026.06.0',
);

void main() {
  test(
    'parses the surface from a 200 response and sends stream:false',
    () async {
      late String sentBody;
      final client = MockClient((req) async {
        sentBody = req.body;
        return http.Response(
          jsonEncode({
            'requestId': 'r1',
            'surface': {
              'type': 'EmergencyRoot',
              'children': [
                {'type': 'SeverityBanner'},
              ],
            },
            'finishReason': 'complete',
          }),
          200,
        );
      });

      final transport = HttpAiTransport(client, endpoint: _endpoint);
      final surface = await transport.compose(_request);

      expect(surface.type, 'EmergencyRoot');
      expect((jsonDecode(sentBody) as Map)['stream'], false);
    },
  );

  test('throws on a non-200 response', () async {
    final client = MockClient((_) async => http.Response('nope', 503));
    final transport = HttpAiTransport(client, endpoint: _endpoint);
    expect(
      () => transport.compose(_request),
      throwsA(
        isA<AiTransportException>().having((e) => e.statusCode, 'status', 503),
      ),
    );
  });

  test('throws on an unparseable body', () async {
    final client = MockClient((_) async => http.Response('not json', 200));
    final transport = HttpAiTransport(client, endpoint: _endpoint);
    expect(
      () => transport.compose(_request),
      throwsA(isA<AiTransportException>()),
    );
  });
}
