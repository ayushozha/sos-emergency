/// Mic capture + TTS playback for non-web targets (stub until native impl).
abstract interface class VoiceAudioIo {
  Future<void> startMic(void Function(List<int> pcm16) onChunk);
  Future<void> stopMic();
  void playTtsPcm(List<int> bytes);
  Future<void> dispose();
}

class VoiceAudioIoImpl implements VoiceAudioIo {
  @override
  Future<void> dispose() async {}

  @override
  void playTtsPcm(List<int> bytes) {}

  @override
  Future<void> startMic(void Function(List<int> pcm16) onChunk) async {}

  @override
  Future<void> stopMic() async {}
}

VoiceAudioIo createVoiceAudioIo() => VoiceAudioIoImpl();
