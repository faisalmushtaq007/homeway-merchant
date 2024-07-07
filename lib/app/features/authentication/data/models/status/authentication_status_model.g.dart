// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationStatusModel _$AuthenticationStatusModelFromJson(
        Map<String, dynamic> json) =>
    AuthenticationStatusModel(
      status: json['status'] as int,
      uid: json['uid'] as int,
    );

const _$AuthenticationStatusModelFieldMap = <String, String>{
  'status': 'status',
  'uid': 'uid',
};

// ignore: unused_element
abstract class _$AuthenticationStatusModelPerFieldToJson {
  // ignore: unused_element
  static Object? status(int instance) => instance;
  // ignore: unused_element
  static Object? uid(int instance) => instance;
}

Map<String, dynamic> _$AuthenticationStatusModelToJson(
        AuthenticationStatusModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'uid': instance.uid,
    };
