// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartialFile _$PartialFileFromJson(Map<String, dynamic> json) => PartialFile(
      metadata: json['metadata'] as Map<String, dynamic>?,
      mimeType: json['mimeType'] as String?,
      name: json['name'] as String,
      repliedMessage: json['repliedMessage'] == null
          ? null
          : Message.fromJson(json['repliedMessage'] as Map<String, dynamic>),
      size: json['size'] as num,
      uri: json['uri'] as String,
      read: json['read'] as String? ?? '',
    );

const _$PartialFileFieldMap = <String, String>{
  'metadata': 'metadata',
  'mimeType': 'mimeType',
  'name': 'name',
  'repliedMessage': 'repliedMessage',
  'size': 'size',
  'uri': 'uri',
  'read': 'read',
};

// ignore: unused_element
abstract class _$PartialFilePerFieldToJson {
  // ignore: unused_element
  static Object? metadata(Map<String, dynamic>? instance) => instance;
  // ignore: unused_element
  static Object? mimeType(String? instance) => instance;
  // ignore: unused_element
  static Object? name(String instance) => instance;
  // ignore: unused_element
  static Object? repliedMessage(Message? instance) => instance?.toJson();
  // ignore: unused_element
  static Object? size(num instance) => instance;
  // ignore: unused_element
  static Object? uri(String instance) => instance;
  // ignore: unused_element
  static Object? read(String instance) => instance;
}

Map<String, dynamic> _$PartialFileToJson(PartialFile instance) =>
    <String, dynamic>{
      'metadata': instance.metadata,
      'mimeType': instance.mimeType,
      'name': instance.name,
      'repliedMessage': instance.repliedMessage?.toJson(),
      'size': instance.size,
      'uri': instance.uri,
      'read': instance.read,
    };
