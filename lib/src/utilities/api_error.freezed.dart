// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$APIError {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() forbidden,
    required TResult Function(String errorId, String errorMessage) badRequest,
    required TResult Function(String errorId, String errorMessage) notFound,
    required TResult Function(String errorId, String errorMessage) problem,
    required TResult Function(String errorId, String errorMessage) unknown,
    required TResult Function() noInternetConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? forbidden,
    TResult? Function(String errorId, String errorMessage)? badRequest,
    TResult? Function(String errorId, String errorMessage)? notFound,
    TResult? Function(String errorId, String errorMessage)? problem,
    TResult? Function(String errorId, String errorMessage)? unknown,
    TResult? Function()? noInternetConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? forbidden,
    TResult Function(String errorId, String errorMessage)? badRequest,
    TResult Function(String errorId, String errorMessage)? notFound,
    TResult Function(String errorId, String errorMessage)? problem,
    TResult Function(String errorId, String errorMessage)? unknown,
    TResult Function()? noInternetConnection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_unauthorized value) unauthorized,
    required TResult Function(_forbidden value) forbidden,
    required TResult Function(_BadRequest value) badRequest,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_problem value) problem,
    required TResult Function(_Unknown value) unknown,
    required TResult Function(_NoInternetConnection value) noInternetConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_unauthorized value)? unauthorized,
    TResult? Function(_forbidden value)? forbidden,
    TResult? Function(_BadRequest value)? badRequest,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_problem value)? problem,
    TResult? Function(_Unknown value)? unknown,
    TResult? Function(_NoInternetConnection value)? noInternetConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_unauthorized value)? unauthorized,
    TResult Function(_forbidden value)? forbidden,
    TResult Function(_BadRequest value)? badRequest,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_problem value)? problem,
    TResult Function(_Unknown value)? unknown,
    TResult Function(_NoInternetConnection value)? noInternetConnection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $APIErrorCopyWith<$Res> {
  factory $APIErrorCopyWith(APIError value, $Res Function(APIError) then) =
      _$APIErrorCopyWithImpl<$Res, APIError>;
}

/// @nodoc
class _$APIErrorCopyWithImpl<$Res, $Val extends APIError>
    implements $APIErrorCopyWith<$Res> {
  _$APIErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_unauthorizedCopyWith<$Res> {
  factory _$$_unauthorizedCopyWith(
          _$_unauthorized value, $Res Function(_$_unauthorized) then) =
      __$$_unauthorizedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_unauthorizedCopyWithImpl<$Res>
    extends _$APIErrorCopyWithImpl<$Res, _$_unauthorized>
    implements _$$_unauthorizedCopyWith<$Res> {
  __$$_unauthorizedCopyWithImpl(
      _$_unauthorized _value, $Res Function(_$_unauthorized) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_unauthorized implements _unauthorized {
  const _$_unauthorized();

  @override
  String toString() {
    return 'APIError.unauthorized()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_unauthorized);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() forbidden,
    required TResult Function(String errorId, String errorMessage) badRequest,
    required TResult Function(String errorId, String errorMessage) notFound,
    required TResult Function(String errorId, String errorMessage) problem,
    required TResult Function(String errorId, String errorMessage) unknown,
    required TResult Function() noInternetConnection,
  }) {
    return unauthorized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? forbidden,
    TResult? Function(String errorId, String errorMessage)? badRequest,
    TResult? Function(String errorId, String errorMessage)? notFound,
    TResult? Function(String errorId, String errorMessage)? problem,
    TResult? Function(String errorId, String errorMessage)? unknown,
    TResult? Function()? noInternetConnection,
  }) {
    return unauthorized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? forbidden,
    TResult Function(String errorId, String errorMessage)? badRequest,
    TResult Function(String errorId, String errorMessage)? notFound,
    TResult Function(String errorId, String errorMessage)? problem,
    TResult Function(String errorId, String errorMessage)? unknown,
    TResult Function()? noInternetConnection,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_unauthorized value) unauthorized,
    required TResult Function(_forbidden value) forbidden,
    required TResult Function(_BadRequest value) badRequest,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_problem value) problem,
    required TResult Function(_Unknown value) unknown,
    required TResult Function(_NoInternetConnection value) noInternetConnection,
  }) {
    return unauthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_unauthorized value)? unauthorized,
    TResult? Function(_forbidden value)? forbidden,
    TResult? Function(_BadRequest value)? badRequest,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_problem value)? problem,
    TResult? Function(_Unknown value)? unknown,
    TResult? Function(_NoInternetConnection value)? noInternetConnection,
  }) {
    return unauthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_unauthorized value)? unauthorized,
    TResult Function(_forbidden value)? forbidden,
    TResult Function(_BadRequest value)? badRequest,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_problem value)? problem,
    TResult Function(_Unknown value)? unknown,
    TResult Function(_NoInternetConnection value)? noInternetConnection,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(this);
    }
    return orElse();
  }
}

