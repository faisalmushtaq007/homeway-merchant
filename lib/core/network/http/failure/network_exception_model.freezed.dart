// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_exception_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NetworkExceptionModel _$NetworkExceptionModelFromJson(
    Map<String, dynamic> json) {
  return _NetworkExceptionModel.fromJson(json);
}

/// @nodoc
mixin _$NetworkExceptionModel {
  @JsonKey(name: 'jsonrpc')
  String? get jsonrpc => throw _privateConstructorUsedError;
  @JsonKey(name: 'id')
  dynamic? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'error')
  ErrorBean? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NetworkExceptionModelCopyWith<NetworkExceptionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkExceptionModelCopyWith<$Res> {
  factory $NetworkExceptionModelCopyWith(NetworkExceptionModel value,
          $Res Function(NetworkExceptionModel) then) =
      _$NetworkExceptionModelCopyWithImpl<$Res, NetworkExceptionModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'jsonrpc') String? jsonrpc,
      @JsonKey(name: 'id') dynamic? id,
      @JsonKey(name: 'error') ErrorBean? error});

  $ErrorBeanCopyWith<$Res>? get error;
}

/// @nodoc
class _$NetworkExceptionModelCopyWithImpl<$Res,
        $Val extends NetworkExceptionModel>
    implements $NetworkExceptionModelCopyWith<$Res> {
  _$NetworkExceptionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jsonrpc = freezed,
    Object? id = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      jsonrpc: freezed == jsonrpc
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorBean?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ErrorBeanCopyWith<$Res>? get error {
    if (_value.error == null) {
      return null;
    }

    return $ErrorBeanCopyWith<$Res>(_value.error!, (value) {
      return _then(_value.copyWith(error: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NetworkExceptionModelImplCopyWith<$Res>
    implements $NetworkExceptionModelCopyWith<$Res> {
  factory _$$NetworkExceptionModelImplCopyWith(
          _$NetworkExceptionModelImpl value,
          $Res Function(_$NetworkExceptionModelImpl) then) =
      __$$NetworkExceptionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'jsonrpc') String? jsonrpc,
      @JsonKey(name: 'id') dynamic? id,
      @JsonKey(name: 'error') ErrorBean? error});

  @override
  $ErrorBeanCopyWith<$Res>? get error;
}

/// @nodoc
class __$$NetworkExceptionModelImplCopyWithImpl<$Res>
    extends _$NetworkExceptionModelCopyWithImpl<$Res,
        _$NetworkExceptionModelImpl>
    implements _$$NetworkExceptionModelImplCopyWith<$Res> {
  __$$NetworkExceptionModelImplCopyWithImpl(_$NetworkExceptionModelImpl _value,
      $Res Function(_$NetworkExceptionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jsonrpc = freezed,
    Object? id = freezed,
    Object? error = freezed,
  }) {
    return _then(_$NetworkExceptionModelImpl(
      jsonrpc: freezed == jsonrpc
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorBean?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NetworkExceptionModelImpl implements _NetworkExceptionModel {
  const _$NetworkExceptionModelImpl(
      {@JsonKey(name: 'jsonrpc') this.jsonrpc,
      @JsonKey(name: 'id') this.id,
      @JsonKey(name: 'error') this.error});

  factory _$NetworkExceptionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NetworkExceptionModelImplFromJson(json);

  @override
  @JsonKey(name: 'jsonrpc')
  final String? jsonrpc;
  @override
  @JsonKey(name: 'id')
  final dynamic? id;
  @override
  @JsonKey(name: 'error')
  final ErrorBean? error;

  @override
  String toString() {
    return 'NetworkExceptionModel(jsonrpc: $jsonrpc, id: $id, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkExceptionModelImpl &&
            (identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, jsonrpc, const DeepCollectionEquality().hash(id), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkExceptionModelImplCopyWith<_$NetworkExceptionModelImpl>
      get copyWith => __$$NetworkExceptionModelImplCopyWithImpl<
          _$NetworkExceptionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NetworkExceptionModelImplToJson(
      this,
    );
  }
}

abstract class _NetworkExceptionModel implements NetworkExceptionModel {
  const factory _NetworkExceptionModel(
          {@JsonKey(name: 'jsonrpc') final String? jsonrpc,
          @JsonKey(name: 'id') final dynamic? id,
          @JsonKey(name: 'error') final ErrorBean? error}) =
      _$NetworkExceptionModelImpl;

  factory _NetworkExceptionModel.fromJson(Map<String, dynamic> json) =
      _$NetworkExceptionModelImpl.fromJson;

  @override
  @JsonKey(name: 'jsonrpc')
  String? get jsonrpc;
  @override
  @JsonKey(name: 'id')
  dynamic? get id;
  @override
  @JsonKey(name: 'error')
  ErrorBean? get error;
  @override
  @JsonKey(ignore: true)
  _$$NetworkExceptionModelImplCopyWith<_$NetworkExceptionModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ErrorBean _$ErrorBeanFromJson(Map<String, dynamic> json) {
  return _ErrorBean.fromJson(json);
}

/// @nodoc
mixin _$ErrorBean {
  @JsonKey(name: 'code')
  int? get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  DataBean? get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'http_status')
  int? get httpStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorBeanCopyWith<ErrorBean> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorBeanCopyWith<$Res> {
  factory $ErrorBeanCopyWith(ErrorBean value, $Res Function(ErrorBean) then) =
      _$ErrorBeanCopyWithImpl<$Res, ErrorBean>;
  @useResult
  $Res call(
      {@JsonKey(name: 'code') int? code,
      @JsonKey(name: 'message') String? message,
      @JsonKey(name: 'data') DataBean? data,
      @JsonKey(name: 'http_status') int? httpStatus});

  $DataBeanCopyWith<$Res>? get data;
}

/// @nodoc
class _$ErrorBeanCopyWithImpl<$Res, $Val extends ErrorBean>
    implements $ErrorBeanCopyWith<$Res> {
  _$ErrorBeanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? data = freezed,
    Object? httpStatus = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DataBean?,
      httpStatus: freezed == httpStatus
          ? _value.httpStatus
          : httpStatus // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DataBeanCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $DataBeanCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ErrorBeanImplCopyWith<$Res>
    implements $ErrorBeanCopyWith<$Res> {
  factory _$$ErrorBeanImplCopyWith(
          _$ErrorBeanImpl value, $Res Function(_$ErrorBeanImpl) then) =
      __$$ErrorBeanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'code') int? code,
      @JsonKey(name: 'message') String? message,
      @JsonKey(name: 'data') DataBean? data,
      @JsonKey(name: 'http_status') int? httpStatus});

  @override
  $DataBeanCopyWith<$Res>? get data;
}

/// @nodoc
class __$$ErrorBeanImplCopyWithImpl<$Res>
    extends _$ErrorBeanCopyWithImpl<$Res, _$ErrorBeanImpl>
    implements _$$ErrorBeanImplCopyWith<$Res> {
  __$$ErrorBeanImplCopyWithImpl(
      _$ErrorBeanImpl _value, $Res Function(_$ErrorBeanImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? data = freezed,
    Object? httpStatus = freezed,
  }) {
    return _then(_$ErrorBeanImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DataBean?,
      httpStatus: freezed == httpStatus
          ? _value.httpStatus
          : httpStatus // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorBeanImpl implements _ErrorBean {
  const _$ErrorBeanImpl(
      {@JsonKey(name: 'code') this.code,
      @JsonKey(name: 'message') this.message,
      @JsonKey(name: 'data') this.data,
      @JsonKey(name: 'http_status') this.httpStatus});

  factory _$ErrorBeanImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorBeanImplFromJson(json);

  @override
  @JsonKey(name: 'code')
  final int? code;
  @override
  @JsonKey(name: 'message')
  final String? message;
  @override
  @JsonKey(name: 'data')
  final DataBean? data;
  @override
  @JsonKey(name: 'http_status')
  final int? httpStatus;

  @override
  String toString() {
    return 'ErrorBean(code: $code, message: $message, data: $data, httpStatus: $httpStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorBeanImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.httpStatus, httpStatus) ||
                other.httpStatus == httpStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message, data, httpStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorBeanImplCopyWith<_$ErrorBeanImpl> get copyWith =>
      __$$ErrorBeanImplCopyWithImpl<_$ErrorBeanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorBeanImplToJson(
      this,
    );
  }
}

abstract class _ErrorBean implements ErrorBean {
  const factory _ErrorBean(
      {@JsonKey(name: 'code') final int? code,
      @JsonKey(name: 'message') final String? message,
      @JsonKey(name: 'data') final DataBean? data,
      @JsonKey(name: 'http_status') final int? httpStatus}) = _$ErrorBeanImpl;

  factory _ErrorBean.fromJson(Map<String, dynamic> json) =
      _$ErrorBeanImpl.fromJson;

  @override
  @JsonKey(name: 'code')
  int? get code;
  @override
  @JsonKey(name: 'message')
  String? get message;
  @override
  @JsonKey(name: 'data')
  DataBean? get data;
  @override
  @JsonKey(name: 'http_status')
  int? get httpStatus;
  @override
  @JsonKey(ignore: true)
  _$$ErrorBeanImplCopyWith<_$ErrorBeanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DataBean _$DataBeanFromJson(Map<String, dynamic> json) {
  return _DataBean.fromJson(json);
}

/// @nodoc
mixin _$DataBean {
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'debug')
  String? get debug => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'arguments')
  List<dynamic>? get arguments => throw _privateConstructorUsedError;
  @JsonKey(name: 'context')
  ContextBean? get context => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataBeanCopyWith<DataBean> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataBeanCopyWith<$Res> {
  factory $DataBeanCopyWith(DataBean value, $Res Function(DataBean) then) =
      _$DataBeanCopyWithImpl<$Res, DataBean>;
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'debug') String? debug,
      @JsonKey(name: 'message') String? message,
      @JsonKey(name: 'arguments') List<dynamic>? arguments,
      @JsonKey(name: 'context') ContextBean? context});

  $ContextBeanCopyWith<$Res>? get context;
}

/// @nodoc
class _$DataBeanCopyWithImpl<$Res, $Val extends DataBean>
    implements $DataBeanCopyWith<$Res> {
  _$DataBeanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? debug = freezed,
    Object? message = freezed,
    Object? arguments = freezed,
    Object? context = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      debug: freezed == debug
          ? _value.debug
          : debug // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      arguments: freezed == arguments
          ? _value.arguments
          : arguments // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as ContextBean?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ContextBeanCopyWith<$Res>? get context {
    if (_value.context == null) {
      return null;
    }

    return $ContextBeanCopyWith<$Res>(_value.context!, (value) {
      return _then(_value.copyWith(context: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DataBeanImplCopyWith<$Res>
    implements $DataBeanCopyWith<$Res> {
  factory _$$DataBeanImplCopyWith(
          _$DataBeanImpl value, $Res Function(_$DataBeanImpl) then) =
      __$$DataBeanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'debug') String? debug,
      @JsonKey(name: 'message') String? message,
      @JsonKey(name: 'arguments') List<dynamic>? arguments,
      @JsonKey(name: 'context') ContextBean? context});

  @override
  $ContextBeanCopyWith<$Res>? get context;
}

/// @nodoc
class __$$DataBeanImplCopyWithImpl<$Res>
    extends _$DataBeanCopyWithImpl<$Res, _$DataBeanImpl>
    implements _$$DataBeanImplCopyWith<$Res> {
  __$$DataBeanImplCopyWithImpl(
      _$DataBeanImpl _value, $Res Function(_$DataBeanImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? debug = freezed,
    Object? message = freezed,
    Object? arguments = freezed,
    Object? context = freezed,
  }) {
    return _then(_$DataBeanImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      debug: freezed == debug
          ? _value.debug
          : debug // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      arguments: freezed == arguments
          ? _value._arguments
          : arguments // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as ContextBean?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataBeanImpl implements _DataBean {
  const _$DataBeanImpl(
      {@JsonKey(name: 'name') this.name,
      @JsonKey(name: 'debug') this.debug,
      @JsonKey(name: 'message') this.message,
      @JsonKey(name: 'arguments') final List<dynamic>? arguments,
      @JsonKey(name: 'context') this.context})
      : _arguments = arguments;

  factory _$DataBeanImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataBeanImplFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'debug')
  final String? debug;
  @override
  @JsonKey(name: 'message')
  final String? message;
  final List<dynamic>? _arguments;
  @override
  @JsonKey(name: 'arguments')
  List<dynamic>? get arguments {
    final value = _arguments;
    if (value == null) return null;
    if (_arguments is EqualUnmodifiableListView) return _arguments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'context')
  final ContextBean? context;

  @override
  String toString() {
    return 'DataBean(name: $name, debug: $debug, message: $message, arguments: $arguments, context: $context)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataBeanImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.debug, debug) || other.debug == debug) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._arguments, _arguments) &&
            (identical(other.context, context) || other.context == context));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, debug, message,
      const DeepCollectionEquality().hash(_arguments), context);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataBeanImplCopyWith<_$DataBeanImpl> get copyWith =>
      __$$DataBeanImplCopyWithImpl<_$DataBeanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataBeanImplToJson(
      this,
    );
  }
}

abstract class _DataBean implements DataBean {
  const factory _DataBean(
      {@JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'debug') final String? debug,
      @JsonKey(name: 'message') final String? message,
      @JsonKey(name: 'arguments') final List<dynamic>? arguments,
      @JsonKey(name: 'context') final ContextBean? context}) = _$DataBeanImpl;

  factory _DataBean.fromJson(Map<String, dynamic> json) =
      _$DataBeanImpl.fromJson;

  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'debug')
  String? get debug;
  @override
  @JsonKey(name: 'message')
  String? get message;
  @override
  @JsonKey(name: 'arguments')
  List<dynamic>? get arguments;
  @override
  @JsonKey(name: 'context')
  ContextBean? get context;
  @override
  @JsonKey(ignore: true)
  _$$DataBeanImplCopyWith<_$DataBeanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContextBean _$ContextBeanFromJson(Map<String, dynamic> json) {
  return _ContextBean.fromJson(json);
}

/// @nodoc
mixin _$ContextBean {
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContextBeanCopyWith<$Res> {
  factory $ContextBeanCopyWith(
          ContextBean value, $Res Function(ContextBean) then) =
      _$ContextBeanCopyWithImpl<$Res, ContextBean>;
}

/// @nodoc
class _$ContextBeanCopyWithImpl<$Res, $Val extends ContextBean>
    implements $ContextBeanCopyWith<$Res> {
  _$ContextBeanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ContextBeanImplCopyWith<$Res> {
  factory _$$ContextBeanImplCopyWith(
          _$ContextBeanImpl value, $Res Function(_$ContextBeanImpl) then) =
      __$$ContextBeanImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ContextBeanImplCopyWithImpl<$Res>
    extends _$ContextBeanCopyWithImpl<$Res, _$ContextBeanImpl>
    implements _$$ContextBeanImplCopyWith<$Res> {
  __$$ContextBeanImplCopyWithImpl(
      _$ContextBeanImpl _value, $Res Function(_$ContextBeanImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$ContextBeanImpl implements _ContextBean {
  const _$ContextBeanImpl();

  factory _$ContextBeanImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContextBeanImplFromJson(json);

  @override
  String toString() {
    return 'ContextBean()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ContextBeanImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return _$$ContextBeanImplToJson(
      this,
    );
  }
}

abstract class _ContextBean implements ContextBean {
  const factory _ContextBean() = _$ContextBeanImpl;

  factory _ContextBean.fromJson(Map<String, dynamic> json) =
      _$ContextBeanImpl.fromJson;
}
