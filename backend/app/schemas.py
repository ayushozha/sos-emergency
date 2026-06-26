"""Request/response shapes for the chat proxy.

These mirror the Flutter `ModelClient` vocabulary: a system prompt (built
client-side from the GenUI catalog + persona) plus a running history of user /
model turns. The proxy forwards them to Featherless and streams the raw A2UI
text deltas back.
"""

from typing import Literal

from pydantic import BaseModel, Field

Role = Literal["user", "model"]


class Message(BaseModel):
    role: Role
    text: str


class ChatRequest(BaseModel):
    # The combined system prompt (catalog A2UI instructions + persona). Built on
    # the client because the widget catalog lives in the Flutter app.
    system: str

    # The running conversation, oldest first. Sent in full on every turn so the
    # model has the complete context.
    messages: list[Message] = Field(default_factory=list)

    # Optional per-request model override. Falls back to the server default.
    model: str | None = None

    # Client catalog version (e.g. "2026.06.0"). Logged for observability as
    # the catalog evolves; the backend stays catalog-agnostic and never acts on
    # it — the catalog and prompt are built entirely on the client.
    catalog_version: str | None = Field(default=None, alias="catalogVersion")
