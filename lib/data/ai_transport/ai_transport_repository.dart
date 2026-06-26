import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/domain/models/classification.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';

/// Thrown when the compose transport fails or returns an invalid surface.
class AiTransportException implements Exception {
  AiTransportException(this.message);
  final String message;

  @override
  String toString() => 'AiTransportException: $message';
}

/// Transport boundary for screen composition (PDF `POST /v1/chat/stream`).
abstract interface class AiTransportRepository {
  Future<A2uiNode> compose({
    required Classification classification,
    required EmergencyContext context,
    bool stream = false,
  });
}