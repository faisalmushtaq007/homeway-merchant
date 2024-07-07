// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
      createdAt: json['createdAt'] as int?,
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String?,
      lastMessages: (json['lastMessages'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
      name: json['name'] as String?,
      type: $enumDecodeNullable(_$RoomTypeEnumMap, json['type']),
      updatedAt: json['updatedAt'] as int?,
      users: (json['users'] as List<dynamic>)
          .map((e) => ChatUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

const _$RoomFieldMap = <String, String>{
  'createdAt': 'createdAt',
  'id': 'id',
  'imageUrl': 'imageUrl',
  'lastMessages': 'lastMessages',
  'metadata': 'metadata',
  'name': 'name',
  'type': 'type',
  'updatedAt': 'updatedAt',
  'users': 'users',
};

// ignore: unused_element
abstract class _$RoomPerFieldToJson {
  // ignore: unused_element
  static Object? createdAt(int? instance) => instance;
  // ignore: unused_element
  static Object? id(String instance) => instance;
  // ignore: unused_element
  static Object? imageUrl(String? instance) => instance;
  // ignore: unused_element
  static Object? lastMessages(List<Message>? instance) =>
      instance?.map((e) => e.toJson()).toList();
  // ignore: unused_element
  static Object? metadata(Map<String, dynamic>? instance) => instance;
  // ignore: unused_element
  static Object? name(String? instance) => instance;
  // ignore: unused_element
  static Object? type(RoomType? instance) => _$RoomTypeEnumMap[instance];
  // ignore: unused_element
  static Object? updatedAt(int? instance) => instance;
  // ignore: unused_element
  static Object? users(List<ChatUser> instance) =>
      instance.map((e) => e.toJson()).toList();
}

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'lastMessages': instance.lastMessages?.map((e) => e.toJson()).toList(),
      'metadata': instance.metadata,
      'name': instance.name,
      'type': _$RoomTypeEnumMap[instance.type],
      'updatedAt': instance.updatedAt,
      'users': instance.users.map((e) => e.toJson()).toList(),
    };

const _$RoomTypeEnumMap = {
  RoomType.channel: 'channel',
  RoomType.direct: 'direct',
  RoomType.group: 'group',
};
