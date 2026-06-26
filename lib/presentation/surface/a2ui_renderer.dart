import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos_emergency/domain/models/a2ui_node.dart';
import 'package:sos_emergency/presentation/surface/catalog_registry.dart';

/// Walks a validated [A2uiNode] tree and builds widgets, resolving data
/// bindings against the DataModel via the registered builders.
///
/// Unknown component types render nothing — the registry is the allow-list over
/// what can ever appear on screen.
class A2uiRenderer extends ConsumerWidget {
  const A2uiRenderer({required this.node, super.key});

  final A2uiNode node;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final builder = catalogRegistry[node.type];
    if (builder == null) {
      return const SizedBox.shrink(); // unknown == nothing
    }
    return builder(context, ref, node);
  }
}
