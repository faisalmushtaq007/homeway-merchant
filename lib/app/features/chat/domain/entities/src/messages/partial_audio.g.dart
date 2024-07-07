// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_audio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartialAudio _$PartialAudioFromJson(Map<String, dynamic> json) => PartialAudio(
      duration: Duration(microseconds: json['duration'] as int),
      metadata: json['metadata'] as Map<String, dynamic>?,
      mimeType: json['mimeType'] as String?,
      name: json['name'] as String,
      repliedMessage: json['repliedMessage'] == null
          ? null
          : Message.fromJson(json['repliedMessage'] as Map<String, dynamic>),
      size: json['size'] as num,
      uri: json['uri'] as String,
      waveForm: (json['waveForm'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      read: json['read'] as String? ?? '',
    );

const _$PartialAudioFieldMap = <String, String>{
  'duration': 'duration',
  'metadata': 'metadata',
  'mimeType': 'mimeType',
  'name': 'name',
  'repliedMessage': 'repliedMessage',
  'size': 'size',
  'uri': 'uri',
  'waveForm': 'waveForm',
  'read': 'read',
};

// ignore: unused_element
abstract class _$PartialAudioPerFieldToJson {
  // ignore: unused_element
  static Object? duration(Duration instance) => instance.inMicroseconds;
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
  static Object? waveForm(List<double>? instance) => instance;
  // ignore: unused_element
  static Object? read(String instance) => instance;
}

Map<String, dynamic> _$PartialAudioToJson(PartialAudio instance) =>
    <String, dynamic>{
      'duration': instance.duration.inMicroseconds,
      'metadata': instance.metadata,
      'mimeType': instance.mimeType,
      'name': instance.name,
      'repliedMessage': instance.repliedMessage?.toJson(),
      'size': instance.size,
      'uri': instance.uri,
      'waveForm': instance.waveForm,
      'read': instance.read,
    };