abstract class _unauthorized implements APIError {
  const factory _unauthorized() = _$_unauthorized;
}

/// @nodoc
abstract class _$$_forbiddenCopyWith<$Res> {
  factory _$$_forbiddenCopyWith(
          _$_forbidden value, $Res Function(_$_forbidden) then) =
      __$$_forbiddenCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_forbiddenCopyWithImpl<$Res>
    extends _$APIErrorCopyWithImpl<$Res, _$_forbidden>
    implements _$$_forbiddenCopyWith<$Res> {
  __$$_forbiddenCopyWithImpl(
      _$_forbidden _value, $Res Function(_$_forbidden) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_forbidden implements _forbidden {
  const _$_forbidden();

  @override
  String toString() {
    return 'APIError.forbidden()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_forbidden);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() forbidden,
    required TResult Function(String errorId, String errorMessage) badRequest,
    required TResult Function(String errorId, String errorMessage) notFound,
    required TResult Function(String errorId, String errorMessage) problem,
    required TResult Function(String errorId, String errorMessage) unknown,
    required TResult Function() noInternetConnection,
  }) {
    return forbidden();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? forbidden,
    TResult? Function(String errorId, String errorMessage)? badRequest,
    TResult? Function(String errorId, String errorMessage)? notFound,
    TResult? Function(String errorId, String errorMessage)? problem,
    TResult? Function(String errorId, String errorMessage)? unknown,
    TResult? Function()? noInternetConnection,
  }) {
    return forbidden?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? forbidden,
    TResult Function(String errorId, String errorMessage)? badRequest,
    TResult Function(String errorId, String errorMessage)? notFound,
    TResult Function(String errorId, String errorMessage)? problem,
    TResult Function(String errorId, String errorMessage)? unknown,
    TResult Function()? noInternetConnection,
    required TResult orElse(),
  }) {
    if (forbidden != null) {
      return forbidden();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_unauthorized value) unauthorized,
    required TResult Function(_forbidden value) forbidden,
    required TResult Function(_BadRequest value) badRequest,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_problem value) problem,
    required TResult Function(_Unknown value) unknown,
    required TResult Function(_NoInternetConnection value) noInternetConnection,
  }) {
    return forbidden(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_unauthorized value)? unauthorized,
    TResult? Function(_forbidden value)? forbidden,
    TResult? Function(_BadRequest value)? badRequest,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_problem value)? problem,
    TResult? Function(_Unknown value)? unknown,
    TResult? Function(_NoInternetConnection value)? noInternetConnection,
  }) {
    return forbidden?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_unauthorized value)? unauthorized,
    TResult Function(_forbidden value)? forbidden,
    TResult Function(_BadRequest value)? badRequest,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_problem value)? problem,
    TResult Function(_Unknown value)? unknown,
    TResult Function(_NoInternetConnection value)? noInternetConnection,
    required TResult orElse(),
  }) {
    if (forbidden != null) {
      return forbidden(this);
    }
    return orElse();
  }
}

abstract class _forbidden implements APIError {
  const factory _forbidden() = _$_forbidden;
}

/// @nodoc
abstract class _$$_BadRequestCopyWith<$Res> {
  factory _$$_BadRequestCopyWith(
          _$_BadRequest value, $Res Function(_$_BadRequest) then) =
      __$$_BadRequestCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorId, String errorMessage});
}

