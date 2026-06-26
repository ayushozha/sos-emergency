// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'a2ui_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_A2uiNode _$A2uiNodeFromJson(Map<String, dynamic> json) => _A2uiNode(
  type: json['type'] as String,
  props: json['props'] as Map<String, dynamic>? ?? const <String, Object?>{},
  bindings:
      (json['bindings'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
  children:
      (json['children'] as List<dynamic>?)
          ?.map((e) => A2uiNode.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <A2uiNode>[],
);

Map<String, dynamic> _$A2uiNodeToJson(_A2uiNode instance) => <String, dynamic>{
  'type': instance.type,
  'props': instance.props,
  'bindings': instance.bindings,
  'children': instance.children,
};
