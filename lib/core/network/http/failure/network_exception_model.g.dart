// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_exception_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NetworkExceptionModelImpl _$$NetworkExceptionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NetworkExceptionModelImpl(
      jsonrpc: json['jsonrpc'] as String?,
      id: json['id'],
      error: json['error'] == null
          ? null
          : ErrorBean.fromJson(json['error'] as Map<String, dynamic>),
    );

const _$$NetworkExceptionModelImplFieldMap = <String, String>{
  'jsonrpc': 'jsonrpc',
  'id': 'id',
  'error': 'error',
};

// ignore: unused_element
abstract class _$$NetworkExceptionModelImplPerFieldToJson {
  // ignore: unused_element
  static Object? jsonrpc(String? instance) => instance;
  // ignore: unused_element
  static Object? id(dynamic instance) => instance;
  // ignore: unused_element
  static Object? error(ErrorBean? instance) => instance?.toJson();
}

Map<String, dynamic> _$$NetworkExceptionModelImplToJson(
        _$NetworkExceptionModelImpl instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'error': instance.error?.toJson(),
    };

_$ErrorBeanImpl _$$ErrorBeanImplFromJson(Map<String, dynamic> json) =>
    _$ErrorBeanImpl(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : DataBean.fromJson(json['data'] as Map<String, dynamic>),
      httpStatus: json['http_status'] as int?,
    );

const _$$ErrorBeanImplFieldMap = <String, String>{
  'code': 'code',
  'message': 'message',
  'data': 'data',
  'httpStatus': 'http_status',
};

// ignore: unused_element
abstract class _$$ErrorBeanImplPerFieldToJson {
  // ignore: unused_element
  static Object? code(int? instance) => instance;
  // ignore: unused_element
  static Object? message(String? instance) => instance;
  // ignore: unused_element
  static Object? data(DataBean? instance) => instance?.toJson();
  // ignore: unused_element
  static Object? httpStatus(int? instance) => instance;
}

Map<String, dynamic> _$$ErrorBeanImplToJson(_$ErrorBeanImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data?.toJson(),
      'http_status': instance.httpStatus,
    };

_$DataBeanImpl _$$DataBeanImplFromJson(Map<String, dynamic> json) =>
    _$DataBeanImpl(
      name: json['name'] as String?,
      debug: json['debug'] as String?,
      message: json['message'] as String?,
      arguments: json['arguments'] as List<dynamic>?,
      context: json['context'] == null
          ? null
          : ContextBean.fromJson(json['context'] as Map<String, dynamic>),
    );

const _$$DataBeanImplFieldMap = <String, String>{
  'name': 'name',
  'debug': 'debug',
  'message': 'message',
  'arguments': 'arguments',
  'context': 'context',
};

// ignore: unused_element
abstract class _$$DataBeanImplPerFieldToJson {
  // ignore: unused_element
  static Object? name(String? instance) => instance;
  // ignore: unused_element
  static Object? debug(String? instance) => instance;
  // ignore: unused_element
  static Object? message(String? instance) => instance;
  // ignore: unused_element
  static Object? arguments(List<dynamic>? instance) => instance;
  // ignore: unused_element
  static Object? context(ContextBean? instance) => instance?.toJson();
}

Map<String, dynamic> _$$DataBeanImplToJson(_$DataBeanImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'debug': instance.debug,
      'message': instance.message,
      'arguments': instance.arguments,
      'context': instance.context?.toJson(),
    };

_$ContextBeanImpl _$$ContextBeanImplFromJson(Map<String, dynamic> json) =>
    _$ContextBeanImpl();

const _$$ContextBeanImplFieldMap = <String, String>{};

// ignore: unused_element
abstract class _$$ContextBeanImplPerFieldToJson {}

Map<String, dynamic> _$$ContextBeanImplToJson(_$ContextBeanImpl instance) =>
    <String, dynamic>{};
