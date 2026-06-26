import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos_emergency/app/theme/sos_tokens.dart';
import 'package:sos_emergency/app/theme/surface_palette.dart';
import 'package:sos_emergency/application/orchestrator.dart';
import 'package:sos_emergency/data/voice_session/voice_session_repository.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/presentation/catalog/shared/sos_chrome.dart';
import 'package:sos_emergency/presentation/catalog/shared/sos_icons.dart';
import 'package:sos_emergency/presentation/catalog/voice_wake_listener.dart';
import 'package:sos_emergency/presentation/surface/a2ui_renderer.dart';
import 'package:sos_emergency/presentation/surface/binding_resolver.dart';
import 'package:sos_emergency/presentation/surface/surface_theme_providers.dart';
import 'package:sos_emergency/shared/backend_config.dart';

/// `BigChoiceCard` — a large, icon-led, mutually-exclusive choice. One tap
/// selects and advances; no submit step. Inputs: `label`, `icon`, `selected?`.
Widget buildBigChoiceCard(BuildContext context, WidgetRef ref, A2uiNode node) {
  final palette = ref.watch(surfacePaletteProvider);
  final label = ref.resolveString(node, 'label') ?? '';
  final icon = SosIcons.resolve(ref.resolveString(node, 'icon'));
  final selected = ref.resolve(node, 'selected') == true;

  return Container(
    constraints: const BoxConstraints(minHeight: 150),
    padding: const EdgeInsets.all(SosTokens.space4),
    decoration: BoxDecoration(
      color: palette.surface,
      borderRadius: BorderRadius.circular(SosTokens.radiusLg),
      border: Border.all(
        color: selected
            ? palette.info
            : palette.textMuted.withValues(alpha: 0.16),
        width: selected ? 2 : 1,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: palette.tray,
            borderRadius: BorderRadius.circular(SosTokens.radiusSm),
          ),
          child: Icon(icon, color: palette.textMuted, size: 26),
        ),
        const SizedBox(height: SosTokens.space3),
        Text(label, style: SosText.title(palette.text)),
      ],
    ),
  );
}

/// `ChoiceGrid` — arranges nested `BigChoiceCard`s in a fixed-column grid; the
/// opening "What's happening?" surface. Input: `columns` (default 4).
Widget buildChoiceGrid(BuildContext context, WidgetRef ref, A2uiNode node) {
  final columns = (node.props['columns'] as num?)?.toInt() ?? 4;
  return LayoutBuilder(
    builder: (context, constraints) {
      const gap = SosTokens.space3;
      final tileWidth = (constraints.maxWidth - gap * (columns - 1)) / columns;
      return Wrap(
        spacing: gap,
        runSpacing: gap,
        children: [
          for (final child in node.children)
            SizedBox(
              width: tileWidth,
              child: A2uiRenderer(node: child),
            ),
        ],
      );
    },
  );
}

