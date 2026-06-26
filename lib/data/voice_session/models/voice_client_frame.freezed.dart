// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_client_frame.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
VoiceClientFrame _$VoiceClientFrameFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'session.start':
          return VoiceClientSessionStart.fromJson(
            json
          );
                case 'audio.chunk':
          return VoiceClientAudioChunk.fromJson(
            json
          );
                case 'audio.commit':
          return VoiceClientAudioCommit.fromJson(
            json
          );
                case 'text':
          return VoiceClientText.fromJson(
            json
          );
                case 'control':
          return VoiceClientControl.fromJson(
            json
          );
                case 'session.end':
          return VoiceClientSessionEnd.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'VoiceClientFrame',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$VoiceClientFrame {



  /// Serializes this VoiceClientFrame to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceClientFrame);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoiceClientFrame()';
}


}

/// @nodoc
class $VoiceClientFrameCopyWith<$Res>  {
$VoiceClientFrameCopyWith(VoiceClientFrame _, $Res Function(VoiceClientFrame) __);
}


/// Adds pattern-matching-related methods to [VoiceClientFrame].
extension VoiceClientFramePatterns on VoiceClientFrame {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VoiceClientSessionStart value)?  sessionStart,TResult Function( VoiceClientAudioChunk value)?  audioChunk,TResult Function( VoiceClientAudioCommit value)?  audioCommit,TResult Function( VoiceClientText value)?  text,TResult Function( VoiceClientControl value)?  control,TResult Function( VoiceClientSessionEnd value)?  sessionEnd,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VoiceClientSessionStart() when sessionStart != null:
return sessionStart(_that);case VoiceClientAudioChunk() when audioChunk != null:
return audioChunk(_that);case VoiceClientAudioCommit() when audioCommit != null:
return audioCommit(_that);case VoiceClientText() when text != null:
return text(_that);case VoiceClientControl() when control != null:
return control(_that);case VoiceClientSessionEnd() when sessionEnd != null:
return sessionEnd(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VoiceClientSessionStart value)  sessionStart,required TResult Function( VoiceClientAudioChunk value)  audioChunk,required TResult Function( VoiceClientAudioCommit value)  audioCommit,required TResult Function( VoiceClientText value)  text,required TResult Function( VoiceClientControl value)  control,required TResult Function( VoiceClientSessionEnd value)  sessionEnd,}){
final _that = this;
switch (_that) {
case VoiceClientSessionStart():
return sessionStart(_that);case VoiceClientAudioChunk():
return audioChunk(_that);case VoiceClientAudioCommit():
return audioCommit(_that);case VoiceClientText():
return text(_that);case VoiceClientControl():
return control(_that);case VoiceClientSessionEnd():
return sessionEnd(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VoiceClientSessionStart value)?  sessionStart,TResult? Function( VoiceClientAudioChunk value)?  audioChunk,TResult? Function( VoiceClientAudioCommit value)?  audioCommit,TResult? Function( VoiceClientText value)?  text,TResult? Function( VoiceClientControl value)?  control,TResult? Function( VoiceClientSessionEnd value)?  sessionEnd,}){
final _that = this;
switch (_that) {
case VoiceClientSessionStart() when sessionStart != null:
return sessionStart(_that);case VoiceClientAudioChunk() when audioChunk != null:
return audioChunk(_that);case VoiceClientAudioCommit() when audioCommit != null:
return audioCommit(_that);case VoiceClientText() when text != null:
return text(_that);case VoiceClientControl() when control != null:
return control(_that);case VoiceClientSessionEnd() when sessionEnd != null:
return sessionEnd(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( VoiceSessionConfig config)?  sessionStart,TResult Function( int seq,  String audio)?  audioChunk,TResult Function()?  audioCommit,TResult Function( String text)?  text,TResult Function( VoiceControlAction action)?  control,TResult Function()?  sessionEnd,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VoiceClientSessionStart() when sessionStart != null:
return sessionStart(_that.config);case VoiceClientAudioChunk() when audioChunk != null:
return audioChunk(_that.seq,_that.audio);case VoiceClientAudioCommit() when audioCommit != null:
return audioCommit();case VoiceClientText() when text != null:
return text(_that.text);case VoiceClientControl() when control != null:
return control(_that.action);case VoiceClientSessionEnd() when sessionEnd != null:
return sessionEnd();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( VoiceSessionConfig config)  sessionStart,required TResult Function( int seq,  String audio)  audioChunk,required TResult Function()  audioCommit,required TResult Function( String text)  text,required TResult Function( VoiceControlAction action)  control,required TResult Function()  sessionEnd,}) {final _that = this;
switch (_that) {
case VoiceClientSessionStart():
return sessionStart(_that.config);case VoiceClientAudioChunk():
return audioChunk(_that.seq,_that.audio);case VoiceClientAudioCommit():
return audioCommit();case VoiceClientText():
return text(_that.text);case VoiceClientControl():
return control(_that.action);case VoiceClientSessionEnd():
return sessionEnd();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( VoiceSessionConfig config)?  sessionStart,TResult? Function( int seq,  String audio)?  audioChunk,TResult? Function()?  audioCommit,TResult? Function( String text)?  text,TResult? Function( VoiceControlAction action)?  control,TResult? Function()?  sessionEnd,}) {final _that = this;
switch (_that) {
case VoiceClientSessionStart() when sessionStart != null:
return sessionStart(_that.config);case VoiceClientAudioChunk() when audioChunk != null:
return audioChunk(_that.seq,_that.audio);case VoiceClientAudioCommit() when audioCommit != null:
return audioCommit();case VoiceClientText() when text != null:
return text(_that.text);case VoiceClientControl() when control != null:
return control(_that.action);case VoiceClientSessionEnd() when sessionEnd != null:
return sessionEnd();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class VoiceClientSessionStart implements VoiceClientFrame {
  const VoiceClientSessionStart({required this.config, final  String? $type}): $type = $type ?? 'session.start';
  factory VoiceClientSessionStart.fromJson(Map<String, dynamic> json) => _$VoiceClientSessionStartFromJson(json);

 final  VoiceSessionConfig config;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of VoiceClientFrame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceClientSessionStartCopyWith<VoiceClientSessionStart> get copyWith => _$VoiceClientSessionStartCopyWithImpl<VoiceClientSessionStart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoiceClientSessionStartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceClientSessionStart&&(identical(other.config, config) || other.config == config));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,config);

@override
String toString() {
  return 'VoiceClientFrame.sessionStart(config: $config)';
}


}

/// @nodoc
abstract mixin class $VoiceClientSessionStartCopyWith<$Res> implements $VoiceClientFrameCopyWith<$Res> {
  factory $VoiceClientSessionStartCopyWith(VoiceClientSessionStart value, $Res Function(VoiceClientSessionStart) _then) = _$VoiceClientSessionStartCopyWithImpl;
@useResult
$Res call({
 VoiceSessionConfig config
});


$VoiceSessionConfigCopyWith<$Res> get config;

}
/// @nodoc
class _$VoiceClientSessionStartCopyWithImpl<$Res>
    implements $VoiceClientSessionStartCopyWith<$Res> {
  _$VoiceClientSessionStartCopyWithImpl(this._self, this._then);

  final VoiceClientSessionStart _self;
  final $Res Function(VoiceClientSessionStart) _then;

/// Create a copy of VoiceClientFrame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? config = null,}) {
  return _then(VoiceClientSessionStart(
config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as VoiceSessionConfig,
  ));
}

/// Create a copy of VoiceClientFrame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VoiceSessionConfigCopyWith<$Res> get config {
  
  return $VoiceSessionConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class VoiceClientAudioChunk implements VoiceClientFrame {
  const VoiceClientAudioChunk({required this.seq, required this.audio, final  String? $type}): $type = $type ?? 'audio.chunk';
  factory VoiceClientAudioChunk.fromJson(Map<String, dynamic> json) => _$VoiceClientAudioChunkFromJson(json);

 final  int seq;
 final  String audio;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of VoiceClientFrame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceClientAudioChunkCopyWith<VoiceClientAudioChunk> get copyWith => _$VoiceClientAudioChunkCopyWithImpl<VoiceClientAudioChunk>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoiceClientAudioChunkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceClientAudioChunk&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.audio, audio) || other.audio == audio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seq,audio);

