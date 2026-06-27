// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_health.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VoiceHealthResponse {

 HealthStatus get status; String get version; DateTime get timestamp; double? get uptimeSeconds; int? get activeSessions; ModelHealth? get model; List<DependencyHealth>? get dependencies;
/// Create a copy of VoiceHealthResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceHealthResponseCopyWith<VoiceHealthResponse> get copyWith => _$VoiceHealthResponseCopyWithImpl<VoiceHealthResponse>(this as VoiceHealthResponse, _$identity);

  /// Serializes this VoiceHealthResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceHealthResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.version, version) || other.version == version)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.uptimeSeconds, uptimeSeconds) || other.uptimeSeconds == uptimeSeconds)&&(identical(other.activeSessions, activeSessions) || other.activeSessions == activeSessions)&&(identical(other.model, model) || other.model == model)&&const DeepCollectionEquality().equals(other.dependencies, dependencies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,version,timestamp,uptimeSeconds,activeSessions,model,const DeepCollectionEquality().hash(dependencies));

@override
String toString() {
  return 'VoiceHealthResponse(status: $status, version: $version, timestamp: $timestamp, uptimeSeconds: $uptimeSeconds, activeSessions: $activeSessions, model: $model, dependencies: $dependencies)';
}


}

/// @nodoc
abstract mixin class $VoiceHealthResponseCopyWith<$Res>  {
  factory $VoiceHealthResponseCopyWith(VoiceHealthResponse value, $Res Function(VoiceHealthResponse) _then) = _$VoiceHealthResponseCopyWithImpl;
@useResult
$Res call({
 HealthStatus status, String version, DateTime timestamp, double? uptimeSeconds, int? activeSessions, ModelHealth? model, List<DependencyHealth>? dependencies
});


$ModelHealthCopyWith<$Res>? get model;

}
/// @nodoc
class _$VoiceHealthResponseCopyWithImpl<$Res>
    implements $VoiceHealthResponseCopyWith<$Res> {
  _$VoiceHealthResponseCopyWithImpl(this._self, this._then);

  final VoiceHealthResponse _self;
  final $Res Function(VoiceHealthResponse) _then;

/// Create a copy of VoiceHealthResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? version = null,Object? timestamp = null,Object? uptimeSeconds = freezed,Object? activeSessions = freezed,Object? model = freezed,Object? dependencies = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HealthStatus,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,uptimeSeconds: freezed == uptimeSeconds ? _self.uptimeSeconds : uptimeSeconds // ignore: cast_nullable_to_non_nullable
as double?,activeSessions: freezed == activeSessions ? _self.activeSessions : activeSessions // ignore: cast_nullable_to_non_nullable
as int?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as ModelHealth?,dependencies: freezed == dependencies ? _self.dependencies : dependencies // ignore: cast_nullable_to_non_nullable
as List<DependencyHealth>?,
  ));
}
/// Create a copy of VoiceHealthResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModelHealthCopyWith<$Res>? get model {
    if (_self.model == null) {
    return null;
  }

  return $ModelHealthCopyWith<$Res>(_self.model!, (value) {
    return _then(_self.copyWith(model: value));
  });
}
}


