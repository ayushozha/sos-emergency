import 'package:sos_emergency/domain/models/a2ui_node.dart';

/// Whether [node] or any descendant has the given component [type].
bool containsType(A2uiNode node, String type) {
  if (node.type == type) return true;
  return node.children.any((child) => containsType(child, type));
}

/// All component type names present in the tree rooted at [node].
Set<String> collectTypes(A2uiNode node) => {
  node.type,
  for (final child in node.children) ...collectTypes(child),
};
