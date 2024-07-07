// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseModel _$BaseResponseModelFromJson(Map<String, dynamic> json) =>
    BaseResponseModel(
      data: json['data'],
      success: json['success'] as int? ?? 0,
      correlationId: json['correlationId'] as String?,
    );

const _$BaseResponseModelFieldMap = <String, String>{
  'data': 'data',
  'success': 'success',
  'correlationId': 'correlationId',
};

// ignore: unused_element
abstract class _$BaseResponseModelPerFieldToJson {
  // ignore: unused_element
  static Object? data(dynamic instance) => instance;
  // ignore: unused_element
  static Object? success(int? instance) => instance;
  // ignore: unused_element
  static Object? correlationId(String? instance) => instance;
}

Map<String, dynamic> _$BaseResponseModelToJson(BaseResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'success': instance.success,
      'correlationId': instance.correlationId,
    };
