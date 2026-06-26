// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_server_frame.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
VoiceServerFrame _$VoiceServerFrameFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'session.ready':
          return VoiceServerSessionReady.fromJson(
            json
          );
                case 'transcript':
          return VoiceServerTranscript.fromJson(
            json
          );
                case 'audio.chunk':
          return VoiceServerAudioChunk.fromJson(
            json
          );
                case 'intent':
          return VoiceServerIntent.fromJson(
            json
          );
                case 'event':
          return VoiceServerEvent.fromJson(
            json
          );
                case 'error':
          return VoiceServerError.fromJson(
            json
          );
                case 'session.closed':
          return VoiceServerSessionClosed.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'VoiceServerFrame',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$VoiceServerFrame {



  /// Serializes this VoiceServerFrame to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceServerFrame);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoiceServerFrame()';
}


}

/// @nodoc
class $VoiceServerFrameCopyWith<$Res>  {
$VoiceServerFrameCopyWith(VoiceServerFrame _, $Res Function(VoiceServerFrame) __);
}


/// Adds pattern-matching-related methods to [VoiceServerFrame].
extension VoiceServerFramePatterns on VoiceServerFrame {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VoiceServerSessionReady value)?  sessionReady,TResult Function( VoiceServerTranscript value)?  transcript,TResult Function( VoiceServerAudioChunk value)?  audioChunk,TResult Function( VoiceServerIntent value)?  intent,TResult Function( VoiceServerEvent value)?  event,TResult Function( VoiceServerError value)?  error,TResult Function( VoiceServerSessionClosed value)?  sessionClosed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VoiceServerSessionReady() when sessionReady != null:
return sessionReady(_that);case VoiceServerTranscript() when transcript != null:
return transcript(_that);case VoiceServerAudioChunk() when audioChunk != null:
return audioChunk(_that);case VoiceServerIntent() when intent != null:
return intent(_that);case VoiceServerEvent() when event != null:
return event(_that);case VoiceServerError() when error != null:
return error(_that);case VoiceServerSessionClosed() when sessionClosed != null:
return sessionClosed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VoiceServerSessionReady value)  sessionReady,required TResult Function( VoiceServerTranscript value)  transcript,required TResult Function( VoiceServerAudioChunk value)  audioChunk,required TResult Function( VoiceServerIntent value)  intent,required TResult Function( VoiceServerEvent value)  event,required TResult Function( VoiceServerError value)  error,required TResult Function( VoiceServerSessionClosed value)  sessionClosed,}){
final _that = this;
switch (_that) {
case VoiceServerSessionReady():
return sessionReady(_that);case VoiceServerTranscript():
return transcript(_that);case VoiceServerAudioChunk():
return audioChunk(_that);case VoiceServerIntent():
return intent(_that);case VoiceServerEvent():
return event(_that);case VoiceServerError():
return error(_that);case VoiceServerSessionClosed():
return sessionClosed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VoiceServerSessionReady value)?  sessionReady,TResult? Function( VoiceServerTranscript value)?  transcript,TResult? Function( VoiceServerAudioChunk value)?  audioChunk,TResult? Function( VoiceServerIntent value)?  intent,TResult? Function( VoiceServerEvent value)?  event,TResult? Function( VoiceServerError value)?  error,TResult? Function( VoiceServerSessionClosed value)?  sessionClosed,}){
final _that = this;
switch (_that) {
case VoiceServerSessionReady() when sessionReady != null:
return sessionReady(_that);case VoiceServerTranscript() when transcript != null:
return transcript(_that);case VoiceServerAudioChunk() when audioChunk != null:
return audioChunk(_that);case VoiceServerIntent() when intent != null:
return intent(_that);case VoiceServerEvent() when event != null:
return event(_that);case VoiceServerError() when error != null:
return error(_that);case VoiceServerSessionClosed() when sessionClosed != null:
return sessionClosed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String sessionId,  NegotiatedAudioConfig? config)?  sessionReady,TResult Function( TranscriptRole role,  String text,  bool isFinal)?  transcript,TResult Function( int seq,  String audio)?  audioChunk,TResult Function( VoiceIntent intent,  double confidence,  Map<String, dynamic>? slots)?  intent,TResult Function( VoiceEventName name)?  event,TResult Function( String code,  String message,  bool fatal)?  error,TResult Function( SessionCloseReason reason)?  sessionClosed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VoiceServerSessionReady() when sessionReady != null:
return sessionReady(_that.sessionId,_that.config);case VoiceServerTranscript() when transcript != null:
return transcript(_that.role,_that.text,_that.isFinal);case VoiceServerAudioChunk() when audioChunk != null:
return audioChunk(_that.seq,_that.audio);case VoiceServerIntent() when intent != null:
return intent(_that.intent,_that.confidence,_that.slots);case VoiceServerEvent() when event != null:
return event(_that.name);case VoiceServerError() when error != null:
return error(_that.code,_that.message,_that.fatal);case VoiceServerSessionClosed() when sessionClosed != null:
return sessionClosed(_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String sessionId,  NegotiatedAudioConfig? config)  sessionReady,required TResult Function( TranscriptRole role,  String text,  bool isFinal)  transcript,required TResult Function( int seq,  String audio)  audioChunk,required TResult Function( VoiceIntent intent,  double confidence,  Map<String, dynamic>? slots)  intent,required TResult Function( VoiceEventName name)  event,required TResult Function( String code,  String message,  bool fatal)  error,required TResult Function( SessionCloseReason reason)  sessionClosed,}) {final _that = this;
switch (_that) {
case VoiceServerSessionReady():
return sessionReady(_that.sessionId,_that.config);case VoiceServerTranscript():
return transcript(_that.role,_that.text,_that.isFinal);case VoiceServerAudioChunk():
return audioChunk(_that.seq,_that.audio);case VoiceServerIntent():
return intent(_that.intent,_that.confidence,_that.slots);case VoiceServerEvent():
return event(_that.name);case VoiceServerError():
return error(_that.code,_that.message,_that.fatal);case VoiceServerSessionClosed():
return sessionClosed(_that.reason);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String sessionId,  NegotiatedAudioConfig? config)?  sessionReady,TResult? Function( TranscriptRole role,  String text,  bool isFinal)?  transcript,TResult? Function( int seq,  String audio)?  audioChunk,TResult? Function( VoiceIntent intent,  double confidence,  Map<String, dynamic>? slots)?  intent,TResult? Function( VoiceEventName name)?  event,TResult? Function( String code,  String message,  bool fatal)?  error,TResult? Function( SessionCloseReason reason)?  sessionClosed,}) {final _that = this;
switch (_that) {
case VoiceServerSessionReady() when sessionReady != null:
return sessionReady(_that.sessionId,_that.config);case VoiceServerTranscript() when transcript != null:
return transcript(_that.role,_that.text,_that.isFinal);case VoiceServerAudioChunk() when audioChunk != null:
return audioChunk(_that.seq,_that.audio);case VoiceServerIntent() when intent != null:
return intent(_that.intent,_that.confidence,_that.slots);case VoiceServerEvent() when event != null:
return event(_that.name);case VoiceServerError() when error != null:
return error(_that.code,_that.message,_that.fatal);case VoiceServerSessionClosed() when sessionClosed != null:
return sessionClosed(_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class VoiceServerSessionReady implements VoiceServerFrame {
  const VoiceServerSessionReady({required this.sessionId, this.config, final  String? $type}): $type = $type ?? 'session.ready';
  factory VoiceServerSessionReady.fromJson(Map<String, dynamic> json) => _$VoiceServerSessionReadyFromJson(json);

 final  String sessionId;
 final  NegotiatedAudioConfig? config;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of VoiceServerFrame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceServerSessionReadyCopyWith<VoiceServerSessionReady> get copyWith => _$VoiceServerSessionReadyCopyWithImpl<VoiceServerSessionReady>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoiceServerSessionReadyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceServerSessionReady&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.config, config) || other.config == config));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,config);

