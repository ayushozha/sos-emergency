// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compose_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ComposeResponse {

 String get requestId; A2uiNode get surface; String? get catalogVersion; ComposeFinishReason? get finishReason; ComposeUsage? get usage;
/// Create a copy of ComposeResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComposeResponseCopyWith<ComposeResponse> get copyWith => _$ComposeResponseCopyWithImpl<ComposeResponse>(this as ComposeResponse, _$identity);

  /// Serializes this ComposeResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComposeResponse&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.surface, surface) || other.surface == surface)&&(identical(other.catalogVersion, catalogVersion) || other.catalogVersion == catalogVersion)&&(identical(other.finishReason, finishReason) || other.finishReason == finishReason)&&(identical(other.usage, usage) || other.usage == usage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requestId,surface,catalogVersion,finishReason,usage);

@override
String toString() {
  return 'ComposeResponse(requestId: $requestId, surface: $surface, catalogVersion: $catalogVersion, finishReason: $finishReason, usage: $usage)';
}


}

/// @nodoc
abstract mixin class $ComposeResponseCopyWith<$Res>  {
  factory $ComposeResponseCopyWith(ComposeResponse value, $Res Function(ComposeResponse) _then) = _$ComposeResponseCopyWithImpl;
@useResult
$Res call({
 String requestId, A2uiNode surface, String? catalogVersion, ComposeFinishReason? finishReason, ComposeUsage? usage
});


$A2uiNodeCopyWith<$Res> get surface;$ComposeUsageCopyWith<$Res>? get usage;

}
/// @nodoc
class _$ComposeResponseCopyWithImpl<$Res>
    implements $ComposeResponseCopyWith<$Res> {
  _$ComposeResponseCopyWithImpl(this._self, this._then);

  final ComposeResponse _self;
  final $Res Function(ComposeResponse) _then;

/// Create a copy of ComposeResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requestId = null,Object? surface = null,Object? catalogVersion = freezed,Object? finishReason = freezed,Object? usage = freezed,}) {
  return _then(_self.copyWith(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,surface: null == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as A2uiNode,catalogVersion: freezed == catalogVersion ? _self.catalogVersion : catalogVersion // ignore: cast_nullable_to_non_nullable
as String?,finishReason: freezed == finishReason ? _self.finishReason : finishReason // ignore: cast_nullable_to_non_nullable
as ComposeFinishReason?,usage: freezed == usage ? _self.usage : usage // ignore: cast_nullable_to_non_nullable
as ComposeUsage?,
  ));
}
/// Create a copy of ComposeResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$A2uiNodeCopyWith<$Res> get surface {
  
  return $A2uiNodeCopyWith<$Res>(_self.surface, (value) {
    return _then(_self.copyWith(surface: value));
  });
}/// Create a copy of ComposeResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComposeUsageCopyWith<$Res>? get usage {
    if (_self.usage == null) {
    return null;
  }

  return $ComposeUsageCopyWith<$Res>(_self.usage!, (value) {
    return _then(_self.copyWith(usage: value));
  });
}
}


