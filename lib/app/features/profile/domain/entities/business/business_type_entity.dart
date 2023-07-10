import 'package:flutter/widgets.dart';

class BusinessTypeEntity {
  const BusinessTypeEntity({
    this.id = -1,
    required this.businessTypeId,
    required this.businessTypeName,
    this.localAssetPath = '',
    this.remoteAssetPath,
    this.metaData,
    this.localAssetWidget,
    this.remoteAssetWidget,
  });

  factory BusinessTypeEntity.fromMap(Map<String, dynamic> map) {
    return BusinessTypeEntity(
      id: map['id'] as int,
      businessTypeId: map['businessTypeId'] as String,
      businessTypeName: map['businessTypeName'] as String,
      localAssetPath: map['localAssetPath'] as String,
      remoteAssetPath: map['remoteAssetPath'] as String,
      metaData: map['metaData'] as Map<String, dynamic>,
    );
  }

  final int id;
  final String? businessTypeId;
  final String? businessTypeName;
  final String localAssetPath;
  final String? remoteAssetPath;
  final Map<String, dynamic>? metaData;
  final Widget? localAssetWidget;
  final Widget? remoteAssetWidget;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'businessTypeId': this.businessTypeId,
      'businessTypeName': this.businessTypeName,
      'localAssetPath': this.localAssetPath,
      'remoteAssetPath': this.remoteAssetPath,
      'metaData': this.metaData,
    };
  }

  BusinessTypeEntity copyWith({
    int? id,
    String? businessTypeId,
    String? businessTypeName,
    String? localAssetPath,
    String? remoteAssetPath,
    Map<String, dynamic>? metaData,
    Widget? localAssetWidget,
    Widget? remoteAssetWidget,
  }) {
    return BusinessTypeEntity(
      id: id ?? this.id,
      businessTypeId: businessTypeId ?? this.businessTypeId,
      businessTypeName: businessTypeName ?? this.businessTypeName,
      localAssetPath: localAssetPath ?? this.localAssetPath,
      remoteAssetPath: remoteAssetPath ?? this.remoteAssetPath,
      metaData: metaData ?? this.metaData,
      localAssetWidget: localAssetWidget ?? this.localAssetWidget,
      remoteAssetWidget: remoteAssetWidget ?? this.remoteAssetWidget,
    );
  }
}
