import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/models/severity.dart';

part 'surface.freezed.dart';

/// What the renderer consumes: a validated layout [root] (an `EmergencyRoot`
/// tree of catalog components) tagged with the [mode] and [severity] it was
/// composed for.
///
/// In Phase 2 every Surface is deterministic ([isFallback] is true — there is
/// no AI yet). Phase 3 adds AI-composed surfaces and a Safety Supervisor.
@freezed
abstract class Surface with _$Surface {
  const factory Surface({
    required AppMode mode,
    required Severity severity,
    required A2uiNode root,
    @Default(true) bool isFallback,
  }) = _Surface;
}
