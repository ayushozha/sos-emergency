import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/application/ai_composer.dart';
import 'package:sos_emergency/data/ai_transport/ai_transport_repository.dart';
import 'package:sos_emergency/data/ai_transport/http_ai_transport.dart';
import 'package:sos_emergency/domain/safety/safety_supervisor.dart';
import 'package:sos_emergency/shared/backend_config.dart';

part 'ai_orchestration.g.dart';

/// REST composition endpoint (`POST /v1/chat/stream`).
Uri composeEndpoint() => BackendConfig.baseUri.replace(
  path: '${BackendConfig.baseUri.path}/v1/chat/stream'.replaceAll('//', '/'),
);

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
AiTransportRepository aiTransport(Ref ref) => HttpAiTransport(
  ref.watch(httpClientProvider),
  endpoint: composeEndpoint(),
);

@Riverpod(keepAlive: true)
AiComposer aiComposer(Ref ref) => AiComposer(ref.watch(aiTransportProvider));

@Riverpod(keepAlive: true)
SafetySupervisor safetySupervisor(Ref ref) => const SafetySupervisor();

/// Master switch for AI enrichment. When off, the app runs the deterministic
/// baseline only (the Phase 2 product).
@Riverpod(keepAlive: true)
class AiEnabled extends _$AiEnabled {
  @override
  bool build() => true;

  void enable() => state = true;
  void disable() => state = false;
}