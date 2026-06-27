"""Server configuration, loaded from the environment / a local .env file.

The model API key lives here on the server and is never sent to the client —
that is the whole point of putting a proxy in front of Featherless.
"""

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore",
    )

    # Secret. Required to talk to Featherless. Get one at https://featherless.ai
    featherless_api_key: str = ""

    # Featherless exposes an OpenAI-compatible API.
    featherless_base_url: str = "https://api.featherless.ai/v1"

    # Default model. Fast instruction-following for A2UI's structured output.
    # Override per-request from the client, or globally via FEATHERLESS_MODEL.
    featherless_model: str = "Qwen/Qwen2.5-72B-Instruct"

    # Comma-separated list of origins allowed to call the API. Flutter web/dev
    # servers use random ports, so "*" is convenient in development. Lock this
    # down to your real origins before deploying.
    cors_allow_origins: str = "*"

    # --- Deepgram Voice Agent (the hands-free voice layer) -------------------
    # Secret. Required for /v1/voice/agent. Get one at https://deepgram.com.
    deepgram_api_key: str = ""

    # The Deepgram-managed conversational pipeline. Deepgram runs STT -> LLM
    # ("think") -> TTS over one websocket; our Featherless A2UI pipeline only
    # gets pulled in when the think model calls render_emergency_ui.
    voice_listen_model: str = "nova-3"
    voice_think_model: str = "gpt-4o-mini"
    voice_think_temperature: float = 0.3
    voice_speak_model: str = "aura-2-thalia-en"
    voice_language: str = "en"
    voice_greeting: str = "Emergency assistant here. Tell me what's happening."

    # Audio formats on the wire. Input = mic from Flutter; output = TTS to play.
    voice_input_sample_rate: int = 16000
    voice_output_sample_rate: int = 24000

    # Optional override for the emergency-dispatcher "think" prompt. Empty means
    # use the built-in default in app/voice_prompt.py.
    voice_dispatcher_prompt: str = ""

    def cors_origins_list(self) -> list[str]:
        return [o.strip() for o in self.cors_allow_origins.split(",") if o.strip()]


settings = Settings()