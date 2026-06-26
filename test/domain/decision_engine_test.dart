import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/domain/engine/decision_engine.dart';
import 'package:sos_emergency/domain/models/emergency_context.dart';
import 'package:sos_emergency/domain/models/emergency_enums.dart';
import 'package:sos_emergency/domain/models/severity.dart';
import 'package:sos_emergency/domain/orchestrator/scenario_library.dart';

void main() {
  const engine = DecisionEngine();
  final contexts = scenarioContexts();

  group('DecisionEngine classifies every MVP scenario', () {
    for (final entry in contexts.entries) {
      test('${entry.key.name} input classifies as ${entry.key.name}', () {
        final result = engine.classify(entry.value);
        expect(result.scenario, entry.key);
      });
    }
  });

  group('hard triggers and ordering', () {
    test('airbag deploy forces crash/critical even with another intent', () {
      final ctx = idleContext().copyWith(
        bus: const VehicleBusSnapshot(airbagDeployed: true),
        userSignals: const [UserSignal(intent: UserIntent.lockedOut)],
      );
      final result = engine.classify(ctx);
      expect(result.scenario, ScenarioClass.crash);
      expect(result.severity, Severity.critical);
      expect(result.mode, AppMode.crash);
      expect(result.confidence, greaterThan(0.95));
    });

    test('crash impulse alone is enough', () {
      final result = engine.classify(
        idleContext().copyWith(crashImpulseDetected: true),
      );
      expect(result.scenario, ScenarioClass.crash);
    });

    test('feel-unsafe while parked at night is unsafeParked, not followed', () {
      final ctx = idleContext().copyWith(
        isNight: true,
        userSignals: const [UserSignal(intent: UserIntent.feelUnsafe)],
      );
      expect(engine.classify(ctx).scenario, ScenarioClass.unsafeParked);
    });

    test('feel-unsafe while driving is an active threat', () {
      final ctx = idleContext().copyWith(
        vehicleState: VehicleState.driving,
        userSignals: const [UserSignal(intent: UserIntent.feelUnsafe)],
      );
      expect(engine.classify(ctx).scenario, ScenarioClass.beingFollowed);
    });
  });

  group('severity and mode mapping', () {
    test('roadside scenarios are moderate', () {
      expect(
        engine.classify(contexts[ScenarioClass.flatTire]!).severity,
        Severity.moderate,
      );
      expect(
        engine.classify(contexts[ScenarioClass.wontStart]!).mode,
        AppMode.roadside,
      );
    });

    test('a fire hazard escalates a moderate scenario', () {
      final ctx = contexts[ScenarioClass.flatTire]!.copyWith(
        hazards: const {Hazard.fire},
      );
      expect(engine.classify(ctx).severity, Severity.high);
    });

    test('empty context falls back to triage', () {
      final result = engine.classify(idleContext());
      expect(result.scenario, ScenarioClass.unknown);
      expect(result.mode, AppMode.triage);
      expect(result.severity, Severity.neutral);
    });
  });
}