@override
String toString() {
  return 'VoiceClientFrame.audioChunk(seq: $seq, audio: $audio)';
}


}

/// @nodoc
abstract mixin class $VoiceClientAudioChunkCopyWith<$Res> implements $VoiceClientFrameCopyWith<$Res> {
  factory $VoiceClientAudioChunkCopyWith(VoiceClientAudioChunk value, $Res Function(VoiceClientAudioChunk) _then) = _$VoiceClientAudioChunkCopyWithImpl;
@useResult
$Res call({
 int seq, String audio
});




}
/// @nodoc
class _$VoiceClientAudioChunkCopyWithImpl<$Res>
    implements $VoiceClientAudioChunkCopyWith<$Res> {
  _$VoiceClientAudioChunkCopyWithImpl(this._self, this._then);

  final VoiceClientAudioChunk _self;
  final $Res Function(VoiceClientAudioChunk) _then;

/// Create a copy of VoiceClientFrame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? seq = null,Object? audio = null,}) {
  return _then(VoiceClientAudioChunk(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,audio: null == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class VoiceClientAudioCommit implements VoiceClientFrame {
  const VoiceClientAudioCommit({final  String? $type}): $type = $type ?? 'audio.commit';
  factory VoiceClientAudioCommit.fromJson(Map<String, dynamic> json) => _$VoiceClientAudioCommitFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$VoiceClientAudioCommitToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceClientAudioCommit);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoiceClientFrame.audioCommit()';
}


}




/// @nodoc
@JsonSerializable()

class VoiceClientText implements VoiceClientFrame {
  const VoiceClientText({required this.text, final  String? $type}): $type = $type ?? 'text';
  factory VoiceClientText.fromJson(Map<String, dynamic> json) => _$VoiceClientTextFromJson(json);

 final  String text;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of VoiceClientFrame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceClientTextCopyWith<VoiceClientText> get copyWith => _$VoiceClientTextCopyWithImpl<VoiceClientText>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoiceClientTextToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceClientText&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'VoiceClientFrame.text(text: $text)';
}


}

