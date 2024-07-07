// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartialText _$PartialTextFromJson(Map<String, dynamic> json) => PartialText(
      metadata: json['metadata'] as Map<String, dynamic>?,
      previewData: json['previewData'] == null
          ? null
          : PreviewData.fromJson(json['previewData'] as Map<String, dynamic>),
      repliedMessage: json['repliedMessage'] == null
          ? null
          : Message.fromJson(json['repliedMessage'] as Map<String, dynamic>),
      text: json['text'] as String,
      read: json['read'] as String? ?? '',
    );

const _$PartialTextFieldMap = <String, String>{
  'metadata': 'metadata',
  'previewData': 'previewData',
  'repliedMessage': 'repliedMessage',
  'text': 'text',
  'read': 'read',
};

// ignore: unused_element
abstract class _$PartialTextPerFieldToJson {
  // ignore: unused_element
  static Object? metadata(Map<String, dynamic>? instance) => instance;
  // ignore: unused_element
  static Object? previewData(PreviewData? instance) => instance?.toJson();
  // ignore: unused_element
  static Object? repliedMessage(Message? instance) => instance?.toJson();
  // ignore: unused_element
  static Object? text(String instance) => instance;
  // ignore: unused_element
  static Object? read(String instance) => instance;
}

Map<String, dynamic> _$PartialTextToJson(PartialText instance) =>
    <String, dynamic>{
      'metadata': instance.metadata,
      'previewData': instance.previewData?.toJson(),
      'repliedMessage': instance.repliedMessage?.toJson(),
      'text': instance.text,
      'read': instance.read,
    };
