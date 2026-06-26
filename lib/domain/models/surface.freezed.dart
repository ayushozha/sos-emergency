// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surface.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Surface {

 AppMode get mode; Severity get severity; A2uiNode get root; bool get isFallback;
/// Create a copy of Surface
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurfaceCopyWith<Surface> get copyWith => _$SurfaceCopyWithImpl<Surface>(this as Surface, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Surface&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.root, root) || other.root == root)&&(identical(other.isFallback, isFallback) || other.isFallback == isFallback));
}


@override
int get hashCode => Object.hash(runtimeType,mode,severity,root,isFallback);

@override
String toString() {
  return 'Surface(mode: $mode, severity: $severity, root: $root, isFallback: $isFallback)';
}


}

/// @nodoc
abstract mixin class $SurfaceCopyWith<$Res>  {
  factory $SurfaceCopyWith(Surface value, $Res Function(Surface) _then) = _$SurfaceCopyWithImpl;
@useResult
$Res call({
 AppMode mode, Severity severity, A2uiNode root, bool isFallback
});


$A2uiNodeCopyWith<$Res> get root;

}
/// @nodoc
class _$SurfaceCopyWithImpl<$Res>
    implements $SurfaceCopyWith<$Res> {
  _$SurfaceCopyWithImpl(this._self, this._then);

  final Surface _self;
  final $Res Function(Surface) _then;

/// Create a copy of Surface
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? severity = null,Object? root = null,Object? isFallback = null,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AppMode,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as Severity,root: null == root ? _self.root : root // ignore: cast_nullable_to_non_nullable
as A2uiNode,isFallback: null == isFallback ? _self.isFallback : isFallback // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Surface
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$A2uiNodeCopyWith<$Res> get root {
  
  return $A2uiNodeCopyWith<$Res>(_self.root, (value) {
    return _then(_self.copyWith(root: value));
  });
}
}


/// Adds pattern-matching-related methods to [Surface].
extension SurfacePatterns on Surface {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Surface value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Surface() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Surface value)  $default,){
final _that = this;
switch (_that) {
case _Surface():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Surface value)?  $default,){
final _that = this;
switch (_that) {
case _Surface() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppMode mode,  Severity severity,  A2uiNode root,  bool isFallback)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Surface() when $default != null:
return $default(_that.mode,_that.severity,_that.root,_that.isFallback);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppMode mode,  Severity severity,  A2uiNode root,  bool isFallback)  $default,) {final _that = this;
switch (_that) {
case _Surface():
return $default(_that.mode,_that.severity,_that.root,_that.isFallback);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppMode mode,  Severity severity,  A2uiNode root,  bool isFallback)?  $default,) {final _that = this;
switch (_that) {
case _Surface() when $default != null:
return $default(_that.mode,_that.severity,_that.root,_that.isFallback);case _:
  return null;

}
}

}

/// @nodoc


class _Surface implements Surface {
  const _Surface({required this.mode, required this.severity, required this.root, this.isFallback = true});
  

@override final  AppMode mode;
@override final  Severity severity;
@override final  A2uiNode root;
@override@JsonKey() final  bool isFallback;

/// Create a copy of Surface
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurfaceCopyWith<_Surface> get copyWith => __$SurfaceCopyWithImpl<_Surface>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Surface&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.root, root) || other.root == root)&&(identical(other.isFallback, isFallback) || other.isFallback == isFallback));
}


@override
int get hashCode => Object.hash(runtimeType,mode,severity,root,isFallback);

@override
String toString() {
  return 'Surface(mode: $mode, severity: $severity, root: $root, isFallback: $isFallback)';
}


}

/// @nodoc
abstract mixin class _$SurfaceCopyWith<$Res> implements $SurfaceCopyWith<$Res> {
  factory _$SurfaceCopyWith(_Surface value, $Res Function(_Surface) _then) = __$SurfaceCopyWithImpl;
@override @useResult
$Res call({
 AppMode mode, Severity severity, A2uiNode root, bool isFallback
});


@override $A2uiNodeCopyWith<$Res> get root;

}
/// @nodoc
class __$SurfaceCopyWithImpl<$Res>
    implements _$SurfaceCopyWith<$Res> {
  __$SurfaceCopyWithImpl(this._self, this._then);

  final _Surface _self;
  final $Res Function(_Surface) _then;

/// Create a copy of Surface
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? severity = null,Object? root = null,Object? isFallback = null,}) {
  return _then(_Surface(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AppMode,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as Severity,root: null == root ? _self.root : root // ignore: cast_nullable_to_non_nullable
as A2uiNode,isFallback: null == isFallback ? _self.isFallback : isFallback // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Surface
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$A2uiNodeCopyWith<$Res> get root {
  
  return $A2uiNodeCopyWith<$Res>(_self.root, (value) {
    return _then(_self.copyWith(root: value));
  });
}
}

// dart format on