/// `YesNoLarge` — two half-surface targets for one critical yes/no. Voice-
/// answerable. Inputs: `question`, `yesLabel?`, `noLabel?`, `yesHint?`,
/// `noHint?`.
Widget buildYesNoLarge(BuildContext context, WidgetRef ref, A2uiNode node) {
  final palette = ref.watch(surfacePaletteProvider);
  final question = ref.resolveString(node, 'question') ?? '';
  return SosCard(
    palette: palette,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          question,
          textAlign: TextAlign.center,
          style: SosText.headline(palette.text),
        ),
        const SizedBox(height: SosTokens.space4),
        Row(
          children: [
            Expanded(
              child: _YesNoTile(
                label: ref.resolveString(node, 'yesLabel') ?? 'Yes',
                hint: ref.resolveString(node, 'yesHint'),
                emphatic: true,
                palette: palette,
              ),
            ),
            const SizedBox(width: SosTokens.space3),
            Expanded(
              child: _YesNoTile(
                label: ref.resolveString(node, 'noLabel') ?? 'No',
                hint: ref.resolveString(node, 'noHint'),
                emphatic: false,
                palette: palette,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _YesNoTile extends StatelessWidget {
  const _YesNoTile({
    required this.label,
    required this.hint,
    required this.emphatic,
    required this.palette,
  });

  final String label;
  final String? hint;
  final bool emphatic;
  final SurfacePalette palette;

  @override
  Widget build(BuildContext context) {
    final fg = emphatic ? Colors.white : palette.text;
    return Container(
      height: SosTokens.touchPrimary,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: emphatic
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [SosTokens.brandRedLight, SosTokens.brandRedDark],
              )
            : null,
        color: emphatic ? null : palette.surface,
        borderRadius: BorderRadius.circular(SosTokens.radiusMd),
        border: emphatic
            ? null
            : Border.all(color: palette.textMuted.withValues(alpha: 0.22)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: SosText.scream(fg).copyWith(fontSize: 34),
          ),
          if (hint != null)
            Text(
              hint!,
              style: SosText.body(emphatic ? Colors.white : palette.textMuted),
            ),
        ],
      ),
    );
  }
}

/// `StepChecklist` — guided steps with strong current-step emphasis; one "hot"
/// step at a time, done steps recede, future steps dim. Works offline.
/// Inputs: `title?`, `steps[]{title,detail,done}`, `currentIndex`.
Widget buildStepChecklist(BuildContext context, WidgetRef ref, A2uiNode node) {
  final palette = ref.watch(surfacePaletteProvider);
  final title = ref.resolveString(node, 'title');
  final currentIndex = ref.resolveInt(node, 'currentIndex') ?? 0;
  final steps = (ref.resolve(node, 'steps') as List?) ?? const [];

  return SosCard(
    palette: palette,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) ...[
          Text(
            '${title.toUpperCase()} · STEP '
            '${currentIndex + 1} OF ${steps.length}',
            style: SosText.label(palette.textMuted),
          ),
          const SizedBox(height: SosTokens.space4),
        ],
        for (var i = 0; i < steps.length; i++) ...[
          if (i > 0) const SizedBox(height: SosTokens.space3),
          _StepRow(
            palette: palette,
            index: i,
            data: (steps[i] as Map).cast<String, Object?>(),
            isCurrent: i == currentIndex,
          ),
        ],
      ],
    ),
  );
}

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.palette,
    required this.index,
    required this.data,
    required this.isCurrent,
  });

  final SurfacePalette palette;
  final int index;
  final Map<String, Object?> data;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final title = data['title']?.toString() ?? '';
    final detail = data['detail']?.toString();
    final done = data['done'] == true;
    const amber = SosTokens.moderate;

    final marker = CircleAvatar(
      radius: 18,
      backgroundColor: done
          ? palette.safe
          : isCurrent
          ? amber
          : palette.surface,
      child: done
          ? const Icon(Icons.check_rounded, color: Colors.white, size: 20)
          : Text(
              '${index + 1}',
              style: SosText.title(
                isCurrent ? Colors.white : palette.textMuted,
              ),
            ),
    );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: SosText.title(
            done || !isCurrent ? palette.textMuted : palette.text,
          ).copyWith(decoration: done ? TextDecoration.lineThrough : null),
        ),
        if (detail != null && isCurrent)
          Text(detail, style: SosText.body(palette.textMuted)),
      ],
    );

    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        marker,
        const SizedBox(width: SosTokens.space3),
        Expanded(child: content),
      ],
    );

    if (!isCurrent) {
      return Opacity(opacity: done ? 0.6 : 0.45, child: row);
    }
    return Container(
      padding: const EdgeInsets.all(SosTokens.space4),
      decoration: BoxDecoration(
        color: amber.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(SosTokens.radiusMd),
        border: Border.all(color: amber, width: 2),
      ),
      child: row,
    );
  }
}

/// `PushToTalk` — prominent voice entry; the primary input while driving. Big
/// mic target, unmistakable listening state, live transcript. Inputs: `state`
/// (idle·listening·processing), `transcript?`.
Widget buildPushToTalk(BuildContext context, WidgetRef ref, A2uiNode node) {
  return _PushToTalk(node: node);
}

class _PushToTalk extends ConsumerStatefulWidget {
  const _PushToTalk({required this.node});

  final A2uiNode node;

  @override
  ConsumerState<_PushToTalk> createState() => _PushToTalkState();
}

class _PushToTalkState extends ConsumerState<_PushToTalk> {
  VoiceWakeListener? _wakeListener;
  StreamSubscription<VoiceFrame>? _voiceFrames;
  String? _state;
  String? _transcript;
  bool _backendBusy = false;

