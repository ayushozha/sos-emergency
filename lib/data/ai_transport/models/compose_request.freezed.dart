// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compose_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ComposeRequest {

 ClassificationDto get classification; ComposeContext get context; String get catalogVersion; bool get stream; int get timeBudgetMs; String? get requestId;
/// Create a copy of ComposeRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComposeRequestCopyWith<ComposeRequest> get copyWith => _$ComposeRequestCopyWithImpl<ComposeRequest>(this as ComposeRequest, _$identity);

  /// Serializes this ComposeRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComposeRequest&&(identical(other.classification, classification) || other.classification == classification)&&(identical(other.context, context) || other.context == context)&&(identical(other.catalogVersion, catalogVersion) || other.catalogVersion == catalogVersion)&&(identical(other.stream, stream) || other.stream == stream)&&(identical(other.timeBudgetMs, timeBudgetMs) || other.timeBudgetMs == timeBudgetMs)&&(identical(other.requestId, requestId) || other.requestId == requestId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classification,context,catalogVersion,stream,timeBudgetMs,requestId);

@override
String toString() {
  return 'ComposeRequest(classification: $classification, context: $context, catalogVersion: $catalogVersion, stream: $stream, timeBudgetMs: $timeBudgetMs, requestId: $requestId)';
}


}

