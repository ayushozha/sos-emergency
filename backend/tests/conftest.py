"""Shared pytest fixtures."""

import pytest
from fastapi.testclient import TestClient

from app.main import app


@pytest.fixture
def client():
    """TestClient with FastAPI lifespan (http_client on app.state)."""
    with TestClient(app) as test_client:
        yield test_client