import 'package:sos_emergency/domain/catalog/catalog_components.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/domain/models/classification.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/models/surface.dart';

/// The deterministic guardrail layer. Every Surface — deterministic baseline
/// and AI-proposed alike — passes through [enforce] before it can render. The
/// Supervisor cannot be overridden by model output; when a candidate degrades
/// below the safety floor it returns the baseline marked as a fallback.
///
/// Pure Dart, no Flutter — the single most heavily tested component (see the
/// adversarial suite).
class SafetySupervisor {
  const SafetySupervisor();

  /// Validates [candidate] against the guardrails, repairing what it can and
  /// falling back to [baseline] when an essential invariant can't be met.
  Surface enforce(
    Surface candidate, {
    required Surface baseline,
    required Classification classification,
  }) {
    final root = candidate.root;

    // R1: the persistent safety layer (911 + live-location + voice) lives in
    // EmergencyRoot. If the root isn't one, the rail isn't guaranteed — bypass
    // the candidate entirely.
    if (root.type != 'EmergencyRoot') return _fallback(baseline);

    // R4: reject unknown components — strip subtrees the renderer can't build.
    final stripped = _stripUnknown(root);
    if (stripped == null) return _fallback(baseline);
    var safeRoot = stripped;

    // R2: in a threat, SafeRouteMap may only route to safety. Never home.
    if (classification.mode == AppMode.threat) {
      safeRoot = _restrictRouting(safeRoot);
    }

    // R3: an auto-escalating countdown must always expose a labelled cancel.
    if (_contains(safeRoot, 'CountdownCard') &&
        !_contains(safeRoot, 'ImSafeCancel')) {
      safeRoot = safeRoot.copyWith(
        children: [
          ...safeRoot.children,
          const A2uiNode(type: 'ImSafeCancel', props: {'holdMs': 1200}),
        ],
      );
    }

    // R6: while driving, collapse to the minimal/voice-first variant — the
    // banner plus a single primary action. The persistent rail (in
    // EmergencyRoot) still covers 911 + share-location + voice.
    if (safeRoot.props['carState'] == 'driving') {
      safeRoot = _collapseForDriving(safeRoot);
    }

    // R5: if enforcement stripped the surface empty, fall back.
    if (safeRoot.children.isEmpty) return _fallback(baseline);

    return candidate.copyWith(root: safeRoot);
  }

  /// Components that may remain as the single "primary" while driving.
  static const Set<String> _drivingPrimaries = {
    'ActionStack',
    'SOSCallButton',
    'GuidanceCallout',
    'CountdownCard',
    'YesNoLarge',
    'PushToTalk',
  };

  /// Keeps at most the first SeverityBanner and the first primary action,
  /// dropping everything else so a driver isn't asked to read or scroll.
  A2uiNode _collapseForDriving(A2uiNode root) {
    A2uiNode? banner;
    A2uiNode? primary;
    for (final child in root.children) {
      if (child.type == 'SeverityBanner') {
        banner ??= child;
      } else if (primary == null && _drivingPrimaries.contains(child.type)) {
        primary = child;
      }
    }
    return root.copyWith(children: [?banner, ?primary]);
  }

  Surface _fallback(Surface baseline) => baseline.copyWith(isFallback: true);

  /// Drops any node whose type isn't in the catalog allow-list, recursively.
  /// Returns null when [node] itself is unknown.
  A2uiNode? _stripUnknown(A2uiNode node) {
    if (!knownComponents.contains(node.type)) return null;
    final children = node.children
        .map(_stripUnknown)
        .whereType<A2uiNode>()
        .toList();
    return node.copyWith(children: children);
  }

  /// Forces every SafeRouteMap into threat mode and removes any destination
  /// that isn't a recognised safe place.
  A2uiNode _restrictRouting(A2uiNode node) {
    var current = node;
    if (node.type == 'SafeRouteMap') {
      final raw = (node.props['destinations'] as List?) ?? const [];
      final safe = raw.where((d) {
        if (d is! Map) return false;
        return safeDestinationTypes.contains(d['type']?.toString());
      }).toList();
      current = node.copyWith(
        props: {...node.props, 'destinations': safe, 'threatMode': true},
      );
    }
    return current.copyWith(
      children: current.children.map(_restrictRouting).toList(),
    );
  }

  bool _contains(A2uiNode node, String type) {
    if (node.type == type) return true;
    return node.children.any((child) => _contains(child, type));
  }
}
