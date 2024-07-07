// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_result_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApiResultState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String reason, Object? error,
            NetworkException? exception, StackTrace? stackTrace)
        failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(String reason, Object? error, NetworkException? exception,
            StackTrace? stackTrace)?
        failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(String reason, Object? error, NetworkException? exception,
            StackTrace? stackTrace)?
        failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiSuccess<T> value) success,
    required TResult Function(ApiFailure<T> value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiSuccess<T> value)? success,
    TResult? Function(ApiFailure<T> value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiSuccess<T> value)? success,
    TResult Function(ApiFailure<T> value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResultStateCopyWith<T, $Res> {
  factory $ApiResultStateCopyWith(
          ApiResultState<T> value, $Res Function(ApiResultState<T>) then) =
      _$ApiResultStateCopyWithImpl<T, $Res, ApiResultState<T>>;
}

/// @nodoc
class _$ApiResultStateCopyWithImpl<T, $Res, $Val extends ApiResultState<T>>
    implements $ApiResultStateCopyWith<T, $Res> {
  _$ApiResultStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ApiSuccessImplCopyWith<T, $Res> {
  factory _$$ApiSuccessImplCopyWith(
          _$ApiSuccessImpl<T> value, $Res Function(_$ApiSuccessImpl<T>) then) =
      __$$ApiSuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$ApiSuccessImplCopyWithImpl<T, $Res>
    extends _$ApiResultStateCopyWithImpl<T, $Res, _$ApiSuccessImpl<T>>
    implements _$$ApiSuccessImplCopyWith<T, $Res> {
  __$$ApiSuccessImplCopyWithImpl(
      _$ApiSuccessImpl<T> _value, $Res Function(_$ApiSuccessImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$ApiSuccessImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$ApiSuccessImpl<T> implements ApiSuccess<T> {
  const _$ApiSuccessImpl({required this.data});

  @override
  final T data;

  @override
  String toString() {
    return 'ApiResultState<$T>.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiSuccessImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiSuccessImplCopyWith<T, _$ApiSuccessImpl<T>> get copyWith =>
      __$$ApiSuccessImplCopyWithImpl<T, _$ApiSuccessImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String reason, Object? error,
            NetworkException? exception, StackTrace? stackTrace)
        failure,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(String reason, Object? error, NetworkException? exception,
            StackTrace? stackTrace)?
        failure,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(String reason, Object? error, NetworkException? exception,
            StackTrace? stackTrace)?
        failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiSuccess<T> value) success,
    required TResult Function(ApiFailure<T> value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiSuccess<T> value)? success,
    TResult? Function(ApiFailure<T> value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiSuccess<T> value)? success,
    TResult Function(ApiFailure<T> value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ApiSuccess<T> implements ApiResultState<T> {
  const factory ApiSuccess({required final T data}) = _$ApiSuccessImpl<T>;

  T get data;
  @JsonKey(ignore: true)
  _$$ApiSuccessImplCopyWith<T, _$ApiSuccessImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ApiFailureImplCopyWith<T, $Res> {
  factory _$$ApiFailureImplCopyWith(
          _$ApiFailureImpl<T> value, $Res Function(_$ApiFailureImpl<T>) then) =
      __$$ApiFailureImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call(
      {String reason,
      Object? error,
      NetworkException? exception,
      StackTrace? stackTrace});

  $NetworkExceptionCopyWith<$Res>? get exception;
}

/// @nodoc
class __$$ApiFailureImplCopyWithImpl<T, $Res>
    extends _$ApiResultStateCopyWithImpl<T, $Res, _$ApiFailureImpl<T>>
    implements _$$ApiFailureImplCopyWith<T, $Res> {
  __$$ApiFailureImplCopyWithImpl(
      _$ApiFailureImpl<T> _value, $Res Function(_$ApiFailureImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
    Object? error = freezed,
    Object? exception = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_$ApiFailureImpl<T>(
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error ? _value.error : error,
      exception: freezed == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as NetworkException?,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $NetworkExceptionCopyWith<$Res>? get exception {
    if (_value.exception == null) {
      return null;
    }

    return $NetworkExceptionCopyWith<$Res>(_value.exception!, (value) {
      return _then(_value.copyWith(exception: value));
    });
  }
}

/// @nodoc

class _$ApiFailureImpl<T> implements ApiFailure<T> {
  const _$ApiFailureImpl(
      {required this.reason, this.error, this.exception, this.stackTrace});

  @override
  final String reason;
  @override
  final Object? error;
  @override
  final NetworkException? exception;
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'ApiResultState<$T>.failure(reason: $reason, error: $error, exception: $exception, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiFailureImpl<T> &&
            (identical(other.reason, reason) || other.reason == reason) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.exception, exception) ||
                other.exception == exception) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reason,
      const DeepCollectionEquality().hash(error), exception, stackTrace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiFailureImplCopyWith<T, _$ApiFailureImpl<T>> get copyWith =>
      __$$ApiFailureImplCopyWithImpl<T, _$ApiFailureImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(String reason, Object? error,
            NetworkException? exception, StackTrace? stackTrace)
        failure,
  }) {
    return failure(reason, error, exception, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(String reason, Object? error, NetworkException? exception,
            StackTrace? stackTrace)?
        failure,
  }) {
    return failure?.call(reason, error, exception, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(String reason, Object? error, NetworkException? exception,
            StackTrace? stackTrace)?
        failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(reason, error, exception, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApiSuccess<T> value) success,
    required TResult Function(ApiFailure<T> value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApiSuccess<T> value)? success,
    TResult? Function(ApiFailure<T> value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApiSuccess<T> value)? success,
    TResult Function(ApiFailure<T> value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class ApiFailure<T> implements ApiResultState<T> {
  const factory ApiFailure(
      {required final String reason,
      final Object? error,
      final NetworkException? exception,
      final StackTrace? stackTrace}) = _$ApiFailureImpl<T>;

  String get reason;
  Object? get error;
  NetworkException? get exception;
  StackTrace? get stackTrace;
  @JsonKey(ignore: true)
  _$$ApiFailureImplCopyWith<T, _$ApiFailureImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