/// @nodoc
class __$$_BadRequestCopyWithImpl<$Res>
    extends _$APIErrorCopyWithImpl<$Res, _$_BadRequest>
    implements _$$_BadRequestCopyWith<$Res> {
  __$$_BadRequestCopyWithImpl(
      _$_BadRequest _value, $Res Function(_$_BadRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorId = null,
    Object? errorMessage = null,
  }) {
    return _then(_$_BadRequest(
      null == errorId
          ? _value.errorId
          : errorId // ignore: cast_nullable_to_non_nullable
              as String,
      null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_BadRequest implements _BadRequest {
  const _$_BadRequest(this.errorId, this.errorMessage);

  @override
  final String errorId;
  @override
  final String errorMessage;

  @override
  String toString() {
    return 'APIError.badRequest(errorId: $errorId, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BadRequest &&
            (identical(other.errorId, errorId) || other.errorId == errorId) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorId, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BadRequestCopyWith<_$_BadRequest> get copyWith =>
      __$$_BadRequestCopyWithImpl<_$_BadRequest>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() forbidden,
    required TResult Function(String errorId, String errorMessage) badRequest,
    required TResult Function(String errorId, String errorMessage) notFound,
    required TResult Function(String errorId, String errorMessage) problem,
    required TResult Function(String errorId, String errorMessage) unknown,
    required TResult Function() noInternetConnection,
  }) {
    return badRequest(errorId, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? forbidden,
    TResult? Function(String errorId, String errorMessage)? badRequest,
    TResult? Function(String errorId, String errorMessage)? notFound,
    TResult? Function(String errorId, String errorMessage)? problem,
    TResult? Function(String errorId, String errorMessage)? unknown,
    TResult? Function()? noInternetConnection,
  }) {
    return badRequest?.call(errorId, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? forbidden,
    TResult Function(String errorId, String errorMessage)? badRequest,
    TResult Function(String errorId, String errorMessage)? notFound,
    TResult Function(String errorId, String errorMessage)? problem,
    TResult Function(String errorId, String errorMessage)? unknown,
    TResult Function()? noInternetConnection,
    required TResult orElse(),
  }) {
    if (badRequest != null) {
      return badRequest(errorId, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_unauthorized value) unauthorized,
    required TResult Function(_forbidden value) forbidden,
    required TResult Function(_BadRequest value) badRequest,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_problem value) problem,
    required TResult Function(_Unknown value) unknown,
    required TResult Function(_NoInternetConnection value) noInternetConnection,
  }) {
    return badRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_unauthorized value)? unauthorized,
    TResult? Function(_forbidden value)? forbidden,
    TResult? Function(_BadRequest value)? badRequest,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_problem value)? problem,
    TResult? Function(_Unknown value)? unknown,
    TResult? Function(_NoInternetConnection value)? noInternetConnection,
  }) {
    return badRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_unauthorized value)? unauthorized,
    TResult Function(_forbidden value)? forbidden,
    TResult Function(_BadRequest value)? badRequest,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_problem value)? problem,
    TResult Function(_Unknown value)? unknown,
    TResult Function(_NoInternetConnection value)? noInternetConnection,
    required TResult orElse(),
  }) {
    if (badRequest != null) {
      return badRequest(this);
    }
    return orElse();
  }
}

abstract class _BadRequest implements APIError {
  const factory _BadRequest(final String errorId, final String errorMessage) =
      _$_BadRequest;

  String get errorId;
  String get errorMessage;
  @JsonKey(ignore: true)
  _$$_BadRequestCopyWith<_$_BadRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_NotFoundCopyWith<$Res> {
  factory _$$_NotFoundCopyWith(
          _$_NotFound value, $Res Function(_$_NotFound) then) =
      __$$_NotFoundCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorId, String errorMessage});
}

