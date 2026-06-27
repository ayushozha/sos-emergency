"""Screen composition: Classification + context → A2UI surface via Featherless."""

from __future__ import annotations

import json
import re
from collections.abc import AsyncIterator
from uuid import UUID

import httpx

from .api_models import (
    A2uiNode,
    ComposeContext,
    ComposeRequest,
    ComposeResponse,
    ComposeStreamDoneEvent,
    ComposeStreamErrorEvent,
    ComposeStreamNodeEvent,
    ComposeUsage,
    Classification,
    FinishReason,
)
from .config import settings
from .featherless import stream_deltas
from .schemas import ChatRequest, Message

_JSON_FENCE = re.compile(r"```(?:json)?\s*([\s\S]*?)\s*```", re.IGNORECASE)


def _tier_label(severity: str) -> str:
    return {
        "neutral": "Info",
        "moderate": "Moderate",
        "high": "High",
        "critical": "Critical",
    }.get(severity, severity.title())


def build_compose_prompt(req: ComposeRequest) -> str:
    clf = req.classification
    ctx = req.context
    hazards = ", ".join(clf.hazards) if clf.hazards else "none"
    pos = ""
    if ctx.position and ctx.position.latitude is not None:
        pos = (
            f"Position: {ctx.position.latitude}, {ctx.position.longitude}"
            f"{f' ({ctx.position.address})' if ctx.position.address else ''}."
        )

    return f"""You compose emergency UI for an in-car SOS app using ONLY registered catalog widgets.

Return ONE JSON object — the root A2uiNode tree. No markdown fences, no prose.
Root MUST be type "EmergencyRoot" with props tier="{clf.severity}", carState="{ctx.carState}".

Catalog version: {req.catalogVersion}
Scenario: {clf.scenario} (mode={clf.mode}, severity={clf.severity}, confidence={clf.confidence})
Hazards: {hazards}
Context: connectivity={ctx.connectivity}, isNight={ctx.isNight}, locale={ctx.locale}, emergencyNumber={ctx.emergencyNumber}
{pos}

Allowed widget types include: EmergencyRoot, SeverityBanner, GuidanceCallout, ChoiceGrid,
BigChoiceCard, ActionStack, StepChecklist, YesNoLarge, CountdownCard, ImSafeCancel,
SOSCallButton, ShareLocationAction, NotifyContactsAction, SafeRouteMap, LocationCard,
VehicleStatusCard, ContactStatusList, MedicalIdCard, PushToTalk, OfflineBanner, ETACard.

Each node: {{"type": "...", "props": {{}}, "children": [...]}}.
Safety-first: largest action is emergency call or share location when severity is high/critical.
"""


def _extract_json(text: str) -> dict:
    stripped = text.strip()
    fence = _JSON_FENCE.search(stripped)
    if fence:
        stripped = fence.group(1).strip()
    start = stripped.find("{")
    end = stripped.rfind("}")
    if start < 0 or end <= start:
        raise ValueError("Model response did not contain a JSON object.")
    return json.loads(stripped[start : end + 1])


def parse_surface(raw: str) -> A2uiNode:
    data = _extract_json(raw)
    node = A2uiNode.model_validate(data)
    if node.type != "EmergencyRoot":
        raise ValueError(f"Root must be EmergencyRoot, got {node.type!r}.")
    return node


