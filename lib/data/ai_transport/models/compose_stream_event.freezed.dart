// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compose_stream_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
ComposeStreamEvent _$ComposeStreamEventFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'node':
          return ComposeStreamNode.fromJson(
            json
          );
                case 'done':
          return ComposeStreamDone.fromJson(
            json
          );
                case 'error':
          return ComposeStreamError.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'ComposeStreamEvent',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$ComposeStreamEvent {



  /// Serializes this ComposeStreamEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComposeStreamEvent);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ComposeStreamEvent()';
}


}

/// @nodoc
class $ComposeStreamEventCopyWith<$Res>  {
$ComposeStreamEventCopyWith(ComposeStreamEvent _, $Res Function(ComposeStreamEvent) __);
}


/// Adds pattern-matching-related methods to [ComposeStreamEvent].
extension ComposeStreamEventPatterns on ComposeStreamEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ComposeStreamNode value)?  node,TResult Function( ComposeStreamDone value)?  done,TResult Function( ComposeStreamError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ComposeStreamNode() when node != null:
return node(_that);case ComposeStreamDone() when done != null:
return done(_that);case ComposeStreamError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ComposeStreamNode value)  node,required TResult Function( ComposeStreamDone value)  done,required TResult Function( ComposeStreamError value)  error,}){
final _that = this;
switch (_that) {
case ComposeStreamNode():
return node(_that);case ComposeStreamDone():
return done(_that);case ComposeStreamError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ComposeStreamNode value)?  node,TResult? Function( ComposeStreamDone value)?  done,TResult? Function( ComposeStreamError value)?  error,}){
final _that = this;
switch (_that) {
case ComposeStreamNode() when node != null:
return node(_that);case ComposeStreamDone() when done != null:
return done(_that);case ComposeStreamError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( A2uiNode node,  String? parentId)?  node,TResult Function( ComposeFinishReason finishReason)?  done,TResult Function( String code,  String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ComposeStreamNode() when node != null:
return node(_that.node,_that.parentId);case ComposeStreamDone() when done != null:
return done(_that.finishReason);case ComposeStreamError() when error != null:
return error(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( A2uiNode node,  String? parentId)  node,required TResult Function( ComposeFinishReason finishReason)  done,required TResult Function( String code,  String message)  error,}) {final _that = this;
switch (_that) {
case ComposeStreamNode():
return node(_that.node,_that.parentId);case ComposeStreamDone():
return done(_that.finishReason);case ComposeStreamError():
return error(_that.code,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( A2uiNode node,  String? parentId)?  node,TResult? Function( ComposeFinishReason finishReason)?  done,TResult? Function( String code,  String message)?  error,}) {final _that = this;
switch (_that) {
case ComposeStreamNode() when node != null:
return node(_that.node,_that.parentId);case ComposeStreamDone() when done != null:
return done(_that.finishReason);case ComposeStreamError() when error != null:
return error(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class ComposeStreamNode implements ComposeStreamEvent {
  const ComposeStreamNode({required this.node, this.parentId, final  String? $type}): $type = $type ?? 'node';
  factory ComposeStreamNode.fromJson(Map<String, dynamic> json) => _$ComposeStreamNodeFromJson(json);

 final  A2uiNode node;
 final  String? parentId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ComposeStreamEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComposeStreamNodeCopyWith<ComposeStreamNode> get copyWith => _$ComposeStreamNodeCopyWithImpl<ComposeStreamNode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComposeStreamNodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComposeStreamNode&&(identical(other.node, node) || other.node == node)&&(identical(other.parentId, parentId) || other.parentId == parentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,node,parentId);

@override
String toString() {
  return 'ComposeStreamEvent.node(node: $node, parentId: $parentId)';
}


}

/// @nodoc
abstract mixin class $ComposeStreamNodeCopyWith<$Res> implements $ComposeStreamEventCopyWith<$Res> {
  factory $ComposeStreamNodeCopyWith(ComposeStreamNode value, $Res Function(ComposeStreamNode) _then) = _$ComposeStreamNodeCopyWithImpl;
@useResult
$Res call({
 A2uiNode node, String? parentId
});


$A2uiNodeCopyWith<$Res> get node;

}
/// @nodoc
class _$ComposeStreamNodeCopyWithImpl<$Res>
    implements $ComposeStreamNodeCopyWith<$Res> {
  _$ComposeStreamNodeCopyWithImpl(this._self, this._then);

  final ComposeStreamNode _self;
  final $Res Function(ComposeStreamNode) _then;

/// Create a copy of ComposeStreamEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? node = null,Object? parentId = freezed,}) {
  return _then(ComposeStreamNode(
node: null == node ? _self.node : node // ignore: cast_nullable_to_non_nullable
as A2uiNode,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ComposeStreamEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$A2uiNodeCopyWith<$Res> get node {
  
  return $A2uiNodeCopyWith<$Res>(_self.node, (value) {
    return _then(_self.copyWith(node: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ComposeStreamDone implements ComposeStreamEvent {
  const ComposeStreamDone({required this.finishReason, final  String? $type}): $type = $type ?? 'done';
  factory ComposeStreamDone.fromJson(Map<String, dynamic> json) => _$ComposeStreamDoneFromJson(json);

 final  ComposeFinishReason finishReason;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ComposeStreamEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComposeStreamDoneCopyWith<ComposeStreamDone> get copyWith => _$ComposeStreamDoneCopyWithImpl<ComposeStreamDone>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComposeStreamDoneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComposeStreamDone&&(identical(other.finishReason, finishReason) || other.finishReason == finishReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,finishReason);

@override
String toString() {
  return 'ComposeStreamEvent.done(finishReason: $finishReason)';
}


}

/// @nodoc
abstract mixin class $ComposeStreamDoneCopyWith<$Res> implements $ComposeStreamEventCopyWith<$Res> {
  factory $ComposeStreamDoneCopyWith(ComposeStreamDone value, $Res Function(ComposeStreamDone) _then) = _$ComposeStreamDoneCopyWithImpl;
@useResult
$Res call({
 ComposeFinishReason finishReason
});




}
/// @nodoc
class _$ComposeStreamDoneCopyWithImpl<$Res>
    implements $ComposeStreamDoneCopyWith<$Res> {
  _$ComposeStreamDoneCopyWithImpl(this._self, this._then);

  final ComposeStreamDone _self;
  final $Res Function(ComposeStreamDone) _then;

/// Create a copy of ComposeStreamEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? finishReason = null,}) {
  return _then(ComposeStreamDone(
finishReason: null == finishReason ? _self.finishReason : finishReason // ignore: cast_nullable_to_non_nullable
as ComposeFinishReason,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ComposeStreamError implements ComposeStreamEvent {
  const ComposeStreamError({required this.code, required this.message, final  String? $type}): $type = $type ?? 'error';
  factory ComposeStreamError.fromJson(Map<String, dynamic> json) => _$ComposeStreamErrorFromJson(json);

 final  String code;
 final  String message;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ComposeStreamEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComposeStreamErrorCopyWith<ComposeStreamError> get copyWith => _$ComposeStreamErrorCopyWithImpl<ComposeStreamError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComposeStreamErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComposeStreamError&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'ComposeStreamEvent.error(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $ComposeStreamErrorCopyWith<$Res> implements $ComposeStreamEventCopyWith<$Res> {
  factory $ComposeStreamErrorCopyWith(ComposeStreamError value, $Res Function(ComposeStreamError) _then) = _$ComposeStreamErrorCopyWithImpl;
@useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class _$ComposeStreamErrorCopyWithImpl<$Res>
    implements $ComposeStreamErrorCopyWith<$Res> {
  _$ComposeStreamErrorCopyWithImpl(this._self, this._then);

  final ComposeStreamError _self;
  final $Res Function(ComposeStreamError) _then;

/// Create a copy of ComposeStreamEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(ComposeStreamError(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
