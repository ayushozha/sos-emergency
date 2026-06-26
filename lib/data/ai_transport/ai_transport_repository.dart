import 'package:sos_emergency/domain/models/a2ui_node.dart';

/// Transport boundary for screen composition. The concrete impl targets a fast
/// REST endpoint (Phase 3); Phase 0 uses `MockTransport` with hand-authored
/// A2UI JSON. Domain code depends only on this interface.
// ignore: one_member_abstracts
abstract interface class AiTransportRepository {
  /// Returns the complete A2UI screen-JSON document as a parsed node tree.
  Future<A2uiNode> compose();
}