/// @nodoc
abstract mixin class $ComposeRequestCopyWith<$Res>  {
  factory $ComposeRequestCopyWith(ComposeRequest value, $Res Function(ComposeRequest) _then) = _$ComposeRequestCopyWithImpl;
@useResult
$Res call({
 ClassificationDto classification, ComposeContext context, String catalogVersion, bool stream, int timeBudgetMs, String? requestId
});


$ClassificationDtoCopyWith<$Res> get classification;$ComposeContextCopyWith<$Res> get context;

}
/// @nodoc
class _$ComposeRequestCopyWithImpl<$Res>
    implements $ComposeRequestCopyWith<$Res> {
  _$ComposeRequestCopyWithImpl(this._self, this._then);

  final ComposeRequest _self;
  final $Res Function(ComposeRequest) _then;

/// Create a copy of ComposeRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? classification = null,Object? context = null,Object? catalogVersion = null,Object? stream = null,Object? timeBudgetMs = null,Object? requestId = freezed,}) {
  return _then(_self.copyWith(
classification: null == classification ? _self.classification : classification // ignore: cast_nullable_to_non_nullable
as ClassificationDto,context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as ComposeContext,catalogVersion: null == catalogVersion ? _self.catalogVersion : catalogVersion // ignore: cast_nullable_to_non_nullable
as String,stream: null == stream ? _self.stream : stream // ignore: cast_nullable_to_non_nullable
as bool,timeBudgetMs: null == timeBudgetMs ? _self.timeBudgetMs : timeBudgetMs // ignore: cast_nullable_to_non_nullable
as int,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ComposeRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClassificationDtoCopyWith<$Res> get classification {
  
  return $ClassificationDtoCopyWith<$Res>(_self.classification, (value) {
    return _then(_self.copyWith(classification: value));
  });
}/// Create a copy of ComposeRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComposeContextCopyWith<$Res> get context {
  
  return $ComposeContextCopyWith<$Res>(_self.context, (value) {
    return _then(_self.copyWith(context: value));
  });
}
}


/// Adds pattern-matching-related methods to [ComposeRequest].
extension ComposeRequestPatterns on ComposeRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComposeRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComposeRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComposeRequest value)  $default,){
final _that = this;
switch (_that) {
case _ComposeRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComposeRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ComposeRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ClassificationDto classification,  ComposeContext context,  String catalogVersion,  bool stream,  int timeBudgetMs,  String? requestId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComposeRequest() when $default != null:
return $default(_that.classification,_that.context,_that.catalogVersion,_that.stream,_that.timeBudgetMs,_that.requestId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ClassificationDto classification,  ComposeContext context,  String catalogVersion,  bool stream,  int timeBudgetMs,  String? requestId)  $default,) {final _that = this;
switch (_that) {
case _ComposeRequest():
return $default(_that.classification,_that.context,_that.catalogVersion,_that.stream,_that.timeBudgetMs,_that.requestId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ClassificationDto classification,  ComposeContext context,  String catalogVersion,  bool stream,  int timeBudgetMs,  String? requestId)?  $default,) {final _that = this;
switch (_that) {
case _ComposeRequest() when $default != null:
return $default(_that.classification,_that.context,_that.catalogVersion,_that.stream,_that.timeBudgetMs,_that.requestId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComposeRequest implements ComposeRequest {
  const _ComposeRequest({required this.classification, required this.context, required this.catalogVersion, this.stream = true, this.timeBudgetMs = 3000, this.requestId});
  factory _ComposeRequest.fromJson(Map<String, dynamic> json) => _$ComposeRequestFromJson(json);

@override final  ClassificationDto classification;
@override final  ComposeContext context;
@override final  String catalogVersion;
@override@JsonKey() final  bool stream;
@override@JsonKey() final  int timeBudgetMs;
@override final  String? requestId;

/// Create a copy of ComposeRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComposeRequestCopyWith<_ComposeRequest> get copyWith => __$ComposeRequestCopyWithImpl<_ComposeRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComposeRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComposeRequest&&(identical(other.classification, classification) || other.classification == classification)&&(identical(other.context, context) || other.context == context)&&(identical(other.catalogVersion, catalogVersion) || other.catalogVersion == catalogVersion)&&(identical(other.stream, stream) || other.stream == stream)&&(identical(other.timeBudgetMs, timeBudgetMs) || other.timeBudgetMs == timeBudgetMs)&&(identical(other.requestId, requestId) || other.requestId == requestId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,classification,context,catalogVersion,stream,timeBudgetMs,requestId);

@override
String toString() {
  return 'ComposeRequest(classification: $classification, context: $context, catalogVersion: $catalogVersion, stream: $stream, timeBudgetMs: $timeBudgetMs, requestId: $requestId)';
}


}

/// @nodoc
abstract mixin class _$ComposeRequestCopyWith<$Res> implements $ComposeRequestCopyWith<$Res> {
  factory _$ComposeRequestCopyWith(_ComposeRequest value, $Res Function(_ComposeRequest) _then) = __$ComposeRequestCopyWithImpl;
@override @useResult
$Res call({
 ClassificationDto classification, ComposeContext context, String catalogVersion, bool stream, int timeBudgetMs, String? requestId
});


@override $ClassificationDtoCopyWith<$Res> get classification;@override $ComposeContextCopyWith<$Res> get context;

}
/// @nodoc
class __$ComposeRequestCopyWithImpl<$Res>
    implements _$ComposeRequestCopyWith<$Res> {
  __$ComposeRequestCopyWithImpl(this._self, this._then);

  final _ComposeRequest _self;
  final $Res Function(_ComposeRequest) _then;

/// Create a copy of ComposeRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? classification = null,Object? context = null,Object? catalogVersion = null,Object? stream = null,Object? timeBudgetMs = null,Object? requestId = freezed,}) {
  return _then(_ComposeRequest(
classification: null == classification ? _self.classification : classification // ignore: cast_nullable_to_non_nullable
as ClassificationDto,context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as ComposeContext,catalogVersion: null == catalogVersion ? _self.catalogVersion : catalogVersion // ignore: cast_nullable_to_non_nullable
as String,stream: null == stream ? _self.stream : stream // ignore: cast_nullable_to_non_nullable
as bool,timeBudgetMs: null == timeBudgetMs ? _self.timeBudgetMs : timeBudgetMs // ignore: cast_nullable_to_non_nullable
as int,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ComposeRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClassificationDtoCopyWith<$Res> get classification {
  
  return $ClassificationDtoCopyWith<$Res>(_self.classification, (value) {
    return _then(_self.copyWith(classification: value));
  });
}/// Create a copy of ComposeRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComposeContextCopyWith<$Res> get context {
  
  return $ComposeContextCopyWith<$Res>(_self.context, (value) {
    return _then(_self.copyWith(context: value));
  });
}
}


/// @nodoc
mixin _$ClassificationDto {

 ApiScenarioClass get scenario; ApiSeverity get severity; ApiAppMode get mode; double get confidence; List<ApiHazard> get hazards;
/// Create a copy of ClassificationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClassificationDtoCopyWith<ClassificationDto> get copyWith => _$ClassificationDtoCopyWithImpl<ClassificationDto>(this as ClassificationDto, _$identity);

  /// Serializes this ClassificationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassificationDto&&(identical(other.scenario, scenario) || other.scenario == scenario)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&const DeepCollectionEquality().equals(other.hazards, hazards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scenario,severity,mode,confidence,const DeepCollectionEquality().hash(hazards));

@override
String toString() {
  return 'ClassificationDto(scenario: $scenario, severity: $severity, mode: $mode, confidence: $confidence, hazards: $hazards)';
}


}

/// @nodoc
abstract mixin class $ClassificationDtoCopyWith<$Res>  {
  factory $ClassificationDtoCopyWith(ClassificationDto value, $Res Function(ClassificationDto) _then) = _$ClassificationDtoCopyWithImpl;
@useResult
$Res call({
 ApiScenarioClass scenario, ApiSeverity severity, ApiAppMode mode, double confidence, List<ApiHazard> hazards
});




}
/// @nodoc
class _$ClassificationDtoCopyWithImpl<$Res>
    implements $ClassificationDtoCopyWith<$Res> {
  _$ClassificationDtoCopyWithImpl(this._self, this._then);

  final ClassificationDto _self;
  final $Res Function(ClassificationDto) _then;

/// Create a copy of ClassificationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scenario = null,Object? severity = null,Object? mode = null,Object? confidence = null,Object? hazards = null,}) {
  return _then(_self.copyWith(
scenario: null == scenario ? _self.scenario : scenario // ignore: cast_nullable_to_non_nullable
as ApiScenarioClass,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as ApiSeverity,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ApiAppMode,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,hazards: null == hazards ? _self.hazards : hazards // ignore: cast_nullable_to_non_nullable
as List<ApiHazard>,
  ));
}

}


/// Adds pattern-matching-related methods to [ClassificationDto].
extension ClassificationDtoPatterns on ClassificationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClassificationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClassificationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClassificationDto value)  $default,){
final _that = this;
switch (_that) {
case _ClassificationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClassificationDto value)?  $default,){
final _that = this;
switch (_that) {
case _ClassificationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ApiScenarioClass scenario,  ApiSeverity severity,  ApiAppMode mode,  double confidence,  List<ApiHazard> hazards)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClassificationDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ApiScenarioClass scenario,  ApiSeverity severity,  ApiAppMode mode,  double confidence,  List<ApiHazard> hazards)  $default,) {final _that = this;
switch (_that) {
case _ClassificationDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ApiScenarioClass scenario,  ApiSeverity severity,  ApiAppMode mode,  double confidence,  List<ApiHazard> hazards)?  $default,) {final _that = this;
switch (_that) {
case _ClassificationDto() when $default != null:
return $default(_that.scenario,_that.severity,_that.mode,_that.confidence,_that.hazards);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClassificationDto implements ClassificationDto {
  const _ClassificationDto({required this.scenario, required this.severity, required this.mode, required this.confidence, final  List<ApiHazard> hazards = const <ApiHazard>[]}): _hazards = hazards;
  factory _ClassificationDto.fromJson(Map<String, dynamic> json) => _$ClassificationDtoFromJson(json);

@override final  ApiScenarioClass scenario;
@override final  ApiSeverity severity;
@override final  ApiAppMode mode;
@override final  double confidence;
 final  List<ApiHazard> _hazards;
@override@JsonKey() List<ApiHazard> get hazards {
  if (_hazards is EqualUnmodifiableListView) return _hazards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hazards);
}


/// Create a copy of ClassificationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClassificationDtoCopyWith<_ClassificationDto> get copyWith => __$ClassificationDtoCopyWithImpl<_ClassificationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClassificationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClassificationDto&&(identical(other.scenario, scenario) || other.scenario == scenario)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&const DeepCollectionEquality().equals(other._hazards, _hazards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scenario,severity,mode,confidence,const DeepCollectionEquality().hash(_hazards));

@override
String toString() {
  return 'ClassificationDto(scenario: $scenario, severity: $severity, mode: $mode, confidence: $confidence, hazards: $hazards)';
}


}

/// @nodoc
abstract mixin class _$ClassificationDtoCopyWith<$Res> implements $ClassificationDtoCopyWith<$Res> {
  factory _$ClassificationDtoCopyWith(_ClassificationDto value, $Res Function(_ClassificationDto) _then) = __$ClassificationDtoCopyWithImpl;
@override @useResult
$Res call({
 ApiScenarioClass scenario, ApiSeverity severity, ApiAppMode mode, double confidence, List<ApiHazard> hazards
});




}
/// @nodoc
class __$ClassificationDtoCopyWithImpl<$Res>
    implements _$ClassificationDtoCopyWith<$Res> {
  __$ClassificationDtoCopyWithImpl(this._self, this._then);

  final _ClassificationDto _self;
  final $Res Function(_ClassificationDto) _then;

/// Create a copy of ClassificationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scenario = null,Object? severity = null,Object? mode = null,Object? confidence = null,Object? hazards = null,}) {
  return _then(_ClassificationDto(
scenario: null == scenario ? _self.scenario : scenario // ignore: cast_nullable_to_non_nullable
as ApiScenarioClass,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as ApiSeverity,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ApiAppMode,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,hazards: null == hazards ? _self._hazards : hazards // ignore: cast_nullable_to_non_nullable
as List<ApiHazard>,
  ));
}


}


/// @nodoc
mixin _$ComposeContext {

 ApiCarState get carState; ApiConnectivity get connectivity; bool get isNight; String get locale; String? get emergencyNumber; ComposePosition? get position;
/// Create a copy of ComposeContext
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComposeContextCopyWith<ComposeContext> get copyWith => _$ComposeContextCopyWithImpl<ComposeContext>(this as ComposeContext, _$identity);

  /// Serializes this ComposeContext to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComposeContext&&(identical(other.carState, carState) || other.carState == carState)&&(identical(other.connectivity, connectivity) || other.connectivity == connectivity)&&(identical(other.isNight, isNight) || other.isNight == isNight)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.emergencyNumber, emergencyNumber) || other.emergencyNumber == emergencyNumber)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,carState,connectivity,isNight,locale,emergencyNumber,position);

@override
String toString() {
  return 'ComposeContext(carState: $carState, connectivity: $connectivity, isNight: $isNight, locale: $locale, emergencyNumber: $emergencyNumber, position: $position)';
}


}

/// @nodoc
abstract mixin class $ComposeContextCopyWith<$Res>  {
  factory $ComposeContextCopyWith(ComposeContext value, $Res Function(ComposeContext) _then) = _$ComposeContextCopyWithImpl;
@useResult
$Res call({
 ApiCarState carState, ApiConnectivity connectivity, bool isNight, String locale, String? emergencyNumber, ComposePosition? position
});


$ComposePositionCopyWith<$Res>? get position;

}
/// @nodoc
class _$ComposeContextCopyWithImpl<$Res>
    implements $ComposeContextCopyWith<$Res> {
  _$ComposeContextCopyWithImpl(this._self, this._then);

  final ComposeContext _self;
  final $Res Function(ComposeContext) _then;

/// Create a copy of ComposeContext
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? carState = null,Object? connectivity = null,Object? isNight = null,Object? locale = null,Object? emergencyNumber = freezed,Object? position = freezed,}) {
  return _then(_self.copyWith(
carState: null == carState ? _self.carState : carState // ignore: cast_nullable_to_non_nullable
as ApiCarState,connectivity: null == connectivity ? _self.connectivity : connectivity // ignore: cast_nullable_to_non_nullable
as ApiConnectivity,isNight: null == isNight ? _self.isNight : isNight // ignore: cast_nullable_to_non_nullable
as bool,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,emergencyNumber: freezed == emergencyNumber ? _self.emergencyNumber : emergencyNumber // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as ComposePosition?,
  ));
}
/// Create a copy of ComposeContext
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComposePositionCopyWith<$Res>? get position {
    if (_self.position == null) {
    return null;
  }

  return $ComposePositionCopyWith<$Res>(_self.position!, (value) {
    return _then(_self.copyWith(position: value));
  });
}
}


