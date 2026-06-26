import 'package:sos_emergency/data/ai_transport/ai_transport_repository.dart';
import 'package:sos_emergency/data/ai_transport/models/compose_request.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';

/// A test double for [AiTransportRepository]: returns a fixed [surface], throws
/// [error], and records the last request and call count.
class FakeAiTransport implements AiTransportRepository {
  FakeAiTransport({this.surface, this.error});

  final A2uiNode? surface;
  final Object? error;

  ComposeRequest? lastRequest;
  int calls = 0;

  @override
  Future<A2uiNode> compose(ComposeRequest request) async {
    calls++;
    lastRequest = request;
    // The error is supplied by the test; rethrow it verbatim.
    // ignore: only_throw_errors
    if (error != null) throw error!;
    return surface!;
  }
}
