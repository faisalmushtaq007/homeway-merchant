import 'package:homemakers_merchant/app/features/profile/common/document_type_enum.dart';
import 'package:homemakers_merchant/utils/app_equatable/src/app_equatable.dart';

class BusinessDocumentUploadedEntity with AppEquatable {
  BusinessDocumentUploadedEntity({
    required this.documentType,
    this.businessDocumentAssetsEntity = const [],
    this.documentIDNumber = '',
    this.documentFrontAssets,
    this.documentBackAssets,
    this.documentFrontAssetsUploadStatus = DocumentUploadStatus.none,
    this.documentBackAssetsUploadStatus = DocumentUploadStatus.none,
    this.hasDocumentFrontSide = true,
  });

  factory BusinessDocumentUploadedEntity.fromMap(Map<String, dynamic> map) {
    return BusinessDocumentUploadedEntity(
      documentType: map['documentType'] as DocumentType,
      documentIDNumber: map['documentIDNumber'] as String,
      documentFrontAssets:
          map['documentFrontAssets'] as BusinessDocumentAssetsEntity,
      documentBackAssets:
          map['documentBackAssets'] as BusinessDocumentAssetsEntity,
      documentFrontAssetsUploadStatus:
          map['documentFrontAssetsUploadStatus'] as DocumentUploadStatus,
      documentBackAssetsUploadStatus:
          map['documentBackAssetsUploadStatus'] as DocumentUploadStatus,
      hasDocumentFrontSide: map['hasDocumentFrontSide'] as bool,
      businessDocumentAssetsEntity: map['businessDocumentAssetsEntity']
          as List<BusinessDocumentAssetsEntity>,
    );
  }

  final DocumentType documentType;
  final String documentIDNumber;
  final BusinessDocumentAssetsEntity? documentFrontAssets;
  final BusinessDocumentAssetsEntity? documentBackAssets;
  final DocumentUploadStatus documentFrontAssetsUploadStatus;
  final DocumentUploadStatus documentBackAssetsUploadStatus;
  final bool hasDocumentFrontSide;
  final List<BusinessDocumentAssetsEntity> businessDocumentAssetsEntity;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        documentType,
        documentIDNumber,
        documentFrontAssets,
        documentBackAssets,
        documentFrontAssetsUploadStatus,
        documentBackAssetsUploadStatus,
        hasDocumentFrontSide,
        businessDocumentAssetsEntity,
      ];

  BusinessDocumentUploadedEntity copyWith({
    DocumentType? documentType,
    String? documentIDNumber,
    BusinessDocumentAssetsEntity? documentFrontAssets,
    BusinessDocumentAssetsEntity? documentBackAssets,
    DocumentUploadStatus? documentFrontAssetsUploadStatus,
    DocumentUploadStatus? documentBackAssetsUploadStatus,
    bool? hasDocumentFrontSide,
    List<BusinessDocumentAssetsEntity>? businessDocumentAssetsEntity,
  }) {
    return BusinessDocumentUploadedEntity(
      documentType: documentType ?? this.documentType,
      documentIDNumber: documentIDNumber ?? this.documentIDNumber,
      documentFrontAssets: documentFrontAssets ?? this.documentFrontAssets,
      documentBackAssets: documentBackAssets ?? this.documentBackAssets,
      documentFrontAssetsUploadStatus: documentFrontAssetsUploadStatus ??
          this.documentFrontAssetsUploadStatus,
      documentBackAssetsUploadStatus:
          documentBackAssetsUploadStatus ?? this.documentBackAssetsUploadStatus,
      hasDocumentFrontSide: hasDocumentFrontSide ?? this.hasDocumentFrontSide,
      businessDocumentAssetsEntity:
          businessDocumentAssetsEntity ?? this.businessDocumentAssetsEntity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'documentType': this.documentType,
      'documentIDNumber': this.documentIDNumber,
      'documentFrontAssets': this.documentFrontAssets,
      'documentBackAssets': this.documentBackAssets,
      'documentFrontAssetsUploadStatus': this.documentFrontAssetsUploadStatus,
      'documentBackAssetsUploadStatus': this.documentBackAssetsUploadStatus,
      'hasDocumentFrontSide': this.hasDocumentFrontSide,
      'businessDocumentAssetsEntity': this.businessDocumentAssetsEntity,
    };
  }
}

