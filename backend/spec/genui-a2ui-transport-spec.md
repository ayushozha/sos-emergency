# GenUI A2UI Transport — Integration Guide (v0.2)

How to adopt the official **Flutter GenUI SDK** (`genui`) for the emergency
surface while keeping **Python (FastAPI) as the model transport**. The catalog,
component schemas, and system prompt live client-side in Dart; the backend is a
thin, content-agnostic streaming proxy in front of Featherless.

This is a build guide, not a proposal. Follow the phases in order.

## Design decisions (settled — do not relitigate)

1. **genui's only seam is `A2uiTransportAdapter(onSend:)`.** We implement
   `onSend` to POST to our existing `/v1/chat/stream`. No Firebase AI, no Vertex.
2. **The catalog and prompt are built client-side.** The backend never sees a
   `CatalogItem` and never builds a prompt. `PromptBuilder` (Dart) serializes the
   catalog + A2UI protocol into the `system` string; the backend just relays it.
3. **The backend is a byte relay.** It forwards `{system, messages}` to the model
   and streams raw text deltas back. It does not parse, validate, or understand
   A2UI. All parsing happens in `A2uiTransportAdapter` on the client.
4. **System prompt is sent per request** in the body (not a one-time frame).
   `/v1/chat/stream` already accepts `system` on every call.
5. **Reuse `/v1/chat/stream` as-is.** It is already a genui-compatible transport.
   The voice agent's A2UI side-channel uses the same contract — one transport
   serves both.

## End-to-end flow

```
┌─ Flutter (genui SDK) ───────────────────────┐    ┌─ FastAPI backend ─┐    ┌─ Model ─┐
│ Catalog: [CatalogItem(name, dataSchema,      │    │ /v1/chat/stream    │    │         │
│           widgetBuilder), ...]               │    │ (thin proxy)       │    │         │
│ PromptBuilder.chat(catalog:)                 │    │                    │    │         │
│   → systemPromptJoined()                     │    │                    │    │         │
│ A2uiTransportAdapter(onSend:) ──POST {system,messages}──▶ stream_deltas ────▶│  ...    │
│ SurfaceController / Surface  ◀──NDJSON {"delta"}─────────  re-emit text  ◀───│         │
└──────────────────────────────────────────────┘    └────────────────────┘    └─────────┘
```

---

## Phase 0 — Confirm the SDK surface (do first)

The `genui` package is alpha (`^0.9.2` pinned). Before porting, confirm these
symbols exist in the resolved version and adjust names if they drifted:

```bash
cd /Users/pramodthebe/Desktop/sos-emergency
grep -rE "class (SurfaceController|A2uiTransportAdapter|Conversation|PromptBuilder|CatalogItem|Surface)\b" \
  $(dart pub cache path 2>/dev/null || echo ~/.pub-cache)/hosted/pub.dev/genui-0.9.2/lib
```

Expected API (from the GenUI docs): `SurfaceController(catalogs:)`,
`A2uiTransportAdapter(onSend:)`, `PromptBuilder.chat(catalog:, systemPromptFragments:)`,
`promptBuilder.systemPromptJoined()`, `Conversation(controller:, transport:)`,
`Surface(surfaceContext:)`, `CatalogItem(name:, dataSchema:, widgetBuilder:)`,
`S.object(...)` from `json_schema_builder`.

---

## Phase 1 — Backend: pass through `catalogVersion` (the only server change)

The proxy already does the transport. The one addition is logging which client
catalog version is calling, for observability when the catalog evolves.

**`app/schemas.py`** — add one optional field:

```python
class ChatRequest(BaseModel):
    system: str
    messages: list[Message] = Field(default_factory=list)
    model: str | None = None
    # Client catalog version (e.g. "2026.06.0"). Logged for observability;
    # the backend stays catalog-agnostic and does not act on it.
    catalog_version: str | None = Field(default=None, alias="catalogVersion")
```

**`app/main.py`** — log it at the top of `chat_stream`, before streaming:

```python
@app.post("/v1/chat/stream")
async def chat_stream(req: ChatRequest, request: Request):
    logger.info("compose request: catalog=%s model=%s turns=%d",
                req.catalog_version, req.model, len(req.messages))
    if not settings.featherless_api_key:
        ...
```

That is the entire backend diff. `featherless.stream_deltas` is unchanged.

> Do **not** add catalog-aware logic to `schemas.py` / `featherless.py`. The
> catalog stays in Dart. The server's job is to relay bytes.

---

## Phase 2 — Client: build the genui catalog with real schemas

Replace the bespoke manifest+registry with genui `CatalogItem`s. One item per
component; the `dataSchema` is the machine-readable contract the model fills in.

**`lib/genui/emergency_catalog.dart`** (new):

```dart
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

final _sosCallButton = CatalogItem(
  name: 'SOSCallButton',
  dataSchema: S.object(
    properties: {
      'emergencyNumber': S.string(description: 'Number to dial, e.g. "911".'),
      'callState': S.string(
        description: 'idle | dialing | connected.',
      ),
      'callDuration': S.integer(description: 'Seconds connected, if any.'),
    },
    required: ['emergencyNumber', 'callState'],
  ),
  widgetBuilder: (itemContext) {
    final data = itemContext.data as Map<String, Object?>;
    return SosCallButton(                          // existing widget, reused
      emergencyNumber: data['emergencyNumber'] as String,
      callState: data['callState'] as String,
    );
  },
);

// ...one CatalogItem per component (port all 30 from catalog_manifest.dart)...

Catalog buildEmergencyCatalog() =>
    BasicCatalogItems.asCatalog().copyWith(newItems: [
      _sosCallButton,
      // _countdownCard, _safeRouteMap, _severityBanner, ...
    ]);
```

