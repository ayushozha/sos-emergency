import 'dart:convert';

import 'package:genui/genui.dart';
import 'package:http/http.dart' as http;
import 'package:sos_emergency/genui/emergency_catalog.dart';

/// The client catalog version sent to the backend for observability. Bump when
/// the catalog's component set or schemas change.
const String kCatalogVersion = '2026.06.0';

/// Persona fragment appended to genui's generated A2UI instructions.
const String _personaFragment =
    'You are an in-car emergency assistant. Compose the calmest, safest '
    'surface for the situation. Prefer one dominant action at a time. Never '
    'invent components outside the catalog.';

/// A live genui session: the [Conversation] to drive and the
/// [SurfaceController] whose surfaces the UI renders.
class EmergencySession {
  EmergencySession({
    required this.conversation,
    required this.controller,
    required this.transport,
    required this.systemPrompt,
  });

  final Conversation conversation;
  final SurfaceController controller;
  final A2uiTransportAdapter transport;

  /// The catalog-derived system prompt. Send this on the Deepgram voice WS
  /// initial `{"system": ...}` frame so voice-triggered renders use the same
  /// catalog and protocol as the text path.
  final String systemPrompt;

  /// Feeds one raw A2UI text delta from the Deepgram voice agent's render
  /// side-channel into the **same** surface pipeline the text path uses. The
  /// voice WS streams `{"render_start"}`, then `{"delta": ...}` × N, then
  /// `{"done": true}`; call this for each delta so voice- and text-triggered
  /// surfaces render identically.
  void ingestVoiceDelta(String delta) => transport.addChunk(delta);

  void dispose() => conversation.dispose();
}

/// Builds a genui [EmergencySession] wired to the Python FastAPI backend.
///
/// The catalog and system prompt are built **here on the client** — the backend
/// is a content-agnostic byte relay. The [A2uiTransportAdapter.onSend] callback
/// POSTs `{system, messages, catalogVersion}` to `/v1/chat/stream` and feeds the
/// streamed NDJSON `{"delta": ...}` chunks back into the adapter, which parses
/// them into surface commands.
EmergencySession buildEmergencySession({
  required Uri backendBase,
  http.Client? httpClient,
}) {
  final client = httpClient ?? http.Client();
  final catalog = buildEmergencyCatalog();
  final controller = SurfaceController(catalogs: [catalog]);

  final promptBuilder = PromptBuilder.chat(
    catalog: catalog,
    systemPromptFragments: [
      _personaFragment,
    ],
  );
  final systemPrompt = promptBuilder.systemPromptJoined();

  // Conversation history sent to the backend on every turn, oldest first.
  final history = <Map<String, String>>[];

  late final A2uiTransportAdapter adapter;
  adapter = A2uiTransportAdapter(
    onSend: (message) async {
      history.add({'role': 'user', 'text': _textOf(message)});

      final request =
          http.Request('POST', backendBase.resolve('/v1/chat/stream'))
            ..headers['Content-Type'] = 'application/json'
            ..body = jsonEncode({
              'system': systemPrompt,
              'messages': history,
              'catalogVersion': kCatalogVersion,
            });

      final response = await client.send(request);
      if (response.statusCode >= 400) {
        throw Exception('Backend error ${response.statusCode}');
      }

      // Reassemble the model turn so the next request carries full context.
      final modelTurn = StringBuffer();
      await for (final line
          in response.stream
              .transform(utf8.decoder)
              .transform(const LineSplitter())) {
        if (line.trim().isEmpty) continue;
        final obj = jsonDecode(line) as Map<String, Object?>;
        final delta = obj['delta'];
        if (delta is String) {
          modelTurn.write(delta);
          adapter.addChunk(delta);
        }
        if (obj['error'] != null) {
          throw Exception(obj['error']);
        }
        if (obj['done'] == true) break;
      }
      history.add({'role': 'model', 'text': modelTurn.toString()});
    },
  );

  final conversation = Conversation(controller: controller, transport: adapter);
  return EmergencySession(
    conversation: conversation,
    controller: controller,
    transport: adapter,
    systemPrompt: systemPrompt,
  );
}

/// Flattens a genui [ChatMessage] to plain text for the backend's
/// `{role, text}` shape (the only thing the transport proxy understands).
String _textOf(ChatMessage message) =>
    message.parts.whereType<TextPart>().map((p) => p.text).join('\n');
