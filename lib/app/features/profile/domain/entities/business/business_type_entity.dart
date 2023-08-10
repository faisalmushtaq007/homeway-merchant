part of 'package:homemakers_merchant/app/features/profile/index.dart';

class BusinessTypeEntity {
  BusinessTypeEntity({
    this.id = -1,
    this.businessTypeId = '',
    this.businessTypeName = '',
    this.localAssetPath = '',
    this.remoteAssetPath,
    this.metaData,
    this.localAssetWidget,
    this.remoteAssetWidget,
    this.hasSelected = false,
  });

  factory BusinessTypeEntity.fromMap(Map<String, dynamic> map) {
    return BusinessTypeEntity(
      id: map['id'] as int,
      businessTypeId: map['businessTypeId'] as String,
      businessTypeName: map['businessTypeName'] as String,
      localAssetPath: map['localAssetPath'] as String,
      remoteAssetPath: map['remoteAssetPath'] as String,
      metaData: map['metaData'] as Map<String, dynamic>,
      hasSelected: map['hasSelected'] as bool,
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
  bool hasSelected;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'businessTypeId': this.businessTypeId,
      'businessTypeName': this.businessTypeName,
      'localAssetPath': this.localAssetPath,
      'remoteAssetPath': this.remoteAssetPath,
      'metaData': this.metaData,
      'hasSelected': this.hasSelected,
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
    bool? hasSelected,
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
      hasSelected: hasSelected ?? this.hasSelected,
    );
  }
}