Port priority (do these three first to prove the loop, then the rest):
`SOSCallButton`, `CountdownCard`, `SafeRouteMap`.

The existing widget bodies in `lib/presentation/catalog/*.dart` are reused
inside `widgetBuilder` — only the registration wrapper changes. The informal
`inputs` strings in `catalog_manifest.dart` become real `S.object` schemas.

---

## Phase 3 — Client: wire transport → backend

**`lib/genui/emergency_conversation.dart`** (new):

```dart
import 'dart:convert';
import 'package:genui/genui.dart';
import 'package:http/http.dart' as http;

const _catalogVersion = '2026.06.0';

({Conversation conversation, SurfaceController controller}) buildConversation(
  Uri backendBase,
) {
  final catalog = buildEmergencyCatalog();
  final controller = SurfaceController(catalogs: [catalog]);

  final promptBuilder = PromptBuilder.chat(
    catalog: catalog,
    systemPromptFragments: [
      'You are an in-car emergency assistant. Compose the safest, calmest '
      'surface for the situation. One dominant action at a time. Never invent '
      'components outside the catalog.',
    ],
  );

  late final A2uiTransportAdapter adapter;
  adapter = A2uiTransportAdapter(onSend: (message) async {
    final req = http.Request('POST', backendBase.resolve('/v1/chat/stream'))
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode({
        'system': promptBuilder.systemPromptJoined(),
        'messages': message.toBackendMessages(),   // genui turns → [{role,text}]
        'catalogVersion': _catalogVersion,
      });

    final res = await http.Client().send(req);
    if (res.statusCode >= 400) {
      throw Exception('Backend ${res.statusCode}');
    }
    await for (final line in res.stream
        .transform(utf8.decoder)
        .transform(const LineSplitter())) {
      if (line.trim().isEmpty) continue;
      final obj = jsonDecode(line) as Map<String, Object?>;
      if (obj['delta'] != null) adapter.addChunk(obj['delta'] as String);
      if (obj['error'] != null) throw Exception(obj['error']);
      if (obj['done'] == true) break;
    }
  });

  return (
    conversation: Conversation(controller: controller, transport: adapter),
    controller: controller,
  );
}
```

`message.toBackendMessages()` maps genui's conversation turns to the backend's
`[{role: 'user'|'model', text: ...}]` shape (same mapping the existing
`ModelClient._toMessage` already uses).

---

## Phase 4 — Client: render surfaces

```dart
conversation.events.listen((event) {
  if (event is ConversationSurfaceAdded) setState(() => _ids.add(event.surfaceId));
  if (event is ConversationSurfaceRemoved) setState(() => _ids.remove(event.surfaceId));
});

// in build():
ListView.builder(
  itemCount: _ids.length,
  itemBuilder: (_, i) => Surface(surfaceContext: controller.contextFor(_ids[i])),
);

// to compose:
await conversation.sendRequest(ChatMessage.user(TextPart(situationText)));
```

This replaces `A2uiRenderer` + `catalogRegistry` lookups — genui's `Surface`
walks the surface and enforces the catalog allow-list itself.

---

## Phase 5 — Deterministic fallback

Keep `DeterministicComposer` as the AI-off path, but emit a genui surface
instead of the bespoke `A2uiNode` tree: build the same components by injecting an
`A2uiMessage`/`createSurface` directly into the `SurfaceController` (no network).
This keeps one render path. Until ported, gate the fallback behind a flag and
render it through the old path.

---

## Phase 6 — Delete the bespoke stack

Once Phases 2–5 render correctly, remove:

- `lib/domain/models/a2ui_node.dart` (+ generated parts)
- `lib/presentation/surface/a2ui_renderer.dart`, `binding_resolver.dart`,
  `data_model.dart`, `catalog_registry.dart`
- `lib/presentation/catalog/catalog_manifest.dart`
- `lib/data/ai_transport/*` (the REST DTOs — genui owns the wire format now)
- `test/presentation/catalog_registry_test.dart`

Keep the component widget bodies in `lib/presentation/catalog/*.dart`; they are
reused by the new `widgetBuilder`s.

---

## Validation

```bash
# 1. Backend up
cd backend && uvicorn app.main:app --reload --port 8000
curl http://localhost:8000/health

# 2. Transport sanity — backend relays a stream for a genui-shaped prompt.
#    (Use the real PromptBuilder output for "system" once Phase 2 compiles.)
curl -N -X POST http://localhost:8000/v1/chat/stream \
  -H 'Content-Type: application/json' \
  -d '{"system":"<paste systemPromptJoined() output>",
       "messages":[{"role":"user","text":"I was just in a crash"}],
       "catalogVersion":"2026.06.0"}'
# Expect NDJSON: {"delta":...} lines then {"done":true}; the concatenated
# deltas must parse as genui A2UI commands (createSurface/...).

# 3. Client loop
flutter run --dart-define=BACKEND_BASE=http://localhost:8000
```

**Model-output check (the one real risk):** the concatenated deltas must be
valid genui A2UI commands. `PromptBuilder` instructs the model in the protocol;
Qwen2.5-72B follows structured-output instructions well. If output drifts, raise
`systemPromptFragments` strictness or lower `temperature` — this is a prompt
tuning task on the client, never a backend change.

## Backend caveats

- **Prompt size.** `PromptBuilder.chat()` emits a 3,000–5,000+ token system
  prompt (A2UI protocol + every `dataSchema`). Within Qwen2.5-72B's context
  window; no body-size limit on the existing route. No action needed beyond
  awareness.
- **Read timeout.** `HTTP_TIMEOUT.read = 300s` already covers long streamed
  composes. No change.