class BusinessDocumentAssetsEntity with AppEquatable {
  BusinessDocumentAssetsEntity({
    required this.assetName,
    required this.assetOriginalName,
    required this.assetPath,
    required this.assetExtension,
    required this.assetIdNumber,
    this.assetBase64Code = '',
    this.assetUrl = '',
    this.assetMoreInfo = const {},
    this.assetsUploadStatus = DocumentUploadStatus.none,
    this.hasAssetsFrontSide = true,
    this.backSideAssetsInfo,
  });

  factory BusinessDocumentAssetsEntity.fromMap(Map<String, dynamic> map) {
    return BusinessDocumentAssetsEntity(
      assetName: map['assetName'] as String,
      assetOriginalName: map['assetOriginalName'] as String,
      assetPath: map['assetPath'] as String,
      assetUrl: map['assetUrl'] as String,
      assetExtension: map['assetExtension'] as String,
      assetMoreInfo: map['assetMoreInfo'] as Map<String, dynamic>,
      assetBase64Code: map['assetBase64Code'] as String,
      assetsUploadStatus: map['assetsUploadStatus'] as DocumentUploadStatus,
      assetIdNumber: map['assetIdNumber'] as String,
      hasAssetsFrontSide: map['hasAssetsFrontSide'] as bool,
      backSideAssetsInfo:
          map['backSideAssetsInfo'] as BusinessDocumentAssetsEntity,
    );
  }

  final String assetName;
  final String assetOriginalName;
  final String assetPath;
  final String assetUrl;
  final String assetExtension;
  final Map<String, dynamic> assetMoreInfo;
  final String assetBase64Code;
  final DocumentUploadStatus assetsUploadStatus;
  final String assetIdNumber;
  final bool hasAssetsFrontSide;
  final BusinessDocumentAssetsEntity? backSideAssetsInfo;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        assetName,
        assetExtension,
        assetOriginalName,
        assetMoreInfo,
        assetPath,
        assetsUploadStatus,
        assetUrl,
        assetBase64Code,
        assetIdNumber,
        hasAssetsFrontSide,
        backSideAssetsInfo,
      ];

  BusinessDocumentAssetsEntity copyWith({
    String? assetName,
    String? assetOriginalName,
    String? assetPath,
    String? assetUrl,
    String? assetExtension,
    Map<String, dynamic>? assetMoreInfo,
    String? assetBase64Code,
    DocumentUploadStatus? assetsUploadStatus,
    String? assetIdNumber,
    bool? hasAssetsFrontSide,
    BusinessDocumentAssetsEntity? backSideAssetsInfo,
  }) {
    return BusinessDocumentAssetsEntity(
      assetName: assetName ?? this.assetName,
      assetOriginalName: assetOriginalName ?? this.assetOriginalName,
      assetPath: assetPath ?? this.assetPath,
      assetUrl: assetUrl ?? this.assetUrl,
      assetExtension: assetExtension ?? this.assetExtension,
      assetMoreInfo: assetMoreInfo ?? this.assetMoreInfo,
      assetBase64Code: assetBase64Code ?? this.assetBase64Code,
      assetsUploadStatus: assetsUploadStatus ?? this.assetsUploadStatus,
      assetIdNumber: assetIdNumber ?? this.assetIdNumber,
      hasAssetsFrontSide: hasAssetsFrontSide ?? this.hasAssetsFrontSide,
      backSideAssetsInfo: backSideAssetsInfo ?? this.backSideAssetsInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'assetName': this.assetName,
      'assetOriginalName': this.assetOriginalName,
      'assetPath': this.assetPath,
      'assetUrl': this.assetUrl,
      'assetExtension': this.assetExtension,
      'assetMoreInfo': this.assetMoreInfo,
      'assetBase64Code': this.assetBase64Code,
      'assetsUploadStatus': this.assetsUploadStatus,
      'assetIdNumber': this.assetIdNumber,
      'hasAssetsFrontSide': this.hasAssetsFrontSide,
      'backSideAssetsInfo': this.backSideAssetsInfo,
    };
  }
}
