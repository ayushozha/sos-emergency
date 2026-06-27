"""Quick voice WebSocket smoke test against the local backend."""

import asyncio
import json
import sys

import websockets


async def main(port: int = 8001) -> int:
    uri = f"ws://127.0.0.1:{port}/v1/voice/agent"
    audio_chunks = 0
    async with websockets.connect(uri) as ws:
        await ws.send(
            json.dumps(
                {
                    "type": "session.start",
                    "config": {
                        "locale": "en-US",
                        "sampleRate": 24000,
                        "codec": "pcm16",
                        "tier": "neutral",
                    },
                }
            )
        )
        send_user_text = "--text" in sys.argv
        sent_text = False
        for _ in range(60):
            msg = await asyncio.wait_for(ws.recv(), timeout=30)
            data = json.loads(msg)
            frame_type = data.get("type")
            print(f"frame: {frame_type}", end="")
            if frame_type == "session.ready":
                print(" ok")
            elif frame_type == "audio.chunk":
                audio_chunks += 1
                print(f" b64_len={len(data.get('audio', ''))}")
            elif frame_type == "transcript":
                print(f" role={data.get('role')} text={data.get('text', '')[:80]!r}")
            elif frame_type == "error":
                print(f" {data}")
            else:
                print(f" {data}")

            if send_user_text and frame_type == "session.ready" and not sent_text:
                sent_text = True
                await ws.send(
                    json.dumps({"type": "text", "text": "I smell smoke from my engine"})
                )
            if audio_chunks >= 10:
                break

    print(f"audio_chunks={audio_chunks}")
    return 0 if audio_chunks > 0 else 1


if __name__ == "__main__":
    port = int(sys.argv[1]) if len(sys.argv) > 1 else 8001
    raise SystemExit(asyncio.run(main(port)))