// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ResultState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String message, dynamic isLoading) loading,
    required TResult Function(String message, dynamic isProcessing) processing,
    required TResult Function(T data) success,
    required TResult Function(String message, List<T> data) empty,
    required TResult Function(String message, List<T> data) allData,
    required TResult Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String message, dynamic isLoading)? loading,
    TResult? Function(String message, dynamic isProcessing)? processing,
    TResult? Function(T data)? success,
    TResult? Function(String message, List<T> data)? empty,
    TResult? Function(String message, List<T> data)? allData,
    TResult? Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String message, dynamic isLoading)? loading,
    TResult Function(String message, dynamic isProcessing)? processing,
    TResult Function(T data)? success,
    TResult Function(String message, List<T> data)? empty,
    TResult Function(String message, List<T> data)? allData,
    TResult Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ResultIdle<T> value) idle,
    required TResult Function(_ResultLoading<T> value) loading,
    required TResult Function(_ResultProcessing<T> value) processing,
    required TResult Function(_ResultSuccess<T> value) success,
    required TResult Function(_ResultEmpty<T> value) empty,
    required TResult Function(_ResultAllData<T> value) allData,
    required TResult Function(_ResultError<T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ResultIdle<T> value)? idle,
    TResult? Function(_ResultLoading<T> value)? loading,
    TResult? Function(_ResultProcessing<T> value)? processing,
    TResult? Function(_ResultSuccess<T> value)? success,
    TResult? Function(_ResultEmpty<T> value)? empty,
    TResult? Function(_ResultAllData<T> value)? allData,
    TResult? Function(_ResultError<T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ResultIdle<T> value)? idle,
    TResult Function(_ResultLoading<T> value)? loading,
    TResult Function(_ResultProcessing<T> value)? processing,
    TResult Function(_ResultSuccess<T> value)? success,
    TResult Function(_ResultEmpty<T> value)? empty,
    TResult Function(_ResultAllData<T> value)? allData,
    TResult Function(_ResultError<T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultStateCopyWith<T, $Res> {
  factory $ResultStateCopyWith(
          ResultState<T> value, $Res Function(ResultState<T>) then) =
      _$ResultStateCopyWithImpl<T, $Res, ResultState<T>>;
}

/// @nodoc
class _$ResultStateCopyWithImpl<T, $Res, $Val extends ResultState<T>>
    implements $ResultStateCopyWith<T, $Res> {
  _$ResultStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ResultIdleImplCopyWith<T, $Res> {
  factory _$$ResultIdleImplCopyWith(
          _$ResultIdleImpl<T> value, $Res Function(_$ResultIdleImpl<T>) then) =
      __$$ResultIdleImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$ResultIdleImplCopyWithImpl<T, $Res>
    extends _$ResultStateCopyWithImpl<T, $Res, _$ResultIdleImpl<T>>
    implements _$$ResultIdleImplCopyWith<T, $Res> {
  __$$ResultIdleImplCopyWithImpl(
      _$ResultIdleImpl<T> _value, $Res Function(_$ResultIdleImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ResultIdleImpl<T> implements _ResultIdle<T> {
  const _$ResultIdleImpl();

  @override
  String toString() {
    return 'ResultState<$T>.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResultIdleImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String message, dynamic isLoading) loading,
    required TResult Function(String message, dynamic isProcessing) processing,
    required TResult Function(T data) success,
    required TResult Function(String message, List<T> data) empty,
    required TResult Function(String message, List<T> data) allData,
    required TResult Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)
        error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String message, dynamic isLoading)? loading,
    TResult? Function(String message, dynamic isProcessing)? processing,
    TResult? Function(T data)? success,
    TResult? Function(String message, List<T> data)? empty,
    TResult? Function(String message, List<T> data)? allData,
    TResult? Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)?
        error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String message, dynamic isLoading)? loading,
    TResult Function(String message, dynamic isProcessing)? processing,
    TResult Function(T data)? success,
    TResult Function(String message, List<T> data)? empty,
    TResult Function(String message, List<T> data)? allData,
    TResult Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)?
        error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ResultIdle<T> value) idle,
    required TResult Function(_ResultLoading<T> value) loading,
    required TResult Function(_ResultProcessing<T> value) processing,
    required TResult Function(_ResultSuccess<T> value) success,
    required TResult Function(_ResultEmpty<T> value) empty,
    required TResult Function(_ResultAllData<T> value) allData,
    required TResult Function(_ResultError<T> value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ResultIdle<T> value)? idle,
    TResult? Function(_ResultLoading<T> value)? loading,
    TResult? Function(_ResultProcessing<T> value)? processing,
    TResult? Function(_ResultSuccess<T> value)? success,
    TResult? Function(_ResultEmpty<T> value)? empty,
    TResult? Function(_ResultAllData<T> value)? allData,
    TResult? Function(_ResultError<T> value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ResultIdle<T> value)? idle,
    TResult Function(_ResultLoading<T> value)? loading,
    TResult Function(_ResultProcessing<T> value)? processing,
    TResult Function(_ResultSuccess<T> value)? success,
    TResult Function(_ResultEmpty<T> value)? empty,
    TResult Function(_ResultAllData<T> value)? allData,
    TResult Function(_ResultError<T> value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _ResultIdle<T> implements ResultState<T> {
  const factory _ResultIdle() = _$ResultIdleImpl<T>;
}

/// @nodoc
abstract class _$$ResultLoadingImplCopyWith<T, $Res> {
  factory _$$ResultLoadingImplCopyWith(_$ResultLoadingImpl<T> value,
          $Res Function(_$ResultLoadingImpl<T>) then) =
      __$$ResultLoadingImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message, dynamic isLoading});
}

/// @nodoc
class __$$ResultLoadingImplCopyWithImpl<T, $Res>
    extends _$ResultStateCopyWithImpl<T, $Res, _$ResultLoadingImpl<T>>
    implements _$$ResultLoadingImplCopyWith<T, $Res> {
  __$$ResultLoadingImplCopyWithImpl(_$ResultLoadingImpl<T> _value,
      $Res Function(_$ResultLoadingImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? isLoading = freezed,
  }) {
    return _then(_$ResultLoadingImpl<T>(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: freezed == isLoading ? _value.isLoading! : isLoading,
    ));
  }
}

/// @nodoc

class _$ResultLoadingImpl<T> implements _ResultLoading<T> {
  const _$ResultLoadingImpl(
      {this.message = 'Loading...', this.isLoading = false});

  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final dynamic isLoading;

  @override
  String toString() {
    return 'ResultState<$T>.loading(message: $message, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultLoadingImpl<T> &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(isLoading));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultLoadingImplCopyWith<T, _$ResultLoadingImpl<T>> get copyWith =>
      __$$ResultLoadingImplCopyWithImpl<T, _$ResultLoadingImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String message, dynamic isLoading) loading,
    required TResult Function(String message, dynamic isProcessing) processing,
    required TResult Function(T data) success,
    required TResult Function(String message, List<T> data) empty,
    required TResult Function(String message, List<T> data) allData,
    required TResult Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)
        error,
  }) {
    return loading(message, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String message, dynamic isLoading)? loading,
    TResult? Function(String message, dynamic isProcessing)? processing,
    TResult? Function(T data)? success,
    TResult? Function(String message, List<T> data)? empty,
    TResult? Function(String message, List<T> data)? allData,
    TResult? Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)?
        error,
  }) {
    return loading?.call(message, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String message, dynamic isLoading)? loading,
    TResult Function(String message, dynamic isProcessing)? processing,
    TResult Function(T data)? success,
    TResult Function(String message, List<T> data)? empty,
    TResult Function(String message, List<T> data)? allData,
    TResult Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)?
        error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(message, isLoading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ResultIdle<T> value) idle,
    required TResult Function(_ResultLoading<T> value) loading,
    required TResult Function(_ResultProcessing<T> value) processing,
    required TResult Function(_ResultSuccess<T> value) success,
    required TResult Function(_ResultEmpty<T> value) empty,
    required TResult Function(_ResultAllData<T> value) allData,
    required TResult Function(_ResultError<T> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ResultIdle<T> value)? idle,
    TResult? Function(_ResultLoading<T> value)? loading,
    TResult? Function(_ResultProcessing<T> value)? processing,
    TResult? Function(_ResultSuccess<T> value)? success,
    TResult? Function(_ResultEmpty<T> value)? empty,
    TResult? Function(_ResultAllData<T> value)? allData,
    TResult? Function(_ResultError<T> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ResultIdle<T> value)? idle,
    TResult Function(_ResultLoading<T> value)? loading,
    TResult Function(_ResultProcessing<T> value)? processing,
    TResult Function(_ResultSuccess<T> value)? success,
    TResult Function(_ResultEmpty<T> value)? empty,
    TResult Function(_ResultAllData<T> value)? allData,
    TResult Function(_ResultError<T> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _ResultLoading<T> implements ResultState<T> {
  const factory _ResultLoading(
      {final String message, final dynamic isLoading}) = _$ResultLoadingImpl<T>;

  String get message;
  dynamic get isLoading;
  @JsonKey(ignore: true)
  _$$ResultLoadingImplCopyWith<T, _$ResultLoadingImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResultProcessingImplCopyWith<T, $Res> {
  factory _$$ResultProcessingImplCopyWith(_$ResultProcessingImpl<T> value,
          $Res Function(_$ResultProcessingImpl<T>) then) =
      __$$ResultProcessingImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message, dynamic isProcessing});
}

