import 'package:sos_emergency/data/ai_transport/ai_transport_repository.dart';
import 'package:sos_emergency/data/ai_transport/models/compose_request.dart';
import 'package:sos_emergency/data/api/api_enums.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/domain/models/classification.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';

/// Bridges the domain to the REST composition transport: maps a
/// [Classification] + [EmergencyContext] into a [ComposeRequest], calls the
/// endpoint, and returns the proposed A2UI surface. Throws (via the transport)
/// on failure so the orchestrator can time-box and fall back.
class AiComposer {
  const AiComposer(this._transport, {this.catalogVersion = '2026.06.0'});

  final AiTransportRepository _transport;
  final String catalogVersion;

  Future<A2uiNode> compose(Classification clf, EmergencyContext ctx) {
    return _transport.compose(_request(clf, ctx));
  }

  ComposeRequest _request(Classification clf, EmergencyContext ctx) {
    return ComposeRequest(
      classification: ClassificationDto(
        scenario: ApiScenarioClass.values.byName(clf.scenario.name),
        severity: ApiSeverity.values.byName(clf.severity.name),
        mode: ApiAppMode.values.byName(clf.mode.name),
        confidence: clf.confidence,
        hazards: clf.hazards
            .map((h) => ApiHazard.values.byName(h.name))
            .toList(),
      ),
      context: ComposeContext(
        carState: ctx.vehicleState == VehicleState.driving
            ? ApiCarState.driving
            : ApiCarState.parked,
        connectivity: ApiConnectivity.values.byName(ctx.connectivity.name),
        isNight: ctx.isNight,
        locale: 'en-US',
        position: ctx.position == null
            ? null
            : ComposePosition(
                latitude: ctx.position!.latitude,
                longitude: ctx.position!.longitude,
                address: ctx.position!.address,
              ),
      ),
      catalogVersion: catalogVersion,
      stream: false,
    );
  }
}
