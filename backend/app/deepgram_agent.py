"""A thin async wrapper around one Deepgram Voice Agent websocket session.

Deepgram manages the full STT -> LLM ("think") -> TTS loop over a single
websocket (`wss://agent.deepgram.com/v1/agent/converse`). This module owns the
backend side of that connection: it builds the `Settings` message from config,
opens the socket, pumps mic audio up, and forwards every agent event (TTS audio
bytes, transcripts, status, function-call requests) to a single callback.

It deliberately knows nothing about A2UI or Featherless — the bridge in
`main.py` registers the callback and decides what to do with each event. Keep
that separation: this file is the Deepgram transport; the bridge is the policy.
"""

from __future__ import annotations

import asyncio
import contextlib
from collections.abc import Awaitable, Callable
from typing import Any

from deepgram import AsyncDeepgramClient
from deepgram.agent.v1.types import (
    AgentV1InjectUserMessage,
    AgentV1Settings,
    AgentV1SendFunctionCallResponse,
    AgentV1SettingsAgent,
    AgentV1SettingsAgentListen,
    AgentV1SettingsAgentListenProvider_V1,
    AgentV1SettingsAudio,
    AgentV1SettingsAudioInput,
    AgentV1SettingsAudioOutput,
)
from deepgram.core.events import EventType
from deepgram.types.speak_settings_v1 import SpeakSettingsV1
from deepgram.types.speak_settings_v1provider import SpeakSettingsV1Provider_Deepgram
from deepgram.types.think_settings_v1 import ThinkSettingsV1
from deepgram.types.think_settings_v1provider import ThinkSettingsV1Provider_OpenAi

from .config import settings
from .voice_prompt import (
    DISPATCHER_PROMPT,
    render_function_definition,
)

# Callback invoked for every message from the agent socket. Receives either
# raw `bytes` (a chunk of TTS audio) or a parsed pydantic event model with a
# `.type` attribute ("ConversationText", "FunctionCallRequest", ...). May be a
# coroutine — the SDK awaits it.
EventCallback = Callable[[Any], Awaitable[None] | None]

# Deepgram closes an idle socket after ~10s; ping well inside that window.
_KEEPALIVE_INTERVAL_S = 5.0


def _build_settings(dispatcher_prompt: str) -> AgentV1Settings:
    """Construct the `Settings` message (Design A: client-side function call)."""
    return AgentV1Settings(
        audio=AgentV1SettingsAudio(
            input=AgentV1SettingsAudioInput(
                encoding="linear16",
                sample_rate=settings.voice_input_sample_rate,
            ),
            output=AgentV1SettingsAudioOutput(
                encoding="linear16",
                sample_rate=settings.voice_output_sample_rate,
                container="wav",
            ),
        ),
        agent=AgentV1SettingsAgent(
            language=settings.voice_language,
            greeting=settings.voice_greeting,
            listen=AgentV1SettingsAgentListen(
                provider=AgentV1SettingsAgentListenProvider_V1(
                    type="deepgram",
                    model=settings.voice_listen_model,
                ),
            ),
            think=ThinkSettingsV1(
                provider=ThinkSettingsV1Provider_OpenAi(
                    type="open_ai",
                    model=settings.voice_think_model,
                    temperature=settings.voice_think_temperature,
                ),
                prompt=dispatcher_prompt,
                # No endpoint URL on the function => Deepgram routes the call
                # back to us as a FunctionCallRequest instead of calling out.
                functions=[render_function_definition()],
            ),
            speak=SpeakSettingsV1(
                provider=SpeakSettingsV1Provider_Deepgram(
                    type="deepgram",
                    model=settings.voice_speak_model,
                ),
            ),
        ),
    )


class DeepgramAgentSession:
    """One live Deepgram agent connection, used as an async context manager.

        async with DeepgramAgentSession(on_event=cb) as session:
            await session.send_audio(chunk)
            ...

    On enter it connects, sends `Settings`, and starts a background task that
    listens for agent events and forwards them to `on_event`. A second
    background task sends periodic keepalives. On exit both are cancelled and
    the socket is closed.
    """

    def __init__(
        self,
        *,
        on_event: EventCallback,
        dispatcher_prompt: str | None = None,
    ) -> None:
        self._on_event = on_event
        self._dispatcher_prompt = (
            dispatcher_prompt or settings.voice_dispatcher_prompt or DISPATCHER_PROMPT
        )
        self._client = AsyncDeepgramClient(api_key=settings.deepgram_api_key)
        self._stack = contextlib.AsyncExitStack()
        self._agent: Any = None
        self._listen_task: asyncio.Task | None = None
        self._keepalive_task: asyncio.Task | None = None

    async def __aenter__(self) -> "DeepgramAgentSession":
        # connect() is an async context manager yielding the socket client.
        self._agent = await self._stack.enter_async_context(
            self._client.agent.v1.connect()
        )
        self._agent.on(EventType.MESSAGE, self._on_event)
        await self._agent.send_settings(_build_settings(self._dispatcher_prompt))
        # start_listening() runs the receive loop until the socket closes.
        self._listen_task = asyncio.create_task(self._agent.start_listening())
        self._keepalive_task = asyncio.create_task(self._keepalive_loop())
        return self

    async def __aexit__(self, *exc: object) -> None:
        await self.close()

    async def send_audio(self, chunk: bytes) -> None:
        """Forward a chunk of mic audio (linear16 PCM) to the agent."""
        if self._agent is not None:
            await self._agent.send_media(chunk)

    async def send_inject_user_message(self, content: str) -> None:
        """Inject a user utterance so the agent responds as if the user spoke it."""
        if self._agent is not None:
            await self._agent.send_inject_user_message(
                AgentV1InjectUserMessage(content=content)
            )

    async def send_function_call_response(
        self, *, call_id: str, name: str, content: str
    ) -> None:
        """Answer a FunctionCallRequest so the agent can speak a confirmation."""
        if self._agent is None:
            return
        await self._agent.send_function_call_response(
            AgentV1SendFunctionCallResponse(
                type="FunctionCallResponse",
                id=call_id,
                name=name,
                content=content,
            )
        )

    async def _keepalive_loop(self) -> None:
        try:
            while True:
                await asyncio.sleep(_KEEPALIVE_INTERVAL_S)
                if self._agent is not None:
                    await self._agent.send_keep_alive()
        except (asyncio.CancelledError, Exception):
            # Socket closed or task cancelled; nothing more to keep alive.
            return

    async def close(self) -> None:
        for task in (self._keepalive_task, self._listen_task):
            if task is not None and not task.done():
                task.cancel()
                with contextlib.suppress(asyncio.CancelledError, Exception):
                    await task
        with contextlib.suppress(Exception):
            await self._stack.aclose()
        self._agent = None
