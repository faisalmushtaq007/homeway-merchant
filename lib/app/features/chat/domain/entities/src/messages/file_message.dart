import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'package:homemakers_merchant/app/features/chat/domain/entities/src/message.dart';
import 'package:homemakers_merchant/app/features/chat/domain/entities/src/chat_user.dart'
    show ChatUser;
import 'package:homemakers_merchant/app/features/chat/domain/entities/src/messages/partial_file.dart';

part 'file_message.g.dart';

/// A class that represents file message.
@JsonSerializable()
@immutable
abstract class FileMessage extends Message {
  /// Creates a file message.
  const FileMessage._({
    required super.author,
    super.createdAt,
    required super.id,
    this.isLoading,
    super.metadata,
    this.mimeType,
    required this.name,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    required this.size,
    super.status,
    MessageType? type,
    super.updatedAt,
    required this.uri,
    this.read = '',
  }) : super(type: type ?? MessageType.file);

  const factory FileMessage({
    required ChatUser author,
    int? createdAt,
    required String id,
    bool? isLoading,
    Map<String, dynamic>? metadata,
    String? mimeType,
    required String name,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    required num size,
    Status? status,
    MessageType? type,
    int? updatedAt,
    required String uri,
    String read,
  }) = _FileMessage;

  /// Creates a file message from a map (decoded JSON).
  factory FileMessage.fromJson(Map<String, dynamic> json) =>
      _$FileMessageFromJson(json);

  /// Creates a full file message from a partial one.
  factory FileMessage.fromPartial({
    required ChatUser author,
    int? createdAt,
    required String id,
    bool? isLoading,
    required PartialFile partialFile,
    String? remoteId,
    String? roomId,
    bool? showStatus,
    Status? status,
    int? updatedAt,
    String? read,
  }) =>
      _FileMessage(
        author: author,
        createdAt: createdAt,
        id: id,
        isLoading: isLoading,
        metadata: partialFile.metadata,
        mimeType: partialFile.mimeType,
        name: partialFile.name,
        remoteId: remoteId,
        repliedMessage: partialFile.repliedMessage,
        roomId: roomId,
        showStatus: showStatus,
        size: partialFile.size,
        status: status,
        type: MessageType.file,
        updatedAt: updatedAt,
        uri: partialFile.uri,
        read: read ?? '',
      );

  /// Specify whether the message content is currently being loaded.
  final bool? isLoading;

  /// Media type.
  final String? mimeType;

  /// The name of the file.
  final String name;

  /// Size of the file in bytes.
  final num size;

  /// The file source (either a remote URL or a local resource).
  final String uri;

  /// Read
  final String read;

  /// Equatable props.
  @override
  List<Object?> get props => [
        author,
        createdAt,
        id,
        isLoading,
        metadata,
        mimeType,
        name,
        remoteId,
        repliedMessage,
        roomId,
        showStatus,
        size,
        status,
        updatedAt,
        uri,
        read,
      ];

  @override
  Message copyWith({
    ChatUser? author,
    int? createdAt,
    String? id,
    bool? isLoading,
    Map<String, dynamic>? metadata,
    String? mimeType,
    String? name,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    num? size,
    Status? status,
    int? updatedAt,
    String? uri,
    String? read,
  });

  /// Converts a file message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$FileMessageToJson(this);
}

/// A utility class to enable better copyWith.
class _FileMessage extends FileMessage {
  const _FileMessage({
    required super.author,
    super.createdAt,
    required super.id,
    super.isLoading,
    super.metadata,
    super.mimeType,
    required super.name,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    required super.size,
    super.status,
    super.type,
    super.updatedAt,
    required super.uri,
    super.read,
  }) : super._();

  @override
  Message copyWith({
    ChatUser? author,
    dynamic createdAt = _Unset,
    dynamic height = _Unset,
    String? id,
    dynamic isLoading = _Unset,
    dynamic metadata = _Unset,
    dynamic mimeType = _Unset,
    String? name,
    dynamic remoteId = _Unset,
    dynamic repliedMessage = _Unset,
    dynamic roomId,
    dynamic showStatus = _Unset,
    num? size,
    dynamic status = _Unset,
    dynamic updatedAt = _Unset,
    String? uri,
    dynamic width = _Unset,
    dynamic read = _Unset,
  }) =>
      _FileMessage(
        author: author ?? this.author,
        createdAt: createdAt == _Unset ? this.createdAt : createdAt as int?,
        id: id ?? this.id,
        isLoading: isLoading == _Unset ? this.isLoading : isLoading as bool?,
        metadata: metadata == _Unset
            ? this.metadata
            : metadata as Map<String, dynamic>?,
        mimeType: mimeType == _Unset ? this.mimeType : mimeType as String?,
        name: name ?? this.name,
        remoteId: remoteId == _Unset ? this.remoteId : remoteId as String?,
        repliedMessage: repliedMessage == _Unset
            ? this.repliedMessage
            : repliedMessage as Message?,
        roomId: roomId == _Unset ? this.roomId : roomId as String?,
        showStatus:
            showStatus == _Unset ? this.showStatus : showStatus as bool?,
        size: size ?? this.size,
        status: status == _Unset ? this.status : status as Status?,
        updatedAt: updatedAt == _Unset ? this.updatedAt : updatedAt as int?,
        uri: uri ?? this.uri,
        read: read == _Unset ? this.read : read as String,
      );
}

class _Unset {}