/// Adds pattern-matching-related methods to [VoiceHealthResponse].
extension VoiceHealthResponsePatterns on VoiceHealthResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoiceHealthResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoiceHealthResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoiceHealthResponse value)  $default,){
final _that = this;
switch (_that) {
case _VoiceHealthResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoiceHealthResponse value)?  $default,){
final _that = this;
switch (_that) {
case _VoiceHealthResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HealthStatus status,  String version,  DateTime timestamp,  double? uptimeSeconds,  int? activeSessions,  ModelHealth? model,  List<DependencyHealth>? dependencies)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoiceHealthResponse() when $default != null:
return $default(_that.status,_that.version,_that.timestamp,_that.uptimeSeconds,_that.activeSessions,_that.model,_that.dependencies);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HealthStatus status,  String version,  DateTime timestamp,  double? uptimeSeconds,  int? activeSessions,  ModelHealth? model,  List<DependencyHealth>? dependencies)  $default,) {final _that = this;
switch (_that) {
case _VoiceHealthResponse():
return $default(_that.status,_that.version,_that.timestamp,_that.uptimeSeconds,_that.activeSessions,_that.model,_that.dependencies);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HealthStatus status,  String version,  DateTime timestamp,  double? uptimeSeconds,  int? activeSessions,  ModelHealth? model,  List<DependencyHealth>? dependencies)?  $default,) {final _that = this;
switch (_that) {
case _VoiceHealthResponse() when $default != null:
return $default(_that.status,_that.version,_that.timestamp,_that.uptimeSeconds,_that.activeSessions,_that.model,_that.dependencies);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VoiceHealthResponse implements VoiceHealthResponse {
  const _VoiceHealthResponse({required this.status, required this.version, required this.timestamp, this.uptimeSeconds, this.activeSessions, this.model, final  List<DependencyHealth>? dependencies}): _dependencies = dependencies;
  factory _VoiceHealthResponse.fromJson(Map<String, dynamic> json) => _$VoiceHealthResponseFromJson(json);

@override final  HealthStatus status;
@override final  String version;
@override final  DateTime timestamp;
@override final  double? uptimeSeconds;
@override final  int? activeSessions;
@override final  ModelHealth? model;
 final  List<DependencyHealth>? _dependencies;
@override List<DependencyHealth>? get dependencies {
  final value = _dependencies;
  if (value == null) return null;
  if (_dependencies is EqualUnmodifiableListView) return _dependencies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of VoiceHealthResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoiceHealthResponseCopyWith<_VoiceHealthResponse> get copyWith => __$VoiceHealthResponseCopyWithImpl<_VoiceHealthResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoiceHealthResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoiceHealthResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.version, version) || other.version == version)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.uptimeSeconds, uptimeSeconds) || other.uptimeSeconds == uptimeSeconds)&&(identical(other.activeSessions, activeSessions) || other.activeSessions == activeSessions)&&(identical(other.model, model) || other.model == model)&&const DeepCollectionEquality().equals(other._dependencies, _dependencies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,version,timestamp,uptimeSeconds,activeSessions,model,const DeepCollectionEquality().hash(_dependencies));

@override
String toString() {
  return 'VoiceHealthResponse(status: $status, version: $version, timestamp: $timestamp, uptimeSeconds: $uptimeSeconds, activeSessions: $activeSessions, model: $model, dependencies: $dependencies)';
}


}

/// @nodoc
abstract mixin class _$VoiceHealthResponseCopyWith<$Res> implements $VoiceHealthResponseCopyWith<$Res> {
  factory _$VoiceHealthResponseCopyWith(_VoiceHealthResponse value, $Res Function(_VoiceHealthResponse) _then) = __$VoiceHealthResponseCopyWithImpl;
@override @useResult
$Res call({
 HealthStatus status, String version, DateTime timestamp, double? uptimeSeconds, int? activeSessions, ModelHealth? model, List<DependencyHealth>? dependencies
});


@override $ModelHealthCopyWith<$Res>? get model;

}
/// @nodoc
class __$VoiceHealthResponseCopyWithImpl<$Res>
    implements _$VoiceHealthResponseCopyWith<$Res> {
  __$VoiceHealthResponseCopyWithImpl(this._self, this._then);

  final _VoiceHealthResponse _self;
  final $Res Function(_VoiceHealthResponse) _then;

/// Create a copy of VoiceHealthResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? version = null,Object? timestamp = null,Object? uptimeSeconds = freezed,Object? activeSessions = freezed,Object? model = freezed,Object? dependencies = freezed,}) {
  return _then(_VoiceHealthResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HealthStatus,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,uptimeSeconds: freezed == uptimeSeconds ? _self.uptimeSeconds : uptimeSeconds // ignore: cast_nullable_to_non_nullable
as double?,activeSessions: freezed == activeSessions ? _self.activeSessions : activeSessions // ignore: cast_nullable_to_non_nullable
as int?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as ModelHealth?,dependencies: freezed == dependencies ? _self._dependencies : dependencies // ignore: cast_nullable_to_non_nullable
as List<DependencyHealth>?,
  ));
}