/// @nodoc
class __$$_NotFoundCopyWithImpl<$Res>
    extends _$APIErrorCopyWithImpl<$Res, _$_NotFound>
    implements _$$_NotFoundCopyWith<$Res> {
  __$$_NotFoundCopyWithImpl(
      _$_NotFound _value, $Res Function(_$_NotFound) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorId = null,
    Object? errorMessage = null,
  }) {
    return _then(_$_NotFound(
      null == errorId
          ? _value.errorId
          : errorId // ignore: cast_nullable_to_non_nullable
              as String,
      null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_NotFound implements _NotFound {
  const _$_NotFound(this.errorId, this.errorMessage);

  @override
  final String errorId;
  @override
  final String errorMessage;

  @override
  String toString() {
    return 'APIError.notFound(errorId: $errorId, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NotFound &&
            (identical(other.errorId, errorId) || other.errorId == errorId) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorId, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NotFoundCopyWith<_$_NotFound> get copyWith =>
      __$$_NotFoundCopyWithImpl<_$_NotFound>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() forbidden,
    required TResult Function(String errorId, String errorMessage) badRequest,
    required TResult Function(String errorId, String errorMessage) notFound,
    required TResult Function(String errorId, String errorMessage) problem,
    required TResult Function(String errorId, String errorMessage) unknown,
    required TResult Function() noInternetConnection,
  }) {
    return notFound(errorId, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? forbidden,
    TResult? Function(String errorId, String errorMessage)? badRequest,
    TResult? Function(String errorId, String errorMessage)? notFound,
    TResult? Function(String errorId, String errorMessage)? problem,
    TResult? Function(String errorId, String errorMessage)? unknown,
    TResult? Function()? noInternetConnection,
  }) {
    return notFound?.call(errorId, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? forbidden,
    TResult Function(String errorId, String errorMessage)? badRequest,
    TResult Function(String errorId, String errorMessage)? notFound,
    TResult Function(String errorId, String errorMessage)? problem,
    TResult Function(String errorId, String errorMessage)? unknown,
    TResult Function()? noInternetConnection,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(errorId, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_unauthorized value) unauthorized,
    required TResult Function(_forbidden value) forbidden,
    required TResult Function(_BadRequest value) badRequest,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_problem value) problem,
    required TResult Function(_Unknown value) unknown,
    required TResult Function(_NoInternetConnection value) noInternetConnection,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_unauthorized value)? unauthorized,
    TResult? Function(_forbidden value)? forbidden,
    TResult? Function(_BadRequest value)? badRequest,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_problem value)? problem,
    TResult? Function(_Unknown value)? unknown,
    TResult? Function(_NoInternetConnection value)? noInternetConnection,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_unauthorized value)? unauthorized,
    TResult Function(_forbidden value)? forbidden,
    TResult Function(_BadRequest value)? badRequest,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_problem value)? problem,
    TResult Function(_Unknown value)? unknown,
    TResult Function(_NoInternetConnection value)? noInternetConnection,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class _NotFound implements APIError {
  const factory _NotFound(final String errorId, final String errorMessage) =
      _$_NotFound;

  String get errorId;
  String get errorMessage;
  @JsonKey(ignore: true)
  _$$_NotFoundCopyWith<_$_NotFound> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_problemCopyWith<$Res> {
  factory _$$_problemCopyWith(
          _$_problem value, $Res Function(_$_problem) then) =
      __$$_problemCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorId, String errorMessage});
}

