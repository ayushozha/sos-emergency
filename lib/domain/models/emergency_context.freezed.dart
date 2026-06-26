// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'emergency_context.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GeoPosition {

 double get latitude; double get longitude; String? get address; String? get detail; double? get accuracyMeters;
/// Create a copy of GeoPosition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeoPositionCopyWith<GeoPosition> get copyWith => _$GeoPositionCopyWithImpl<GeoPosition>(this as GeoPosition, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeoPosition&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.accuracyMeters, accuracyMeters) || other.accuracyMeters == accuracyMeters));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,address,detail,accuracyMeters);

@override
String toString() {
  return 'GeoPosition(latitude: $latitude, longitude: $longitude, address: $address, detail: $detail, accuracyMeters: $accuracyMeters)';
}


}

/// @nodoc
abstract mixin class $GeoPositionCopyWith<$Res>  {
  factory $GeoPositionCopyWith(GeoPosition value, $Res Function(GeoPosition) _then) = _$GeoPositionCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, String? address, String? detail, double? accuracyMeters
});




}
/// @nodoc
class _$GeoPositionCopyWithImpl<$Res>
    implements $GeoPositionCopyWith<$Res> {
  _$GeoPositionCopyWithImpl(this._self, this._then);

  final GeoPosition _self;
  final $Res Function(GeoPosition) _then;

/// Create a copy of GeoPosition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? address = freezed,Object? detail = freezed,Object? accuracyMeters = freezed,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,accuracyMeters: freezed == accuracyMeters ? _self.accuracyMeters : accuracyMeters // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [GeoPosition].
extension GeoPositionPatterns on GeoPosition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeoPosition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeoPosition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeoPosition value)  $default,){
final _that = this;
switch (_that) {
case _GeoPosition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeoPosition value)?  $default,){
final _that = this;
switch (_that) {
case _GeoPosition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude,  String? address,  String? detail,  double? accuracyMeters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeoPosition() when $default != null:
return $default(_that.latitude,_that.longitude,_that.address,_that.detail,_that.accuracyMeters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude,  String? address,  String? detail,  double? accuracyMeters)  $default,) {final _that = this;
switch (_that) {
case _GeoPosition():
return $default(_that.latitude,_that.longitude,_that.address,_that.detail,_that.accuracyMeters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude,  String? address,  String? detail,  double? accuracyMeters)?  $default,) {final _that = this;
switch (_that) {
case _GeoPosition() when $default != null:
return $default(_that.latitude,_that.longitude,_that.address,_that.detail,_that.accuracyMeters);case _:
  return null;

}
}

}

/// @nodoc


class _GeoPosition implements GeoPosition {
  const _GeoPosition({required this.latitude, required this.longitude, this.address, this.detail, this.accuracyMeters});
  

@override final  double latitude;
@override final  double longitude;
@override final  String? address;
@override final  String? detail;
@override final  double? accuracyMeters;

/// Create a copy of GeoPosition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeoPositionCopyWith<_GeoPosition> get copyWith => __$GeoPositionCopyWithImpl<_GeoPosition>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeoPosition&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.accuracyMeters, accuracyMeters) || other.accuracyMeters == accuracyMeters));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,address,detail,accuracyMeters);

@override
String toString() {
  return 'GeoPosition(latitude: $latitude, longitude: $longitude, address: $address, detail: $detail, accuracyMeters: $accuracyMeters)';
}


}

/// @nodoc
abstract mixin class _$GeoPositionCopyWith<$Res> implements $GeoPositionCopyWith<$Res> {
  factory _$GeoPositionCopyWith(_GeoPosition value, $Res Function(_GeoPosition) _then) = __$GeoPositionCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, String? address, String? detail, double? accuracyMeters
});




}
/// @nodoc
class __$GeoPositionCopyWithImpl<$Res>
    implements _$GeoPositionCopyWith<$Res> {
  __$GeoPositionCopyWithImpl(this._self, this._then);

  final _GeoPosition _self;
  final $Res Function(_GeoPosition) _then;

/// Create a copy of GeoPosition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? address = freezed,Object? detail = freezed,Object? accuracyMeters = freezed,}) {
  return _then(_GeoPosition(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,accuracyMeters: freezed == accuracyMeters ? _self.accuracyMeters : accuracyMeters // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$VehicleBusSnapshot {

 bool get airbagDeployed; bool get engineCranksNoStart; bool get tirePressureLow; bool get doorsLocked; int? get fuelPercent; int? get evChargePercent; String? get profile;
/// Create a copy of VehicleBusSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleBusSnapshotCopyWith<VehicleBusSnapshot> get copyWith => _$VehicleBusSnapshotCopyWithImpl<VehicleBusSnapshot>(this as VehicleBusSnapshot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehicleBusSnapshot&&(identical(other.airbagDeployed, airbagDeployed) || other.airbagDeployed == airbagDeployed)&&(identical(other.engineCranksNoStart, engineCranksNoStart) || other.engineCranksNoStart == engineCranksNoStart)&&(identical(other.tirePressureLow, tirePressureLow) || other.tirePressureLow == tirePressureLow)&&(identical(other.doorsLocked, doorsLocked) || other.doorsLocked == doorsLocked)&&(identical(other.fuelPercent, fuelPercent) || other.fuelPercent == fuelPercent)&&(identical(other.evChargePercent, evChargePercent) || other.evChargePercent == evChargePercent)&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,airbagDeployed,engineCranksNoStart,tirePressureLow,doorsLocked,fuelPercent,evChargePercent,profile);

@override
String toString() {
  return 'VehicleBusSnapshot(airbagDeployed: $airbagDeployed, engineCranksNoStart: $engineCranksNoStart, tirePressureLow: $tirePressureLow, doorsLocked: $doorsLocked, fuelPercent: $fuelPercent, evChargePercent: $evChargePercent, profile: $profile)';
}


}

/// @nodoc
abstract mixin class $VehicleBusSnapshotCopyWith<$Res>  {
  factory $VehicleBusSnapshotCopyWith(VehicleBusSnapshot value, $Res Function(VehicleBusSnapshot) _then) = _$VehicleBusSnapshotCopyWithImpl;
@useResult
$Res call({
 bool airbagDeployed, bool engineCranksNoStart, bool tirePressureLow, bool doorsLocked, int? fuelPercent, int? evChargePercent, String? profile
});




}
/// @nodoc
class _$VehicleBusSnapshotCopyWithImpl<$Res>
    implements $VehicleBusSnapshotCopyWith<$Res> {
  _$VehicleBusSnapshotCopyWithImpl(this._self, this._then);

  final VehicleBusSnapshot _self;
  final $Res Function(VehicleBusSnapshot) _then;

/// Create a copy of VehicleBusSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? airbagDeployed = null,Object? engineCranksNoStart = null,Object? tirePressureLow = null,Object? doorsLocked = null,Object? fuelPercent = freezed,Object? evChargePercent = freezed,Object? profile = freezed,}) {
  return _then(_self.copyWith(
airbagDeployed: null == airbagDeployed ? _self.airbagDeployed : airbagDeployed // ignore: cast_nullable_to_non_nullable
as bool,engineCranksNoStart: null == engineCranksNoStart ? _self.engineCranksNoStart : engineCranksNoStart // ignore: cast_nullable_to_non_nullable
as bool,tirePressureLow: null == tirePressureLow ? _self.tirePressureLow : tirePressureLow // ignore: cast_nullable_to_non_nullable
as bool,doorsLocked: null == doorsLocked ? _self.doorsLocked : doorsLocked // ignore: cast_nullable_to_non_nullable
as bool,fuelPercent: freezed == fuelPercent ? _self.fuelPercent : fuelPercent // ignore: cast_nullable_to_non_nullable
as int?,evChargePercent: freezed == evChargePercent ? _self.evChargePercent : evChargePercent // ignore: cast_nullable_to_non_nullable
as int?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VehicleBusSnapshot].
extension VehicleBusSnapshotPatterns on VehicleBusSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VehicleBusSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VehicleBusSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VehicleBusSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _VehicleBusSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VehicleBusSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _VehicleBusSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool airbagDeployed,  bool engineCranksNoStart,  bool tirePressureLow,  bool doorsLocked,  int? fuelPercent,  int? evChargePercent,  String? profile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VehicleBusSnapshot() when $default != null:
return $default(_that.airbagDeployed,_that.engineCranksNoStart,_that.tirePressureLow,_that.doorsLocked,_that.fuelPercent,_that.evChargePercent,_that.profile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool airbagDeployed,  bool engineCranksNoStart,  bool tirePressureLow,  bool doorsLocked,  int? fuelPercent,  int? evChargePercent,  String? profile)  $default,) {final _that = this;
switch (_that) {
case _VehicleBusSnapshot():
return $default(_that.airbagDeployed,_that.engineCranksNoStart,_that.tirePressureLow,_that.doorsLocked,_that.fuelPercent,_that.evChargePercent,_that.profile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool airbagDeployed,  bool engineCranksNoStart,  bool tirePressureLow,  bool doorsLocked,  int? fuelPercent,  int? evChargePercent,  String? profile)?  $default,) {final _that = this;
switch (_that) {
case _VehicleBusSnapshot() when $default != null:
return $default(_that.airbagDeployed,_that.engineCranksNoStart,_that.tirePressureLow,_that.doorsLocked,_that.fuelPercent,_that.evChargePercent,_that.profile);case _:
  return null;

}
}

}

/// @nodoc


class _VehicleBusSnapshot implements VehicleBusSnapshot {
  const _VehicleBusSnapshot({this.airbagDeployed = false, this.engineCranksNoStart = false, this.tirePressureLow = false, this.doorsLocked = false, this.fuelPercent, this.evChargePercent, this.profile});
  

@override@JsonKey() final  bool airbagDeployed;
@override@JsonKey() final  bool engineCranksNoStart;
@override@JsonKey() final  bool tirePressureLow;
@override@JsonKey() final  bool doorsLocked;
@override final  int? fuelPercent;
@override final  int? evChargePercent;
@override final  String? profile;

/// Create a copy of VehicleBusSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleBusSnapshotCopyWith<_VehicleBusSnapshot> get copyWith => __$VehicleBusSnapshotCopyWithImpl<_VehicleBusSnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleBusSnapshot&&(identical(other.airbagDeployed, airbagDeployed) || other.airbagDeployed == airbagDeployed)&&(identical(other.engineCranksNoStart, engineCranksNoStart) || other.engineCranksNoStart == engineCranksNoStart)&&(identical(other.tirePressureLow, tirePressureLow) || other.tirePressureLow == tirePressureLow)&&(identical(other.doorsLocked, doorsLocked) || other.doorsLocked == doorsLocked)&&(identical(other.fuelPercent, fuelPercent) || other.fuelPercent == fuelPercent)&&(identical(other.evChargePercent, evChargePercent) || other.evChargePercent == evChargePercent)&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,airbagDeployed,engineCranksNoStart,tirePressureLow,doorsLocked,fuelPercent,evChargePercent,profile);

@override
String toString() {
  return 'VehicleBusSnapshot(airbagDeployed: $airbagDeployed, engineCranksNoStart: $engineCranksNoStart, tirePressureLow: $tirePressureLow, doorsLocked: $doorsLocked, fuelPercent: $fuelPercent, evChargePercent: $evChargePercent, profile: $profile)';
}


}

/// @nodoc
abstract mixin class _$VehicleBusSnapshotCopyWith<$Res> implements $VehicleBusSnapshotCopyWith<$Res> {
  factory _$VehicleBusSnapshotCopyWith(_VehicleBusSnapshot value, $Res Function(_VehicleBusSnapshot) _then) = __$VehicleBusSnapshotCopyWithImpl;
@override @useResult
$Res call({
 bool airbagDeployed, bool engineCranksNoStart, bool tirePressureLow, bool doorsLocked, int? fuelPercent, int? evChargePercent, String? profile
});




}
/// @nodoc
class __$VehicleBusSnapshotCopyWithImpl<$Res>
    implements _$VehicleBusSnapshotCopyWith<$Res> {
  __$VehicleBusSnapshotCopyWithImpl(this._self, this._then);

  final _VehicleBusSnapshot _self;
  final $Res Function(_VehicleBusSnapshot) _then;

/// Create a copy of VehicleBusSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? airbagDeployed = null,Object? engineCranksNoStart = null,Object? tirePressureLow = null,Object? doorsLocked = null,Object? fuelPercent = freezed,Object? evChargePercent = freezed,Object? profile = freezed,}) {
  return _then(_VehicleBusSnapshot(
airbagDeployed: null == airbagDeployed ? _self.airbagDeployed : airbagDeployed // ignore: cast_nullable_to_non_nullable
as bool,engineCranksNoStart: null == engineCranksNoStart ? _self.engineCranksNoStart : engineCranksNoStart // ignore: cast_nullable_to_non_nullable
as bool,tirePressureLow: null == tirePressureLow ? _self.tirePressureLow : tirePressureLow // ignore: cast_nullable_to_non_nullable
as bool,doorsLocked: null == doorsLocked ? _self.doorsLocked : doorsLocked // ignore: cast_nullable_to_non_nullable
as bool,fuelPercent: freezed == fuelPercent ? _self.fuelPercent : fuelPercent // ignore: cast_nullable_to_non_nullable
as int?,evChargePercent: freezed == evChargePercent ? _self.evChargePercent : evChargePercent // ignore: cast_nullable_to_non_nullable
as int?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$UserSignal {

 UserIntent get intent; String? get note;
/// Create a copy of UserSignal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSignalCopyWith<UserSignal> get copyWith => _$UserSignalCopyWithImpl<UserSignal>(this as UserSignal, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSignal&&(identical(other.intent, intent) || other.intent == intent)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,intent,note);

@override
String toString() {
  return 'UserSignal(intent: $intent, note: $note)';
}


}

/// @nodoc
abstract mixin class $UserSignalCopyWith<$Res>  {
  factory $UserSignalCopyWith(UserSignal value, $Res Function(UserSignal) _then) = _$UserSignalCopyWithImpl;
@useResult
$Res call({
 UserIntent intent, String? note
});




}
/// @nodoc
class _$UserSignalCopyWithImpl<$Res>
    implements $UserSignalCopyWith<$Res> {
  _$UserSignalCopyWithImpl(this._self, this._then);

  final UserSignal _self;
  final $Res Function(UserSignal) _then;

/// Create a copy of UserSignal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? intent = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
intent: null == intent ? _self.intent : intent // ignore: cast_nullable_to_non_nullable
as UserIntent,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSignal].
extension UserSignalPatterns on UserSignal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSignal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSignal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSignal value)  $default,){
final _that = this;
switch (_that) {
case _UserSignal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSignal value)?  $default,){
final _that = this;
switch (_that) {
case _UserSignal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserIntent intent,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSignal() when $default != null:
return $default(_that.intent,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserIntent intent,  String? note)  $default,) {final _that = this;
switch (_that) {
case _UserSignal():
return $default(_that.intent,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserIntent intent,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _UserSignal() when $default != null:
return $default(_that.intent,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _UserSignal implements UserSignal {
  const _UserSignal({required this.intent, this.note});
  

@override final  UserIntent intent;
@override final  String? note;

/// Create a copy of UserSignal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSignalCopyWith<_UserSignal> get copyWith => __$UserSignalCopyWithImpl<_UserSignal>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSignal&&(identical(other.intent, intent) || other.intent == intent)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,intent,note);

@override
String toString() {
  return 'UserSignal(intent: $intent, note: $note)';
}


}

/// @nodoc
abstract mixin class _$UserSignalCopyWith<$Res> implements $UserSignalCopyWith<$Res> {
  factory _$UserSignalCopyWith(_UserSignal value, $Res Function(_UserSignal) _then) = __$UserSignalCopyWithImpl;
@override @useResult
$Res call({
 UserIntent intent, String? note
});




}
/// @nodoc
class __$UserSignalCopyWithImpl<$Res>
    implements _$UserSignalCopyWith<$Res> {
  __$UserSignalCopyWithImpl(this._self, this._then);

  final _UserSignal _self;
  final $Res Function(_UserSignal) _then;

/// Create a copy of UserSignal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? intent = null,Object? note = freezed,}) {
  return _then(_UserSignal(
intent: null == intent ? _self.intent : intent // ignore: cast_nullable_to_non_nullable
as UserIntent,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$EmergencyContext {

 VehicleState get vehicleState; double get speedMps; Connectivity get connectivity; bool get isNight; DateTime get timestamp; bool get crashImpulseDetected; GeoPosition? get position; VehicleBusSnapshot? get bus; List<UserSignal> get userSignals; Set<Hazard> get hazards;
/// Create a copy of EmergencyContext
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmergencyContextCopyWith<EmergencyContext> get copyWith => _$EmergencyContextCopyWithImpl<EmergencyContext>(this as EmergencyContext, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmergencyContext&&(identical(other.vehicleState, vehicleState) || other.vehicleState == vehicleState)&&(identical(other.speedMps, speedMps) || other.speedMps == speedMps)&&(identical(other.connectivity, connectivity) || other.connectivity == connectivity)&&(identical(other.isNight, isNight) || other.isNight == isNight)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.crashImpulseDetected, crashImpulseDetected) || other.crashImpulseDetected == crashImpulseDetected)&&(identical(other.position, position) || other.position == position)&&(identical(other.bus, bus) || other.bus == bus)&&const DeepCollectionEquality().equals(other.userSignals, userSignals)&&const DeepCollectionEquality().equals(other.hazards, hazards));
}


@override
int get hashCode => Object.hash(runtimeType,vehicleState,speedMps,connectivity,isNight,timestamp,crashImpulseDetected,position,bus,const DeepCollectionEquality().hash(userSignals),const DeepCollectionEquality().hash(hazards));

@override
String toString() {
  return 'EmergencyContext(vehicleState: $vehicleState, speedMps: $speedMps, connectivity: $connectivity, isNight: $isNight, timestamp: $timestamp, crashImpulseDetected: $crashImpulseDetected, position: $position, bus: $bus, userSignals: $userSignals, hazards: $hazards)';
}


}

/// @nodoc
abstract mixin class $EmergencyContextCopyWith<$Res>  {
  factory $EmergencyContextCopyWith(EmergencyContext value, $Res Function(EmergencyContext) _then) = _$EmergencyContextCopyWithImpl;
@useResult
$Res call({
 VehicleState vehicleState, double speedMps, Connectivity connectivity, bool isNight, DateTime timestamp, bool crashImpulseDetected, GeoPosition? position, VehicleBusSnapshot? bus, List<UserSignal> userSignals, Set<Hazard> hazards
});


$GeoPositionCopyWith<$Res>? get position;$VehicleBusSnapshotCopyWith<$Res>? get bus;

}
/// @nodoc
class _$EmergencyContextCopyWithImpl<$Res>
    implements $EmergencyContextCopyWith<$Res> {
  _$EmergencyContextCopyWithImpl(this._self, this._then);

  final EmergencyContext _self;
  final $Res Function(EmergencyContext) _then;

/// Create a copy of EmergencyContext
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vehicleState = null,Object? speedMps = null,Object? connectivity = null,Object? isNight = null,Object? timestamp = null,Object? crashImpulseDetected = null,Object? position = freezed,Object? bus = freezed,Object? userSignals = null,Object? hazards = null,}) {
  return _then(_self.copyWith(
vehicleState: null == vehicleState ? _self.vehicleState : vehicleState // ignore: cast_nullable_to_non_nullable
as VehicleState,speedMps: null == speedMps ? _self.speedMps : speedMps // ignore: cast_nullable_to_non_nullable
as double,connectivity: null == connectivity ? _self.connectivity : connectivity // ignore: cast_nullable_to_non_nullable
as Connectivity,isNight: null == isNight ? _self.isNight : isNight // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,crashImpulseDetected: null == crashImpulseDetected ? _self.crashImpulseDetected : crashImpulseDetected // ignore: cast_nullable_to_non_nullable
as bool,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as GeoPosition?,bus: freezed == bus ? _self.bus : bus // ignore: cast_nullable_to_non_nullable
as VehicleBusSnapshot?,userSignals: null == userSignals ? _self.userSignals : userSignals // ignore: cast_nullable_to_non_nullable
as List<UserSignal>,hazards: null == hazards ? _self.hazards : hazards // ignore: cast_nullable_to_non_nullable
as Set<Hazard>,
  ));
}
/// Create a copy of EmergencyContext
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPositionCopyWith<$Res>? get position {
    if (_self.position == null) {
    return null;
  }

  return $GeoPositionCopyWith<$Res>(_self.position!, (value) {
    return _then(_self.copyWith(position: value));
  });
}/// Create a copy of EmergencyContext
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleBusSnapshotCopyWith<$Res>? get bus {
    if (_self.bus == null) {
    return null;
  }

  return $VehicleBusSnapshotCopyWith<$Res>(_self.bus!, (value) {
    return _then(_self.copyWith(bus: value));
  });
}
}


/// Adds pattern-matching-related methods to [EmergencyContext].
extension EmergencyContextPatterns on EmergencyContext {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmergencyContext value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmergencyContext() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmergencyContext value)  $default,){
final _that = this;
switch (_that) {
case _EmergencyContext():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmergencyContext value)?  $default,){
final _that = this;
switch (_that) {
case _EmergencyContext() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VehicleState vehicleState,  double speedMps,  Connectivity connectivity,  bool isNight,  DateTime timestamp,  bool crashImpulseDetected,  GeoPosition? position,  VehicleBusSnapshot? bus,  List<UserSignal> userSignals,  Set<Hazard> hazards)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmergencyContext() when $default != null:
return $default(_that.vehicleState,_that.speedMps,_that.connectivity,_that.isNight,_that.timestamp,_that.crashImpulseDetected,_that.position,_that.bus,_that.userSignals,_that.hazards);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VehicleState vehicleState,  double speedMps,  Connectivity connectivity,  bool isNight,  DateTime timestamp,  bool crashImpulseDetected,  GeoPosition? position,  VehicleBusSnapshot? bus,  List<UserSignal> userSignals,  Set<Hazard> hazards)  $default,) {final _that = this;
switch (_that) {
case _EmergencyContext():
return $default(_that.vehicleState,_that.speedMps,_that.connectivity,_that.isNight,_that.timestamp,_that.crashImpulseDetected,_that.position,_that.bus,_that.userSignals,_that.hazards);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VehicleState vehicleState,  double speedMps,  Connectivity connectivity,  bool isNight,  DateTime timestamp,  bool crashImpulseDetected,  GeoPosition? position,  VehicleBusSnapshot? bus,  List<UserSignal> userSignals,  Set<Hazard> hazards)?  $default,) {final _that = this;
switch (_that) {
case _EmergencyContext() when $default != null:
return $default(_that.vehicleState,_that.speedMps,_that.connectivity,_that.isNight,_that.timestamp,_that.crashImpulseDetected,_that.position,_that.bus,_that.userSignals,_that.hazards);case _:
  return null;

}
}

}

/// @nodoc


class _EmergencyContext extends EmergencyContext {
  const _EmergencyContext({required this.vehicleState, required this.speedMps, required this.connectivity, required this.isNight, required this.timestamp, this.crashImpulseDetected = false, this.position, this.bus, final  List<UserSignal> userSignals = const <UserSignal>[], final  Set<Hazard> hazards = const <Hazard>{}}): _userSignals = userSignals,_hazards = hazards,super._();
  

@override final  VehicleState vehicleState;
@override final  double speedMps;
@override final  Connectivity connectivity;
@override final  bool isNight;
@override final  DateTime timestamp;
@override@JsonKey() final  bool crashImpulseDetected;
@override final  GeoPosition? position;
@override final  VehicleBusSnapshot? bus;
 final  List<UserSignal> _userSignals;
@override@JsonKey() List<UserSignal> get userSignals {
  if (_userSignals is EqualUnmodifiableListView) return _userSignals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_userSignals);
}

 final  Set<Hazard> _hazards;
@override@JsonKey() Set<Hazard> get hazards {
  if (_hazards is EqualUnmodifiableSetView) return _hazards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_hazards);
}


/// Create a copy of EmergencyContext
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmergencyContextCopyWith<_EmergencyContext> get copyWith => __$EmergencyContextCopyWithImpl<_EmergencyContext>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmergencyContext&&(identical(other.vehicleState, vehicleState) || other.vehicleState == vehicleState)&&(identical(other.speedMps, speedMps) || other.speedMps == speedMps)&&(identical(other.connectivity, connectivity) || other.connectivity == connectivity)&&(identical(other.isNight, isNight) || other.isNight == isNight)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.crashImpulseDetected, crashImpulseDetected) || other.crashImpulseDetected == crashImpulseDetected)&&(identical(other.position, position) || other.position == position)&&(identical(other.bus, bus) || other.bus == bus)&&const DeepCollectionEquality().equals(other._userSignals, _userSignals)&&const DeepCollectionEquality().equals(other._hazards, _hazards));
}


