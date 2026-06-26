// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_session_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VoiceSessionConfig {

 String get locale; int get sampleRate; AudioCodec get codec; String? get incidentId; ApiSeverity? get tier;
/// Create a copy of VoiceSessionConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceSessionConfigCopyWith<VoiceSessionConfig> get copyWith => _$VoiceSessionConfigCopyWithImpl<VoiceSessionConfig>(this as VoiceSessionConfig, _$identity);

  /// Serializes this VoiceSessionConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceSessionConfig&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.sampleRate, sampleRate) || other.sampleRate == sampleRate)&&(identical(other.codec, codec) || other.codec == codec)&&(identical(other.incidentId, incidentId) || other.incidentId == incidentId)&&(identical(other.tier, tier) || other.tier == tier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,locale,sampleRate,codec,incidentId,tier);

@override
String toString() {
  return 'VoiceSessionConfig(locale: $locale, sampleRate: $sampleRate, codec: $codec, incidentId: $incidentId, tier: $tier)';
}


}

/// @nodoc
abstract mixin class $VoiceSessionConfigCopyWith<$Res>  {
  factory $VoiceSessionConfigCopyWith(VoiceSessionConfig value, $Res Function(VoiceSessionConfig) _then) = _$VoiceSessionConfigCopyWithImpl;
@useResult
$Res call({
 String locale, int sampleRate, AudioCodec codec, String? incidentId, ApiSeverity? tier
});




}
/// @nodoc
class _$VoiceSessionConfigCopyWithImpl<$Res>
    implements $VoiceSessionConfigCopyWith<$Res> {
  _$VoiceSessionConfigCopyWithImpl(this._self, this._then);

  final VoiceSessionConfig _self;
  final $Res Function(VoiceSessionConfig) _then;

/// Create a copy of VoiceSessionConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? locale = null,Object? sampleRate = null,Object? codec = null,Object? incidentId = freezed,Object? tier = freezed,}) {
  return _then(_self.copyWith(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,sampleRate: null == sampleRate ? _self.sampleRate : sampleRate // ignore: cast_nullable_to_non_nullable
as int,codec: null == codec ? _self.codec : codec // ignore: cast_nullable_to_non_nullable
as AudioCodec,incidentId: freezed == incidentId ? _self.incidentId : incidentId // ignore: cast_nullable_to_non_nullable
as String?,tier: freezed == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as ApiSeverity?,
  ));
}

}


/// Adds pattern-matching-related methods to [VoiceSessionConfig].
extension VoiceSessionConfigPatterns on VoiceSessionConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoiceSessionConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoiceSessionConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoiceSessionConfig value)  $default,){
final _that = this;
switch (_that) {
case _VoiceSessionConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoiceSessionConfig value)?  $default,){
final _that = this;
switch (_that) {
case _VoiceSessionConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String locale,  int sampleRate,  AudioCodec codec,  String? incidentId,  ApiSeverity? tier)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoiceSessionConfig() when $default != null:
return $default(_that.locale,_that.sampleRate,_that.codec,_that.incidentId,_that.tier);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String locale,  int sampleRate,  AudioCodec codec,  String? incidentId,  ApiSeverity? tier)  $default,) {final _that = this;
switch (_that) {
case _VoiceSessionConfig():
return $default(_that.locale,_that.sampleRate,_that.codec,_that.incidentId,_that.tier);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String locale,  int sampleRate,  AudioCodec codec,  String? incidentId,  ApiSeverity? tier)?  $default,) {final _that = this;
switch (_that) {
case _VoiceSessionConfig() when $default != null:
return $default(_that.locale,_that.sampleRate,_that.codec,_that.incidentId,_that.tier);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VoiceSessionConfig implements VoiceSessionConfig {
  const _VoiceSessionConfig({required this.locale, required this.sampleRate, required this.codec, this.incidentId, this.tier});
  factory _VoiceSessionConfig.fromJson(Map<String, dynamic> json) => _$VoiceSessionConfigFromJson(json);

@override final  String locale;
@override final  int sampleRate;
@override final  AudioCodec codec;
@override final  String? incidentId;
@override final  ApiSeverity? tier;

/// Create a copy of VoiceSessionConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoiceSessionConfigCopyWith<_VoiceSessionConfig> get copyWith => __$VoiceSessionConfigCopyWithImpl<_VoiceSessionConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoiceSessionConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoiceSessionConfig&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.sampleRate, sampleRate) || other.sampleRate == sampleRate)&&(identical(other.codec, codec) || other.codec == codec)&&(identical(other.incidentId, incidentId) || other.incidentId == incidentId)&&(identical(other.tier, tier) || other.tier == tier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,locale,sampleRate,codec,incidentId,tier);

@override
String toString() {
  return 'VoiceSessionConfig(locale: $locale, sampleRate: $sampleRate, codec: $codec, incidentId: $incidentId, tier: $tier)';
}


}

/// @nodoc
abstract mixin class _$VoiceSessionConfigCopyWith<$Res> implements $VoiceSessionConfigCopyWith<$Res> {
  factory _$VoiceSessionConfigCopyWith(_VoiceSessionConfig value, $Res Function(_VoiceSessionConfig) _then) = __$VoiceSessionConfigCopyWithImpl;
@override @useResult
$Res call({
 String locale, int sampleRate, AudioCodec codec, String? incidentId, ApiSeverity? tier
});




}
/// @nodoc
class __$VoiceSessionConfigCopyWithImpl<$Res>
    implements _$VoiceSessionConfigCopyWith<$Res> {
  __$VoiceSessionConfigCopyWithImpl(this._self, this._then);

  final _VoiceSessionConfig _self;
  final $Res Function(_VoiceSessionConfig) _then;

/// Create a copy of VoiceSessionConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locale = null,Object? sampleRate = null,Object? codec = null,Object? incidentId = freezed,Object? tier = freezed,}) {
  return _then(_VoiceSessionConfig(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,sampleRate: null == sampleRate ? _self.sampleRate : sampleRate // ignore: cast_nullable_to_non_nullable
as int,codec: null == codec ? _self.codec : codec // ignore: cast_nullable_to_non_nullable
as AudioCodec,incidentId: freezed == incidentId ? _self.incidentId : incidentId // ignore: cast_nullable_to_non_nullable
as String?,tier: freezed == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as ApiSeverity?,
  ));
}


}


/// @nodoc
mixin _$NegotiatedAudioConfig {

 int? get sampleRate; AudioCodec? get codec;
/// Create a copy of NegotiatedAudioConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NegotiatedAudioConfigCopyWith<NegotiatedAudioConfig> get copyWith => _$NegotiatedAudioConfigCopyWithImpl<NegotiatedAudioConfig>(this as NegotiatedAudioConfig, _$identity);

  /// Serializes this NegotiatedAudioConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NegotiatedAudioConfig&&(identical(other.sampleRate, sampleRate) || other.sampleRate == sampleRate)&&(identical(other.codec, codec) || other.codec == codec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sampleRate,codec);

@override
String toString() {
  return 'NegotiatedAudioConfig(sampleRate: $sampleRate, codec: $codec)';
}


}

/// @nodoc
abstract mixin class $NegotiatedAudioConfigCopyWith<$Res>  {
  factory $NegotiatedAudioConfigCopyWith(NegotiatedAudioConfig value, $Res Function(NegotiatedAudioConfig) _then) = _$NegotiatedAudioConfigCopyWithImpl;
@useResult
$Res call({
 int? sampleRate, AudioCodec? codec
});




}
/// @nodoc
class _$NegotiatedAudioConfigCopyWithImpl<$Res>
    implements $NegotiatedAudioConfigCopyWith<$Res> {
  _$NegotiatedAudioConfigCopyWithImpl(this._self, this._then);

  final NegotiatedAudioConfig _self;
  final $Res Function(NegotiatedAudioConfig) _then;

/// Create a copy of NegotiatedAudioConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sampleRate = freezed,Object? codec = freezed,}) {
  return _then(_self.copyWith(
sampleRate: freezed == sampleRate ? _self.sampleRate : sampleRate // ignore: cast_nullable_to_non_nullable
as int?,codec: freezed == codec ? _self.codec : codec // ignore: cast_nullable_to_non_nullable
as AudioCodec?,
  ));
}

}