/// @nodoc
class __$$ResultProcessingImplCopyWithImpl<T, $Res>
    extends _$ResultStateCopyWithImpl<T, $Res, _$ResultProcessingImpl<T>>
    implements _$$ResultProcessingImplCopyWith<T, $Res> {
  __$$ResultProcessingImplCopyWithImpl(_$ResultProcessingImpl<T> _value,
      $Res Function(_$ResultProcessingImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? isProcessing = freezed,
  }) {
    return _then(_$ResultProcessingImpl<T>(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      isProcessing:
          freezed == isProcessing ? _value.isProcessing! : isProcessing,
    ));
  }
}

/// @nodoc

class _$ResultProcessingImpl<T> implements _ResultProcessing<T> {
  const _$ResultProcessingImpl(
      {this.message = 'Processing...', this.isProcessing = false});

  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final dynamic isProcessing;

  @override
  String toString() {
    return 'ResultState<$T>.processing(message: $message, isProcessing: $isProcessing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultProcessingImpl<T> &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other.isProcessing, isProcessing));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(isProcessing));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultProcessingImplCopyWith<T, _$ResultProcessingImpl<T>> get copyWith =>
      __$$ResultProcessingImplCopyWithImpl<T, _$ResultProcessingImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String message, dynamic isLoading) loading,
    required TResult Function(String message, dynamic isProcessing) processing,
    required TResult Function(T data) success,
    required TResult Function(String message, List<T> data) empty,
    required TResult Function(String message, List<T> data) allData,
    required TResult Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)
        error,
  }) {
    return processing(message, isProcessing);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String message, dynamic isLoading)? loading,
    TResult? Function(String message, dynamic isProcessing)? processing,
    TResult? Function(T data)? success,
    TResult? Function(String message, List<T> data)? empty,
    TResult? Function(String message, List<T> data)? allData,
    TResult? Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)?
        error,
  }) {
    return processing?.call(message, isProcessing);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String message, dynamic isLoading)? loading,
    TResult Function(String message, dynamic isProcessing)? processing,
    TResult Function(T data)? success,
    TResult Function(String message, List<T> data)? empty,
    TResult Function(String message, List<T> data)? allData,
    TResult Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)?
        error,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing(message, isProcessing);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ResultIdle<T> value) idle,
    required TResult Function(_ResultLoading<T> value) loading,
    required TResult Function(_ResultProcessing<T> value) processing,
    required TResult Function(_ResultSuccess<T> value) success,
    required TResult Function(_ResultEmpty<T> value) empty,
    required TResult Function(_ResultAllData<T> value) allData,
    required TResult Function(_ResultError<T> value) error,
  }) {
    return processing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ResultIdle<T> value)? idle,
    TResult? Function(_ResultLoading<T> value)? loading,
    TResult? Function(_ResultProcessing<T> value)? processing,
    TResult? Function(_ResultSuccess<T> value)? success,
    TResult? Function(_ResultEmpty<T> value)? empty,
    TResult? Function(_ResultAllData<T> value)? allData,
    TResult? Function(_ResultError<T> value)? error,
  }) {
    return processing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ResultIdle<T> value)? idle,
    TResult Function(_ResultLoading<T> value)? loading,
    TResult Function(_ResultProcessing<T> value)? processing,
    TResult Function(_ResultSuccess<T> value)? success,
    TResult Function(_ResultEmpty<T> value)? empty,
    TResult Function(_ResultAllData<T> value)? allData,
    TResult Function(_ResultError<T> value)? error,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing(this);
    }
    return orElse();
  }
}

