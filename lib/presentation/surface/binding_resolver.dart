import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/presentation/surface/data_model.dart';

/// Resolves a builder input by name: a declared data binding wins over a static
/// prop. Watching the bound path makes the calling widget rebuild when that
/// value changes.
extension BindingResolver on WidgetRef {
  Object? resolve(A2uiNode node, String key) {
    final path = node.bindings[key];
    if (path != null) {
      return watch(dataPathProvider(path));
    }
    return node.props[key];
  }

  /// Convenience: resolve a key as a [String], or `null`.
  String? resolveString(A2uiNode node, String key) =>
      resolve(node, key)?.toString();

  /// Convenience: resolve [key] as an [int], parsing strings when needed.
  int? resolveInt(A2uiNode node, String key) {
    final value = resolve(node, key);
    return switch (value) {
      final int v => v,
      final num v => v.toInt(),
      final String v => int.tryParse(v),
      _ => null,
    };
  }
}