/// Adds pattern-matching-related methods to [NegotiatedAudioConfig].
extension NegotiatedAudioConfigPatterns on NegotiatedAudioConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NegotiatedAudioConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NegotiatedAudioConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NegotiatedAudioConfig value)  $default,){
final _that = this;
switch (_that) {
case _NegotiatedAudioConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NegotiatedAudioConfig value)?  $default,){
final _that = this;
switch (_that) {
case _NegotiatedAudioConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? sampleRate,  AudioCodec? codec)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NegotiatedAudioConfig() when $default != null:
return $default(_that.sampleRate,_that.codec);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? sampleRate,  AudioCodec? codec)  $default,) {final _that = this;
switch (_that) {
case _NegotiatedAudioConfig():
return $default(_that.sampleRate,_that.codec);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? sampleRate,  AudioCodec? codec)?  $default,) {final _that = this;
switch (_that) {
case _NegotiatedAudioConfig() when $default != null:
return $default(_that.sampleRate,_that.codec);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NegotiatedAudioConfig implements NegotiatedAudioConfig {
  const _NegotiatedAudioConfig({this.sampleRate, this.codec});
  factory _NegotiatedAudioConfig.fromJson(Map<String, dynamic> json) => _$NegotiatedAudioConfigFromJson(json);

@override final  int? sampleRate;
@override final  AudioCodec? codec;

/// Create a copy of NegotiatedAudioConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NegotiatedAudioConfigCopyWith<_NegotiatedAudioConfig> get copyWith => __$NegotiatedAudioConfigCopyWithImpl<_NegotiatedAudioConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NegotiatedAudioConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NegotiatedAudioConfig&&(identical(other.sampleRate, sampleRate) || other.sampleRate == sampleRate)&&(identical(other.codec, codec) || other.codec == codec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sampleRate,codec);

@override
String toString() {
  return 'NegotiatedAudioConfig(sampleRate: $sampleRate, codec: $codec)';
}


}

/// @nodoc
abstract mixin class _$NegotiatedAudioConfigCopyWith<$Res> implements $NegotiatedAudioConfigCopyWith<$Res> {
  factory _$NegotiatedAudioConfigCopyWith(_NegotiatedAudioConfig value, $Res Function(_NegotiatedAudioConfig) _then) = __$NegotiatedAudioConfigCopyWithImpl;
@override @useResult
$Res call({
 int? sampleRate, AudioCodec? codec
});




}
/// @nodoc
class __$NegotiatedAudioConfigCopyWithImpl<$Res>
    implements _$NegotiatedAudioConfigCopyWith<$Res> {
  __$NegotiatedAudioConfigCopyWithImpl(this._self, this._then);

  final _NegotiatedAudioConfig _self;
  final $Res Function(_NegotiatedAudioConfig) _then;

/// Create a copy of NegotiatedAudioConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sampleRate = freezed,Object? codec = freezed,}) {
  return _then(_NegotiatedAudioConfig(
sampleRate: freezed == sampleRate ? _self.sampleRate : sampleRate // ignore: cast_nullable_to_non_nullable
as int?,codec: freezed == codec ? _self.codec : codec // ignore: cast_nullable_to_non_nullable
as AudioCodec?,
  ));
}


}

// dart format on
