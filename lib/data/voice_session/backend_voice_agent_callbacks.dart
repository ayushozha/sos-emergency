/// Hooks for side effects while streaming from `WS /v1/voice/agent`.
///
/// The typed voice frame stream covers transcripts and status; A2UI and
/// TTS are handled here because they use a different wire shape (NDJSON deltas
/// and raw PCM binary).
abstract interface class BackendVoiceAgentCallbacks {
  void onRenderStart(Map<String, Object?> info);
  void onA2uiDelta(String delta);
  void onRenderDone();
  void onTtsAudio(List<int> pcm16);
  void onCallEmergency();
}

/// No-op callbacks — used in tests and when only transcripts matter.
class NoOpBackendVoiceAgentCallbacks implements BackendVoiceAgentCallbacks {
  const NoOpBackendVoiceAgentCallbacks();

  @override
  void onA2uiDelta(String delta) {}

  @override
  void onRenderDone() {}

  @override
  void onRenderStart(Map<String, Object?> info) {}

  @override
  void onTtsAudio(List<int> pcm16) {}

  @override
  void onCallEmergency() {}
}
