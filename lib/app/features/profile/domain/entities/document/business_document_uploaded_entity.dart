part of 'package:homemakers_merchant/app/features/profile/index.dart';

class BusinessDocumentUploadedEntity with AppEquatable {
  BusinessDocumentUploadedEntity({
    this.documentID = -1,
    this.documentType = DocumentType.tradeLicence,
    this.businessDocumentAssetsEntity = const [],
    this.documentIDNumber = '',
    this.documentFrontAssets,
    this.documentBackAssets,
    this.documentFrontAssetsUploadStatus = DocumentUploadStatus.none,
    this.documentBackAssetsUploadStatus = DocumentUploadStatus.none,
    this.hasDocumentFrontSide = true,
    this.hasButtonEnable = true,
    this.hasTextFieldEnable = false,
  });

  factory BusinessDocumentUploadedEntity.fromMap(Map<String, dynamic> map) {
    return BusinessDocumentUploadedEntity(
      documentID: map['documentID']??-1,
      documentType: (map['documentType'] != null) ? DocumentType.values.byName(map['documentType']) : DocumentType.other,
      documentIDNumber: map['documentIDNumber'] as String,
      documentFrontAssets:
          map['documentFrontAssets'] != null ? BusinessDocumentAssetsEntity.fromMap(map['documentFrontAssets']) : BusinessDocumentAssetsEntity(),
      documentBackAssets: map['documentBackAssets'] != null ? BusinessDocumentAssetsEntity.fromMap(map['documentBackAssets']) : BusinessDocumentAssetsEntity(),
      documentFrontAssetsUploadStatus: (map['documentFrontAssetsUploadStatus'] != null)
          ? DocumentUploadStatus.values.byName(map['documentFrontAssetsUploadStatus'])
          : DocumentUploadStatus.none,
      documentBackAssetsUploadStatus: (map['documentBackAssetsUploadStatus'] != null)
          ? DocumentUploadStatus.values.byName(map['documentBackAssetsUploadStatus'])
          : DocumentUploadStatus.none,
      hasDocumentFrontSide: map['hasDocumentFrontSide']??true as bool,
      businessDocumentAssetsEntity:
          map['businessDocumentAssetsEntity'].map((e) => BusinessDocumentAssetsEntity.fromMap(e)).toList().cast<BusinessDocumentAssetsEntity>(),
      hasButtonEnable: map['hasButtonEnable']??true as bool,
      hasTextFieldEnable: map['hasTextFieldEnable']??false as bool,
    );
  }
  int documentID;
  DocumentType documentType;
  String documentIDNumber;
  BusinessDocumentAssetsEntity? documentFrontAssets;
  BusinessDocumentAssetsEntity? documentBackAssets;
  DocumentUploadStatus documentFrontAssetsUploadStatus;
  DocumentUploadStatus documentBackAssetsUploadStatus;
  bool hasDocumentFrontSide;
  List<BusinessDocumentAssetsEntity> businessDocumentAssetsEntity;
  bool hasButtonEnable;
  bool hasTextFieldEnable;

