"""Pydantic models aligned with docs/brainstorm/sos_api_schemas.pdf."""

from __future__ import annotations

from datetime import datetime, timezone
from typing import Any, Literal
from uuid import UUID, uuid4

from pydantic import BaseModel, Field

Severity = Literal["neutral", "moderate", "high", "critical"]
AppMode = Literal["triage", "crash", "medical", "threat", "roadside"]
Connectivity = Literal["online", "degraded", "offline"]
CarState = Literal["driving", "parked"]
ScenarioClass = Literal[
    "crash",
    "medical",
    "beingFollowed",
    "flatTire",
    "wontStart",
    "lockedOut",
    "outOfGas",
    "unsafeParked",
    "unknown",
]
Hazard = Literal["smoke", "fire", "weather", "lowVisibility"]
FinishReason = Literal["complete", "timeout", "refused"]
HealthStatus = Literal["ok", "degraded", "down"]


class A2uiNode(BaseModel):
    type: str
    id: str | None = None
    props: dict[str, Any] = Field(default_factory=dict)
    bindings: dict[str, str] = Field(default_factory=dict)
    children: list[A2uiNode] = Field(default_factory=list)


class Classification(BaseModel):
    scenario: ScenarioClass
    severity: Severity
    mode: AppMode
    confidence: float = Field(ge=0, le=1)
    hazards: list[Hazard] = Field(default_factory=list)


class GeoPosition(BaseModel):
    latitude: float | None = None
    longitude: float | None = None
    address: str | None = None


class ComposeContext(BaseModel):
    carState: CarState
    connectivity: Connectivity
    isNight: bool
    locale: str = "en-US"
    emergencyNumber: str = "911"
    position: GeoPosition | None = None


class ComposeRequest(BaseModel):
    classification: Classification
    context: ComposeContext
    catalogVersion: str
    stream: bool = True
    timeBudgetMs: int = Field(default=3000, ge=100, le=10000)
    requestId: UUID = Field(default_factory=uuid4)


class ComposeUsage(BaseModel):
    latencyMs: float | None = None
    inputTokens: int | None = None
    outputTokens: int | None = None


class ComposeResponse(BaseModel):
    requestId: UUID
    catalogVersion: str
    surface: A2uiNode
    finishReason: FinishReason = "complete"
    usage: ComposeUsage | None = None


class ComposeStreamNodeEvent(BaseModel):
    type: Literal["node"] = "node"
    parentId: str | None = None
    node: A2uiNode


class ComposeStreamDoneEvent(BaseModel):
    type: Literal["done"] = "done"
    finishReason: FinishReason


class ComposeStreamErrorEvent(BaseModel):
    type: Literal["error"] = "error"
    code: str
    message: str


class ModelHealth(BaseModel):
    id: str
    ready: bool


class DependencyHealth(BaseModel):
    name: str
    status: HealthStatus
    latencyMs: float | None = None


class VoiceHealthResponse(BaseModel):
    status: HealthStatus
    version: str
    timestamp: datetime
    uptimeSeconds: float = 0
    activeSessions: int = 0
    model: ModelHealth | None = None
    dependencies: list[DependencyHealth] | None = None


# --- Voice WebSocket frames (PDF contract) ---


class VoiceSessionConfig(BaseModel):
    locale: str = "en-US"
    sampleRate: Literal[8000, 16000, 24000, 48000] = 16000
    codec: Literal["pcm16", "opus"] = "pcm16"
    incidentId: UUID | None = None
    tier: Severity | None = None


class VoiceSessionStart(BaseModel):
    type: Literal["session.start"] = "session.start"
    config: VoiceSessionConfig


class VoiceAudioChunkIn(BaseModel):
    type: Literal["audio.chunk"] = "audio.chunk"
    seq: int = Field(ge=0)
    audio: str


class VoiceAudioCommit(BaseModel):
    type: Literal["audio.commit"] = "audio.commit"


class VoiceTextIn(BaseModel):
    type: Literal["text"] = "text"
    text: str


class VoiceControlIn(BaseModel):
    type: Literal["control"] = "control"
    action: Literal["mute", "unmute", "barge_in", "cancel"]


class VoiceSessionEnd(BaseModel):
    type: Literal["session.end"] = "session.end"


class VoiceSessionReady(BaseModel):
    type: Literal["session.ready"] = "session.ready"
    sessionId: UUID
    config: dict[str, Any]


class VoiceTranscript(BaseModel):
    type: Literal["transcript"] = "transcript"
    role: Literal["user", "agent"]
    text: str
    isFinal: bool


class VoiceAudioChunkOut(BaseModel):
    type: Literal["audio.chunk"] = "audio.chunk"
    seq: int = Field(ge=0)
    audio: str


class VoiceIntent(BaseModel):
    type: Literal["intent"] = "intent"
    intent: str
    confidence: float = Field(ge=0, le=1)
    slots: dict[str, Any] = Field(default_factory=dict)


class VoiceEvent(BaseModel):
    type: Literal["event"] = "event"
    name: Literal["vad_start", "vad_stop", "barge_in", "thinking"]


class VoiceError(BaseModel):
    type: Literal["error"] = "error"
    code: str
    message: str
    fatal: bool = False


class VoiceSessionClosed(BaseModel):
    type: Literal["session.closed"] = "session.closed"
    reason: Literal["client_request", "timeout", "completed", "error"]


def utc_now() -> datetime:
    return datetime.now(timezone.utc)