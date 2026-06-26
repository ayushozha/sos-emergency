import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/presentation/surface/data_model.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
  });

  group('DataModel', () {
    test('write then read round-trips a value', () {
      container.read(dataModelProvider.notifier).write('/demo/countdown', 8);
      expect(container.read(dataModelProvider)['/demo/countdown'], 8);
    });

    test('writeAll merges multiple paths', () {
      container
          .read(dataModelProvider.notifier)
          .writeAll({'/a': 1, '/b': 'two'});
      final state = container.read(dataModelProvider);
      expect(state['/a'], 1);
      expect(state['/b'], 'two');
    });

    test('dataPath reflects the latest value for a single path', () {
      final notifier = container.read(dataModelProvider.notifier)
        ..write('/demo/countdown', 5);
      expect(container.read(dataPathProvider('/demo/countdown')), 5);

      notifier.write('/demo/countdown', 4);
      expect(container.read(dataPathProvider('/demo/countdown')), 4);
    });
  });
}