@override
int get hashCode => Object.hash(runtimeType,vehicleState,speedMps,connectivity,isNight,timestamp,crashImpulseDetected,position,bus,const DeepCollectionEquality().hash(_userSignals),const DeepCollectionEquality().hash(_hazards));

@override
String toString() {
  return 'EmergencyContext(vehicleState: $vehicleState, speedMps: $speedMps, connectivity: $connectivity, isNight: $isNight, timestamp: $timestamp, crashImpulseDetected: $crashImpulseDetected, position: $position, bus: $bus, userSignals: $userSignals, hazards: $hazards)';
}


}

/// @nodoc
abstract mixin class _$EmergencyContextCopyWith<$Res> implements $EmergencyContextCopyWith<$Res> {
  factory _$EmergencyContextCopyWith(_EmergencyContext value, $Res Function(_EmergencyContext) _then) = __$EmergencyContextCopyWithImpl;
@override @useResult
$Res call({
 VehicleState vehicleState, double speedMps, Connectivity connectivity, bool isNight, DateTime timestamp, bool crashImpulseDetected, GeoPosition? position, VehicleBusSnapshot? bus, List<UserSignal> userSignals, Set<Hazard> hazards
});


@override $GeoPositionCopyWith<$Res>? get position;@override $VehicleBusSnapshotCopyWith<$Res>? get bus;

}
/// @nodoc
class __$EmergencyContextCopyWithImpl<$Res>
    implements _$EmergencyContextCopyWith<$Res> {
  __$EmergencyContextCopyWithImpl(this._self, this._then);

  final _EmergencyContext _self;
  final $Res Function(_EmergencyContext) _then;

/// Create a copy of EmergencyContext
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vehicleState = null,Object? speedMps = null,Object? connectivity = null,Object? isNight = null,Object? timestamp = null,Object? crashImpulseDetected = null,Object? position = freezed,Object? bus = freezed,Object? userSignals = null,Object? hazards = null,}) {
  return _then(_EmergencyContext(
vehicleState: null == vehicleState ? _self.vehicleState : vehicleState // ignore: cast_nullable_to_non_nullable
as VehicleState,speedMps: null == speedMps ? _self.speedMps : speedMps // ignore: cast_nullable_to_non_nullable
as double,connectivity: null == connectivity ? _self.connectivity : connectivity // ignore: cast_nullable_to_non_nullable
as Connectivity,isNight: null == isNight ? _self.isNight : isNight // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,crashImpulseDetected: null == crashImpulseDetected ? _self.crashImpulseDetected : crashImpulseDetected // ignore: cast_nullable_to_non_nullable
as bool,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as GeoPosition?,bus: freezed == bus ? _self.bus : bus // ignore: cast_nullable_to_non_nullable
as VehicleBusSnapshot?,userSignals: null == userSignals ? _self._userSignals : userSignals // ignore: cast_nullable_to_non_nullable
as List<UserSignal>,hazards: null == hazards ? _self._hazards : hazards // ignore: cast_nullable_to_non_nullable
as Set<Hazard>,
  ));
}

/// Create a copy of EmergencyContext
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPositionCopyWith<$Res>? get position {
    if (_self.position == null) {
    return null;
  }

  return $GeoPositionCopyWith<$Res>(_self.position!, (value) {
    return _then(_self.copyWith(position: value));
  });
}/// Create a copy of EmergencyContext
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleBusSnapshotCopyWith<$Res>? get bus {
    if (_self.bus == null) {
    return null;
  }

  return $VehicleBusSnapshotCopyWith<$Res>(_self.bus!, (value) {
    return _then(_self.copyWith(bus: value));
  });
}
}

// dart format on
