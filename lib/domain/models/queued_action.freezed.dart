// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queued_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QueuedAction {

 String get id; QueuedActionKind get kind; Map<String, Object?> get payload;
/// Create a copy of QueuedAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueuedActionCopyWith<QueuedAction> get copyWith => _$QueuedActionCopyWithImpl<QueuedAction>(this as QueuedAction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueuedAction&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&const DeepCollectionEquality().equals(other.payload, payload));
}


@override
int get hashCode => Object.hash(runtimeType,id,kind,const DeepCollectionEquality().hash(payload));

@override
String toString() {
  return 'QueuedAction(id: $id, kind: $kind, payload: $payload)';
}


}

/// @nodoc
abstract mixin class $QueuedActionCopyWith<$Res>  {
  factory $QueuedActionCopyWith(QueuedAction value, $Res Function(QueuedAction) _then) = _$QueuedActionCopyWithImpl;
@useResult
$Res call({
 String id, QueuedActionKind kind, Map<String, Object?> payload
});




}
/// @nodoc
class _$QueuedActionCopyWithImpl<$Res>
    implements $QueuedActionCopyWith<$Res> {
  _$QueuedActionCopyWithImpl(this._self, this._then);

  final QueuedAction _self;
  final $Res Function(QueuedAction) _then;

/// Create a copy of QueuedAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? payload = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as QueuedActionKind,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}

}


/// Adds pattern-matching-related methods to [QueuedAction].
extension QueuedActionPatterns on QueuedAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueuedAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueuedAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueuedAction value)  $default,){
final _that = this;
switch (_that) {
case _QueuedAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueuedAction value)?  $default,){
final _that = this;
switch (_that) {
case _QueuedAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  QueuedActionKind kind,  Map<String, Object?> payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueuedAction() when $default != null:
return $default(_that.id,_that.kind,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  QueuedActionKind kind,  Map<String, Object?> payload)  $default,) {final _that = this;
switch (_that) {
case _QueuedAction():
return $default(_that.id,_that.kind,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  QueuedActionKind kind,  Map<String, Object?> payload)?  $default,) {final _that = this;
switch (_that) {
case _QueuedAction() when $default != null:
return $default(_that.id,_that.kind,_that.payload);case _:
  return null;

}
}

}

/// @nodoc


class _QueuedAction implements QueuedAction {
  const _QueuedAction({required this.id, required this.kind, final  Map<String, Object?> payload = const <String, Object?>{}}): _payload = payload;
  

@override final  String id;
@override final  QueuedActionKind kind;
 final  Map<String, Object?> _payload;
@override@JsonKey() Map<String, Object?> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}


/// Create a copy of QueuedAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueuedActionCopyWith<_QueuedAction> get copyWith => __$QueuedActionCopyWithImpl<_QueuedAction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueuedAction&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&const DeepCollectionEquality().equals(other._payload, _payload));
}


@override
int get hashCode => Object.hash(runtimeType,id,kind,const DeepCollectionEquality().hash(_payload));

@override
String toString() {
  return 'QueuedAction(id: $id, kind: $kind, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$QueuedActionCopyWith<$Res> implements $QueuedActionCopyWith<$Res> {
  factory _$QueuedActionCopyWith(_QueuedAction value, $Res Function(_QueuedAction) _then) = __$QueuedActionCopyWithImpl;
@override @useResult
$Res call({
 String id, QueuedActionKind kind, Map<String, Object?> payload
});




}
/// @nodoc
class __$QueuedActionCopyWithImpl<$Res>
    implements _$QueuedActionCopyWith<$Res> {
  __$QueuedActionCopyWithImpl(this._self, this._then);

  final _QueuedAction _self;
  final $Res Function(_QueuedAction) _then;

/// Create a copy of QueuedAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? payload = null,}) {
  return _then(_QueuedAction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as QueuedActionKind,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}


}

// dart format on
