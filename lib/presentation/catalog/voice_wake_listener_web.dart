import 'dart:async';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:sos_emergency/presentation/catalog/voice_wake_listener_stub.dart';
import 'package:web/web.dart' as web;

class VoiceWakeListener {
  VoiceWakeListener({
    required this.onWakePhrase,
    required this.onTranscript,
    required this.onError,
  });

  final VoiceTranscriptCallback onWakePhrase;
  final VoiceTranscriptCallback onTranscript;
  final VoiceErrorCallback onError;

  web.SpeechRecognition? _recognition;
  Timer? _restartTimer;
  bool _shouldListen = false;
  bool _running = false;

  bool get isSupported =>
      web.window.has('SpeechRecognition') ||
      web.window.has('webkitSpeechRecognition');

  void start() {
    if (!isSupported) return;
    _shouldListen = true;
    _restartTimer?.cancel();
    _recognition ??= _createRecognition();
    _startRecognition();
  }

  void stop() {
    _shouldListen = false;
    _restartTimer?.cancel();
    final recognition = _recognition;
    if (recognition == null) return;
    try {
      recognition.abort();
    } on Object {
      // Browser speech engines throw if abort races with their own end event.
    }
  }

  web.SpeechRecognition _createRecognition() {
    final recognition =
        (web.window.has('SpeechRecognition')
              ? web.SpeechRecognition()
              : (web.window['webkitSpeechRecognition'] as JSFunction)
                    .callAsConstructor<web.SpeechRecognition>())
          ..lang = 'en-US'
          ..continuous = true
          ..interimResults = true
          ..maxAlternatives = 1
          ..onstart = (() {
            _running = true;
          }).toJS
          ..onend = (() {
            _running = false;
            if (_shouldListen) {
              _restartTimer = Timer(
                const Duration(milliseconds: 500),
                _startRecognition,
              );
            }
          }).toJS
          ..onerror = ((web.Event event) {
            final error = event as web.SpeechRecognitionErrorEvent;
            if (error.error == 'not-allowed' ||
                error.error == 'service-not-allowed') {
              _shouldListen = false;
            }
            onError(error.message.isEmpty ? error.error : error.message);
          }).toJS
          ..onresult = ((web.Event event) {
            final speechEvent = event as web.SpeechRecognitionEvent;
            final results = speechEvent.results;
            for (var i = speechEvent.resultIndex; i < results.length; i++) {
              final result = results.item(i);
              if (result.length == 0) continue;
              final transcript = result.item(0).transcript.trim();
              if (transcript.isEmpty) continue;
              onTranscript(transcript);
              if (result.isFinal && _containsWakePhrase(transcript)) {
                onWakePhrase(transcript);
              }
            }
          }).toJS;
    return recognition;
  }

  void _startRecognition() {
    if (!_shouldListen || _running) return;
    try {
      _recognition?.start();
    } on Object catch (error) {
      onError(error.toString());
    }
  }

  bool _containsWakePhrase(String transcript) {
    final normalized = transcript.toLowerCase().replaceAll(',', '');
    return normalized.contains('hey emergency') ||
        normalized.contains('hay emergency');
  }
}