def _fallback_surface(req: ComposeRequest) -> A2uiNode:
    """Deterministic baseline when the model is unavailable."""
    clf = req.classification
    ctx = req.context
    tier = clf.severity
    children: list[A2uiNode] = []

    if ctx.connectivity == "offline":
        children.append(A2uiNode(type="OfflineBanner"))

    children.append(
        A2uiNode(
            type="SeverityBanner",
            props={
                "tier": tier,
                "label": _tier_label(tier),
                "context": clf.scenario,
            },
        )
    )

    if clf.scenario == "crash":
        children.extend(
            [
                A2uiNode(
                    type="CountdownCard",
                    props={
                        "secondsLeft": 8,
                        "totalSeconds": 15,
                        "message": "Calling 911 automatically",
                    },
                ),
                A2uiNode(type="ImSafeCancel", props={"holdMs": 1200}),
            ]
        )
    elif clf.scenario in ("beingFollowed", "unsafeParked"):
        children.append(
            A2uiNode(
                type="GuidanceCallout",
                props={
                    "tier": tier,
                    "kicker": "Do this now",
                    "text": "Drive to the nearest police station",
                },
            )
        )
        children.append(
            A2uiNode(
                type="SafeRouteMap",
                props={"threatMode": True, "etaLabel": "4 min", "destinations": []},
            )
        )
    elif clf.scenario == "medical":
        children.extend(
            [
                A2uiNode(
                    type="GuidanceCallout",
                    props={
                        "tier": tier,
                        "kicker": "Do this now",
                        "text": "Pull over and stop the car",
                    },
                ),
                A2uiNode(
                    type="MedicalIdCard",
                    props={
                        "bloodType": "O+",
                        "allergies": "Penicillin",
                        "conditions": "Hypertension",
                    },
                ),
                A2uiNode(
                    type="SOSCallButton",
                    props={"emergencyNumber": ctx.emergencyNumber, "callState": "idle"},
                ),
            ]
        )
    elif clf.scenario == "flatTire":
        children.append(
            A2uiNode(
                type="StepChecklist",
                props={
                    "title": "Change a tire",
                    "currentIndex": 0,
                    "steps": [
                        {"title": "Pull onto a flat, firm shoulder", "done": False},
                        {"title": "Hazards on, parking brake set", "done": False},
                    ],
                },
            )
        )
    elif clf.scenario == "wontStart":
        children.append(
            A2uiNode(
                type="StepChecklist",
                props={
                    "title": "Jump-start",
                    "currentIndex": 1,
                    "steps": [
                        {"title": "Park both cars, engines off", "done": True},
                        {"title": "Clamp red to dead + terminal", "done": False},
                    ],
                },
            )
        )
    elif clf.scenario == "unknown":
        choices = [
            ("Car problem", "vehicle"),
            ("Crash", "crash"),
            ("Medical", "medical"),
            ("Being followed", "followed"),
        ]
        children.append(
            A2uiNode(
                type="ChoiceGrid",
                props={"columns": 4},
                children=[
                    A2uiNode(
                        type="BigChoiceCard",
                        props={"label": label, "icon": icon},
                    )
                    for label, icon in choices
                ],
            )
        )
        children.append(A2uiNode(type="PushToTalk", props={"state": "idle"}))

    return A2uiNode(
        type="EmergencyRoot",
        props={"tier": tier, "carState": ctx.carState},
        children=children,
    )


async def _collect_model_text(
    req: ComposeRequest, client: httpx.AsyncClient
) -> tuple[str, FinishReason]:
    if not settings.featherless_api_key:
        return "", "refused"

    chat = ChatRequest(
        system=build_compose_prompt(req),
        messages=[
            Message(
                role="user",
                text=f"Compose the emergency surface for scenario {req.classification.scenario}.",
            )
        ],
    )
    chunks: list[str] = []
    async for delta in stream_deltas(chat, client):
        chunks.append(delta)
    text = "".join(chunks)
    if not text.strip():
        return "", "refused"
    return text, "complete"


async def compose_surface(
    req: ComposeRequest, client: httpx.AsyncClient
) -> tuple[A2uiNode, FinishReason, ComposeUsage]:
    import time

    started = time.perf_counter()
    finish: FinishReason = "complete"
    surface: A2uiNode

    try:
        import asyncio

        raw, finish = await asyncio.wait_for(
            _collect_model_text(req, client),
            timeout=req.timeBudgetMs / 1000,
        )
        if finish == "refused" or not raw.strip():
            surface = _fallback_surface(req)
            finish = "refused"
        else:
            try:
                surface = parse_surface(raw)
            except (ValueError, json.JSONDecodeError):
                surface = _fallback_surface(req)
                finish = "refused"
    except TimeoutError:
        surface = _fallback_surface(req)
        finish = "timeout"
    except httpx.HTTPError:
        surface = _fallback_surface(req)
        finish = "refused"

    latency_ms = (time.perf_counter() - started) * 1000
    return surface, finish, ComposeUsage(latencyMs=latency_ms)


def walk_nodes(
    root: A2uiNode, parent_id: str | None = None
) -> list[tuple[str | None, A2uiNode]]:
    """Preorder traversal assigning stable ids for SSE parent linking."""
    node_id = root.id or root.type
    out: list[tuple[str | None, A2uiNode]] = [(parent_id, root)]
    for child in root.children:
        out.extend(walk_nodes(child, node_id))
    return out


async def stream_compose_events(
    req: ComposeRequest, client: httpx.AsyncClient
) -> AsyncIterator[str]:
    """Yields SSE data lines (without the `data: ` prefix — caller adds it)."""
    try:
        surface, finish, _usage = await compose_surface(req, client)
        root_id = surface.id or surface.type
        for parent_id, node in walk_nodes(surface):
            if (node.id or node.type) == root_id and parent_id is None:
                evt = ComposeStreamNodeEvent(parentId=None, node=node)
            else:
                evt = ComposeStreamNodeEvent(parentId=parent_id, node=node)
            yield evt.model_dump_json()
        yield ComposeStreamDoneEvent(finishReason=finish).model_dump_json()
    except Exception as error:
        yield ComposeStreamErrorEvent(
            code="compose_failed", message=str(error)
        ).model_dump_json()


def compose_response(
    req: ComposeRequest, surface: A2uiNode, finish: FinishReason, usage: ComposeUsage
) -> ComposeResponse:
    return ComposeResponse(
        requestId=req.requestId,
        catalogVersion=req.catalogVersion,
        surface=surface,
        finishReason=finish,
        usage=usage,
    )