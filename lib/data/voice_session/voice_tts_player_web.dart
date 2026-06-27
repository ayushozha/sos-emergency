import 'dart:convert';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart' as web;

/// Plays backend `audio.chunk` frames (PCM16 @ 24 kHz, optional WAV header).
class VoiceTtsPlayer {
  web.HTMLAudioElement? _unlockElement;

  /// Call from a user gesture so Chrome allows subsequent TTS playback.
  Future<void> ensureResumed() async {
    _unlockElement ??= web.HTMLAudioElement();
    try {
      await _unlockElement!.play().toDart;
    } on Object {
      // Blocked until a real user gesture — play() on TTS chunks may still work.
    }
  }

  void reset() {}

  Future<void> playBase64Pcm16(String audio, {int sampleRate = 24000}) async {
    var bytes = base64Decode(audio);
    if (_isWav(bytes)) {
      bytes = bytes.sublist(44);
    }
    if (bytes.isEmpty) return;

    final wav = _pcmToWav(bytes, sampleRate);
    final blob = web.Blob(
      [wav.toJS].toJS as JSArray<web.BlobPart>,
      web.BlobPropertyBag(type: 'audio/wav'),
    );
    final url = web.URL.createObjectURL(blob);
    final element = web.HTMLAudioElement();
    element.src = url;
    element.onended = ((web.Event _) {
      web.URL.revokeObjectURL(url);
    }).toJS;
    try {
      await element.play().toDart;
    } on Object {
      // Autoplay policy — user must click the page first.
    }
  }

  bool _isWav(Uint8List bytes) =>
      bytes.length > 44 &&
      bytes[0] == 0x52 &&
      bytes[1] == 0x49 &&
      bytes[2] == 0x46 &&
      bytes[3] == 0x46;

  Uint8List _pcmToWav(Uint8List pcm, int sampleRate) {
    final dataSize = pcm.length;
    final header = ByteData(44);
    header.setUint8(0, 0x52); // RIFF
    header.setUint8(1, 0x49);
    header.setUint8(2, 0x46);
    header.setUint8(3, 0x46);
    header.setUint32(4, 36 + dataSize, Endian.little);
    header.setUint8(8, 0x57); // WAVE
    header.setUint8(9, 0x41);
    header.setUint8(10, 0x56);
    header.setUint8(11, 0x45);
    header.setUint8(12, 0x66); // fmt
    header.setUint8(13, 0x6d);
    header.setUint8(14, 0x74);
    header.setUint8(15, 0x20);
    header.setUint32(16, 16, Endian.little);
    header.setUint16(20, 1, Endian.little); // PCM
    header.setUint16(22, 1, Endian.little); // mono
    header.setUint32(24, sampleRate, Endian.little);
    header.setUint32(28, sampleRate * 2, Endian.little);
    header.setUint16(32, 2, Endian.little);
    header.setUint16(34, 16, Endian.little);
    header.setUint8(36, 0x64); // data
    header.setUint8(37, 0x61);
    header.setUint8(38, 0x74);
    header.setUint8(39, 0x61);
    header.setUint32(40, dataSize, Endian.little);
    return Uint8List.fromList([...header.buffer.asUint8List(), ...pcm]);
  }
}