/// Create a copy of VoiceHealthResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModelHealthCopyWith<$Res>? get model {
    if (_self.model == null) {
    return null;
  }

  return $ModelHealthCopyWith<$Res>(_self.model!, (value) {
    return _then(_self.copyWith(model: value));
  });
}
}


/// @nodoc
mixin _$ModelHealth {

 String get id; bool get ready;
/// Create a copy of ModelHealth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModelHealthCopyWith<ModelHealth> get copyWith => _$ModelHealthCopyWithImpl<ModelHealth>(this as ModelHealth, _$identity);

  /// Serializes this ModelHealth to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModelHealth&&(identical(other.id, id) || other.id == id)&&(identical(other.ready, ready) || other.ready == ready));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ready);

@override
String toString() {
  return 'ModelHealth(id: $id, ready: $ready)';
}


}

/// @nodoc
abstract mixin class $ModelHealthCopyWith<$Res>  {
  factory $ModelHealthCopyWith(ModelHealth value, $Res Function(ModelHealth) _then) = _$ModelHealthCopyWithImpl;
@useResult
$Res call({
 String id, bool ready
});




}
/// @nodoc
class _$ModelHealthCopyWithImpl<$Res>
    implements $ModelHealthCopyWith<$Res> {
  _$ModelHealthCopyWithImpl(this._self, this._then);

  final ModelHealth _self;
  final $Res Function(ModelHealth) _then;

/// Create a copy of ModelHealth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ready = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ready: null == ready ? _self.ready : ready // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ModelHealth].
extension ModelHealthPatterns on ModelHealth {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModelHealth value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModelHealth() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModelHealth value)  $default,){
final _that = this;
switch (_that) {
case _ModelHealth():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModelHealth value)?  $default,){
final _that = this;
switch (_that) {
case _ModelHealth() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  bool ready)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModelHealth() when $default != null:
return $default(_that.id,_that.ready);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  bool ready)  $default,) {final _that = this;
switch (_that) {
case _ModelHealth():
return $default(_that.id,_that.ready);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  bool ready)?  $default,) {final _that = this;
switch (_that) {
case _ModelHealth() when $default != null:
return $default(_that.id,_that.ready);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ModelHealth implements ModelHealth {
  const _ModelHealth({required this.id, required this.ready});
  factory _ModelHealth.fromJson(Map<String, dynamic> json) => _$ModelHealthFromJson(json);

@override final  String id;
@override final  bool ready;

/// Create a copy of ModelHealth
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModelHealthCopyWith<_ModelHealth> get copyWith => __$ModelHealthCopyWithImpl<_ModelHealth>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModelHealthToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModelHealth&&(identical(other.id, id) || other.id == id)&&(identical(other.ready, ready) || other.ready == ready));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ready);

@override
String toString() {
  return 'ModelHealth(id: $id, ready: $ready)';
}


}

