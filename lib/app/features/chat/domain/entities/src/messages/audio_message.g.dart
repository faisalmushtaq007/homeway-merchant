// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioMessage _$AudioMessageFromJson(Map<String, dynamic> json) => AudioMessage(
      author: ChatUser.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as int?,
      duration: Duration(microseconds: json['duration'] as int),
      id: json['id'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
      mimeType: json['mimeType'] as String?,
      name: json['name'] as String,
      remoteId: json['remoteId'] as String?,
      repliedMessage: json['repliedMessage'] == null
          ? null
          : Message.fromJson(json['repliedMessage'] as Map<String, dynamic>),
      roomId: json['roomId'] as String?,
      showStatus: json['showStatus'] as bool?,
      size: json['size'] as num,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']),
      updatedAt: json['updatedAt'] as int?,
      uri: json['uri'] as String,
      waveForm: (json['waveForm'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      read: json['read'] as String,
    );

const _$AudioMessageFieldMap = <String, String>{
  'author': 'author',
  'createdAt': 'createdAt',
  'id': 'id',
  'metadata': 'metadata',
  'remoteId': 'remoteId',
  'repliedMessage': 'repliedMessage',
  'roomId': 'roomId',
  'showStatus': 'showStatus',
  'status': 'status',
  'type': 'type',
  'updatedAt': 'updatedAt',
  'duration': 'duration',
  'mimeType': 'mimeType',
  'name': 'name',
  'size': 'size',
  'uri': 'uri',
  'waveForm': 'waveForm',
  'read': 'read',
};

// ignore: unused_element
abstract class _$AudioMessagePerFieldToJson {
  // ignore: unused_element
  static Object? author(ChatUser instance) => instance.toJson();
  // ignore: unused_element
  static Object? createdAt(int? instance) => instance;
  // ignore: unused_element
  static Object? id(String instance) => instance;
  // ignore: unused_element
  static Object? metadata(Map<String, dynamic>? instance) => instance;
  // ignore: unused_element
  static Object? remoteId(String? instance) => instance;
  // ignore: unused_element
  static Object? repliedMessage(Message? instance) => instance?.toJson();
  // ignore: unused_element
  static Object? roomId(String? instance) => instance;
  // ignore: unused_element
  static Object? showStatus(bool? instance) => instance;
  // ignore: unused_element
  static Object? status(Status? instance) => _$StatusEnumMap[instance];
  // ignore: unused_element
  static Object? type(MessageType instance) => _$MessageTypeEnumMap[instance]!;
  // ignore: unused_element
  static Object? updatedAt(int? instance) => instance;
  // ignore: unused_element
  static Object? duration(Duration instance) => instance.inMicroseconds;
  // ignore: unused_element
  static Object? mimeType(String? instance) => instance;
  // ignore: unused_element
  static Object? name(String instance) => instance;
  // ignore: unused_element
  static Object? size(num instance) => instance;
  // ignore: unused_element
  static Object? uri(String instance) => instance;
  // ignore: unused_element
  static Object? waveForm(List<double>? instance) => instance;
  // ignore: unused_element
  static Object? read(String instance) => instance;
}

Map<String, dynamic> _$AudioMessageToJson(AudioMessage instance) =>
    <String, dynamic>{
      'author': instance.author.toJson(),
      'createdAt': instance.createdAt,
      'id': instance.id,
      'metadata': instance.metadata,
      'remoteId': instance.remoteId,
      'repliedMessage': instance.repliedMessage?.toJson(),
      'roomId': instance.roomId,
      'showStatus': instance.showStatus,
      'status': _$StatusEnumMap[instance.status],
      'type': _$MessageTypeEnumMap[instance.type]!,
      'updatedAt': instance.updatedAt,
      'duration': instance.duration.inMicroseconds,
      'mimeType': instance.mimeType,
      'name': instance.name,
      'size': instance.size,
      'uri': instance.uri,
      'waveForm': instance.waveForm,
      'read': instance.read,
    };

const _$StatusEnumMap = {
  Status.delivered: 'delivered',
  Status.error: 'error',
  Status.seen: 'seen',
  Status.sending: 'sending',
  Status.sent: 'sent',
};

const _$MessageTypeEnumMap = {
  MessageType.audio: 'audio',
  MessageType.custom: 'custom',
  MessageType.file: 'file',
  MessageType.image: 'image',
  MessageType.system: 'system',
  MessageType.text: 'text',
  MessageType.unsupported: 'unsupported',
  MessageType.video: 'video',
};
