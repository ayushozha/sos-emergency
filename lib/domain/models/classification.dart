import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/models/severity.dart';

part 'classification.freezed.dart';

/// The deterministic engine's verdict on an incident: what it is, how bad, and
/// which mode to render — with the confidence behind it.
@freezed
abstract class Classification with _$Classification {
  const factory Classification({
    required ScenarioClass scenario,
    required Severity severity,
    required AppMode mode,
    required double confidence,
    @Default(<Hazard>{}) Set<Hazard> hazards,
  }) = _Classification;
}