  @override
  bool get cacheHash => false;

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
        hasButtonEnable,
        hasTextFieldEnable,
        documentID,
      ];

  BusinessDocumentUploadedEntity copyWith({
    int? documentID,
    DocumentType? documentType,
    String? documentIDNumber,
    BusinessDocumentAssetsEntity? documentFrontAssets,
    BusinessDocumentAssetsEntity? documentBackAssets,
    DocumentUploadStatus? documentFrontAssetsUploadStatus,
    DocumentUploadStatus? documentBackAssetsUploadStatus,
    bool? hasDocumentFrontSide,
    List<BusinessDocumentAssetsEntity>? businessDocumentAssetsEntity,
    bool? hasButtonEnable,
    bool? hasTextFieldEnable,
  }) {
    return BusinessDocumentUploadedEntity(
      documentID: documentID ?? this.documentID,
      documentType: documentType ?? this.documentType,
      documentIDNumber: documentIDNumber ?? this.documentIDNumber,
      documentFrontAssets: documentFrontAssets ?? this.documentFrontAssets,
      documentBackAssets: documentBackAssets ?? this.documentBackAssets,
      documentFrontAssetsUploadStatus: documentFrontAssetsUploadStatus ?? this.documentFrontAssetsUploadStatus,
      documentBackAssetsUploadStatus: documentBackAssetsUploadStatus ?? this.documentBackAssetsUploadStatus,
      hasDocumentFrontSide: hasDocumentFrontSide ?? this.hasDocumentFrontSide,
      businessDocumentAssetsEntity: businessDocumentAssetsEntity ?? this.businessDocumentAssetsEntity,
      hasButtonEnable: hasButtonEnable ?? this.hasButtonEnable,
      hasTextFieldEnable: hasTextFieldEnable ?? this.hasTextFieldEnable,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'documentID': this.documentID,
      'documentType': this.documentType.name,
      'documentIDNumber': this.documentIDNumber,
      'documentFrontAssets': this.documentFrontAssets?.toMap()??BusinessDocumentAssetsEntity().toMap(),
      'documentBackAssets': this.documentBackAssets?.toMap()??BusinessDocumentAssetsEntity().toMap(),
      'documentFrontAssetsUploadStatus': this.documentFrontAssetsUploadStatus.name,
      'documentBackAssetsUploadStatus': this.documentBackAssetsUploadStatus.name,
      'hasDocumentFrontSide': this.hasDocumentFrontSide??true,
      'businessDocumentAssetsEntity': this.businessDocumentAssetsEntity.map((e) => e.toMap()).toList(),
      'hasButtonEnable': this.hasButtonEnable??true,
      'hasTextFieldEnable': this.hasTextFieldEnable??false,
    };
  }
}

class BusinessDocumentAssetsEntity with AppEquatable {
  BusinessDocumentAssetsEntity({
    this.assetName = '',
    this.assetOriginalName = '',
    this.assetPath = '',
    this.assetExtension = '',
    this.assetIdNumber = '',
    this.assetBase64Code = '',
    this.assetUrl = '',
    this.assetMoreInfo = const {},
    this.assetsUploadStatus = DocumentUploadStatus.none,
    this.hasAssetsFrontSide = true,
    this.backSideAssetsInfo,
    this.textEditingController,
    this.onSubmitted,
    this.onChanged,
    this.onSaved,
  });

  factory BusinessDocumentAssetsEntity.fromMap(Map<String, dynamic> map) {
    return BusinessDocumentAssetsEntity(
      assetName: map['assetName']??'' as String,
      assetOriginalName: map['assetOriginalName']??'' as String,
      assetPath: map['assetPath']??'' as String,
      assetUrl: map['assetUrl']??'' as String,
      assetExtension: map['assetExtension']??'' as String,
      assetMoreInfo: map['assetMoreInfo']??<String,dynamic>{} as Map<String, dynamic>,
      assetBase64Code: map['assetBase64Code']??'' as String,
      assetsUploadStatus: map['assetsUploadStatus']!=null?DocumentUploadStatus.values.byName(map['assetsUploadStatus']):DocumentUploadStatus.none,
      assetIdNumber: map['assetIdNumber']??'' as String,
      hasAssetsFrontSide: map['hasAssetsFrontSide']??true as bool,
      //backSideAssetsInfo: map['backSideAssetsInfo'] as BusinessDocumentAssetsEntity,
      //textEditingController: map['textEditingController'] as TextEditingController,
    );
  }

  String assetName;
  String assetOriginalName;
  String assetPath;
  String assetUrl;
  String assetExtension;
  Map<String, dynamic> assetMoreInfo;
  String assetBase64Code;
  DocumentUploadStatus assetsUploadStatus;
  String assetIdNumber;
  bool hasAssetsFrontSide;
  BusinessDocumentAssetsEntity? backSideAssetsInfo;
  TextEditingController? textEditingController;
  ValueChanged<String>? onChanged;
  ValueChanged<String>? onSubmitted;
  FormFieldSetter<String>? onSaved;

  @override
  bool get cacheHash => false;

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
        textEditingController,
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
    TextEditingController? textEditingController,
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
      //backSideAssetsInfo: backSideAssetsInfo ?? this.backSideAssetsInfo,
      //textEditingController: textEditingController ?? this.textEditingController,
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
      'assetsUploadStatus': this.assetsUploadStatus.name,
      'assetIdNumber': this.assetIdNumber,
      'hasAssetsFrontSide': this.hasAssetsFrontSide??true,
      //'backSideAssetsInfo': this.backSideAssetsInfo,
      //'textEditingController': this.textEditingController,
    };
  }
}
