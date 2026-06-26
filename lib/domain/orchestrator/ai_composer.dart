import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/data/ai_transport/ai_transport_repository.dart';
import 'package:sos_emergency/data/ai_transport/http_ai_transport.dart';
import 'package:sos_emergency/data/ai_transport/mock_transport.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/domain/models/classification.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';
import 'package:sos_emergency/shared/backend_config.dart';

part 'ai_composer.g.dart';

@Riverpod(keepAlive: true)
bool useBackendCompose(Ref ref) =>
    BackendConfig.isConfigured && BackendConfig.useBackend;

@Riverpod(keepAlive: true)
AiTransportRepository activeAiTransport(Ref ref) {
  if (ref.watch(useBackendComposeProvider)) {
    return ref.watch(aiTransportRepositoryProvider);
  }
  return ref.watch(mockAiTransportRepositoryProvider);
}

/// Calls the compose API (or mock) and returns an A2UI root node.
@Riverpod(keepAlive: true)
class AiComposer extends _$AiComposer {
  @override
  FutureOr<void> build() {}

  Future<A2uiNode?> tryCompose(
    Classification classification,
    EmergencyContext context,
  ) async {
    try {
      return await ref
          .read(activeAiTransportProvider)
          .compose(classification: classification, context: context);
    } on AiTransportException {
      return null;
    } catch (_) {
      return null;
    }
  }
}