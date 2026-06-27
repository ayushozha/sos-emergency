import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/genui/emergency_conversation.dart';

part 'voice_emergency_session.g.dart';

/// Backend base URL for GenUI transport and the voice agent socket.
const String kBackendBase = String.fromEnvironment(
  'BACKEND_BASE',
  defaultValue: 'http://localhost:8000',
);

Uri backendHttpBase() => Uri.parse(kBackendBase);

/// Optional model override for *voice-triggered* A2UI renders. Empty = use the
/// server default (the backend's configured Featherless model). Set a different
/// slug here only when you want voice renders on a model other than the
/// default, e.g.:
///   --dart-define=VOICE_RENDER_MODEL=Qwen/Qwen2.5-72B-Instruct
const String kVoiceRenderModel = String.fromEnvironment('VOICE_RENDER_MODEL');

Uri backendVoiceWsUri() {
  final http = backendHttpBase();
  final wsScheme = http.scheme == 'https' ? 'wss' : 'ws';
  return http.replace(scheme: wsScheme).resolve('/v1/voice/agent');
}

/// GenUI session used for voice-triggered A2UI renders (`render_emergency_ui`).
@Riverpod(keepAlive: true)
EmergencySession voiceEmergencySession(Ref ref) {
  final session = buildEmergencySession(backendBase: backendHttpBase());
  ref.onDispose(session.dispose);
  return session;
}
