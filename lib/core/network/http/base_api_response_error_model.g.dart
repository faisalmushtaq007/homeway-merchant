// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_api_response_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseApiResponseErrorModel _$BaseApiResponseErrorModelFromJson(
        Map<String, dynamic> json) =>
    BaseApiResponseErrorModel(
      correlationId: json['correlationId'] as String?,
      error: json['error'] == null
          ? null
          : BaseResponseError.fromJson(json['error'] as Map<String, dynamic>),
      success: json['success'] as int?,
    );

const _$BaseApiResponseErrorModelFieldMap = <String, String>{
  'correlationId': 'correlationId',
  'error': 'error',
  'success': 'success',
};

// ignore: unused_element
abstract class _$BaseApiResponseErrorModelPerFieldToJson {
  // ignore: unused_element
  static Object? correlationId(String? instance) => instance;
  // ignore: unused_element
  static Object? error(BaseResponseError? instance) => instance?.toJson();
  // ignore: unused_element
  static Object? success(int? instance) => instance;
}

Map<String, dynamic> _$BaseApiResponseErrorModelToJson(
        BaseApiResponseErrorModel instance) =>
    <String, dynamic>{
      'correlationId': instance.correlationId,
      'error': instance.error?.toJson(),
      'success': instance.success,
    };

BaseResponseError _$BaseResponseErrorFromJson(Map<String, dynamic> json) =>
    BaseResponseError(
      code: json['code'] as String,
      message: json['message'] as String,
    );

const _$BaseResponseErrorFieldMap = <String, String>{
  'code': 'code',
  'message': 'message',
};

// ignore: unused_element
abstract class _$BaseResponseErrorPerFieldToJson {
  // ignore: unused_element
  static Object? code(String instance) => instance;
  // ignore: unused_element
  static Object? message(String instance) => instance;
}

Map<String, dynamic> _$BaseResponseErrorToJson(BaseResponseError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
