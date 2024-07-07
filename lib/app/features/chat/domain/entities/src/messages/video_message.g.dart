// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoMessage _$VideoMessageFromJson(Map<String, dynamic> json) => VideoMessage(
      author: ChatUser.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as int?,
      height: (json['height'] as num?)?.toDouble(),
      id: json['id'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
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
      width: (json['width'] as num?)?.toDouble(),
      read: json['read'] as String,
    );

const _$VideoMessageFieldMap = <String, String>{
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
  'height': 'height',
  'name': 'name',
  'size': 'size',
  'uri': 'uri',
  'width': 'width',
  'read': 'read',
};

// ignore: unused_element
abstract class _$VideoMessagePerFieldToJson {
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
  static Object? height(double? instance) => instance;
  // ignore: unused_element
  static Object? name(String instance) => instance;
  // ignore: unused_element
  static Object? size(num instance) => instance;
  // ignore: unused_element
  static Object? uri(String instance) => instance;
  // ignore: unused_element
  static Object? width(double? instance) => instance;
  // ignore: unused_element
  static Object? read(String instance) => instance;
}

Map<String, dynamic> _$VideoMessageToJson(VideoMessage instance) =>
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
      'height': instance.height,
      'name': instance.name,
      'size': instance.size,
      'uri': instance.uri,
      'width': instance.width,
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
