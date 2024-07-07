// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatUser _$ChatUserFromJson(Map<String, dynamic> json) => ChatUser(
      createdAt: json['createdAt'] as int?,
      firstName: json['firstName'] as String?,
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String?,
      lastName: json['lastName'] as String?,
      lastSeen: json['lastSeen'] as int?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      role: $enumDecodeNullable(_$RoleEnumMap, json['role']),
      updatedAt: json['updatedAt'] as int?,
      isOnline: json['isOnline'] as bool,
      pushToken: json['pushToken'] as String,
    );

const _$ChatUserFieldMap = <String, String>{
  'createdAt': 'createdAt',
  'firstName': 'firstName',
  'id': 'id',
  'imageUrl': 'imageUrl',
  'lastName': 'lastName',
  'lastSeen': 'lastSeen',
  'metadata': 'metadata',
  'role': 'role',
  'updatedAt': 'updatedAt',
  'isOnline': 'isOnline',
  'pushToken': 'pushToken',
};

// ignore: unused_element
abstract class _$ChatUserPerFieldToJson {
  // ignore: unused_element
  static Object? createdAt(int? instance) => instance;
  // ignore: unused_element
  static Object? firstName(String? instance) => instance;
  // ignore: unused_element
  static Object? id(String instance) => instance;
  // ignore: unused_element
  static Object? imageUrl(String? instance) => instance;
  // ignore: unused_element
  static Object? lastName(String? instance) => instance;
  // ignore: unused_element
  static Object? lastSeen(int? instance) => instance;
  // ignore: unused_element
  static Object? metadata(Map<String, dynamic>? instance) => instance;
  // ignore: unused_element
  static Object? role(Role? instance) => _$RoleEnumMap[instance];
  // ignore: unused_element
  static Object? updatedAt(int? instance) => instance;
  // ignore: unused_element
  static Object? isOnline(bool instance) => instance;
  // ignore: unused_element
  static Object? pushToken(String instance) => instance;
}

Map<String, dynamic> _$ChatUserToJson(ChatUser instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'firstName': instance.firstName,
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'lastName': instance.lastName,
      'lastSeen': instance.lastSeen,
      'metadata': instance.metadata,
      'role': _$RoleEnumMap[instance.role],
      'updatedAt': instance.updatedAt,
      'isOnline': instance.isOnline,
      'pushToken': instance.pushToken,
    };

const _$RoleEnumMap = {
  Role.admin: 'admin',
  Role.agent: 'agent',
  Role.moderator: 'moderator',
  Role.user: 'user',
};
