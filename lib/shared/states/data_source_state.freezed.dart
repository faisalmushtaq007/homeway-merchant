// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_source_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DataSourceState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T? data, dynamic meta) remote,
    required TResult Function(T? data, dynamic meta) localDb,
    required TResult Function(
            DataSourceFailure dataSourceFailure,
            String reason,
            Object? error,
            NetworkException? networkException,
            StackTrace? stackTrace,
            Exception? exception,
            dynamic extra)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T? data, dynamic meta)? remote,
    TResult? Function(T? data, dynamic meta)? localDb,
    TResult? Function(
            DataSourceFailure dataSourceFailure,
            String reason,
            Object? error,
            NetworkException? networkException,
            StackTrace? stackTrace,
            Exception? exception,
            dynamic extra)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T? data, dynamic meta)? remote,
    TResult Function(T? data, dynamic meta)? localDb,
    TResult Function(
            DataSourceFailure dataSourceFailure,
            String reason,
            Object? error,
            NetworkException? networkException,
            StackTrace? stackTrace,
            Exception? exception,
            dynamic extra)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DataSourceRemote<T> value) remote,
    required TResult Function(_DataSourceLocalDb<T> value) localDb,
    required TResult Function(_DataSourceError<T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DataSourceRemote<T> value)? remote,
    TResult? Function(_DataSourceLocalDb<T> value)? localDb,
    TResult? Function(_DataSourceError<T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DataSourceRemote<T> value)? remote,
    TResult Function(_DataSourceLocalDb<T> value)? localDb,
    TResult Function(_DataSourceError<T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataSourceStateCopyWith<T, $Res> {
  factory $DataSourceStateCopyWith(
          DataSourceState<T> value, $Res Function(DataSourceState<T>) then) =
      _$DataSourceStateCopyWithImpl<T, $Res, DataSourceState<T>>;
}

/// @nodoc
class _$DataSourceStateCopyWithImpl<T, $Res, $Val extends DataSourceState<T>>
    implements $DataSourceStateCopyWith<T, $Res> {
  _$DataSourceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$DataSourceRemoteImplCopyWith<T, $Res> {
  factory _$$DataSourceRemoteImplCopyWith(_$DataSourceRemoteImpl<T> value,
          $Res Function(_$DataSourceRemoteImpl<T>) then) =
      __$$DataSourceRemoteImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T? data, dynamic meta});
}

/// @nodoc
class __$$DataSourceRemoteImplCopyWithImpl<T, $Res>
    extends _$DataSourceStateCopyWithImpl<T, $Res, _$DataSourceRemoteImpl<T>>
    implements _$$DataSourceRemoteImplCopyWith<T, $Res> {
  __$$DataSourceRemoteImplCopyWithImpl(_$DataSourceRemoteImpl<T> _value,
      $Res Function(_$DataSourceRemoteImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? meta = freezed,
  }) {
    return _then(_$DataSourceRemoteImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$DataSourceRemoteImpl<T> implements _DataSourceRemote<T> {
  const _$DataSourceRemoteImpl({this.data, this.meta});

  @override
  final T? data;
  @override
  final dynamic meta;

  @override
  String toString() {
    return 'DataSourceState<$T>.remote(data: $data, meta: $meta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataSourceRemoteImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other.meta, meta));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(meta));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataSourceRemoteImplCopyWith<T, _$DataSourceRemoteImpl<T>> get copyWith =>
      __$$DataSourceRemoteImplCopyWithImpl<T, _$DataSourceRemoteImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T? data, dynamic meta) remote,
    required TResult Function(T? data, dynamic meta) localDb,
    required TResult Function(
            DataSourceFailure dataSourceFailure,
            String reason,
            Object? error,
            NetworkException? networkException,
            StackTrace? stackTrace,
            Exception? exception,
            dynamic extra)
        error,
  }) {
    return remote(data, meta);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T? data, dynamic meta)? remote,
    TResult? Function(T? data, dynamic meta)? localDb,
    TResult? Function(
            DataSourceFailure dataSourceFailure,
            String reason,
            Object? error,
            NetworkException? networkException,
            StackTrace? stackTrace,
            Exception? exception,
            dynamic extra)?
        error,
  }) {
    return remote?.call(data, meta);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T? data, dynamic meta)? remote,
    TResult Function(T? data, dynamic meta)? localDb,
    TResult Function(
            DataSourceFailure dataSourceFailure,
            String reason,
            Object? error,
            NetworkException? networkException,
            StackTrace? stackTrace,
            Exception? exception,
            dynamic extra)?
        error,
    required TResult orElse(),
  }) {
    if (remote != null) {
      return remote(data, meta);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DataSourceRemote<T> value) remote,
    required TResult Function(_DataSourceLocalDb<T> value) localDb,
    required TResult Function(_DataSourceError<T> value) error,
  }) {
    return remote(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DataSourceRemote<T> value)? remote,
    TResult? Function(_DataSourceLocalDb<T> value)? localDb,
    TResult? Function(_DataSourceError<T> value)? error,
  }) {
    return remote?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DataSourceRemote<T> value)? remote,
    TResult Function(_DataSourceLocalDb<T> value)? localDb,
    TResult Function(_DataSourceError<T> value)? error,
    required TResult orElse(),
  }) {
    if (remote != null) {
      return remote(this);
    }
    return orElse();
  }
}

