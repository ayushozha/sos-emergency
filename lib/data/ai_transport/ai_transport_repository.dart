import 'package:sos_emergency/data/ai_transport/models/compose_request.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';

/// Transport boundary for screen composition — the fast REST endpoint
/// (`POST /v1/chat/stream`). Returns the complete A2UI surface; throws
/// [AiTransportException] on any transport/HTTP failure so the caller can
/// time-box and fall back to the deterministic baseline.
// ignore: one_member_abstracts
abstract interface class AiTransportRepository {
  Future<A2uiNode> compose(ComposeRequest request);
}

/// Raised when composition fails at the transport layer (non-200, bad JSON,
/// network error). Treated by the orchestrator as "AI unavailable".
class AiTransportException implements Exception {
  const AiTransportException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'AiTransportException($statusCode): $message';
}