@override
String toString() {
  return 'VoiceServerFrame.sessionReady(sessionId: $sessionId, config: $config)';
}


}

/// @nodoc
abstract mixin class $VoiceServerSessionReadyCopyWith<$Res> implements $VoiceServerFrameCopyWith<$Res> {
  factory $VoiceServerSessionReadyCopyWith(VoiceServerSessionReady value, $Res Function(VoiceServerSessionReady) _then) = _$VoiceServerSessionReadyCopyWithImpl;
@useResult
$Res call({
 String sessionId, NegotiatedAudioConfig? config
});


$NegotiatedAudioConfigCopyWith<$Res>? get config;

}
/// @nodoc
class _$VoiceServerSessionReadyCopyWithImpl<$Res>
    implements $VoiceServerSessionReadyCopyWith<$Res> {
  _$VoiceServerSessionReadyCopyWithImpl(this._self, this._then);

  final VoiceServerSessionReady _self;
  final $Res Function(VoiceServerSessionReady) _then;

/// Create a copy of VoiceServerFrame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? config = freezed,}) {
  return _then(VoiceServerSessionReady(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,config: freezed == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as NegotiatedAudioConfig?,
  ));
}

/// Create a copy of VoiceServerFrame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NegotiatedAudioConfigCopyWith<$Res>? get config {
    if (_self.config == null) {
    return null;
  }

  return $NegotiatedAudioConfigCopyWith<$Res>(_self.config!, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class VoiceServerTranscript implements VoiceServerFrame {
  const VoiceServerTranscript({required this.role, required this.text, required this.isFinal, final  String? $type}): $type = $type ?? 'transcript';
  factory VoiceServerTranscript.fromJson(Map<String, dynamic> json) => _$VoiceServerTranscriptFromJson(json);

 final  TranscriptRole role;
 final  String text;
 final  bool isFinal;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of VoiceServerFrame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceServerTranscriptCopyWith<VoiceServerTranscript> get copyWith => _$VoiceServerTranscriptCopyWithImpl<VoiceServerTranscript>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoiceServerTranscriptToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceServerTranscript&&(identical(other.role, role) || other.role == role)&&(identical(other.text, text) || other.text == text)&&(identical(other.isFinal, isFinal) || other.isFinal == isFinal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,text,isFinal);

@override
String toString() {
  return 'VoiceServerFrame.transcript(role: $role, text: $text, isFinal: $isFinal)';
}


}

/// @nodoc
abstract mixin class $VoiceServerTranscriptCopyWith<$Res> implements $VoiceServerFrameCopyWith<$Res> {
  factory $VoiceServerTranscriptCopyWith(VoiceServerTranscript value, $Res Function(VoiceServerTranscript) _then) = _$VoiceServerTranscriptCopyWithImpl;
@useResult
$Res call({
 TranscriptRole role, String text, bool isFinal
});




}
/// @nodoc
class _$VoiceServerTranscriptCopyWithImpl<$Res>
    implements $VoiceServerTranscriptCopyWith<$Res> {
  _$VoiceServerTranscriptCopyWithImpl(this._self, this._then);

  final VoiceServerTranscript _self;
  final $Res Function(VoiceServerTranscript) _then;

/// Create a copy of VoiceServerFrame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? role = null,Object? text = null,Object? isFinal = null,}) {
  return _then(VoiceServerTranscript(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as TranscriptRole,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,isFinal: null == isFinal ? _self.isFinal : isFinal // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class VoiceServerAudioChunk implements VoiceServerFrame {
  const VoiceServerAudioChunk({required this.seq, required this.audio, final  String? $type}): $type = $type ?? 'audio.chunk';
  factory VoiceServerAudioChunk.fromJson(Map<String, dynamic> json) => _$VoiceServerAudioChunkFromJson(json);

 final  int seq;
 final  String audio;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of VoiceServerFrame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceServerAudioChunkCopyWith<VoiceServerAudioChunk> get copyWith => _$VoiceServerAudioChunkCopyWithImpl<VoiceServerAudioChunk>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoiceServerAudioChunkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceServerAudioChunk&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.audio, audio) || other.audio == audio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seq,audio);

@override
String toString() {
  return 'VoiceServerFrame.audioChunk(seq: $seq, audio: $audio)';
}


}

/// @nodoc
abstract mixin class $VoiceServerAudioChunkCopyWith<$Res> implements $VoiceServerFrameCopyWith<$Res> {
  factory $VoiceServerAudioChunkCopyWith(VoiceServerAudioChunk value, $Res Function(VoiceServerAudioChunk) _then) = _$VoiceServerAudioChunkCopyWithImpl;
@useResult
$Res call({
 int seq, String audio
});




}
/// @nodoc
class _$VoiceServerAudioChunkCopyWithImpl<$Res>
    implements $VoiceServerAudioChunkCopyWith<$Res> {
  _$VoiceServerAudioChunkCopyWithImpl(this._self, this._then);

  final VoiceServerAudioChunk _self;
  final $Res Function(VoiceServerAudioChunk) _then;

/// Create a copy of VoiceServerFrame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? seq = null,Object? audio = null,}) {
  return _then(VoiceServerAudioChunk(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,audio: null == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class VoiceServerIntent implements VoiceServerFrame {
  const VoiceServerIntent({required this.intent, required this.confidence, final  Map<String, dynamic>? slots, final  String? $type}): _slots = slots,$type = $type ?? 'intent';
  factory VoiceServerIntent.fromJson(Map<String, dynamic> json) => _$VoiceServerIntentFromJson(json);

 final  VoiceIntent intent;
 final  double confidence;
 final  Map<String, dynamic>? _slots;
 Map<String, dynamic>? get slots {
  final value = _slots;
  if (value == null) return null;
  if (_slots is EqualUnmodifiableMapView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of VoiceServerFrame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceServerIntentCopyWith<VoiceServerIntent> get copyWith => _$VoiceServerIntentCopyWithImpl<VoiceServerIntent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoiceServerIntentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceServerIntent&&(identical(other.intent, intent) || other.intent == intent)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&const DeepCollectionEquality().equals(other._slots, _slots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,intent,confidence,const DeepCollectionEquality().hash(_slots));

@override
String toString() {
  return 'VoiceServerFrame.intent(intent: $intent, confidence: $confidence, slots: $slots)';
}


}

/// @nodoc
abstract mixin class $VoiceServerIntentCopyWith<$Res> implements $VoiceServerFrameCopyWith<$Res> {
  factory $VoiceServerIntentCopyWith(VoiceServerIntent value, $Res Function(VoiceServerIntent) _then) = _$VoiceServerIntentCopyWithImpl;
@useResult
$Res call({
 VoiceIntent intent, double confidence, Map<String, dynamic>? slots
});




}
/// @nodoc
class _$VoiceServerIntentCopyWithImpl<$Res>
    implements $VoiceServerIntentCopyWith<$Res> {
  _$VoiceServerIntentCopyWithImpl(this._self, this._then);

  final VoiceServerIntent _self;
  final $Res Function(VoiceServerIntent) _then;

/// Create a copy of VoiceServerFrame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? intent = null,Object? confidence = null,Object? slots = freezed,}) {
  return _then(VoiceServerIntent(
intent: null == intent ? _self.intent : intent // ignore: cast_nullable_to_non_nullable
as VoiceIntent,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,slots: freezed == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class VoiceServerEvent implements VoiceServerFrame {
  const VoiceServerEvent({required this.name, final  String? $type}): $type = $type ?? 'event';
  factory VoiceServerEvent.fromJson(Map<String, dynamic> json) => _$VoiceServerEventFromJson(json);

 final  VoiceEventName name;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of VoiceServerFrame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceServerEventCopyWith<VoiceServerEvent> get copyWith => _$VoiceServerEventCopyWithImpl<VoiceServerEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoiceServerEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceServerEvent&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'VoiceServerFrame.event(name: $name)';
}


}

/// @nodoc
abstract mixin class $VoiceServerEventCopyWith<$Res> implements $VoiceServerFrameCopyWith<$Res> {
  factory $VoiceServerEventCopyWith(VoiceServerEvent value, $Res Function(VoiceServerEvent) _then) = _$VoiceServerEventCopyWithImpl;
@useResult
$Res call({
 VoiceEventName name
});




}
/// @nodoc
class _$VoiceServerEventCopyWithImpl<$Res>
    implements $VoiceServerEventCopyWith<$Res> {
  _$VoiceServerEventCopyWithImpl(this._self, this._then);

  final VoiceServerEvent _self;
  final $Res Function(VoiceServerEvent) _then;

/// Create a copy of VoiceServerFrame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(VoiceServerEvent(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as VoiceEventName,
  ));
}


}

/// @nodoc
@JsonSerializable()

class VoiceServerError implements VoiceServerFrame {
  const VoiceServerError({required this.code, required this.message, this.fatal = false, final  String? $type}): $type = $type ?? 'error';
  factory VoiceServerError.fromJson(Map<String, dynamic> json) => _$VoiceServerErrorFromJson(json);

 final  String code;
 final  String message;
@JsonKey() final  bool fatal;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of VoiceServerFrame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceServerErrorCopyWith<VoiceServerError> get copyWith => _$VoiceServerErrorCopyWithImpl<VoiceServerError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoiceServerErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceServerError&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.fatal, fatal) || other.fatal == fatal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,fatal);

@override
String toString() {
  return 'VoiceServerFrame.error(code: $code, message: $message, fatal: $fatal)';
}


}

/// @nodoc
abstract mixin class $VoiceServerErrorCopyWith<$Res> implements $VoiceServerFrameCopyWith<$Res> {
  factory $VoiceServerErrorCopyWith(VoiceServerError value, $Res Function(VoiceServerError) _then) = _$VoiceServerErrorCopyWithImpl;
@useResult
$Res call({
 String code, String message, bool fatal
});




}
/// @nodoc
class _$VoiceServerErrorCopyWithImpl<$Res>
    implements $VoiceServerErrorCopyWith<$Res> {
  _$VoiceServerErrorCopyWithImpl(this._self, this._then);

  final VoiceServerError _self;
  final $Res Function(VoiceServerError) _then;

/// Create a copy of VoiceServerFrame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,Object? fatal = null,}) {
  return _then(VoiceServerError(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,fatal: null == fatal ? _self.fatal : fatal // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class VoiceServerSessionClosed implements VoiceServerFrame {
  const VoiceServerSessionClosed({required this.reason, final  String? $type}): $type = $type ?? 'session.closed';
  factory VoiceServerSessionClosed.fromJson(Map<String, dynamic> json) => _$VoiceServerSessionClosedFromJson(json);

 final  SessionCloseReason reason;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of VoiceServerFrame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceServerSessionClosedCopyWith<VoiceServerSessionClosed> get copyWith => _$VoiceServerSessionClosedCopyWithImpl<VoiceServerSessionClosed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoiceServerSessionClosedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceServerSessionClosed&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'VoiceServerFrame.sessionClosed(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $VoiceServerSessionClosedCopyWith<$Res> implements $VoiceServerFrameCopyWith<$Res> {
  factory $VoiceServerSessionClosedCopyWith(VoiceServerSessionClosed value, $Res Function(VoiceServerSessionClosed) _then) = _$VoiceServerSessionClosedCopyWithImpl;
@useResult
$Res call({
 SessionCloseReason reason
});




}
/// @nodoc
class _$VoiceServerSessionClosedCopyWithImpl<$Res>
    implements $VoiceServerSessionClosedCopyWith<$Res> {
  _$VoiceServerSessionClosedCopyWithImpl(this._self, this._then);

  final VoiceServerSessionClosed _self;
  final $Res Function(VoiceServerSessionClosed) _then;

/// Create a copy of VoiceServerFrame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(VoiceServerSessionClosed(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as SessionCloseReason,
  ));
}


}

// dart format on
