import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';

part 'emergency_context.freezed.dart';

/// A GPS fix with an optional resolved address.
@freezed
abstract class GeoPosition with _$GeoPosition {
  const factory GeoPosition({
    required double latitude,
    required double longitude,
    String? address,
    String? detail,
    double? accuracyMeters,
  }) = _GeoPosition;
}

/// A snapshot of vehicle-bus / OBD-II signals. All fields are optional because
/// availability degrades (e.g. in projection mode).
@freezed
abstract class VehicleBusSnapshot with _$VehicleBusSnapshot {
  const factory VehicleBusSnapshot({
    @Default(false) bool airbagDeployed,
    @Default(false) bool engineCranksNoStart,
    @Default(false) bool tirePressureLow,
    @Default(false) bool doorsLocked,
    int? fuelPercent,
    int? evChargePercent,
    String? profile,
  }) = _VehicleBusSnapshot;
}

/// A discrete user signal — a tap, a voice utterance, or a code word — carrying
/// the intent it expresses.
@freezed
abstract class UserSignal with _$UserSignal {
  const factory UserSignal({required UserIntent intent, String? note}) =
      _UserSignal;
}

/// The fused situational snapshot the decision engine consumes. Built by the
/// context aggregator from every signal source.
@freezed
abstract class EmergencyContext with _$EmergencyContext {
  const factory EmergencyContext({
    required VehicleState vehicleState,
    required double speedMps,
    required Connectivity connectivity,
    required bool isNight,
    required DateTime timestamp,
    @Default(false) bool crashImpulseDetected,
    GeoPosition? position,
    VehicleBusSnapshot? bus,
    @Default(<UserSignal>[]) List<UserSignal> userSignals,
    @Default(<Hazard>{}) Set<Hazard> hazards,
  }) = _EmergencyContext;
  const EmergencyContext._();

  /// The most recent explicit intent, if any.
  UserIntent get latestIntent =>
      userSignals.isEmpty ? UserIntent.none : userSignals.last.intent;
}