/// @nodoc
class __$$_problemCopyWithImpl<$Res>
    extends _$APIErrorCopyWithImpl<$Res, _$_problem>
    implements _$$_problemCopyWith<$Res> {
  __$$_problemCopyWithImpl(_$_problem _value, $Res Function(_$_problem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorId = null,
    Object? errorMessage = null,
  }) {
    return _then(_$_problem(
      null == errorId
          ? _value.errorId
          : errorId // ignore: cast_nullable_to_non_nullable
              as String,
      null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_problem implements _problem {
  const _$_problem(this.errorId, this.errorMessage);

  @override
  final String errorId;
  @override
  final String errorMessage;

  @override
  String toString() {
    return 'APIError.problem(errorId: $errorId, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_problem &&
            (identical(other.errorId, errorId) || other.errorId == errorId) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorId, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_problemCopyWith<_$_problem> get copyWith =>
      __$$_problemCopyWithImpl<_$_problem>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() forbidden,
    required TResult Function(String errorId, String errorMessage) badRequest,
    required TResult Function(String errorId, String errorMessage) notFound,
    required TResult Function(String errorId, String errorMessage) problem,
    required TResult Function(String errorId, String errorMessage) unknown,
    required TResult Function() noInternetConnection,
  }) {
    return problem(errorId, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? forbidden,
    TResult? Function(String errorId, String errorMessage)? badRequest,
    TResult? Function(String errorId, String errorMessage)? notFound,
    TResult? Function(String errorId, String errorMessage)? problem,
    TResult? Function(String errorId, String errorMessage)? unknown,
    TResult? Function()? noInternetConnection,
  }) {
    return problem?.call(errorId, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? forbidden,
    TResult Function(String errorId, String errorMessage)? badRequest,
    TResult Function(String errorId, String errorMessage)? notFound,
    TResult Function(String errorId, String errorMessage)? problem,
    TResult Function(String errorId, String errorMessage)? unknown,
    TResult Function()? noInternetConnection,
    required TResult orElse(),
  }) {
    if (problem != null) {
      return problem(errorId, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_unauthorized value) unauthorized,
    required TResult Function(_forbidden value) forbidden,
    required TResult Function(_BadRequest value) badRequest,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_problem value) problem,
    required TResult Function(_Unknown value) unknown,
    required TResult Function(_NoInternetConnection value) noInternetConnection,
  }) {
    return problem(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_unauthorized value)? unauthorized,
    TResult? Function(_forbidden value)? forbidden,
    TResult? Function(_BadRequest value)? badRequest,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_problem value)? problem,
    TResult? Function(_Unknown value)? unknown,
    TResult? Function(_NoInternetConnection value)? noInternetConnection,
  }) {
    return problem?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_unauthorized value)? unauthorized,
    TResult Function(_forbidden value)? forbidden,
    TResult Function(_BadRequest value)? badRequest,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_problem value)? problem,
    TResult Function(_Unknown value)? unknown,
    TResult Function(_NoInternetConnection value)? noInternetConnection,
    required TResult orElse(),
  }) {
    if (problem != null) {
      return problem(this);
    }
    return orElse();
  }
}

abstract class _problem implements APIError {
  const factory _problem(final String errorId, final String errorMessage) =
      _$_problem;

  String get errorId;
  String get errorMessage;
  @JsonKey(ignore: true)
  _$$_problemCopyWith<_$_problem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UnknownCopyWith<$Res> {
  factory _$$_UnknownCopyWith(
          _$_Unknown value, $Res Function(_$_Unknown) then) =
      __$$_UnknownCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorId, String errorMessage});
}