/// @nodoc
abstract mixin class $VoiceClientTextCopyWith<$Res> implements $VoiceClientFrameCopyWith<$Res> {
  factory $VoiceClientTextCopyWith(VoiceClientText value, $Res Function(VoiceClientText) _then) = _$VoiceClientTextCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$VoiceClientTextCopyWithImpl<$Res>
    implements $VoiceClientTextCopyWith<$Res> {
  _$VoiceClientTextCopyWithImpl(this._self, this._then);

  final VoiceClientText _self;
  final $Res Function(VoiceClientText) _then;

/// Create a copy of VoiceClientFrame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(VoiceClientText(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class VoiceClientControl implements VoiceClientFrame {
  const VoiceClientControl({required this.action, final  String? $type}): $type = $type ?? 'control';
  factory VoiceClientControl.fromJson(Map<String, dynamic> json) => _$VoiceClientControlFromJson(json);

 final  VoiceControlAction action;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of VoiceClientFrame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceClientControlCopyWith<VoiceClientControl> get copyWith => _$VoiceClientControlCopyWithImpl<VoiceClientControl>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoiceClientControlToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceClientControl&&(identical(other.action, action) || other.action == action));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action);

@override
String toString() {
  return 'VoiceClientFrame.control(action: $action)';
}


}

/// @nodoc
abstract mixin class $VoiceClientControlCopyWith<$Res> implements $VoiceClientFrameCopyWith<$Res> {
  factory $VoiceClientControlCopyWith(VoiceClientControl value, $Res Function(VoiceClientControl) _then) = _$VoiceClientControlCopyWithImpl;
@useResult
$Res call({
 VoiceControlAction action
});




}
/// @nodoc
class _$VoiceClientControlCopyWithImpl<$Res>
    implements $VoiceClientControlCopyWith<$Res> {
  _$VoiceClientControlCopyWithImpl(this._self, this._then);

  final VoiceClientControl _self;
  final $Res Function(VoiceClientControl) _then;

/// Create a copy of VoiceClientFrame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? action = null,}) {
  return _then(VoiceClientControl(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as VoiceControlAction,
  ));
}


}

/// @nodoc
@JsonSerializable()

class VoiceClientSessionEnd implements VoiceClientFrame {
  const VoiceClientSessionEnd({final  String? $type}): $type = $type ?? 'session.end';
  factory VoiceClientSessionEnd.fromJson(Map<String, dynamic> json) => _$VoiceClientSessionEndFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$VoiceClientSessionEndToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceClientSessionEnd);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VoiceClientFrame.sessionEnd()';
}


}




// dart format on
