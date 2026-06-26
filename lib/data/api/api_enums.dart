import 'package:json_annotation/json_annotation.dart';

/// Wire enums shared by the REST and WebSocket DTOs. These mirror the API
/// schema exactly (see docs/api/openapi.yaml & asyncapi.yaml); the transport
/// boundary maps them to/from the domain model.

enum ApiSeverity { neutral, moderate, high, critical }

enum ApiAppMode { triage, crash, medical, threat, roadside }

enum ApiConnectivity { online, degraded, offline }

enum ApiCarState { driving, parked }

enum ApiScenarioClass {
  crash,
  medical,
  beingFollowed,
  flatTire,
  wontStart,
  lockedOut,
  outOfGas,
  unsafeParked,
  unknown,
}

enum ApiHazard { smoke, fire, weather, lowVisibility }

enum ComposeFinishReason { complete, timeout, refused }

enum HealthStatus { ok, degraded, down }

enum AudioCodec { pcm16, opus }

enum VoiceIntent {
  carProblem,
  crash,
  medical,
  feelUnsafe,
  beingFollowed,
  lockedOut,
  roadside,
  outOfGas,
  document,
  none,
}

enum VoiceControlAction {
  mute,
  unmute,
  @JsonValue('barge_in')
  bargeIn,
  cancel,
}

enum VoiceEventName {
  @JsonValue('vad_start')
  vadStart,
  @JsonValue('vad_stop')
  vadStop,
  @JsonValue('barge_in')
  bargeIn,
  thinking,
}

enum TranscriptRole { user, agent }

enum SessionCloseReason {
  @JsonValue('client_request')
  clientRequest,
  timeout,
  completed,
  error,
}
