import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/application/ai_composer.dart';
import 'package:sos_emergency/data/ai_transport/ai_transport_repository.dart';
import 'package:sos_emergency/data/ai_transport/http_ai_transport.dart';
import 'package:sos_emergency/domain/safety/safety_supervisor.dart';

part 'ai_orchestration.g.dart';

/// Base URL of the REST composition endpoint.
final Uri composeEndpoint = Uri.parse('https://api.sos.local/v1/chat/stream');

/// How long the orchestrator waits for AI enrichment before keeping the
/// deterministic baseline.
const Duration aiTimeBudget = Duration(seconds: 3);

@Riverpod(keepAlive: true)
http.Client httpClient(Ref ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return client;
}

@Riverpod(keepAlive: true)
AiTransportRepository aiTransport(Ref ref) =>
    HttpAiTransport(ref.watch(httpClientProvider), endpoint: composeEndpoint);

@Riverpod(keepAlive: true)
AiComposer aiComposer(Ref ref) => AiComposer(ref.watch(aiTransportProvider));

@Riverpod(keepAlive: true)
SafetySupervisor safetySupervisor(Ref ref) => const SafetySupervisor();

/// Master switch for the legacy bespoke AI enrichment path (the non-streaming
/// [HttpAiTransport] → [composeEndpoint]). Off by default: that endpoint is a
/// placeholder and the path predates the genui/backend transport, so leaving it
/// on makes every compose hit a dead host. The deterministic baseline (the
/// Phase 2 product) renders every scenario without it; voice-triggered GenUI
/// renders go through the separate genui transport. Re-enable once the composer
/// is re-targeted to the genui pipeline (Phase 5).
@Riverpod(keepAlive: true)
class AiEnabled extends _$AiEnabled {
  @override
  bool build() => false;

  void enable() => state = true;
  void disable() => state = false;
}
