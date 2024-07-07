// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unsupported_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnsupportedMessage _$UnsupportedMessageFromJson(Map<String, dynamic> json) =>
    UnsupportedMessage(
      author: ChatUser.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as int?,
      id: json['id'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
      remoteId: json['remoteId'] as String?,
      repliedMessage: json['repliedMessage'] == null
          ? null
          : Message.fromJson(json['repliedMessage'] as Map<String, dynamic>),
      roomId: json['roomId'] as String?,
      showStatus: json['showStatus'] as bool?,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']),
      updatedAt: json['updatedAt'] as int?,
      read: json['read'] as String,
    );

const _$UnsupportedMessageFieldMap = <String, String>{
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
  'read': 'read',
};

// ignore: unused_element
abstract class _$UnsupportedMessagePerFieldToJson {
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
  static Object? read(String instance) => instance;
}

Map<String, dynamic> _$UnsupportedMessageToJson(UnsupportedMessage instance) =>
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
