// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartialImage _$PartialImageFromJson(Map<String, dynamic> json) => PartialImage(
      height: (json['height'] as num?)?.toDouble(),
      metadata: json['metadata'] as Map<String, dynamic>?,
      name: json['name'] as String,
      repliedMessage: json['repliedMessage'] == null
          ? null
          : Message.fromJson(json['repliedMessage'] as Map<String, dynamic>),
      size: json['size'] as num,
      uri: json['uri'] as String,
      width: (json['width'] as num?)?.toDouble(),
      read: json['read'] as String? ?? '',
    );

const _$PartialImageFieldMap = <String, String>{
  'height': 'height',
  'metadata': 'metadata',
  'name': 'name',
  'repliedMessage': 'repliedMessage',
  'size': 'size',
  'uri': 'uri',
  'width': 'width',
  'read': 'read',
};

// ignore: unused_element
abstract class _$PartialImagePerFieldToJson {
  // ignore: unused_element
  static Object? height(double? instance) => instance;
  // ignore: unused_element
  static Object? metadata(Map<String, dynamic>? instance) => instance;
  // ignore: unused_element
  static Object? name(String instance) => instance;
  // ignore: unused_element
  static Object? repliedMessage(Message? instance) => instance?.toJson();
  // ignore: unused_element
  static Object? size(num instance) => instance;
  // ignore: unused_element
  static Object? uri(String instance) => instance;
  // ignore: unused_element
  static Object? width(double? instance) => instance;
  // ignore: unused_element
  static Object? read(String instance) => instance;
}

Map<String, dynamic> _$PartialImageToJson(PartialImage instance) =>
    <String, dynamic>{
      'height': instance.height,
      'metadata': instance.metadata,
      'name': instance.name,
      'repliedMessage': instance.repliedMessage?.toJson(),
      'size': instance.size,
      'uri': instance.uri,
      'width': instance.width,
      'read': instance.read,
    };
