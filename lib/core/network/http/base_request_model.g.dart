// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRequestModel<T> _$BaseRequestModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseRequestModel<T>(
      correlationId: json['correlationId'] as String?,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

const _$BaseRequestModelFieldMap = <String, String>{
  'data': 'data',
  'correlationId': 'correlationId',
};

// ignore: unused_element
abstract class _$BaseRequestModelPerFieldToJson {
  // ignore: unused_element
  static Object? data<T>(
    T? instance,
    Object? Function(T value) toJsonT,
  ) =>
      _$nullableGenericToJson(instance, toJsonT);
  // ignore: unused_element
  static Object? correlationId<T>(
    String? instance,
    Object? Function(T value) toJsonT,
  ) =>
      instance;
}

Map<String, dynamic> _$BaseRequestModelToJson<T>(
  BaseRequestModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'correlationId': instance.correlationId,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
