import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/presentation/catalog/fallbacks.dart';
import 'package:sos_emergency/presentation/catalog/inputs.dart';
import 'package:sos_emergency/presentation/catalog/layout.dart';
import 'package:sos_emergency/presentation/catalog/panic.dart';
import 'package:sos_emergency/presentation/catalog/primitives.dart';
import 'package:sos_emergency/presentation/catalog/severity_banner.dart';
import 'package:sos_emergency/presentation/catalog/spatial.dart';
import 'package:sos_emergency/presentation/catalog/status.dart';

/// Signature every catalog component is registered under.
typedef CatalogBuilder =
    Widget Function(BuildContext context, WidgetRef ref, A2uiNode node);

/// The control surface over what the AI can ever produce: a static map from
/// component name → builder. **If a name isn't registered, it cannot render.**
///
/// This is the full MVP widget catalog (Phase 1). The names here are the AI's
/// vocabulary; their descriptions live in the catalog manifest.
final Map<String, CatalogBuilder> catalogRegistry = <String, CatalogBuilder>{
  // Layout primitives
  'SurfaceColumn': buildSurfaceColumn,
  'SurfaceRow': buildSurfaceRow,
  'Gap': buildGap,
  'SurfaceCard': buildSurfaceCard,
  'GuidanceText': buildGuidanceText,
  'Telemetry': buildTelemetry,
  'CountdownText': buildCountdownText,

  // Container · layout
  'EmergencyRoot': buildEmergencyRoot,
  'ActionStack': buildActionStack,
  'SectionCard': buildSectionCard,

  // Sticky global · panic
  'SOSCallButton': buildSosCallButton,
  'ShareLocationAction': buildShareLocationAction,
  'NotifyContactsAction': buildNotifyContactsAction,
  'ImSafeCancel': buildImSafeCancel,

  // Interactive inputs
  'BigChoiceCard': buildBigChoiceCard,
  'ChoiceGrid': buildChoiceGrid,
  'YesNoLarge': buildYesNoLarge,
  'StepChecklist': buildStepChecklist,
  'PushToTalk': buildPushToTalk,

  // Read-only status & guidance
  'SeverityBanner': buildSeverityBanner,
  'GuidanceCallout': buildGuidanceCallout,
  'LocationCard': buildLocationCard,
  'CountdownCard': buildCountdownCard,
  'ContactStatusList': buildContactStatusList,
  'VehicleStatusCard': buildVehicleStatusCard,

  // Visualization · spatial
  'SafeRouteMap': buildSafeRouteMap,
  'ETACard': buildEtaCard,
  'WeatherHazardCard': buildWeatherHazardCard,

  // Cross-cutting states
  'OfflineBanner': buildOfflineBanner,
};
