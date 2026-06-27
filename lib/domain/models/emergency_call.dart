import 'package:freezed_annotation/freezed_annotation.dart';

part 'emergency_call.freezed.dart';

/// Lifecycle of an emergency call. Auto-escalation never silently dials: it
/// passes through a visible, cancelable [countdown] first.
enum CallPhase { idle, countdown, connecting, active, ended }

/// The current emergency-call state held by the call controller.
@freezed
abstract class EmergencyCallState with _$EmergencyCallState {
  const factory EmergencyCallState({
    required CallPhase phase,
    required String number,
    @Default(0) int secondsLeft,
  }) = _EmergencyCallState;

  const EmergencyCallState._();

  factory EmergencyCallState.idle(String number) =>
      EmergencyCallState(phase: CallPhase.idle, number: number);

  bool get isCounting => phase == CallPhase.countdown;
  bool get isLive => phase == CallPhase.connecting || phase == CallPhase.active;
}
