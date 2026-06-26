"""API contract tests (no live Featherless/Deepgram keys required)."""

import json
from uuid import uuid4

from app.api_models import VoiceSessionReady


def test_health_liveness(client):
    resp = client.get("/health")
    assert resp.status_code == 200
    assert resp.json()["status"] == "ok"


def test_voice_health_minimal(client):
    resp = client.get("/v1/voice/health")
    assert resp.status_code in (200, 503)
    body = resp.json()
    assert "status" in body
    assert "version" in body
    assert "timestamp" in body
    assert "uptimeSeconds" in body


def test_voice_health_verbose_dependencies(client):
    resp = client.get("/v1/voice/health", params={"verbose": True})
    body = resp.json()
    if resp.status_code == 200:
        assert body.get("dependencies") is not None
        assert len(body["dependencies"]) == 3


def test_compose_non_stream_fallback_surface(client):
    payload = {
        "classification": {
            "scenario": "crash",
            "severity": "critical",
            "mode": "crash",
            "confidence": 0.95,
            "hazards": [],
        },
        "context": {
            "carState": "parked",
            "connectivity": "online",
            "isNight": False,
            "locale": "en-US",
            "emergencyNumber": "911",
        },
        "catalogVersion": "2026.06.0",
        "stream": False,
        "timeBudgetMs": 500,
    }
    resp = client.post("/v1/chat/stream", json=payload)
    assert resp.status_code in (200, 503)
    if resp.status_code == 200:
        body = resp.json()
        assert body["surface"]["type"] == "EmergencyRoot"
        assert body["finishReason"] in ("complete", "timeout", "refused")


def test_voice_session_ready_uuid_is_json_safe():
    payload = VoiceSessionReady(
        sessionId=uuid4(),
        config={"sampleRate": 16000, "codec": "pcm16"},
    ).model_dump(mode="json")
    encoded = json.dumps(payload)
    assert '"session.ready"' in encoded
    assert "sessionId" in encoded


def test_compose_sse_stream(client):
    payload = {
        "classification": {
            "scenario": "unknown",
            "severity": "neutral",
            "mode": "triage",
            "confidence": 1.0,
            "hazards": [],
        },
        "context": {
            "carState": "parked",
            "connectivity": "online",
            "isNight": False,
            "locale": "en-US",
        },
        "catalogVersion": "2026.06.0",
        "stream": True,
        "timeBudgetMs": 500,
    }
    resp = client.post("/v1/chat/stream", json=payload)
    assert resp.status_code in (200, 503)
    if resp.status_code == 200:
        assert "text/event-stream" in resp.headers.get("content-type", "")
        assert "data:" in resp.text