/// @nodoc
abstract mixin class _$ModelHealthCopyWith<$Res> implements $ModelHealthCopyWith<$Res> {
  factory _$ModelHealthCopyWith(_ModelHealth value, $Res Function(_ModelHealth) _then) = __$ModelHealthCopyWithImpl;
@override @useResult
$Res call({
 String id, bool ready
});




}
/// @nodoc
class __$ModelHealthCopyWithImpl<$Res>
    implements _$ModelHealthCopyWith<$Res> {
  __$ModelHealthCopyWithImpl(this._self, this._then);

  final _ModelHealth _self;
  final $Res Function(_ModelHealth) _then;

/// Create a copy of ModelHealth
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ready = null,}) {
  return _then(_ModelHealth(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ready: null == ready ? _self.ready : ready // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$DependencyHealth {

 String get name; HealthStatus get status; double? get latencyMs;
/// Create a copy of DependencyHealth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DependencyHealthCopyWith<DependencyHealth> get copyWith => _$DependencyHealthCopyWithImpl<DependencyHealth>(this as DependencyHealth, _$identity);

  /// Serializes this DependencyHealth to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DependencyHealth&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.latencyMs, latencyMs) || other.latencyMs == latencyMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,status,latencyMs);

@override
String toString() {
  return 'DependencyHealth(name: $name, status: $status, latencyMs: $latencyMs)';
}


}

/// @nodoc
abstract mixin class $DependencyHealthCopyWith<$Res>  {
  factory $DependencyHealthCopyWith(DependencyHealth value, $Res Function(DependencyHealth) _then) = _$DependencyHealthCopyWithImpl;
@useResult
$Res call({
 String name, HealthStatus status, double? latencyMs
});




}
/// @nodoc
class _$DependencyHealthCopyWithImpl<$Res>
    implements $DependencyHealthCopyWith<$Res> {
  _$DependencyHealthCopyWithImpl(this._self, this._then);

  final DependencyHealth _self;
  final $Res Function(DependencyHealth) _then;

/// Create a copy of DependencyHealth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? status = null,Object? latencyMs = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HealthStatus,latencyMs: freezed == latencyMs ? _self.latencyMs : latencyMs // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [DependencyHealth].
extension DependencyHealthPatterns on DependencyHealth {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DependencyHealth value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DependencyHealth() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DependencyHealth value)  $default,){
final _that = this;
switch (_that) {
case _DependencyHealth():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DependencyHealth value)?  $default,){
final _that = this;
switch (_that) {
case _DependencyHealth() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  HealthStatus status,  double? latencyMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DependencyHealth() when $default != null:
return $default(_that.name,_that.status,_that.latencyMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  HealthStatus status,  double? latencyMs)  $default,) {final _that = this;
switch (_that) {
case _DependencyHealth():
return $default(_that.name,_that.status,_that.latencyMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  HealthStatus status,  double? latencyMs)?  $default,) {final _that = this;
switch (_that) {
case _DependencyHealth() when $default != null:
return $default(_that.name,_that.status,_that.latencyMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DependencyHealth implements DependencyHealth {
  const _DependencyHealth({required this.name, required this.status, this.latencyMs});
  factory _DependencyHealth.fromJson(Map<String, dynamic> json) => _$DependencyHealthFromJson(json);

@override final  String name;
@override final  HealthStatus status;
@override final  double? latencyMs;

/// Create a copy of DependencyHealth
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DependencyHealthCopyWith<_DependencyHealth> get copyWith => __$DependencyHealthCopyWithImpl<_DependencyHealth>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DependencyHealthToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DependencyHealth&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.latencyMs, latencyMs) || other.latencyMs == latencyMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,status,latencyMs);

@override
String toString() {
  return 'DependencyHealth(name: $name, status: $status, latencyMs: $latencyMs)';
}


}

/// @nodoc
abstract mixin class _$DependencyHealthCopyWith<$Res> implements $DependencyHealthCopyWith<$Res> {
  factory _$DependencyHealthCopyWith(_DependencyHealth value, $Res Function(_DependencyHealth) _then) = __$DependencyHealthCopyWithImpl;
@override @useResult
$Res call({
 String name, HealthStatus status, double? latencyMs
});




}
/// @nodoc
class __$DependencyHealthCopyWithImpl<$Res>
    implements _$DependencyHealthCopyWith<$Res> {
  __$DependencyHealthCopyWithImpl(this._self, this._then);

  final _DependencyHealth _self;
  final $Res Function(_DependencyHealth) _then;

/// Create a copy of DependencyHealth
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? status = null,Object? latencyMs = freezed,}) {
  return _then(_DependencyHealth(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HealthStatus,latencyMs: freezed == latencyMs ? _self.latencyMs : latencyMs // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
