"""Ad-hoc probe for WS /v1/voice/agent: connect, send config, log frames.

Confirms the backend's Deepgram session opens and emits a greeting (binary TTS
+ assistant transcript) without any mic audio. If this works, the backend is
healthy and any "no response" issue is on the client/audio side.
"""

import asyncio
import json
import math
import struct
import sys

import websockets

WS = "ws://localhost:8000/v1/voice/agent"
SYSTEM = (
    "You are an emergency-guidance assistant. Reply ONLY with a compact JSON "
    'object describing UI to render. Use keys like {"title": ..., "steps": [...]}.'
)


def tone_pcm(seconds: float = 1.0, rate: int = 16000, freq: float = 220.0) -> bytes:
    """A simple sine tone as linear16 LE (won't transcribe; just exercises the pipe)."""
    out = bytearray()
    for n in range(int(seconds * rate)):
        s = int(0.3 * 32767 * math.sin(2 * math.pi * freq * n / rate))
        out += struct.pack("<h", s)
    return bytes(out)


async def main() -> None:
    send_audio = "--audio" in sys.argv
    async with websockets.connect(WS, max_size=None) as ws:
        await ws.send(json.dumps({"system": SYSTEM}))
        print("→ sent config")

        if send_audio:

            async def pump() -> None:
                chunk = tone_pcm(0.2)
                for _ in range(15):  # ~3s of audio in 200ms frames
                    await ws.send(chunk)
                    await asyncio.sleep(0.2)

            asyncio.create_task(pump())

        bin_frames = 0
        bin_bytes = 0
        try:
            while True:
                msg = await asyncio.wait_for(ws.recv(), timeout=8.0)
                if isinstance(msg, (bytes, bytearray)):
                    bin_frames += 1
                    bin_bytes += len(msg)
                    if bin_frames <= 3 or bin_frames % 25 == 0:
                        print(f"♪ TTS audio frame #{bin_frames} ({len(msg)} bytes)")
                else:
                    print("· text:", msg[:300])
        except asyncio.TimeoutError:
            print("— no more frames for 8s, stopping —")
        finally:
            print(f"summary: {bin_frames} TTS frames, {bin_bytes} bytes total")


if __name__ == "__main__":
    asyncio.run(main())
