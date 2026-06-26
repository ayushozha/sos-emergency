import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/presentation/catalog/catalog_manifest.dart';
import 'package:sos_emergency/presentation/surface/catalog_registry.dart';

void main() {
  group('catalog registry / manifest consistency', () {
    test('every manifest entry is registered (the AI can only name real types)',
        () {
      for (final entry in catalogManifest) {
        expect(
          catalogRegistry.containsKey(entry.name),
          isTrue,
          reason: '${entry.name} is in the manifest but not the registry',
        );
      }
    });

    test('manifest entries are unique', () {
      final names = catalogManifest.map((e) => e.name).toList();
      expect(names.toSet().length, names.length);
    });

    test('every manifest entry documents its inputs', () {
      for (final entry in catalogManifest) {
        expect(entry.description, isNotEmpty, reason: entry.name);
        expect(entry.inputs, isNotEmpty, reason: entry.name);
      }
    });
  });
}
