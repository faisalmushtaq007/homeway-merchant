// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreviewData _$PreviewDataFromJson(Map<String, dynamic> json) => PreviewData(
      description: json['description'] as String?,
      image: json['image'] == null
          ? null
          : PreviewDataImage.fromJson(json['image'] as Map<String, dynamic>),
      link: json['link'] as String?,
      title: json['title'] as String?,
    );

const _$PreviewDataFieldMap = <String, String>{
  'description': 'description',
  'image': 'image',
  'link': 'link',
  'title': 'title',
};

// ignore: unused_element
abstract class _$PreviewDataPerFieldToJson {
  // ignore: unused_element
  static Object? description(String? instance) => instance;
  // ignore: unused_element
  static Object? image(PreviewDataImage? instance) => instance?.toJson();
  // ignore: unused_element
  static Object? link(String? instance) => instance;
  // ignore: unused_element
  static Object? title(String? instance) => instance;
}

Map<String, dynamic> _$PreviewDataToJson(PreviewData instance) =>
    <String, dynamic>{
      'description': instance.description,
      'image': instance.image?.toJson(),
      'link': instance.link,
      'title': instance.title,
    };

PreviewDataImage _$PreviewDataImageFromJson(Map<String, dynamic> json) =>
    PreviewDataImage(
      height: (json['height'] as num).toDouble(),
      url: json['url'] as String,
      width: (json['width'] as num).toDouble(),
    );

const _$PreviewDataImageFieldMap = <String, String>{
  'height': 'height',
  'url': 'url',
  'width': 'width',
};

// ignore: unused_element
abstract class _$PreviewDataImagePerFieldToJson {
  // ignore: unused_element
  static Object? height(double instance) => instance;
  // ignore: unused_element
  static Object? url(String instance) => instance;
  // ignore: unused_element
  static Object? width(double instance) => instance;
}

Map<String, dynamic> _$PreviewDataImageToJson(PreviewDataImage instance) =>
    <String, dynamic>{
      'height': instance.height,
      'url': instance.url,
      'width': instance.width,
    };
