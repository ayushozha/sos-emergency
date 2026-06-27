import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/data/ai_transport/models/compose_request.dart';
import 'package:sos_emergency/data/ai_transport/models/compose_response.dart';
import 'package:sos_emergency/data/ai_transport/models/compose_stream_event.dart';
import 'package:sos_emergency/data/api/api_enums.dart';
import 'package:sos_emergency/data/voice_session/models/voice_client_frame.dart';
import 'package:sos_emergency/data/voice_session/models/voice_health.dart';
import 'package:sos_emergency/data/voice_session/models/voice_server_frame.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';

void main() {
  group('compose DTOs round-trip', () {
    test('ComposeRequest', () {
      const req = ComposeRequest(
        classification: ClassificationDto(
          scenario: ApiScenarioClass.beingFollowed,
          severity: ApiSeverity.high,
          mode: ApiAppMode.threat,
          confidence: 0.9,
          hazards: [ApiHazard.lowVisibility],
        ),
        context: ComposeContext(
          carState: ApiCarState.driving,
          connectivity: ApiConnectivity.online,
          isNight: true,
          locale: 'en-US',
          emergencyNumber: '911',
        ),
        catalogVersion: '2026.06.0',
      );
      expect(ComposeRequest.fromJson(req.toJson()), req);
      final classificationJson = req.toJson()['classification'] as Map;
      expect(classificationJson['scenario'], 'beingFollowed');
    });

    test('ComposeResponse with nested A2uiNode', () {
      const res = ComposeResponse(
        requestId: 'r1',
        surface: A2uiNode(type: 'EmergencyRoot'),
        finishReason: ComposeFinishReason.complete,
      );
      final round = ComposeResponse.fromJson(res.toJson());
      expect(round.surface.type, 'EmergencyRoot');
      expect(round.finishReason, ComposeFinishReason.complete);
    });

    test('ComposeStreamEvent union dispatches on type', () {
      final node = ComposeStreamEvent.fromJson({
        'type': 'node',
        'node': {'type': 'SeverityBanner'},
      });
      expect(node, isA<ComposeStreamNode>());

      final done = ComposeStreamEvent.fromJson({
        'type': 'done',
        'finishReason': 'timeout',
      });
      expect(done, isA<ComposeStreamDone>());
      expect(
        (done as ComposeStreamDone).finishReason,
        ComposeFinishReason.timeout,
      );
    });
  });

  group('voice DTOs round-trip', () {
    test('VoiceHealthResponse', () {
      final res = VoiceHealthResponse.fromJson({
        'status': 'degraded',
        'version': '1.4.2',
        'timestamp': '2026-06-26T17:04:22.000Z',
        'model': {'id': 'claude-opus-4-8', 'ready': true},
      });
      expect(res.status, HealthStatus.degraded);
      expect(res.model?.ready, isTrue);
    });

    test('VoiceClientFrame encodes dotted + snake-case wire values', () {
      const start = VoiceClientFrame.control(
        action: VoiceControlAction.bargeIn,
      );
      final json = start.toJson();
      expect(json['type'], 'control');
      expect(json['action'], 'barge_in');
    });

    test('VoiceServerFrame intent decodes and carries slots', () {
      final frame = VoiceServerFrame.fromJson({
        'type': 'intent',
        'intent': 'carProblem',
        'confidence': 0.91,
        'slots': {'hazard': 'smoke'},
      });
      expect(frame, isA<VoiceServerIntent>());
      final intent = frame as VoiceServerIntent;
      expect(intent.intent, VoiceIntent.carProblem);
      expect(intent.slots?['hazard'], 'smoke');
    });

    test('session.closed reason uses snake-case wire value', () {
      const frame = VoiceServerFrame.sessionClosed(
        reason: SessionCloseReason.clientRequest,
      );
      expect(frame.toJson()['reason'], 'client_request');
    });
  });
}
