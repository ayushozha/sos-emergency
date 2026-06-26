import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/presentation/catalog/primitives.dart';
import 'package:sos_emergency/presentation/catalog/severity_banner.dart';

/// Signature every catalog component is registered under.
typedef CatalogBuilder =
    Widget Function(BuildContext context, WidgetRef ref, A2uiNode node);

/// The control surface over what the AI can ever produce: a static map from
/// component name → builder. **If a name isn't registered, it cannot render.**
///
/// Phase 0 registers the layout primitives and a first read-only component
/// needed to prove the rendering pipeline. The full catalog lands in Phase 1.
final Map<String, CatalogBuilder> catalogRegistry = <String, CatalogBuilder>{
  // Layout primitives
  'SurfaceColumn': buildSurfaceColumn,
  'SurfaceRow': buildSurfaceRow,
  'Gap': buildGap,
  'SurfaceCard': buildSurfaceCard,
  // Text / status
  'GuidanceText': buildGuidanceText,
  'Telemetry': buildTelemetry,
  'CountdownText': buildCountdownText,
  'SeverityBanner': buildSeverityBanner,
};