  @override
  void initState() {
    super.initState();
    _wakeListener = VoiceWakeListener(
      onWakePhrase: _activateFromSpeech,
      onTranscript: _showHeardText,
      onError: _showWakeError,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _wakeListener?.start();
    });
  }

  @override
  void dispose() {
    _wakeListener?.stop();
    unawaited(_voiceFrames?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = _state ?? ref.resolveString(widget.node, 'state') ?? 'idle';
    final transcript =
        _transcript ?? ref.resolveString(widget.node, 'transcript');
    return _PushToTalkBody(
      state: state,
      transcript: transcript,
      onTap: () => unawaited(_activate('Hey, emergency')),
    );
  }

  Future<void> _activate(String text) async {
    final utterance = text.trim().isEmpty ? 'Hey, emergency' : text.trim();
    _showListening(utterance);
    _routeFromTranscript(utterance);
    _wakeListener?.start();

    if (!BackendConfig.useBackend || _backendBusy) return;

    _backendBusy = true;
    _voiceFrames ??= ref
        .read(voiceSessionRepositoryProvider)
        .frames
        .listen(_handleVoiceFrame);
    try {
      final voice = ref.read(voiceSessionRepositoryProvider);
      await voice.connect();
      voice.sendText(utterance);
    } on Object catch (error) {
      _showVoiceError(error.toString());
    } finally {
      _backendBusy = false;
    }
  }

  void _activateFromSpeech(String transcript) {
    unawaited(_activate(transcript));
  }

  void _handleVoiceFrame(VoiceFrame frame) {
    if (!mounted) return;
    switch (frame) {
      case VoiceTranscriptFrame(:final text):
        _showHeardText(text);
        _routeFromTranscript(text);
      case VoiceIntentFrame(:final intent):
        _routeFromIntent(intent);
      case VoiceErrorFrame(:final message):
        _showVoiceError(message);
    }
  }

  void _showListening(String transcript) {
    if (!mounted) return;
    setState(() {
      _state = 'listening';
      _transcript = _isWakePhrase(transcript) ? 'Listening...' : transcript;
    });
  }

  void _showHeardText(String transcript) {
    if (!mounted || transcript.trim().isEmpty) return;
    setState(() {
      _state = 'listening';
      _transcript = transcript.trim();
    });
  }

  void _showVoiceError(String message) {
    if (!mounted || message.trim().isEmpty) return;
    setState(() {
      _state = 'idle';
      _transcript = message;
    });
  }

  void _showWakeError(String message) {
    if (!mounted || message.trim().isEmpty || _state == 'listening') return;
    setState(() {
      _state = 'idle';
      _transcript = message;
    });
  }

  void _routeFromTranscript(String transcript) {
    final scenario = _scenarioFromTranscript(transcript);
    if (scenario == null) return;
    ref.read(demoScenarioProvider.notifier).select(scenario);
    ref
        .read(surfaceViewModeControllerProvider.notifier)
        .select(SurfaceViewMode.live);
  }

  void _routeFromIntent(UserIntent intent) {
    final scenario = switch (intent) {
      UserIntent.carProblem ||
      UserIntent.roadside ||
      UserIntent.outOfGas => ScenarioClass.wontStart,
      UserIntent.crash => ScenarioClass.crash,
      UserIntent.medical => ScenarioClass.medical,
      UserIntent.feelUnsafe => ScenarioClass.unsafeParked,
      UserIntent.beingFollowed => ScenarioClass.beingFollowed,
      UserIntent.lockedOut => ScenarioClass.lockedOut,
      UserIntent.document || UserIntent.none => null,
    };
    if (scenario == null) return;
    ref.read(demoScenarioProvider.notifier).select(scenario);
    ref
        .read(surfaceViewModeControllerProvider.notifier)
        .select(SurfaceViewMode.live);
  }

  ScenarioClass? _scenarioFromTranscript(String transcript) {
    final normalized = transcript.toLowerCase();
    if (normalized.contains('crash') || normalized.contains('accident')) {
      return ScenarioClass.crash;
    }
    if (normalized.contains('medical') ||
        normalized.contains('heart') ||
        normalized.contains('chest pain')) {
      return ScenarioClass.medical;
    }
    if (normalized.contains('followed') ||
        normalized.contains('following me')) {
      return ScenarioClass.beingFollowed;
    }
    if (normalized.contains('unsafe') || normalized.contains('scared')) {
      return ScenarioClass.unsafeParked;
    }
    if (normalized.contains('locked out')) {
      return ScenarioClass.lockedOut;
    }
    if (normalized.contains('roadside') ||
        normalized.contains('battery') ||
        normalized.contains('tire') ||
        normalized.contains('gas')) {
      return ScenarioClass.wontStart;
    }
    return null;
  }

  bool _isWakePhrase(String transcript) {
    final normalized = transcript.toLowerCase().replaceAll(',', '');
    return normalized.contains('hey emergency') ||
        normalized.contains('hay emergency');
  }
}

class _PushToTalkBody extends ConsumerWidget {
  const _PushToTalkBody({
    required this.state,
    required this.transcript,
    required this.onTap,
  });

  final String state;
  final String? transcript;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(surfacePaletteProvider);
    final listening = state == 'listening';

    return Semantics(
      button: true,
      label: 'Tap to speak',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(SosTokens.space5),
          decoration: BoxDecoration(
            color: listening
                ? palette.safe.withValues(alpha: 0.12)
                : palette.tray,
            borderRadius: BorderRadius.circular(SosTokens.radiusMd),
            border: listening ? Border.all(color: palette.safe) : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: palette.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: listening
                        ? palette.safe
                        : palette.textMuted.withValues(alpha: 0.2),
                    width: listening ? 2 : 1,
                  ),
                ),
                child: Icon(
                  SosIcons.resolve('voice'),
                  size: 44,
                  color: listening ? palette.safe : palette.textMuted,
                ),
              ),
              const SizedBox(height: SosTokens.space4),
              if (listening)
                Text(
                  transcript ?? 'Listening…',
                  textAlign: TextAlign.center,
                  style: SosText.body(SosStatus.reached),
                )
              else
                Column(
                  children: [
                    Text('Tap to speak', style: SosText.headline(palette.text)),
                    const SizedBox(height: SosTokens.space1),
                    Text(
                      'or say "Hey, emergency"',
                      style: SosText.body(palette.textMuted),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
