// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NetworkFailure {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NetworkFailure()';
}


}

/// @nodoc
class $NetworkFailureCopyWith<$Res>  {
$NetworkFailureCopyWith(NetworkFailure _, $Res Function(NetworkFailure) __);
}


/// Adds pattern-matching-related methods to [NetworkFailure].
extension NetworkFailurePatterns on NetworkFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ServerFailure value)?  serverError,TResult Function( TimeoutFailure value)?  timeout,TResult Function( NoInternetFailure value)?  noInternet,TResult Function( UnauthorizedFailure value)?  unauthorized,TResult Function( NotFoundFailure value)?  notFound,TResult Function( UnknownFailure value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ServerFailure() when serverError != null:
return serverError(_that);case TimeoutFailure() when timeout != null:
return timeout(_that);case NoInternetFailure() when noInternet != null:
return noInternet(_that);case UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that);case NotFoundFailure() when notFound != null:
return notFound(_that);case UnknownFailure() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ServerFailure value)  serverError,required TResult Function( TimeoutFailure value)  timeout,required TResult Function( NoInternetFailure value)  noInternet,required TResult Function( UnauthorizedFailure value)  unauthorized,required TResult Function( NotFoundFailure value)  notFound,required TResult Function( UnknownFailure value)  unknown,}){
final _that = this;
switch (_that) {
case ServerFailure():
return serverError(_that);case TimeoutFailure():
return timeout(_that);case NoInternetFailure():
return noInternet(_that);case UnauthorizedFailure():
return unauthorized(_that);case NotFoundFailure():
return notFound(_that);case UnknownFailure():
return unknown(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ServerFailure value)?  serverError,TResult? Function( TimeoutFailure value)?  timeout,TResult? Function( NoInternetFailure value)?  noInternet,TResult? Function( UnauthorizedFailure value)?  unauthorized,TResult? Function( NotFoundFailure value)?  notFound,TResult? Function( UnknownFailure value)?  unknown,}){
final _that = this;
switch (_that) {
case ServerFailure() when serverError != null:
return serverError(_that);case TimeoutFailure() when timeout != null:
return timeout(_that);case NoInternetFailure() when noInternet != null:
return noInternet(_that);case UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that);case NotFoundFailure() when notFound != null:
return notFound(_that);case UnknownFailure() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( dynamic message)?  serverError,TResult Function()?  timeout,TResult Function()?  noInternet,TResult Function()?  unauthorized,TResult Function()?  notFound,TResult Function( String message)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ServerFailure() when serverError != null:
return serverError(_that.message);case TimeoutFailure() when timeout != null:
return timeout();case NoInternetFailure() when noInternet != null:
return noInternet();case UnauthorizedFailure() when unauthorized != null:
return unauthorized();case NotFoundFailure() when notFound != null:
return notFound();case UnknownFailure() when unknown != null:
return unknown(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( dynamic message)  serverError,required TResult Function()  timeout,required TResult Function()  noInternet,required TResult Function()  unauthorized,required TResult Function()  notFound,required TResult Function( String message)  unknown,}) {final _that = this;
switch (_that) {
case ServerFailure():
return serverError(_that.message);case TimeoutFailure():
return timeout();case NoInternetFailure():
return noInternet();case UnauthorizedFailure():
return unauthorized();case NotFoundFailure():
return notFound();case UnknownFailure():
return unknown(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( dynamic message)?  serverError,TResult? Function()?  timeout,TResult? Function()?  noInternet,TResult? Function()?  unauthorized,TResult? Function()?  notFound,TResult? Function( String message)?  unknown,}) {final _that = this;
switch (_that) {
case ServerFailure() when serverError != null:
return serverError(_that.message);case TimeoutFailure() when timeout != null:
return timeout();case NoInternetFailure() when noInternet != null:
return noInternet();case UnauthorizedFailure() when unauthorized != null:
return unauthorized();case NotFoundFailure() when notFound != null:
return notFound();case UnknownFailure() when unknown != null:
return unknown(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ServerFailure implements NetworkFailure {
  const ServerFailure(this.message);
  

 final  dynamic message;

/// Create a copy of NetworkFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerFailureCopyWith<ServerFailure> get copyWith => _$ServerFailureCopyWithImpl<ServerFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerFailure&&const DeepCollectionEquality().equals(other.message, message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(message));
}

@override
String toString() {
    return 'NetworkFailure.serverError(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerFailureCopyWith<$Res> implements $NetworkFailureCopyWith<$Res> {
  factory $ServerFailureCopyWith(ServerFailure value, $Res Function(ServerFailure) _then) = _$ServerFailureCopyWithImpl;
@useResult
$Res call({
 dynamic message
});




}
/// @nodoc
class _$ServerFailureCopyWithImpl<$Res>
    implements $ServerFailureCopyWith<$Res> {
  _$ServerFailureCopyWithImpl(this._self, this._then);

  final ServerFailure _self;
  final $Res Function(ServerFailure) _then;

/// Create a copy of NetworkFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(ServerFailure(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

/// @nodoc


class TimeoutFailure implements NetworkFailure {
  const TimeoutFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeoutFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NetworkFailure.timeout()';
}


}




/// @nodoc


class NoInternetFailure implements NetworkFailure {
  const NoInternetFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NoInternetFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NetworkFailure.noInternet()';
}


}




/// @nodoc


class UnauthorizedFailure implements NetworkFailure {
  const UnauthorizedFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is UnauthorizedFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NetworkFailure.unauthorized()';
}


}




/// @nodoc


class NotFoundFailure implements NetworkFailure {
  const NotFoundFailure();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NotFoundFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NetworkFailure.notFound()';
}


}




/// @nodoc


class UnknownFailure implements NetworkFailure {
  const UnknownFailure(this.message);
  

 final  String message;

/// Create a copy of NetworkFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownFailureCopyWith<UnknownFailure> get copyWith => _$UnknownFailureCopyWithImpl<UnknownFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'NetworkFailure.unknown(message: $message)';
}


}

/// @nodoc
abstract mixin class $UnknownFailureCopyWith<$Res> implements $NetworkFailureCopyWith<$Res> {
  factory $UnknownFailureCopyWith(UnknownFailure value, $Res Function(UnknownFailure) _then) = _$UnknownFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$UnknownFailureCopyWithImpl<$Res>
    implements $UnknownFailureCopyWith<$Res> {
  _$UnknownFailureCopyWithImpl(this._self, this._then);

  final UnknownFailure _self;
  final $Res Function(UnknownFailure) _then;

/// Create a copy of NetworkFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(UnknownFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
