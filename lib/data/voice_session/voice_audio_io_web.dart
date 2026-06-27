import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart' as web;

/// Mic capture + gapless TTS playback for Flutter web (Chrome harness parity).
abstract interface class VoiceAudioIo {
  /// Starts the mic; [onChunk] receives raw linear16 PCM **bytes** (16 kHz,
  /// mono, little-endian, 2 bytes/sample) ready to send over the wire.
  Future<void> startMic(void Function(List<int> pcm16) onChunk);
  Future<void> stopMic();
  void playTtsPcm(List<int> bytes);
  Future<void> dispose();
}

class VoiceAudioIoImpl implements VoiceAudioIo {
  static const int _micRate = 16000;
  static const int _ttsRate = 24000;

  web.MediaStream? _stream;
  web.AudioContext? _micCtx;
  web.ScriptProcessorNode? _processor;
  web.MediaStreamAudioSourceNode? _source;
  web.AudioContext? _outCtx;
  double _playhead = 0;
  void Function(List<int> pcm16)? _onChunk;

  @override
  Future<void> startMic(void Function(List<int> pcm16) onChunk) async {
    _onChunk = onChunk;
    final devices = web.window.navigator.mediaDevices;

    _stream = await devices
        .getUserMedia(
          web.MediaStreamConstraints(audio: web.MediaTrackConstraints()),
        )
        .toDart;

    _micCtx = web.AudioContext();
    _outCtx ??= web.AudioContext();
    _playhead = 0;

    _source = _micCtx!.createMediaStreamSource(_stream!);
    _processor = _micCtx!.createScriptProcessor(4096, 1, 1);
    _processor!.onaudioprocess = ((web.Event event) {
      final ev = event as web.AudioProcessingEvent;
      final input = ev.inputBuffer.getChannelData(0).toDart;
      final ds = _downsample(input, _micCtx!.sampleRate.toInt(), _micRate);
      // Pack to linear16, then hand off the *raw little-endian PCM bytes*
      // (2 bytes/sample). Emitting a List<int> of sample values would let the
      // WebSocket sink truncate each sample to a single byte, corrupting the
      // stream so Deepgram never detects speech.
      final i16 = Int16List(ds.length);
      for (var i = 0; i < ds.length; i++) {
        final sample = ds[i].clamp(-1.0, 1.0);
        i16[i] = (sample * 0x7fff).round();
      }
      _onChunk?.call(i16.buffer.asUint8List());
    }).toJS;

    _source!.connect(_processor!);
    _processor!.connect(_micCtx!.destination);
  }

  @override
  Future<void> stopMic() async {
    _processor?.disconnect();
    _source?.disconnect();
    _stream?.getTracks().toDart.forEach((t) => t.stop());
    _micCtx?.close();
    _processor = null;
    _source = null;
    _stream = null;
    _micCtx = null;
    _onChunk = null;
  }

  @override
  void playTtsPcm(List<int> bytes) {
    final ctx = _outCtx;
    if (ctx == null || bytes.isEmpty) return;

    var pcm = bytes;
    if (pcm.length > 44 &&
        pcm[0] == 0x52 &&
        pcm[1] == 0x49 &&
        pcm[2] == 0x46 &&
        pcm[3] == 0x46) {
      pcm = pcm.sublist(44);
    }
    final even = pcm.length & ~1;
    final i16 = Int16List.view(Uint8List.fromList(pcm.sublist(0, even)).buffer);
    final f32 = Float32List(i16.length);
    for (var i = 0; i < i16.length; i++) {
      f32[i] = i16[i] / 0x8000;
    }

    final buf = ctx.createBuffer(1, f32.length, _ttsRate)
      ..copyToChannel(f32.toJS, 0);
    final src = ctx.createBufferSource()
      ..buffer = buf
      ..connect(ctx.destination);

    final now = ctx.currentTime;
    if (_playhead < now) _playhead = now + 0.04;
    src.start(_playhead);
    _playhead += buf.duration;
  }

  @override
  Future<void> dispose() async {
    await stopMic();
    _outCtx?.close();
    _outCtx = null;
    _playhead = 0;
  }

  static Float32List _downsample(Float32List input, int inRate, int outRate) {
    if (inRate == outRate) return input;
    final ratio = inRate / outRate;
    final out = Float32List((input.length / ratio).round());
    for (var i = 0; i < out.length; i++) {
      final idx = i * ratio;
      final i0 = idx.floor();
      final i1 = (i0 + 1).clamp(0, input.length - 1);
      final frac = idx - i0;
      out[i] = input[i0] * (1 - frac) + input[i1] * frac;
    }
    return out;
  }
}

VoiceAudioIo createVoiceAudioIo() => VoiceAudioIoImpl();
