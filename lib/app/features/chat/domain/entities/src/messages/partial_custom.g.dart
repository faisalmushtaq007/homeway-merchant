// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_custom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartialCustom _$PartialCustomFromJson(Map<String, dynamic> json) =>
    PartialCustom(
      metadata: json['metadata'] as Map<String, dynamic>?,
      repliedMessage: json['repliedMessage'] == null
          ? null
          : Message.fromJson(json['repliedMessage'] as Map<String, dynamic>),
      read: json['read'] as String? ?? '',
    );

const _$PartialCustomFieldMap = <String, String>{
  'metadata': 'metadata',
  'repliedMessage': 'repliedMessage',
  'read': 'read',
};

// ignore: unused_element
abstract class _$PartialCustomPerFieldToJson {
  // ignore: unused_element
  static Object? metadata(Map<String, dynamic>? instance) => instance;
  // ignore: unused_element
  static Object? repliedMessage(Message? instance) => instance?.toJson();
  // ignore: unused_element
  static Object? read(String instance) => instance;
}

Map<String, dynamic> _$PartialCustomToJson(PartialCustom instance) =>
    <String, dynamic>{
      'metadata': instance.metadata,
      'repliedMessage': instance.repliedMessage?.toJson(),
      'read': instance.read,
    };