abstract class _DataSourceRemote<T> implements DataSourceState<T> {
  const factory _DataSourceRemote({final T? data, final dynamic meta}) =
      _$DataSourceRemoteImpl<T>;

  T? get data;
  dynamic get meta;
  @JsonKey(ignore: true)
  _$$DataSourceRemoteImplCopyWith<T, _$DataSourceRemoteImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DataSourceLocalDbImplCopyWith<T, $Res> {
  factory _$$DataSourceLocalDbImplCopyWith(_$DataSourceLocalDbImpl<T> value,
          $Res Function(_$DataSourceLocalDbImpl<T>) then) =
      __$$DataSourceLocalDbImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T? data, dynamic meta});
}

/// @nodoc
class __$$DataSourceLocalDbImplCopyWithImpl<T, $Res>
    extends _$DataSourceStateCopyWithImpl<T, $Res, _$DataSourceLocalDbImpl<T>>
    implements _$$DataSourceLocalDbImplCopyWith<T, $Res> {
  __$$DataSourceLocalDbImplCopyWithImpl(_$DataSourceLocalDbImpl<T> _value,
      $Res Function(_$DataSourceLocalDbImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? meta = freezed,
  }) {
    return _then(_$DataSourceLocalDbImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$DataSourceLocalDbImpl<T> implements _DataSourceLocalDb<T> {
  const _$DataSourceLocalDbImpl({this.data, this.meta});

  @override
  final T? data;
  @override
  final dynamic meta;

  @override
  String toString() {
    return 'DataSourceState<$T>.localDb(data: $data, meta: $meta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataSourceLocalDbImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other.meta, meta));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(meta));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataSourceLocalDbImplCopyWith<T, _$DataSourceLocalDbImpl<T>>
      get copyWith =>
          __$$DataSourceLocalDbImplCopyWithImpl<T, _$DataSourceLocalDbImpl<T>>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T? data, dynamic meta) remote,
    required TResult Function(T? data, dynamic meta) localDb,
    required TResult Function(
            DataSourceFailure dataSourceFailure,
            String reason,
            Object? error,
            NetworkException? networkException,
            StackTrace? stackTrace,
            Exception? exception,
            dynamic extra)
        error,
  }) {
    return localDb(data, meta);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T? data, dynamic meta)? remote,
    TResult? Function(T? data, dynamic meta)? localDb,
    TResult? Function(
            DataSourceFailure dataSourceFailure,
            String reason,
            Object? error,
            NetworkException? networkException,
            StackTrace? stackTrace,
            Exception? exception,
            dynamic extra)?
        error,
  }) {
    return localDb?.call(data, meta);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T? data, dynamic meta)? remote,
    TResult Function(T? data, dynamic meta)? localDb,
    TResult Function(
            DataSourceFailure dataSourceFailure,
            String reason,
            Object? error,
            NetworkException? networkException,
            StackTrace? stackTrace,
            Exception? exception,
            dynamic extra)?
        error,
    required TResult orElse(),
  }) {
    if (localDb != null) {
      return localDb(data, meta);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DataSourceRemote<T> value) remote,
    required TResult Function(_DataSourceLocalDb<T> value) localDb,
    required TResult Function(_DataSourceError<T> value) error,
  }) {
    return localDb(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DataSourceRemote<T> value)? remote,
    TResult? Function(_DataSourceLocalDb<T> value)? localDb,
    TResult? Function(_DataSourceError<T> value)? error,
  }) {
    return localDb?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DataSourceRemote<T> value)? remote,
    TResult Function(_DataSourceLocalDb<T> value)? localDb,
    TResult Function(_DataSourceError<T> value)? error,
    required TResult orElse(),
  }) {
    if (localDb != null) {
      return localDb(this);
    }
    return orElse();
  }
}

abstract class _DataSourceLocalDb<T> implements DataSourceState<T> {
  const factory _DataSourceLocalDb({final T? data, final dynamic meta}) =
      _$DataSourceLocalDbImpl<T>;