/// Adds pattern-matching-related methods to [ComposeResponse].
extension ComposeResponsePatterns on ComposeResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComposeResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComposeResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComposeResponse value)  $default,){
final _that = this;
switch (_that) {
case _ComposeResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComposeResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ComposeResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String requestId,  A2uiNode surface,  String? catalogVersion,  ComposeFinishReason? finishReason,  ComposeUsage? usage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComposeResponse() when $default != null:
return $default(_that.requestId,_that.surface,_that.catalogVersion,_that.finishReason,_that.usage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String requestId,  A2uiNode surface,  String? catalogVersion,  ComposeFinishReason? finishReason,  ComposeUsage? usage)  $default,) {final _that = this;
switch (_that) {
case _ComposeResponse():
return $default(_that.requestId,_that.surface,_that.catalogVersion,_that.finishReason,_that.usage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String requestId,  A2uiNode surface,  String? catalogVersion,  ComposeFinishReason? finishReason,  ComposeUsage? usage)?  $default,) {final _that = this;
switch (_that) {
case _ComposeResponse() when $default != null:
return $default(_that.requestId,_that.surface,_that.catalogVersion,_that.finishReason,_that.usage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComposeResponse implements ComposeResponse {
  const _ComposeResponse({required this.requestId, required this.surface, this.catalogVersion, this.finishReason, this.usage});
  factory _ComposeResponse.fromJson(Map<String, dynamic> json) => _$ComposeResponseFromJson(json);

@override final  String requestId;
@override final  A2uiNode surface;
@override final  String? catalogVersion;
@override final  ComposeFinishReason? finishReason;
@override final  ComposeUsage? usage;

/// Create a copy of ComposeResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComposeResponseCopyWith<_ComposeResponse> get copyWith => __$ComposeResponseCopyWithImpl<_ComposeResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComposeResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComposeResponse&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.surface, surface) || other.surface == surface)&&(identical(other.catalogVersion, catalogVersion) || other.catalogVersion == catalogVersion)&&(identical(other.finishReason, finishReason) || other.finishReason == finishReason)&&(identical(other.usage, usage) || other.usage == usage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requestId,surface,catalogVersion,finishReason,usage);

@override
String toString() {
  return 'ComposeResponse(requestId: $requestId, surface: $surface, catalogVersion: $catalogVersion, finishReason: $finishReason, usage: $usage)';
}


}

/// @nodoc
abstract mixin class _$ComposeResponseCopyWith<$Res> implements $ComposeResponseCopyWith<$Res> {
  factory _$ComposeResponseCopyWith(_ComposeResponse value, $Res Function(_ComposeResponse) _then) = __$ComposeResponseCopyWithImpl;
@override @useResult
$Res call({
 String requestId, A2uiNode surface, String? catalogVersion, ComposeFinishReason? finishReason, ComposeUsage? usage
});


@override $A2uiNodeCopyWith<$Res> get surface;@override $ComposeUsageCopyWith<$Res>? get usage;

}
/// @nodoc
class __$ComposeResponseCopyWithImpl<$Res>
    implements _$ComposeResponseCopyWith<$Res> {
  __$ComposeResponseCopyWithImpl(this._self, this._then);

  final _ComposeResponse _self;
  final $Res Function(_ComposeResponse) _then;

/// Create a copy of ComposeResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requestId = null,Object? surface = null,Object? catalogVersion = freezed,Object? finishReason = freezed,Object? usage = freezed,}) {
  return _then(_ComposeResponse(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,surface: null == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as A2uiNode,catalogVersion: freezed == catalogVersion ? _self.catalogVersion : catalogVersion // ignore: cast_nullable_to_non_nullable
as String?,finishReason: freezed == finishReason ? _self.finishReason : finishReason // ignore: cast_nullable_to_non_nullable
as ComposeFinishReason?,usage: freezed == usage ? _self.usage : usage // ignore: cast_nullable_to_non_nullable
as ComposeUsage?,
  ));
}

/// Create a copy of ComposeResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$A2uiNodeCopyWith<$Res> get surface {
  
  return $A2uiNodeCopyWith<$Res>(_self.surface, (value) {
    return _then(_self.copyWith(surface: value));
  });
}/// Create a copy of ComposeResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComposeUsageCopyWith<$Res>? get usage {
    if (_self.usage == null) {
    return null;
  }

  return $ComposeUsageCopyWith<$Res>(_self.usage!, (value) {
    return _then(_self.copyWith(usage: value));
  });
}
}


/// @nodoc
mixin _$ComposeUsage {

 double? get latencyMs; int? get inputTokens; int? get outputTokens;
/// Create a copy of ComposeUsage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComposeUsageCopyWith<ComposeUsage> get copyWith => _$ComposeUsageCopyWithImpl<ComposeUsage>(this as ComposeUsage, _$identity);

  /// Serializes this ComposeUsage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComposeUsage&&(identical(other.latencyMs, latencyMs) || other.latencyMs == latencyMs)&&(identical(other.inputTokens, inputTokens) || other.inputTokens == inputTokens)&&(identical(other.outputTokens, outputTokens) || other.outputTokens == outputTokens));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latencyMs,inputTokens,outputTokens);

@override
String toString() {
  return 'ComposeUsage(latencyMs: $latencyMs, inputTokens: $inputTokens, outputTokens: $outputTokens)';
}


}

/// @nodoc
abstract mixin class $ComposeUsageCopyWith<$Res>  {
  factory $ComposeUsageCopyWith(ComposeUsage value, $Res Function(ComposeUsage) _then) = _$ComposeUsageCopyWithImpl;
@useResult
$Res call({
 double? latencyMs, int? inputTokens, int? outputTokens
});




}
/// @nodoc
class _$ComposeUsageCopyWithImpl<$Res>
    implements $ComposeUsageCopyWith<$Res> {
  _$ComposeUsageCopyWithImpl(this._self, this._then);

  final ComposeUsage _self;
  final $Res Function(ComposeUsage) _then;

/// Create a copy of ComposeUsage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latencyMs = freezed,Object? inputTokens = freezed,Object? outputTokens = freezed,}) {
  return _then(_self.copyWith(
latencyMs: freezed == latencyMs ? _self.latencyMs : latencyMs // ignore: cast_nullable_to_non_nullable
as double?,inputTokens: freezed == inputTokens ? _self.inputTokens : inputTokens // ignore: cast_nullable_to_non_nullable
as int?,outputTokens: freezed == outputTokens ? _self.outputTokens : outputTokens // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ComposeUsage].
extension ComposeUsagePatterns on ComposeUsage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComposeUsage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComposeUsage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComposeUsage value)  $default,){
final _that = this;
switch (_that) {
case _ComposeUsage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComposeUsage value)?  $default,){
final _that = this;
switch (_that) {
case _ComposeUsage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? latencyMs,  int? inputTokens,  int? outputTokens)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComposeUsage() when $default != null:
return $default(_that.latencyMs,_that.inputTokens,_that.outputTokens);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? latencyMs,  int? inputTokens,  int? outputTokens)  $default,) {final _that = this;
switch (_that) {
case _ComposeUsage():
return $default(_that.latencyMs,_that.inputTokens,_that.outputTokens);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? latencyMs,  int? inputTokens,  int? outputTokens)?  $default,) {final _that = this;
switch (_that) {
case _ComposeUsage() when $default != null:
return $default(_that.latencyMs,_that.inputTokens,_that.outputTokens);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComposeUsage implements ComposeUsage {
  const _ComposeUsage({this.latencyMs, this.inputTokens, this.outputTokens});
  factory _ComposeUsage.fromJson(Map<String, dynamic> json) => _$ComposeUsageFromJson(json);

@override final  double? latencyMs;
@override final  int? inputTokens;
@override final  int? outputTokens;

/// Create a copy of ComposeUsage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComposeUsageCopyWith<_ComposeUsage> get copyWith => __$ComposeUsageCopyWithImpl<_ComposeUsage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComposeUsageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComposeUsage&&(identical(other.latencyMs, latencyMs) || other.latencyMs == latencyMs)&&(identical(other.inputTokens, inputTokens) || other.inputTokens == inputTokens)&&(identical(other.outputTokens, outputTokens) || other.outputTokens == outputTokens));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latencyMs,inputTokens,outputTokens);

@override
String toString() {
  return 'ComposeUsage(latencyMs: $latencyMs, inputTokens: $inputTokens, outputTokens: $outputTokens)';
}


}

/// @nodoc
abstract mixin class _$ComposeUsageCopyWith<$Res> implements $ComposeUsageCopyWith<$Res> {
  factory _$ComposeUsageCopyWith(_ComposeUsage value, $Res Function(_ComposeUsage) _then) = __$ComposeUsageCopyWithImpl;
@override @useResult
$Res call({
 double? latencyMs, int? inputTokens, int? outputTokens
});




}
/// @nodoc
class __$ComposeUsageCopyWithImpl<$Res>
    implements _$ComposeUsageCopyWith<$Res> {
  __$ComposeUsageCopyWithImpl(this._self, this._then);

  final _ComposeUsage _self;
  final $Res Function(_ComposeUsage) _then;

/// Create a copy of ComposeUsage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latencyMs = freezed,Object? inputTokens = freezed,Object? outputTokens = freezed,}) {
  return _then(_ComposeUsage(
latencyMs: freezed == latencyMs ? _self.latencyMs : latencyMs // ignore: cast_nullable_to_non_nullable
as double?,inputTokens: freezed == inputTokens ? _self.inputTokens : inputTokens // ignore: cast_nullable_to_non_nullable
as int?,outputTokens: freezed == outputTokens ? _self.outputTokens : outputTokens // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
