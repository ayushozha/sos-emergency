# GenUI A2UI Transport — Implementation TODO

Tracks building the genui-SDK migration from `genui-a2ui-transport-spec.md`
(Option A: official `genui` SDK + Python transport). Check items off as you go.

> **Status (as of this pass):** Phases 0–4 + 7-seam done, **and the live model
> round-trip is verified.** Backend `catalogVersion` passthrough; genui catalog
> with 22 leaf components (real `S.object` schemas, reusing existing widgets via
> a bridge); transport wired to `/v1/chat/stream`; demo screen
> `EmergencyGenUiScreen`; voice seam (`EmergencySession.ingestVoiceDelta` +
> `systemPrompt`). `flutter analyze` clean; `flutter test` green (3 genui tests):
> - `emergency_catalog_render_test.dart` — renders from canned A2UI messages.
> - `live_output_parse_test.dart` — renders from **real GLM-5.2 output** (prose +
>   ```json fences), proving the parser recovers a surface from messy model text.
>
> Live check performed: real prompt → running backend → GLM-5.2 → valid A2UI
> using SOSCallButton / SeverityBanner / GuidanceCallout / LocationCard /
> ShareLocationAction / NotifyContactsAction inside a genui `Column`. Caught and
> fixed a real bug: `catalogId` must stay `basicCatalogId` (what `PromptBuilder`
> instructs), not a custom value.
>
> **Not done:** a Flutter voice client to call the voice seam (the backend voice
> path + seam are ready); re-targeting `DeterministicComposer` to genui
> (Phase 5); and Phase 8 deletion of the bespoke stack — **held for approval, and
> blocked on Phase 5** since the offline deterministic fallback still uses the
> bespoke `A2uiNode` path.

## Phase 0 — Confirm the SDK surface (done)

- [x] Locate `genui-0.9.2` in pub cache; confirm key classes exist.
- [x] Verify real 0.9.2 signatures (differ from docs):
      - [x] `A2uiTransportAdapter({this.onSend})`, `ManualSendCallback =
            Future<void> Function(ChatMessage)`, `void addChunk(String)`.
      - [x] `PromptBuilder.chat({required Catalog catalog, Iterable<String>
            systemPromptFragments})` → `systemPromptJoined()`.
      - [x] `SurfaceController({required catalogs})`, `contextFor(surfaceId)`,
            `activeSurfaceIds`.
      - [x] `CatalogItem(name:, dataSchema:, exampleData:, widgetBuilder:)`;
            builder gets `CatalogItemContext` (`.data` as `JsonMap`,
            `.dataContext`, `.buildChild`, `.dispatchEvent`).
      - [x] `Conversation({required controller, required transport})`,
            `events`, `sendRequest(ChatMessage)`.
      - [x] `Surface({required surfaceContext})`.
      - [x] A2UI ops are `createSurface` / `updateComponents` / `updateDataModel`
            / `deleteSurface` (flat component-reference model, not a nested tree).
- [x] Confirm deps: `genui: ^0.9.2`, `http: ^1.2.0`; `S` re-exported by
      `package:genui/genui.dart`.

## Phase 1 — Backend: catalogVersion passthrough (only server change)

- [ ] `app/schemas.py`: add optional `catalog_version` (alias `catalogVersion`).
- [ ] `app/main.py`: log catalog/model/turns at the top of `chat_stream`.
- [ ] Keep `featherless.py` / prompt logic untouched (server stays
      catalog-agnostic).
- [ ] Verify: `curl /v1/chat/stream` with a `catalogVersion` still streams NDJSON.

## Phase 2 — Client: genui catalog with real schemas

- [ ] `lib/genui/emergency_catalog.dart`: `buildEmergencyCatalog()` =
      `BasicCatalogItems.asCatalog().copyWith(newItems: [...])`.
- [ ] Port leaf components first (no children): **SeverityBanner**,
      **SOSCallButton**, **CountdownCard** — each with `S.object` dataSchema +
      self-contained `widgetBuilder` reusing the SOS design tokens.
- [ ] `flutter analyze` clean on the new file.

## Phase 3 — Client: transport → backend

- [ ] `lib/genui/emergency_conversation.dart`: `PromptBuilder.chat`,
      `A2uiTransportAdapter(onSend:)` → POST `/v1/chat/stream`, parse NDJSON
      `{"delta"}/{"done"}/{"error"}` → `addChunk`, `Conversation` +
      `SurfaceController`.
- [ ] Map genui `ChatMessage` → backend `{role, text}` messages.
- [ ] Backend base URL via `--dart-define=BACKEND_BASE`.

## Phase 4 — Client: render surfaces

- [ ] Listen to `conversation.events` (`ConversationSurfaceAdded/Removed`).
- [ ] Render each with `Surface(surfaceContext: controller.contextFor(id))`.
- [ ] Demo screen: text input → compose → render (replaces `A2uiRenderer`).

## Phase 5 — Deterministic fallback

- [ ] Re-target `DeterministicComposer` to inject genui surfaces directly into
      the `SurfaceController` (no network), or gate the old path behind a flag.

## Phase 6 — Port remaining components

- [ ] Layout/containers via genui's flat model: `EmergencyRoot`, `ActionStack`,
      `SectionCard`, `ChoiceGrid` (children by `buildChild(id)`).
- [ ] Remaining panic / input / status / spatial / state components.

## Phase 7 — Voice agent integration

- [ ] Send `promptBuilder.systemPromptJoined()` on the `/v1/voice/agent` init
      `{"system": ...}` frame.
- [ ] Pipe voice WS `{"delta"}` frames into the **same** `A2uiTransportAdapter`
      (`addChunk`); treat `{"render_start"}` as begin/reset, `{"done"}` as end.
- [ ] Verify voice-triggered and text-triggered renders produce identical
      surfaces.

## Phase 8 — Retire bespoke stack (destructive — confirm first)

- [ ] Delete `a2ui_node.dart`, `a2ui_renderer.dart`, `binding_resolver.dart`,
      `data_model.dart`, `catalog_registry.dart`, `catalog_manifest.dart`,
      `lib/data/ai_transport/*`, `catalog_registry_test.dart`.
- [ ] Keep reused widget bodies. Run full `flutter analyze` + `flutter test`.
