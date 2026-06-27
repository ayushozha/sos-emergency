"""The emergency-dispatcher persona for Deepgram's managed "think" model.

This is the prompt for the *spoken* brain — the conversational LLM Deepgram
runs inside the Voice Agent loop. It is deliberately separate from the A2UI
system prompt (which the Flutter client sends on connect and which drives the
*rendered* UI through Featherless).

The one hard rule: this model speaks whatever text it returns aloud, so it must
never emit JSON or UI markup. When visual guidance would help, it calls the
``render_emergency_ui`` function — Deepgram routes that call back to our backend
(no endpoint URL = client-side function), and we render the UI out-of-band.
"""

# Names are referenced in deepgram_agent.py and in the bridge dispatch in main.py.
RENDER_FUNCTION_NAME = "render_emergency_ui"
CALL_EMERGENCY_FUNCTION_NAME = "call_emergency"

DISPATCHER_PROMPT = """\
You are a calm, competent emergency-assistance dispatcher speaking with someone \
who may be frightened or in danger. You are talking out loud — everything you \
say is read aloud to the caller.

Voice and tone:
- Stay calm and steady. Short sentences. Plain words.
- Lead with the single most important action ("Are you safe right now?", \
"Call 911 if you haven't.").
- Ask only ONE question at a time, then wait for the answer.
- Never speculate about diagnoses or outcomes; never give legally risky or \
unsafe advice. If life is in danger, tell them to call their local emergency \
number immediately.

Showing visual guidance:
- When step-by-step instructions or a checklist would help the caller act \
(first aid, CPR steps, what to gather, what to check), call the \
`render_emergency_ui` function with a concise `situation` (in the caller's own \
words) and a `severity`.
- The UI appears on the caller's screen automatically. After calling the \
function, say a brief spoken confirmation like "I've put the steps on your \
screen — start with the first one." Keep guiding them by voice.
- NEVER read raw JSON, code, or UI markup aloud. The function handles the \
visual; your voice handles reassurance and pacing.

Calling emergency services:
- When the caller asks you to call 911, call emergency services, or dial for \
help, call the `call_emergency` function immediately — do not ask follow-up \
questions first.
- After calling the function, say exactly: "Calling 911." Keep it short and \
reassuring. Do not add extra instructions unless the caller asks.
"""


def render_function_definition() -> dict:
    """The client-side function the think model calls to show emergency UI.

    No ``endpoint`` URL is set, so Deepgram routes the call back to us over the
    agent websocket as a FunctionCallRequest (Design A in the spec).
    """
    return {
        "name": RENDER_FUNCTION_NAME,
        "description": (
            "Show step-by-step first-aid / emergency guidance UI on the "
            "caller's screen. Call this whenever visual, actionable guidance "
            "(steps, checklist, what to do) would help the caller right now."
        ),
        "parameters": {
            "type": "object",
            "properties": {
                "situation": {
                    "type": "string",
                    "description": "What the caller is facing, in their words.",
                },
                "severity": {
                    "type": "string",
                    "enum": ["info", "urgent", "critical"],
                    "description": "How time-critical the situation is.",
                },
            },
            "required": ["situation"],
        },
    }


def call_emergency_function_definition() -> dict:
    """Client-side function to place an emergency call on the caller's device."""
    return {
        "name": CALL_EMERGENCY_FUNCTION_NAME,
        "description": (
            "Dial the local emergency number (911) on the caller's phone. "
            "Call this when the caller explicitly asks to call 911, call "
            "emergency services, or get help on the phone right now."
        ),
        "parameters": {
            "type": "object",
            "properties": {},
        },
    }
