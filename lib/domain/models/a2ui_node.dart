import 'package:freezed_annotation/freezed_annotation.dart';

part 'a2ui_node.freezed.dart';
part 'a2ui_node.g.dart';

/// The parsed structured-layout tree — the contract between the AI/transport and
/// the renderer.
///
/// A node names a catalog component [type], carries static [props], declares
/// data [bindings] (prop name → DataModel path), and nests [children]. The
/// renderer walks this tree; unknown types render nothing.
@freezed
abstract class A2uiNode with _$A2uiNode {
  const factory A2uiNode({
    required String type,
    @Default(<String, Object?>{}) Map<String, Object?> props,
    @Default(<String, String>{}) Map<String, String> bindings,
    @Default(<A2uiNode>[]) List<A2uiNode> children,
  }) = _A2uiNode;

  factory A2uiNode.fromJson(Map<String, dynamic> json) =>
      _$A2uiNodeFromJson(json);
}
