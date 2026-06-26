// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'classification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Classification {

 ScenarioClass get scenario; Severity get severity; AppMode get mode; double get confidence; Set<Hazard> get hazards;
/// Create a copy of Classification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClassificationCopyWith<Classification> get copyWith => _$ClassificationCopyWithImpl<Classification>(this as Classification, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Classification&&(identical(other.scenario, scenario) || other.scenario == scenario)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&const DeepCollectionEquality().equals(other.hazards, hazards));
}


@override
int get hashCode => Object.hash(runtimeType,scenario,severity,mode,confidence,const DeepCollectionEquality().hash(hazards));

@override
String toString() {
  return 'Classification(scenario: $scenario, severity: $severity, mode: $mode, confidence: $confidence, hazards: $hazards)';
}


}

/// @nodoc
abstract mixin class $ClassificationCopyWith<$Res>  {
  factory $ClassificationCopyWith(Classification value, $Res Function(Classification) _then) = _$ClassificationCopyWithImpl;
@useResult
$Res call({
 ScenarioClass scenario, Severity severity, AppMode mode, double confidence, Set<Hazard> hazards
});




}
/// @nodoc
class _$ClassificationCopyWithImpl<$Res>
    implements $ClassificationCopyWith<$Res> {
  _$ClassificationCopyWithImpl(this._self, this._then);

  final Classification _self;
  final $Res Function(Classification) _then;

/// Create a copy of Classification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scenario = null,Object? severity = null,Object? mode = null,Object? confidence = null,Object? hazards = null,}) {
  return _then(_self.copyWith(
scenario: null == scenario ? _self.scenario : scenario // ignore: cast_nullable_to_non_nullable
as ScenarioClass,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as Severity,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AppMode,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,hazards: null == hazards ? _self.hazards : hazards // ignore: cast_nullable_to_non_nullable
as Set<Hazard>,
  ));
}

}


/// Adds pattern-matching-related methods to [Classification].
extension ClassificationPatterns on Classification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Classification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Classification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Classification value)  $default,){
final _that = this;
switch (_that) {
case _Classification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Classification value)?  $default,){
final _that = this;
switch (_that) {
case _Classification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ScenarioClass scenario,  Severity severity,  AppMode mode,  double confidence,  Set<Hazard> hazards)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Classification() when $default != null:
return $default(_that.scenario,_that.severity,_that.mode,_that.confidence,_that.hazards);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ScenarioClass scenario,  Severity severity,  AppMode mode,  double confidence,  Set<Hazard> hazards)  $default,) {final _that = this;
switch (_that) {
case _Classification():
return $default(_that.scenario,_that.severity,_that.mode,_that.confidence,_that.hazards);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ScenarioClass scenario,  Severity severity,  AppMode mode,  double confidence,  Set<Hazard> hazards)?  $default,) {final _that = this;
switch (_that) {
case _Classification() when $default != null:
return $default(_that.scenario,_that.severity,_that.mode,_that.confidence,_that.hazards);case _:
  return null;

}
}

}

/// @nodoc


class _Classification implements Classification {
  const _Classification({required this.scenario, required this.severity, required this.mode, required this.confidence, final  Set<Hazard> hazards = const <Hazard>{}}): _hazards = hazards;
  

@override final  ScenarioClass scenario;
@override final  Severity severity;
@override final  AppMode mode;
@override final  double confidence;
 final  Set<Hazard> _hazards;
@override@JsonKey() Set<Hazard> get hazards {
  if (_hazards is EqualUnmodifiableSetView) return _hazards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_hazards);
}


/// Create a copy of Classification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClassificationCopyWith<_Classification> get copyWith => __$ClassificationCopyWithImpl<_Classification>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Classification&&(identical(other.scenario, scenario) || other.scenario == scenario)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&const DeepCollectionEquality().equals(other._hazards, _hazards));
}


@override
int get hashCode => Object.hash(runtimeType,scenario,severity,mode,confidence,const DeepCollectionEquality().hash(_hazards));

@override
String toString() {
  return 'Classification(scenario: $scenario, severity: $severity, mode: $mode, confidence: $confidence, hazards: $hazards)';
}


}

/// @nodoc
abstract mixin class _$ClassificationCopyWith<$Res> implements $ClassificationCopyWith<$Res> {
  factory _$ClassificationCopyWith(_Classification value, $Res Function(_Classification) _then) = __$ClassificationCopyWithImpl;
@override @useResult
$Res call({
 ScenarioClass scenario, Severity severity, AppMode mode, double confidence, Set<Hazard> hazards
});




}
/// @nodoc
class __$ClassificationCopyWithImpl<$Res>
    implements _$ClassificationCopyWith<$Res> {
  __$ClassificationCopyWithImpl(this._self, this._then);

  final _Classification _self;
  final $Res Function(_Classification) _then;

/// Create a copy of Classification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scenario = null,Object? severity = null,Object? mode = null,Object? confidence = null,Object? hazards = null,}) {
  return _then(_Classification(
scenario: null == scenario ? _self.scenario : scenario // ignore: cast_nullable_to_non_nullable
as ScenarioClass,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as Severity,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AppMode,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,hazards: null == hazards ? _self._hazards : hazards // ignore: cast_nullable_to_non_nullable
as Set<Hazard>,
  ));
}


}

// dart format on
