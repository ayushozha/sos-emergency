// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contacts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrustedContact {

 String get name; String? get relation;
/// Create a copy of TrustedContact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrustedContactCopyWith<TrustedContact> get copyWith => _$TrustedContactCopyWithImpl<TrustedContact>(this as TrustedContact, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrustedContact&&(identical(other.name, name) || other.name == name)&&(identical(other.relation, relation) || other.relation == relation));
}


@override
int get hashCode => Object.hash(runtimeType,name,relation);

@override
String toString() {
  return 'TrustedContact(name: $name, relation: $relation)';
}


}

/// @nodoc
abstract mixin class $TrustedContactCopyWith<$Res>  {
  factory $TrustedContactCopyWith(TrustedContact value, $Res Function(TrustedContact) _then) = _$TrustedContactCopyWithImpl;
@useResult
$Res call({
 String name, String? relation
});




}
/// @nodoc
class _$TrustedContactCopyWithImpl<$Res>
    implements $TrustedContactCopyWith<$Res> {
  _$TrustedContactCopyWithImpl(this._self, this._then);

  final TrustedContact _self;
  final $Res Function(TrustedContact) _then;

/// Create a copy of TrustedContact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? relation = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,relation: freezed == relation ? _self.relation : relation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrustedContact].
extension TrustedContactPatterns on TrustedContact {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrustedContact value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrustedContact() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrustedContact value)  $default,){
final _that = this;
switch (_that) {
case _TrustedContact():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrustedContact value)?  $default,){
final _that = this;
switch (_that) {
case _TrustedContact() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? relation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrustedContact() when $default != null:
return $default(_that.name,_that.relation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? relation)  $default,) {final _that = this;
switch (_that) {
case _TrustedContact():
return $default(_that.name,_that.relation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? relation)?  $default,) {final _that = this;
switch (_that) {
case _TrustedContact() when $default != null:
return $default(_that.name,_that.relation);case _:
  return null;

}
}

}

/// @nodoc


class _TrustedContact implements TrustedContact {
  const _TrustedContact({required this.name, this.relation});
  

@override final  String name;
@override final  String? relation;

/// Create a copy of TrustedContact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrustedContactCopyWith<_TrustedContact> get copyWith => __$TrustedContactCopyWithImpl<_TrustedContact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrustedContact&&(identical(other.name, name) || other.name == name)&&(identical(other.relation, relation) || other.relation == relation));
}


@override
int get hashCode => Object.hash(runtimeType,name,relation);

@override
String toString() {
  return 'TrustedContact(name: $name, relation: $relation)';
}


}

/// @nodoc
abstract mixin class _$TrustedContactCopyWith<$Res> implements $TrustedContactCopyWith<$Res> {
  factory _$TrustedContactCopyWith(_TrustedContact value, $Res Function(_TrustedContact) _then) = __$TrustedContactCopyWithImpl;
@override @useResult
$Res call({
 String name, String? relation
});




}
/// @nodoc
class __$TrustedContactCopyWithImpl<$Res>
    implements _$TrustedContactCopyWith<$Res> {
  __$TrustedContactCopyWithImpl(this._self, this._then);

  final _TrustedContact _self;
  final $Res Function(_TrustedContact) _then;

/// Create a copy of TrustedContact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? relation = freezed,}) {
  return _then(_TrustedContact(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,relation: freezed == relation ? _self.relation : relation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ContactDelivery {

 TrustedContact get contact; DeliveryStatus get status;
/// Create a copy of ContactDelivery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactDeliveryCopyWith<ContactDelivery> get copyWith => _$ContactDeliveryCopyWithImpl<ContactDelivery>(this as ContactDelivery, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactDelivery&&(identical(other.contact, contact) || other.contact == contact)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,contact,status);

@override
String toString() {
  return 'ContactDelivery(contact: $contact, status: $status)';
}


}

/// @nodoc
abstract mixin class $ContactDeliveryCopyWith<$Res>  {
  factory $ContactDeliveryCopyWith(ContactDelivery value, $Res Function(ContactDelivery) _then) = _$ContactDeliveryCopyWithImpl;
@useResult
$Res call({
 TrustedContact contact, DeliveryStatus status
});


$TrustedContactCopyWith<$Res> get contact;

}
/// @nodoc
class _$ContactDeliveryCopyWithImpl<$Res>
    implements $ContactDeliveryCopyWith<$Res> {
  _$ContactDeliveryCopyWithImpl(this._self, this._then);

  final ContactDelivery _self;
  final $Res Function(ContactDelivery) _then;

/// Create a copy of ContactDelivery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contact = null,Object? status = null,}) {
  return _then(_self.copyWith(
contact: null == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as TrustedContact,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DeliveryStatus,
  ));
}
/// Create a copy of ContactDelivery
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrustedContactCopyWith<$Res> get contact {
  
  return $TrustedContactCopyWith<$Res>(_self.contact, (value) {
    return _then(_self.copyWith(contact: value));
  });
}
}


/// Adds pattern-matching-related methods to [ContactDelivery].
extension ContactDeliveryPatterns on ContactDelivery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContactDelivery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContactDelivery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContactDelivery value)  $default,){
final _that = this;
switch (_that) {
case _ContactDelivery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContactDelivery value)?  $default,){
final _that = this;
switch (_that) {
case _ContactDelivery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TrustedContact contact,  DeliveryStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContactDelivery() when $default != null:
return $default(_that.contact,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TrustedContact contact,  DeliveryStatus status)  $default,) {final _that = this;
switch (_that) {
case _ContactDelivery():
return $default(_that.contact,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TrustedContact contact,  DeliveryStatus status)?  $default,) {final _that = this;
switch (_that) {
case _ContactDelivery() when $default != null:
return $default(_that.contact,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _ContactDelivery implements ContactDelivery {
  const _ContactDelivery({required this.contact, required this.status});
  

@override final  TrustedContact contact;
@override final  DeliveryStatus status;

/// Create a copy of ContactDelivery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactDeliveryCopyWith<_ContactDelivery> get copyWith => __$ContactDeliveryCopyWithImpl<_ContactDelivery>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContactDelivery&&(identical(other.contact, contact) || other.contact == contact)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,contact,status);

@override
String toString() {
  return 'ContactDelivery(contact: $contact, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ContactDeliveryCopyWith<$Res> implements $ContactDeliveryCopyWith<$Res> {
  factory _$ContactDeliveryCopyWith(_ContactDelivery value, $Res Function(_ContactDelivery) _then) = __$ContactDeliveryCopyWithImpl;
@override @useResult
$Res call({
 TrustedContact contact, DeliveryStatus status
});


@override $TrustedContactCopyWith<$Res> get contact;

}
/// @nodoc
class __$ContactDeliveryCopyWithImpl<$Res>
    implements _$ContactDeliveryCopyWith<$Res> {
  __$ContactDeliveryCopyWithImpl(this._self, this._then);

  final _ContactDelivery _self;
  final $Res Function(_ContactDelivery) _then;

/// Create a copy of ContactDelivery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contact = null,Object? status = null,}) {
  return _then(_ContactDelivery(
contact: null == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as TrustedContact,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DeliveryStatus,
  ));
}

/// Create a copy of ContactDelivery
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrustedContactCopyWith<$Res> get contact {
  
  return $TrustedContactCopyWith<$Res>(_self.contact, (value) {
    return _then(_self.copyWith(contact: value));
  });
}
}

// dart format on