abstract class _ResultProcessing<T> implements ResultState<T> {
  const factory _ResultProcessing(
      {final String message,
      final dynamic isProcessing}) = _$ResultProcessingImpl<T>;

  String get message;
  dynamic get isProcessing;
  @JsonKey(ignore: true)
  _$$ResultProcessingImplCopyWith<T, _$ResultProcessingImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResultSuccessImplCopyWith<T, $Res> {
  factory _$$ResultSuccessImplCopyWith(_$ResultSuccessImpl<T> value,
          $Res Function(_$ResultSuccessImpl<T>) then) =
      __$$ResultSuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$ResultSuccessImplCopyWithImpl<T, $Res>
    extends _$ResultStateCopyWithImpl<T, $Res, _$ResultSuccessImpl<T>>
    implements _$$ResultSuccessImplCopyWith<T, $Res> {
  __$$ResultSuccessImplCopyWithImpl(_$ResultSuccessImpl<T> _value,
      $Res Function(_$ResultSuccessImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$ResultSuccessImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$ResultSuccessImpl<T> implements _ResultSuccess<T> {
  const _$ResultSuccessImpl({required this.data});

  @override
  final T data;

  @override
  String toString() {
    return 'ResultState<$T>.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultSuccessImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultSuccessImplCopyWith<T, _$ResultSuccessImpl<T>> get copyWith =>
      __$$ResultSuccessImplCopyWithImpl<T, _$ResultSuccessImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String message, dynamic isLoading) loading,
    required TResult Function(String message, dynamic isProcessing) processing,
    required TResult Function(T data) success,
    required TResult Function(String message, List<T> data) empty,
    required TResult Function(String message, List<T> data) allData,
    required TResult Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)
        error,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String message, dynamic isLoading)? loading,
    TResult? Function(String message, dynamic isProcessing)? processing,
    TResult? Function(T data)? success,
    TResult? Function(String message, List<T> data)? empty,
    TResult? Function(String message, List<T> data)? allData,
    TResult? Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)?
        error,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String message, dynamic isLoading)? loading,
    TResult Function(String message, dynamic isProcessing)? processing,
    TResult Function(T data)? success,
    TResult Function(String message, List<T> data)? empty,
    TResult Function(String message, List<T> data)? allData,
    TResult Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)?
        error,
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
    required TResult Function(_ResultIdle<T> value) idle,
    required TResult Function(_ResultLoading<T> value) loading,
    required TResult Function(_ResultProcessing<T> value) processing,
    required TResult Function(_ResultSuccess<T> value) success,
    required TResult Function(_ResultEmpty<T> value) empty,
    required TResult Function(_ResultAllData<T> value) allData,
    required TResult Function(_ResultError<T> value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ResultIdle<T> value)? idle,
    TResult? Function(_ResultLoading<T> value)? loading,
    TResult? Function(_ResultProcessing<T> value)? processing,
    TResult? Function(_ResultSuccess<T> value)? success,
    TResult? Function(_ResultEmpty<T> value)? empty,
    TResult? Function(_ResultAllData<T> value)? allData,
    TResult? Function(_ResultError<T> value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ResultIdle<T> value)? idle,
    TResult Function(_ResultLoading<T> value)? loading,
    TResult Function(_ResultProcessing<T> value)? processing,
    TResult Function(_ResultSuccess<T> value)? success,
    TResult Function(_ResultEmpty<T> value)? empty,
    TResult Function(_ResultAllData<T> value)? allData,
    TResult Function(_ResultError<T> value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _ResultSuccess<T> implements ResultState<T> {
  const factory _ResultSuccess({required final T data}) =
      _$ResultSuccessImpl<T>;

  T get data;
  @JsonKey(ignore: true)
  _$$ResultSuccessImplCopyWith<T, _$ResultSuccessImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResultEmptyImplCopyWith<T, $Res> {
  factory _$$ResultEmptyImplCopyWith(_$ResultEmptyImpl<T> value,
          $Res Function(_$ResultEmptyImpl<T>) then) =
      __$$ResultEmptyImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message, List<T> data});
}

/// @nodoc
class __$$ResultEmptyImplCopyWithImpl<T, $Res>
    extends _$ResultStateCopyWithImpl<T, $Res, _$ResultEmptyImpl<T>>
    implements _$$ResultEmptyImplCopyWith<T, $Res> {
  __$$ResultEmptyImplCopyWithImpl(
      _$ResultEmptyImpl<T> _value, $Res Function(_$ResultEmptyImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_$ResultEmptyImpl<T>(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc

class _$ResultEmptyImpl<T> implements _ResultEmpty<T> {
  const _$ResultEmptyImpl(
      {this.message = 'Empty', final List<T> data = const []})
      : _data = data;

  @override
  @JsonKey()
  final String message;
  final List<T> _data;
  @override
  @JsonKey()
  List<T> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'ResultState<$T>.empty(message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultEmptyImpl<T> &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultEmptyImplCopyWith<T, _$ResultEmptyImpl<T>> get copyWith =>
      __$$ResultEmptyImplCopyWithImpl<T, _$ResultEmptyImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String message, dynamic isLoading) loading,
    required TResult Function(String message, dynamic isProcessing) processing,
    required TResult Function(T data) success,
    required TResult Function(String message, List<T> data) empty,
    required TResult Function(String message, List<T> data) allData,
    required TResult Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)
        error,
  }) {
    return empty(message, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String message, dynamic isLoading)? loading,
    TResult? Function(String message, dynamic isProcessing)? processing,
    TResult? Function(T data)? success,
    TResult? Function(String message, List<T> data)? empty,
    TResult? Function(String message, List<T> data)? allData,
    TResult? Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)?
        error,
  }) {
    return empty?.call(message, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String message, dynamic isLoading)? loading,
    TResult Function(String message, dynamic isProcessing)? processing,
    TResult Function(T data)? success,
    TResult Function(String message, List<T> data)? empty,
    TResult Function(String message, List<T> data)? allData,
    TResult Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)?
        error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(message, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ResultIdle<T> value) idle,
    required TResult Function(_ResultLoading<T> value) loading,
    required TResult Function(_ResultProcessing<T> value) processing,
    required TResult Function(_ResultSuccess<T> value) success,
    required TResult Function(_ResultEmpty<T> value) empty,
    required TResult Function(_ResultAllData<T> value) allData,
    required TResult Function(_ResultError<T> value) error,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ResultIdle<T> value)? idle,
    TResult? Function(_ResultLoading<T> value)? loading,
    TResult? Function(_ResultProcessing<T> value)? processing,
    TResult? Function(_ResultSuccess<T> value)? success,
    TResult? Function(_ResultEmpty<T> value)? empty,
    TResult? Function(_ResultAllData<T> value)? allData,
    TResult? Function(_ResultError<T> value)? error,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ResultIdle<T> value)? idle,
    TResult Function(_ResultLoading<T> value)? loading,
    TResult Function(_ResultProcessing<T> value)? processing,
    TResult Function(_ResultSuccess<T> value)? success,
    TResult Function(_ResultEmpty<T> value)? empty,
    TResult Function(_ResultAllData<T> value)? allData,
    TResult Function(_ResultError<T> value)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class _ResultEmpty<T> implements ResultState<T> {
  const factory _ResultEmpty({final String message, final List<T> data}) =
      _$ResultEmptyImpl<T>;

  String get message;
  List<T> get data;
  @JsonKey(ignore: true)
  _$$ResultEmptyImplCopyWith<T, _$ResultEmptyImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResultAllDataImplCopyWith<T, $Res> {
  factory _$$ResultAllDataImplCopyWith(_$ResultAllDataImpl<T> value,
          $Res Function(_$ResultAllDataImpl<T>) then) =
      __$$ResultAllDataImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message, List<T> data});
}