/// @nodoc
class __$$_UnknownCopyWithImpl<$Res>
    extends _$APIErrorCopyWithImpl<$Res, _$_Unknown>
    implements _$$_UnknownCopyWith<$Res> {
  __$$_UnknownCopyWithImpl(_$_Unknown _value, $Res Function(_$_Unknown) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorId = null,
    Object? errorMessage = null,
  }) {
    return _then(_$_Unknown(
      null == errorId
          ? _value.errorId
          : errorId // ignore: cast_nullable_to_non_nullable
              as String,
      null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Unknown implements _Unknown {
  const _$_Unknown(this.errorId, this.errorMessage);

  @override
  final String errorId;
  @override
  final String errorMessage;

  @override
  String toString() {
    return 'APIError.unknown(errorId: $errorId, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Unknown &&
            (identical(other.errorId, errorId) || other.errorId == errorId) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorId, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UnknownCopyWith<_$_Unknown> get copyWith =>
      __$$_UnknownCopyWithImpl<_$_Unknown>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() forbidden,
    required TResult Function(String errorId, String errorMessage) badRequest,
    required TResult Function(String errorId, String errorMessage) notFound,
    required TResult Function(String errorId, String errorMessage) problem,
    required TResult Function(String errorId, String errorMessage) unknown,
    required TResult Function() noInternetConnection,
  }) {
    return unknown(errorId, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? forbidden,
    TResult? Function(String errorId, String errorMessage)? badRequest,
    TResult? Function(String errorId, String errorMessage)? notFound,
    TResult? Function(String errorId, String errorMessage)? problem,
    TResult? Function(String errorId, String errorMessage)? unknown,
    TResult? Function()? noInternetConnection,
  }) {
    return unknown?.call(errorId, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? forbidden,
    TResult Function(String errorId, String errorMessage)? badRequest,
    TResult Function(String errorId, String errorMessage)? notFound,
    TResult Function(String errorId, String errorMessage)? problem,
    TResult Function(String errorId, String errorMessage)? unknown,
    TResult Function()? noInternetConnection,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(errorId, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_unauthorized value) unauthorized,
    required TResult Function(_forbidden value) forbidden,
    required TResult Function(_BadRequest value) badRequest,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_problem value) problem,
    required TResult Function(_Unknown value) unknown,
    required TResult Function(_NoInternetConnection value) noInternetConnection,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_unauthorized value)? unauthorized,
    TResult? Function(_forbidden value)? forbidden,
    TResult? Function(_BadRequest value)? badRequest,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_problem value)? problem,
    TResult? Function(_Unknown value)? unknown,
    TResult? Function(_NoInternetConnection value)? noInternetConnection,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_unauthorized value)? unauthorized,
    TResult Function(_forbidden value)? forbidden,
    TResult Function(_BadRequest value)? badRequest,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_problem value)? problem,
    TResult Function(_Unknown value)? unknown,
    TResult Function(_NoInternetConnection value)? noInternetConnection,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _Unknown implements APIError {
  const factory _Unknown(final String errorId, final String errorMessage) =
      _$_Unknown;

  String get errorId;
  String get errorMessage;
  @JsonKey(ignore: true)
  _$$_UnknownCopyWith<_$_Unknown> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_NoInternetConnectionCopyWith<$Res> {
  factory _$$_NoInternetConnectionCopyWith(_$_NoInternetConnection value,
          $Res Function(_$_NoInternetConnection) then) =
      __$$_NoInternetConnectionCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_NoInternetConnectionCopyWithImpl<$Res>
    extends _$APIErrorCopyWithImpl<$Res, _$_NoInternetConnection>
    implements _$$_NoInternetConnectionCopyWith<$Res> {
  __$$_NoInternetConnectionCopyWithImpl(_$_NoInternetConnection _value,
      $Res Function(_$_NoInternetConnection) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_NoInternetConnection implements _NoInternetConnection {
  const _$_NoInternetConnection();

  @override
  String toString() {
    return 'APIError.noInternetConnection()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_NoInternetConnection);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() forbidden,
    required TResult Function(String errorId, String errorMessage) badRequest,
    required TResult Function(String errorId, String errorMessage) notFound,
    required TResult Function(String errorId, String errorMessage) problem,
    required TResult Function(String errorId, String errorMessage) unknown,
    required TResult Function() noInternetConnection,
  }) {
    return noInternetConnection();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? forbidden,
    TResult? Function(String errorId, String errorMessage)? badRequest,
    TResult? Function(String errorId, String errorMessage)? notFound,
    TResult? Function(String errorId, String errorMessage)? problem,
    TResult? Function(String errorId, String errorMessage)? unknown,
    TResult? Function()? noInternetConnection,
  }) {
    return noInternetConnection?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? forbidden,
    TResult Function(String errorId, String errorMessage)? badRequest,
    TResult Function(String errorId, String errorMessage)? notFound,
    TResult Function(String errorId, String errorMessage)? problem,
    TResult Function(String errorId, String errorMessage)? unknown,
    TResult Function()? noInternetConnection,
    required TResult orElse(),
  }) {
    if (noInternetConnection != null) {
      return noInternetConnection();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_unauthorized value) unauthorized,
    required TResult Function(_forbidden value) forbidden,
    required TResult Function(_BadRequest value) badRequest,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_problem value) problem,
    required TResult Function(_Unknown value) unknown,
    required TResult Function(_NoInternetConnection value) noInternetConnection,
  }) {
    return noInternetConnection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_unauthorized value)? unauthorized,
    TResult? Function(_forbidden value)? forbidden,
    TResult? Function(_BadRequest value)? badRequest,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_problem value)? problem,
    TResult? Function(_Unknown value)? unknown,
    TResult? Function(_NoInternetConnection value)? noInternetConnection,
  }) {
    return noInternetConnection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_unauthorized value)? unauthorized,
    TResult Function(_forbidden value)? forbidden,
    TResult Function(_BadRequest value)? badRequest,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_problem value)? problem,
    TResult Function(_Unknown value)? unknown,
    TResult Function(_NoInternetConnection value)? noInternetConnection,
    required TResult orElse(),
  }) {
    if (noInternetConnection != null) {
      return noInternetConnection(this);
    }
    return orElse();
  }
}

abstract class _NoInternetConnection implements APIError {
  const factory _NoInternetConnection() = _$_NoInternetConnection;
}
