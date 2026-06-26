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

    # Default model. Strong instruction-following for A2UI's structured output.
    # Override per-request from the client, or globally via FEATHERLESS_MODEL.
    featherless_model: str = "Qwen/Qwen2.5-72B-Instruct"

    # Comma-separated list of origins allowed to call the API. Flutter web/dev
    # servers use random ports, so "*" is convenient in development. Lock this
    # down to your real origins before deploying.
    cors_allow_origins: str = "*"

    def cors_origins_list(self) -> list[str]:
        return [o.strip() for o in self.cors_allow_origins.split(",") if o.strip()]


settings = Settings()