/// Adds pattern-matching-related methods to [ComposeContext].
extension ComposeContextPatterns on ComposeContext {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComposeContext value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComposeContext() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComposeContext value)  $default,){
final _that = this;
switch (_that) {
case _ComposeContext():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComposeContext value)?  $default,){
final _that = this;
switch (_that) {
case _ComposeContext() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ApiCarState carState,  ApiConnectivity connectivity,  bool isNight,  String locale,  String? emergencyNumber,  ComposePosition? position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComposeContext() when $default != null:
return $default(_that.carState,_that.connectivity,_that.isNight,_that.locale,_that.emergencyNumber,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ApiCarState carState,  ApiConnectivity connectivity,  bool isNight,  String locale,  String? emergencyNumber,  ComposePosition? position)  $default,) {final _that = this;
switch (_that) {
case _ComposeContext():
return $default(_that.carState,_that.connectivity,_that.isNight,_that.locale,_that.emergencyNumber,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ApiCarState carState,  ApiConnectivity connectivity,  bool isNight,  String locale,  String? emergencyNumber,  ComposePosition? position)?  $default,) {final _that = this;
switch (_that) {
case _ComposeContext() when $default != null:
return $default(_that.carState,_that.connectivity,_that.isNight,_that.locale,_that.emergencyNumber,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComposeContext implements ComposeContext {
  const _ComposeContext({required this.carState, required this.connectivity, required this.isNight, required this.locale, this.emergencyNumber, this.position});
  factory _ComposeContext.fromJson(Map<String, dynamic> json) => _$ComposeContextFromJson(json);

@override final  ApiCarState carState;
@override final  ApiConnectivity connectivity;
@override final  bool isNight;
@override final  String locale;
@override final  String? emergencyNumber;
@override final  ComposePosition? position;

/// Create a copy of ComposeContext
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComposeContextCopyWith<_ComposeContext> get copyWith => __$ComposeContextCopyWithImpl<_ComposeContext>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComposeContextToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComposeContext&&(identical(other.carState, carState) || other.carState == carState)&&(identical(other.connectivity, connectivity) || other.connectivity == connectivity)&&(identical(other.isNight, isNight) || other.isNight == isNight)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.emergencyNumber, emergencyNumber) || other.emergencyNumber == emergencyNumber)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,carState,connectivity,isNight,locale,emergencyNumber,position);

@override
String toString() {
  return 'ComposeContext(carState: $carState, connectivity: $connectivity, isNight: $isNight, locale: $locale, emergencyNumber: $emergencyNumber, position: $position)';
}


}

/// @nodoc
abstract mixin class _$ComposeContextCopyWith<$Res> implements $ComposeContextCopyWith<$Res> {
  factory _$ComposeContextCopyWith(_ComposeContext value, $Res Function(_ComposeContext) _then) = __$ComposeContextCopyWithImpl;
@override @useResult
$Res call({
 ApiCarState carState, ApiConnectivity connectivity, bool isNight, String locale, String? emergencyNumber, ComposePosition? position
});


@override $ComposePositionCopyWith<$Res>? get position;

}
/// @nodoc
class __$ComposeContextCopyWithImpl<$Res>
    implements _$ComposeContextCopyWith<$Res> {
  __$ComposeContextCopyWithImpl(this._self, this._then);

  final _ComposeContext _self;
  final $Res Function(_ComposeContext) _then;

/// Create a copy of ComposeContext
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? carState = null,Object? connectivity = null,Object? isNight = null,Object? locale = null,Object? emergencyNumber = freezed,Object? position = freezed,}) {
  return _then(_ComposeContext(
carState: null == carState ? _self.carState : carState // ignore: cast_nullable_to_non_nullable
as ApiCarState,connectivity: null == connectivity ? _self.connectivity : connectivity // ignore: cast_nullable_to_non_nullable
as ApiConnectivity,isNight: null == isNight ? _self.isNight : isNight // ignore: cast_nullable_to_non_nullable
as bool,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,emergencyNumber: freezed == emergencyNumber ? _self.emergencyNumber : emergencyNumber // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as ComposePosition?,
  ));
}

/// Create a copy of ComposeContext
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComposePositionCopyWith<$Res>? get position {
    if (_self.position == null) {
    return null;
  }

  return $ComposePositionCopyWith<$Res>(_self.position!, (value) {
    return _then(_self.copyWith(position: value));
  });
}
}