/// @nodoc
class __$$ResultAllDataImplCopyWithImpl<T, $Res>
    extends _$ResultStateCopyWithImpl<T, $Res, _$ResultAllDataImpl<T>>
    implements _$$ResultAllDataImplCopyWith<T, $Res> {
  __$$ResultAllDataImplCopyWithImpl(_$ResultAllDataImpl<T> _value,
      $Res Function(_$ResultAllDataImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_$ResultAllDataImpl<T>(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc

class _$ResultAllDataImpl<T> implements _ResultAllData<T> {
  const _$ResultAllDataImpl(
      {this.message = 'All data', final List<T> data = const []})
      : _data = data;

  @override
  @JsonKey()
  final String message;
  final List<T> _data;
  @override
  @JsonKey()
  List<T> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'ResultState<$T>.allData(message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultAllDataImpl<T> &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultAllDataImplCopyWith<T, _$ResultAllDataImpl<T>> get copyWith =>
      __$$ResultAllDataImplCopyWithImpl<T, _$ResultAllDataImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String message, dynamic isLoading) loading,
    required TResult Function(String message, dynamic isProcessing) processing,
    required TResult Function(T data) success,
    required TResult Function(String message, List<T> data) empty,
    required TResult Function(String message, List<T> data) allData,
    required TResult Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)
        error,
  }) {
    return allData(message, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String message, dynamic isLoading)? loading,
    TResult? Function(String message, dynamic isProcessing)? processing,
    TResult? Function(T data)? success,
    TResult? Function(String message, List<T> data)? empty,
    TResult? Function(String message, List<T> data)? allData,
    TResult? Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)?
        error,
  }) {
    return allData?.call(message, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String message, dynamic isLoading)? loading,
    TResult Function(String message, dynamic isProcessing)? processing,
    TResult Function(T data)? success,
    TResult Function(String message, List<T> data)? empty,
    TResult Function(String message, List<T> data)? allData,
    TResult Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)?
        error,
    required TResult orElse(),
  }) {
    if (allData != null) {
      return allData(message, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ResultIdle<T> value) idle,
    required TResult Function(_ResultLoading<T> value) loading,
    required TResult Function(_ResultProcessing<T> value) processing,
    required TResult Function(_ResultSuccess<T> value) success,
    required TResult Function(_ResultEmpty<T> value) empty,
    required TResult Function(_ResultAllData<T> value) allData,
    required TResult Function(_ResultError<T> value) error,
  }) {
    return allData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ResultIdle<T> value)? idle,
    TResult? Function(_ResultLoading<T> value)? loading,
    TResult? Function(_ResultProcessing<T> value)? processing,
    TResult? Function(_ResultSuccess<T> value)? success,
    TResult? Function(_ResultEmpty<T> value)? empty,
    TResult? Function(_ResultAllData<T> value)? allData,
    TResult? Function(_ResultError<T> value)? error,
  }) {
    return allData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ResultIdle<T> value)? idle,
    TResult Function(_ResultLoading<T> value)? loading,
    TResult Function(_ResultProcessing<T> value)? processing,
    TResult Function(_ResultSuccess<T> value)? success,
    TResult Function(_ResultEmpty<T> value)? empty,
    TResult Function(_ResultAllData<T> value)? allData,
    TResult Function(_ResultError<T> value)? error,
    required TResult orElse(),
  }) {
    if (allData != null) {
      return allData(this);
    }
    return orElse();
  }
}