  T? get data;
  dynamic get meta;
  @JsonKey(ignore: true)
  _$$DataSourceLocalDbImplCopyWith<T, _$DataSourceLocalDbImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DataSourceErrorImplCopyWith<T, $Res> {
  factory _$$DataSourceErrorImplCopyWith(_$DataSourceErrorImpl<T> value,
          $Res Function(_$DataSourceErrorImpl<T>) then) =
      __$$DataSourceErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call(
      {DataSourceFailure dataSourceFailure,
      String reason,
      Object? error,
      NetworkException? networkException,
      StackTrace? stackTrace,
      Exception? exception,
      dynamic extra});

  $NetworkExceptionCopyWith<$Res>? get networkException;
}

/// @nodoc
class __$$DataSourceErrorImplCopyWithImpl<T, $Res>
    extends _$DataSourceStateCopyWithImpl<T, $Res, _$DataSourceErrorImpl<T>>
    implements _$$DataSourceErrorImplCopyWith<T, $Res> {
  __$$DataSourceErrorImplCopyWithImpl(_$DataSourceErrorImpl<T> _value,
      $Res Function(_$DataSourceErrorImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dataSourceFailure = null,
    Object? reason = null,
    Object? error = freezed,
    Object? networkException = freezed,
    Object? stackTrace = freezed,
    Object? exception = freezed,
    Object? extra = freezed,
  }) {
    return _then(_$DataSourceErrorImpl<T>(
      dataSourceFailure: null == dataSourceFailure
          ? _value.dataSourceFailure
          : dataSourceFailure // ignore: cast_nullable_to_non_nullable
              as DataSourceFailure,
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
      exception: freezed == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as Exception?,
      extra: freezed == extra
          ? _value.extra
          : extra // ignore: cast_nullable_to_non_nullable
              as dynamic,
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

class _$DataSourceErrorImpl<T> implements _DataSourceError<T> {
  const _$DataSourceErrorImpl(
      {this.dataSourceFailure = DataSourceFailure.none,
      required this.reason,
      this.error,
      this.networkException,
      this.stackTrace,
      this.exception,
      this.extra});

  @override
  @JsonKey()
  final DataSourceFailure dataSourceFailure;
  @override
  final String reason;
  @override
  final Object? error;
  @override
  final NetworkException? networkException;
  @override
  final StackTrace? stackTrace;
  @override
  final Exception? exception;
  @override
  final dynamic extra;

  @override
  String toString() {
    return 'DataSourceState<$T>.error(dataSourceFailure: $dataSourceFailure, reason: $reason, error: $error, networkException: $networkException, stackTrace: $stackTrace, exception: $exception, extra: $extra)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataSourceErrorImpl<T> &&
            (identical(other.dataSourceFailure, dataSourceFailure) ||
                other.dataSourceFailure == dataSourceFailure) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.networkException, networkException) ||
                other.networkException == networkException) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.exception, exception) ||
                other.exception == exception) &&
            const DeepCollectionEquality().equals(other.extra, extra));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      dataSourceFailure,
      reason,
      const DeepCollectionEquality().hash(error),
      networkException,
      stackTrace,
      exception,
      const DeepCollectionEquality().hash(extra));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataSourceErrorImplCopyWith<T, _$DataSourceErrorImpl<T>> get copyWith =>
      __$$DataSourceErrorImplCopyWithImpl<T, _$DataSourceErrorImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T? data, dynamic meta) remote,
    required TResult Function(T? data, dynamic meta) localDb,
    required TResult Function(
            DataSourceFailure dataSourceFailure,
            String reason,
            Object? error,
            NetworkException? networkException,
            StackTrace? stackTrace,
            Exception? exception,
            dynamic extra)
        error,
  }) {
    return error(dataSourceFailure, reason, this.error, networkException,
        stackTrace, exception, extra);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T? data, dynamic meta)? remote,
    TResult? Function(T? data, dynamic meta)? localDb,
    TResult? Function(
            DataSourceFailure dataSourceFailure,
            String reason,
            Object? error,
            NetworkException? networkException,
            StackTrace? stackTrace,
            Exception? exception,
            dynamic extra)?
        error,
  }) {
    return error?.call(dataSourceFailure, reason, this.error, networkException,
        stackTrace, exception, extra);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T? data, dynamic meta)? remote,
    TResult Function(T? data, dynamic meta)? localDb,
    TResult Function(
            DataSourceFailure dataSourceFailure,
            String reason,
            Object? error,
            NetworkException? networkException,
            StackTrace? stackTrace,
            Exception? exception,
            dynamic extra)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(dataSourceFailure, reason, this.error, networkException,
          stackTrace, exception, extra);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DataSourceRemote<T> value) remote,
    required TResult Function(_DataSourceLocalDb<T> value) localDb,
    required TResult Function(_DataSourceError<T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DataSourceRemote<T> value)? remote,
    TResult? Function(_DataSourceLocalDb<T> value)? localDb,
    TResult? Function(_DataSourceError<T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DataSourceRemote<T> value)? remote,
    TResult Function(_DataSourceLocalDb<T> value)? localDb,
    TResult Function(_DataSourceError<T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _DataSourceError<T> implements DataSourceState<T> {
  const factory _DataSourceError(
      {final DataSourceFailure dataSourceFailure,
      required final String reason,
      final Object? error,
      final NetworkException? networkException,
      final StackTrace? stackTrace,
      final Exception? exception,
      final dynamic extra}) = _$DataSourceErrorImpl<T>;

  DataSourceFailure get dataSourceFailure;
  String get reason;
  Object? get error;
  NetworkException? get networkException;
  StackTrace? get stackTrace;
  Exception? get exception;
  dynamic get extra;
  @JsonKey(ignore: true)
  _$$DataSourceErrorImplCopyWith<T, _$DataSourceErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
