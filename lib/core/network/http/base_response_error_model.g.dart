// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseErrorModel _$BaseResponseErrorModelFromJson(
        Map<String, dynamic> json) =>
    BaseResponseErrorModel(
      status: json['status'],
      message: json['message'] as String?,
      error: json['error'],
      code: json['code'] as int?,
    );

const _$BaseResponseErrorModelFieldMap = <String, String>{
  'status': 'status',
  'message': 'message',
  'error': 'error',
  'code': 'code',
};

// ignore: unused_element
abstract class _$BaseResponseErrorModelPerFieldToJson {
  // ignore: unused_element
  static Object? status(dynamic instance) => instance;
  // ignore: unused_element
  static Object? message(String? instance) => instance;
  // ignore: unused_element
  static Object? error(dynamic instance) => instance;
  // ignore: unused_element
  static Object? code(int? instance) => instance;
}

Map<String, dynamic> _$BaseResponseErrorModelToJson(
        BaseResponseErrorModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'error': instance.error,
      'code': instance.code,
    };
