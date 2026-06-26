import 'dart:developer' as developer;

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sos_emergency/domain/models/classification.dart';

part 'telemetry.g.dart';

/// Which composer produced the rendered surface.
enum SurfaceSource { baseline, ai }

/// One structured record of a loop iteration — context → classification →
/// which composer won → whether the Supervisor fell back. Essential for
/// debugging non-deterministic AI behaviour in the field. PII is never logged.
class LoopEvent {
  const LoopEvent({
    required this.scenario,
    required this.severity,
    required this.mode,
    required this.source,
    required this.isFallback,
  });

  final String scenario;
  final String severity;
  final String mode;
  final SurfaceSource source;
  final bool isFallback;

  @override
  String toString() =>
      'LoopEvent(scenario: $scenario, severity: $severity, mode: $mode, '
      'source: ${source.name}, fallback: $isFallback)';
}

/// Receives loop events. Swappable for a crash-reporter / analytics backend.
// Sink seam: kept abstract for DI despite the single method.
// ignore: one_member_abstracts
abstract interface class TelemetrySink {
  void record(LoopEvent event);
}

/// Logs events to the Dart developer timeline. Redacts PII by construction —
/// [LoopEvent] carries no location/medical fields.
class DeveloperTelemetrySink implements TelemetrySink {
  const DeveloperTelemetrySink();

  @override
  void record(LoopEvent event) =>
      developer.log(event.toString(), name: 'sos.loop');
}

/// Captures events in memory — used by tests and dashboards.
class RecordingTelemetrySink implements TelemetrySink {
  final List<LoopEvent> events = [];

  @override
  void record(LoopEvent event) => events.add(event);
}

@Riverpod(keepAlive: true)
TelemetrySink telemetry(Ref ref) => const DeveloperTelemetrySink();

/// Builds a [LoopEvent] from a classification + outcome.
LoopEvent loopEventFor(
  Classification classification, {
  required SurfaceSource source,
  required bool isFallback,
}) => LoopEvent(
  scenario: classification.scenario.name,
  severity: classification.severity.name,
  mode: classification.mode.name,
  source: source,
  isFallback: isFallback,
);