abstract class _ResultAllData<T> implements ResultState<T> {
  const factory _ResultAllData({final String message, final List<T> data}) =
      _$ResultAllDataImpl<T>;

  String get message;
  List<T> get data;
  @JsonKey(ignore: true)
  _$$ResultAllDataImplCopyWith<T, _$ResultAllDataImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResultErrorImplCopyWith<T, $Res> {
  factory _$$ResultErrorImplCopyWith(_$ResultErrorImpl<T> value,
          $Res Function(_$ResultErrorImpl<T>) then) =
      __$$ResultErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call(
      {String reason,
      Object? error,
      NetworkException? networkException,
      StackTrace? stackTrace});

  $NetworkExceptionCopyWith<$Res>? get networkException;
}

/// @nodoc
class __$$ResultErrorImplCopyWithImpl<T, $Res>
    extends _$ResultStateCopyWithImpl<T, $Res, _$ResultErrorImpl<T>>
    implements _$$ResultErrorImplCopyWith<T, $Res> {
  __$$ResultErrorImplCopyWithImpl(
      _$ResultErrorImpl<T> _value, $Res Function(_$ResultErrorImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
    Object? error = freezed,
    Object? networkException = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_$ResultErrorImpl<T>(
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error ? _value.error : error,
      networkException: freezed == networkException
          ? _value.networkException
          : networkException // ignore: cast_nullable_to_non_nullable
              as NetworkException?,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $NetworkExceptionCopyWith<$Res>? get networkException {
    if (_value.networkException == null) {
      return null;
    }

    return $NetworkExceptionCopyWith<$Res>(_value.networkException!, (value) {
      return _then(_value.copyWith(networkException: value));
    });
  }
}

/// @nodoc

class _$ResultErrorImpl<T> implements _ResultError<T> {
  const _$ResultErrorImpl(
      {required this.reason,
      this.error,
      this.networkException,
      this.stackTrace});

  @override
  final String reason;
  @override
  final Object? error;
  @override
  final NetworkException? networkException;
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'ResultState<$T>.error(reason: $reason, error: $error, networkException: $networkException, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultErrorImpl<T> &&
            (identical(other.reason, reason) || other.reason == reason) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.networkException, networkException) ||
                other.networkException == networkException) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reason,
      const DeepCollectionEquality().hash(error), networkException, stackTrace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultErrorImplCopyWith<T, _$ResultErrorImpl<T>> get copyWith =>
      __$$ResultErrorImplCopyWithImpl<T, _$ResultErrorImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String message, dynamic isLoading) loading,
    required TResult Function(String message, dynamic isProcessing) processing,
    required TResult Function(T data) success,
    required TResult Function(String message, List<T> data) empty,
    required TResult Function(String message, List<T> data) allData,
    required TResult Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)
        error,
  }) {
    return error(reason, this.error, networkException, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String message, dynamic isLoading)? loading,
    TResult? Function(String message, dynamic isProcessing)? processing,
    TResult? Function(T data)? success,
    TResult? Function(String message, List<T> data)? empty,
    TResult? Function(String message, List<T> data)? allData,
    TResult? Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)?
        error,
  }) {
    return error?.call(reason, this.error, networkException, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String message, dynamic isLoading)? loading,
    TResult Function(String message, dynamic isProcessing)? processing,
    TResult Function(T data)? success,
    TResult Function(String message, List<T> data)? empty,
    TResult Function(String message, List<T> data)? allData,
    TResult Function(String reason, Object? error,
            NetworkException? networkException, StackTrace? stackTrace)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(reason, this.error, networkException, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ResultIdle<T> value) idle,
    required TResult Function(_ResultLoading<T> value) loading,
    required TResult Function(_ResultProcessing<T> value) processing,
    required TResult Function(_ResultSuccess<T> value) success,
    required TResult Function(_ResultEmpty<T> value) empty,
    required TResult Function(_ResultAllData<T> value) allData,
    required TResult Function(_ResultError<T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ResultIdle<T> value)? idle,
    TResult? Function(_ResultLoading<T> value)? loading,
    TResult? Function(_ResultProcessing<T> value)? processing,
    TResult? Function(_ResultSuccess<T> value)? success,
    TResult? Function(_ResultEmpty<T> value)? empty,
    TResult? Function(_ResultAllData<T> value)? allData,
    TResult? Function(_ResultError<T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ResultIdle<T> value)? idle,
    TResult Function(_ResultLoading<T> value)? loading,
    TResult Function(_ResultProcessing<T> value)? processing,
    TResult Function(_ResultSuccess<T> value)? success,
    TResult Function(_ResultEmpty<T> value)? empty,
    TResult Function(_ResultAllData<T> value)? allData,
    TResult Function(_ResultError<T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ResultError<T> implements ResultState<T> {
  const factory _ResultError(
      {required final String reason,
      final Object? error,
      final NetworkException? networkException,
      final StackTrace? stackTrace}) = _$ResultErrorImpl<T>;

  String get reason;
  Object? get error;
  NetworkException? get networkException;
  StackTrace? get stackTrace;
  @JsonKey(ignore: true)
  _$$ResultErrorImplCopyWith<T, _$ResultErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
