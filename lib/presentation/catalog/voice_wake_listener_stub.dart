typedef VoiceTranscriptCallback = void Function(String transcript);
typedef VoiceErrorCallback = void Function(String message);

class VoiceWakeListener {
  VoiceWakeListener({
    required this.onWakePhrase,
    required this.onTranscript,
    required this.onError,
  });

  final VoiceTranscriptCallback onWakePhrase;
  final VoiceTranscriptCallback onTranscript;
  final VoiceErrorCallback onError;

  bool get isSupported => false;

  void start() {}

  void stop() {}
}
