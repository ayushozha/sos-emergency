/// No-op TTS playback on platforms without Web Audio.
class VoiceTtsPlayer {
  void reset() {}

  Future<void> ensureResumed() async {}

  Future<void> playBase64Pcm16(String audio, {int sampleRate = 24000}) async {}
}