// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'a2ui_node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$A2uiNode {

 String get type; Map<String, Object?> get props; Map<String, String> get bindings; List<A2uiNode> get children;
/// Create a copy of A2uiNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$A2uiNodeCopyWith<A2uiNode> get copyWith => _$A2uiNodeCopyWithImpl<A2uiNode>(this as A2uiNode, _$identity);

  /// Serializes this A2uiNode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is A2uiNode&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.props, props)&&const DeepCollectionEquality().equals(other.bindings, bindings)&&const DeepCollectionEquality().equals(other.children, children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(props),const DeepCollectionEquality().hash(bindings),const DeepCollectionEquality().hash(children));

@override
String toString() {
  return 'A2uiNode(type: $type, props: $props, bindings: $bindings, children: $children)';
}


}

/// @nodoc
abstract mixin class $A2uiNodeCopyWith<$Res>  {
  factory $A2uiNodeCopyWith(A2uiNode value, $Res Function(A2uiNode) _then) = _$A2uiNodeCopyWithImpl;
@useResult
$Res call({
 String type, Map<String, Object?> props, Map<String, String> bindings, List<A2uiNode> children
});




}
/// @nodoc
class _$A2uiNodeCopyWithImpl<$Res>
    implements $A2uiNodeCopyWith<$Res> {
  _$A2uiNodeCopyWithImpl(this._self, this._then);

  final A2uiNode _self;
  final $Res Function(A2uiNode) _then;

/// Create a copy of A2uiNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? props = null,Object? bindings = null,Object? children = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,props: null == props ? _self.props : props // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,bindings: null == bindings ? _self.bindings : bindings // ignore: cast_nullable_to_non_nullable
as Map<String, String>,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<A2uiNode>,
  ));
}

}


/// Adds pattern-matching-related methods to [A2uiNode].
extension A2uiNodePatterns on A2uiNode {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _A2uiNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _A2uiNode() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _A2uiNode value)  $default,){
final _that = this;
switch (_that) {
case _A2uiNode():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _A2uiNode value)?  $default,){
final _that = this;
switch (_that) {
case _A2uiNode() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  Map<String, Object?> props,  Map<String, String> bindings,  List<A2uiNode> children)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _A2uiNode() when $default != null:
return $default(_that.type,_that.props,_that.bindings,_that.children);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  Map<String, Object?> props,  Map<String, String> bindings,  List<A2uiNode> children)  $default,) {final _that = this;
switch (_that) {
case _A2uiNode():
return $default(_that.type,_that.props,_that.bindings,_that.children);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  Map<String, Object?> props,  Map<String, String> bindings,  List<A2uiNode> children)?  $default,) {final _that = this;
switch (_that) {
case _A2uiNode() when $default != null:
return $default(_that.type,_that.props,_that.bindings,_that.children);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _A2uiNode implements A2uiNode {
  const _A2uiNode({required this.type, final  Map<String, Object?> props = const <String, Object?>{}, final  Map<String, String> bindings = const <String, String>{}, final  List<A2uiNode> children = const <A2uiNode>[]}): _props = props,_bindings = bindings,_children = children;
  factory _A2uiNode.fromJson(Map<String, dynamic> json) => _$A2uiNodeFromJson(json);

@override final  String type;
 final  Map<String, Object?> _props;
@override@JsonKey() Map<String, Object?> get props {
  if (_props is EqualUnmodifiableMapView) return _props;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_props);
}

 final  Map<String, String> _bindings;
@override@JsonKey() Map<String, String> get bindings {
  if (_bindings is EqualUnmodifiableMapView) return _bindings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_bindings);
}

 final  List<A2uiNode> _children;
@override@JsonKey() List<A2uiNode> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}


/// Create a copy of A2uiNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$A2uiNodeCopyWith<_A2uiNode> get copyWith => __$A2uiNodeCopyWithImpl<_A2uiNode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$A2uiNodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _A2uiNode&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._props, _props)&&const DeepCollectionEquality().equals(other._bindings, _bindings)&&const DeepCollectionEquality().equals(other._children, _children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(_props),const DeepCollectionEquality().hash(_bindings),const DeepCollectionEquality().hash(_children));

@override
String toString() {
  return 'A2uiNode(type: $type, props: $props, bindings: $bindings, children: $children)';
}


}

/// @nodoc
abstract mixin class _$A2uiNodeCopyWith<$Res> implements $A2uiNodeCopyWith<$Res> {
  factory _$A2uiNodeCopyWith(_A2uiNode value, $Res Function(_A2uiNode) _then) = __$A2uiNodeCopyWithImpl;
@override @useResult
$Res call({
 String type, Map<String, Object?> props, Map<String, String> bindings, List<A2uiNode> children
});




}
/// @nodoc
class __$A2uiNodeCopyWithImpl<$Res>
    implements _$A2uiNodeCopyWith<$Res> {
  __$A2uiNodeCopyWithImpl(this._self, this._then);

  final _A2uiNode _self;
  final $Res Function(_A2uiNode) _then;

/// Create a copy of A2uiNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? props = null,Object? bindings = null,Object? children = null,}) {
  return _then(_A2uiNode(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,props: null == props ? _self._props : props // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,bindings: null == bindings ? _self._bindings : bindings // ignore: cast_nullable_to_non_nullable
as Map<String, String>,children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<A2uiNode>,
  ));
}


}

// dart format on
