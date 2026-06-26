# SOS Design System — extracted from the handoff catalog

Source: `Automotive SOS screen catalog` handoff (Claude Design). The HTML prototypes
are the source of truth for visuals; this file distills the tokens and catalog so the
Flutter implementation matches them. (The bundled `_ds/` "HappyDic" tokens are an
unrelated default DS — **ignore them**; the real tokens are inline in the catalog HTML.)

## Visual language
Soft, tactile, premium-medical. Calm-but-urgent. Glanceable, low density, voice-first.
Safety never more than 1 tap away. Severity is conveyed by **hue + glyph + border weight
+ motion** — never color alone.

## Color tokens

### Day (default)
| role | hex |
|---|---|
| ground | `#E7E2DB` |
| surface | `#FBF9F6` |
| tray (sunken) | `#ECE7E0` |
| text | `#36322E` |
| text-muted | `#8A8276` |
| safe (green) | `#2E9E6B` (deep `#2E7D58`) |
| info (blue) | `#3A7BD0` |

### Night (dimmed)
| role | hex |
|---|---|
| ground | `#1A1714` |
| surface | `#262320` |
| raised | `#322D27` |
| text | `#EDE7DD` |
| text-muted | `#A89F92` |
| safe | `#4FC78E` |
| info | `#5BA3F0` |

### Severity tiers (token: `tier`)
| tier | hue | border | text | accent | motion |
|---|---|---|---|---|---|
| moderate | amber `#E8B032` | 2px solid | `#9C7414` | `#C79318` | none (static) |
| high | orange `#E07B3C` | 3px solid | `#B86B22` | — | slow edge breathe |
| critical | red `#DD453D` | 4px + hazard cap | `#C63A33` | brand grad `#EE5A52→#DD453D` | soft pulse 1.8s |

Neutral / no-tier exists for the opening triage screen.

## Typography
- **Hanken Grotesk** — display + body (weights 400–900).
- **JetBrains Mono** — telemetry, labels, coordinates, ETA, countdowns.
- Scale: Scream (900, 88–96px) · Headline (800, 40–48) · Body-L (600, 24–28) ·
  Label/kicker (mono 700, 16–20, uppercase tracked) · Telemetry (mono 500).

## Spacing & touch (4px base grid)
- Spacing: 4 (hairline) · 16 (control padding) · 24 (gap between actions) ·
  48 (section rhythm) · 64 (surface edge inset).
- Touch targets: 44 min · 88 tap · 120 primary · 200+ panic. Radius ~14–24.

## Motion
- Durations: fast 150ms · base 240ms. Ease `cubic-bezier(.2,.7,.2,1)`.
- `sosPulse` 1.8s (critical only) · `liveDot` blink (broadcasting) ·
  `micWave` (mic open) · `shimmer` (skeleton/streaming).
- Honor `prefers-reduced-motion` (→ `MediaQuery.disableAnimations`).

## Widget catalog (the AI's vocabulary)
Each widget ships **loading / empty / offline** fallbacks. The DATA line doubles as the
agent-facing description. `tier`/`theme`/`carState` are inherited context tokens.

### Sticky global · panic (always reachable, 1 tap)
- **SOSCallButton** — oversized one-tap 911. Pinned, never scrolls. No confirm dialog.
  Data: `emergencyNumber` (localized), `callState` (idle·connecting·active),
  `callDuration`. Writes `/sos/call`.
- **ShareLocationAction** — start/stop live location broadcast; on/off unmistakable.
  Data: `isSharing`, `recipients[]`, `coords`. Writes `/sos/location/active`.
- **NotifyContactsAction** — alert trusted contacts; per-person delivery status.
  Data: `contacts[]{name,relation,status:queued·sending·reached·failed}`, `message`.
  Writes `/sos/notify`.
- **ImSafeCancel** — press-and-hold abort of countdown/auto-escalation. Data: `holdMs`,
  `target`. Writes `/sos/abort`.

### Container · layout
- **EmergencyRoot** — the Surface root. Carries `tier`,`theme`,`carState`,`surface`
  (child slot). Guarantees the persistent safety layer (SOS rail + live-location) —
  not part of AI composition. Driving suppresses all but banner + 1 primary + rail.
- **ActionStack** — vertical stack of primary actions ranked by safety. Collapses to a
  single giant button when `carState=driving`. Data: `actions[]{label,icon,tier,priority}`.
- **SectionCard** — bordered grouping, optional title + left tier accent. `title?`,
  `tier`, `children`. Pure container.

### Interactive inputs (low-friction, big targets)
- **BigChoiceCard** — large icon-led single-select; the "What's happening?" grid.
  Data: `label`,`icon`,`value`. Writes `/triage/intent`.
- **YesNoLarge** — two half-surface targets for one critical yes/no. `question`,
  `yesAction`/`noAction`. Writes `/triage/answer`.
- **StepChecklist** — guided steps, one "hot" at a time; offline-first. `steps[]{title,
  detail,done}`, `currentIndex`. Writes `/guide/step`.
- **PushToTalk** — prominent voice entry; idle·listening·processing + live transcript.
  Data: `state`, `transcript`. Writes `/voice/utterance`.

### Read-only status & guidance
- **SeverityBanner** — tier indicator pinned top: color + label + glyph + border.
  `tier`,`label`,`context?`. Read-only.
- **GuidanceCallout** — single most important instruction, AI imperative voice, scream
  type. One on screen. `text`,`tier`,`kicker?`. Auto-scales, no overflow.
- **LocationCard** — address + mono coords + share status. `coords`,`address`,
  `accuracy`,`isSharing`. Last-known cached offline.
- **CountdownCard** — crash auto-escalation ring counting to auto-911. Paired with
  ImSafeCancel. `secondsLeft`,`totalSeconds`,`onExpire`. Cancel writes `/sos/abort`.
- **ContactStatusList** — read-only roster + reached status. `contacts[]{name,relation,
  status,reachedAt}`. Mirror of `/sos/notify`.
- **VehicleStatusCard** — relevant vehicle telemetry, shown only when useful.
  `metrics[]{label,value,tier}`, `profile`. Hidden when irrelevant.

### Visualization · spatial
- **SafeRouteMap** — map layer that only routes to safety (police/fire/hospital/public);
  hides "home"/private places in threat mode. `origin`,`destinations[]{type,name,
  distance,openNow}`,`threatMode`.
- **ETACard** — tracks inbound responder/roadside truck. `provider`,`etaMinutes`,
  `progress`,`distance`. Read-only.
- **WeatherHazardCard** — weather/road-hazard context carrying its own tier.
  `condition`,`tier`,`advice`,`metrics`,`cachedAt?`.

### Cross-cutting fallback contract
Every widget declares `loading` (shimmer matching final shape), `empty` (calm, offers
one next step), `offline` (bundled guidance renders fully; live data shows cached tag).
The persistent SOS rail + offline banner never depend on network/streamed state.

## Example screens (6, in "SOS Screens")
opening triage (neutral, parked) · critical crash (countdown auto-escalate) ·
being-followed-at-night (threat, SafeRouteMap) · suspected heart attack (medical) ·
flat tire (roadside StepChecklist) · won't-start offline. Each labelled car-state +
severity and lists the composed widgets.