/// @nodoc
mixin _$ComposePosition {

 double? get latitude; double? get longitude; String? get address;
/// Create a copy of ComposePosition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComposePositionCopyWith<ComposePosition> get copyWith => _$ComposePositionCopyWithImpl<ComposePosition>(this as ComposePosition, _$identity);

  /// Serializes this ComposePosition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComposePosition&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,address);

@override
String toString() {
  return 'ComposePosition(latitude: $latitude, longitude: $longitude, address: $address)';
}


}

/// @nodoc
abstract mixin class $ComposePositionCopyWith<$Res>  {
  factory $ComposePositionCopyWith(ComposePosition value, $Res Function(ComposePosition) _then) = _$ComposePositionCopyWithImpl;
@useResult
$Res call({
 double? latitude, double? longitude, String? address
});




}
/// @nodoc
class _$ComposePositionCopyWithImpl<$Res>
    implements $ComposePositionCopyWith<$Res> {
  _$ComposePositionCopyWithImpl(this._self, this._then);

  final ComposePosition _self;
  final $Res Function(ComposePosition) _then;

/// Create a copy of ComposePosition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = freezed,Object? longitude = freezed,Object? address = freezed,}) {
  return _then(_self.copyWith(
latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ComposePosition].
extension ComposePositionPatterns on ComposePosition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComposePosition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComposePosition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComposePosition value)  $default,){
final _that = this;
switch (_that) {
case _ComposePosition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComposePosition value)?  $default,){
final _that = this;
switch (_that) {
case _ComposePosition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? latitude,  double? longitude,  String? address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComposePosition() when $default != null:
return $default(_that.latitude,_that.longitude,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? latitude,  double? longitude,  String? address)  $default,) {final _that = this;
switch (_that) {
case _ComposePosition():
return $default(_that.latitude,_that.longitude,_that.address);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? latitude,  double? longitude,  String? address)?  $default,) {final _that = this;
switch (_that) {
case _ComposePosition() when $default != null:
return $default(_that.latitude,_that.longitude,_that.address);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComposePosition implements ComposePosition {
  const _ComposePosition({this.latitude, this.longitude, this.address});
  factory _ComposePosition.fromJson(Map<String, dynamic> json) => _$ComposePositionFromJson(json);

@override final  double? latitude;
@override final  double? longitude;
@override final  String? address;

/// Create a copy of ComposePosition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComposePositionCopyWith<_ComposePosition> get copyWith => __$ComposePositionCopyWithImpl<_ComposePosition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComposePositionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComposePosition&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,address);

@override
String toString() {
  return 'ComposePosition(latitude: $latitude, longitude: $longitude, address: $address)';
}


}

/// @nodoc
abstract mixin class _$ComposePositionCopyWith<$Res> implements $ComposePositionCopyWith<$Res> {
  factory _$ComposePositionCopyWith(_ComposePosition value, $Res Function(_ComposePosition) _then) = __$ComposePositionCopyWithImpl;
@override @useResult
$Res call({
 double? latitude, double? longitude, String? address
});




}
/// @nodoc
class __$ComposePositionCopyWithImpl<$Res>
    implements _$ComposePositionCopyWith<$Res> {
  __$ComposePositionCopyWithImpl(this._self, this._then);

  final _ComposePosition _self;
  final $Res Function(_ComposePosition) _then;

/// Create a copy of ComposePosition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = freezed,Object? longitude = freezed,Object? address = freezed,}) {
  return _then(_ComposePosition(
latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
