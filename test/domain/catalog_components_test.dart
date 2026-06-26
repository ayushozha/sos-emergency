import 'package:flutter_test/flutter_test.dart';
import 'package:sos_emergency/domain/catalog/catalog_components.dart';
import 'package:sos_emergency/presentation/surface/catalog_registry.dart';

void main() {
  test(
    'the supervisor allow-list matches the presentation registry exactly',
    () {
      // If these drift, the Supervisor would either strip renderable components
      // or admit ones the renderer cannot build.
      expect(catalogRegistry.keys.toSet(), knownComponents);
    },
  );
}
