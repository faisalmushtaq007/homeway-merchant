part of 'package:homemakers_merchant/app/features/profile/index.dart';

class NewBusinessDocumentEntity extends INetworkModel<NewBusinessDocumentEntity>
    with EquatableMixin {
  NewBusinessDocumentEntity({
    this.documentID = -1,
    this.documentIdNumber = '',
    this.documentType = DocumentType.other,
    this.base64 = '',
    this.metaInfo = const {},
    this.mimeType = 'image/png',
    this.localAssetPath = '',
    this.networkAssetPath = '',
    this.fileName = '',
    this.fileNameWithExtension = '',
    this.fileExtension = '',
    this.captureDocumentID = '',
    this.width = 0.0,
    this.height = 0.0,
  });

  factory NewBusinessDocumentEntity.fromMap(Map<String, dynamic> map) {
    return NewBusinessDocumentEntity(
      documentID: map['documentID'] ?? -1,
      documentIdNumber: map['documentIdNumber'] ?? '',
      documentType: (map['documentType'] != null)
          ? DocumentType.values.byName(map['documentType'])
          : DocumentType.other,
      base64: map['base64'] ?? '',
      metaInfo: map['metaInfo'] ?? <String, dynamic>{},
      mimeType: map['mimeType'] ?? 'image/png',
      localAssetPath: map['localAssetPath'] ?? '',
      networkAssetPath: map['networkAssetPath'] ?? '',
      fileName: map['fileName'] as String,
      fileNameWithExtension: map['fileNameWithExtension'] ?? '',
      fileExtension: map['fileExtension'] ?? '',
      captureDocumentID: map['captureDocumentID'] ?? '',
      height: map['height'] ?? 0.0,
      width: map['width'] ?? 0.0,
    );
  }

  final int documentID;
  final String captureDocumentID;
  final String documentIdNumber;
  final DocumentType documentType;
  final String base64;
  final Map<String, dynamic> metaInfo;
  final String mimeType;
  final String localAssetPath;
  final String networkAssetPath;
  final String fileName;
  final String fileNameWithExtension;
  final String fileExtension;
  final double height;
  final double width;

  Map<String, dynamic> toMap() => {
        'documentID': documentID,
        'documentIdNumber': documentIdNumber,
        'documentType': documentType.name,
        'base64': base64,
        'metaInfo': metaInfo,
        'mimeType': mimeType,
        'networkAssetPath': networkAssetPath,
        'localAssetPath': localAssetPath,
        'fileName': fileName,
        'fileNameWithExtension': fileNameWithExtension,
        'fileExtension': fileExtension,
        'captureDocumentID': captureDocumentID,
        'height': height,
        'width': width,
      };

  @override
  NewBusinessDocumentEntity fromJson(Map<String, dynamic> json) =>
      NewBusinessDocumentEntity.fromMap(json);

  @override
  Map<String, dynamic>? toJson() => toMap();

  NewBusinessDocumentEntity copyWith({
    int? documentID,
    String? documentIdNumber,
    DocumentType? documentType,
    String? base64,
    Map<String, dynamic>? metaInfo,
    String? mimeType,
    String? localAssetPath,
    String? networkAssetPath,
    String? fileName,
    String? fileNameWithExtension,
    String? fileExtension,
    String? captureDocumentID,
    double? height,
    double? width,
  }) {
    return NewBusinessDocumentEntity(
      documentID: documentID ?? this.documentID,
      documentIdNumber: documentIdNumber ?? this.documentIdNumber,
      documentType: documentType ?? this.documentType,
      base64: base64 ?? this.base64,
      metaInfo: metaInfo ?? this.metaInfo,
      mimeType: mimeType ?? this.mimeType,
      localAssetPath: localAssetPath ?? this.localAssetPath,
      networkAssetPath: networkAssetPath ?? this.networkAssetPath,
      fileName: fileName ?? this.fileName,
      fileNameWithExtension:
          fileNameWithExtension ?? this.fileNameWithExtension,
      fileExtension: fileExtension ?? this.fileExtension,
      captureDocumentID: captureDocumentID ?? this.captureDocumentID,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  @override
  List<Object?> get props => [
        documentID,
        documentIdNumber,
        documentType.name,
        base64,
        metaInfo,
        mimeType,
        networkAssetPath,
        localAssetPath,
        fileName,
        fileNameWithExtension,
        fileExtension,
        captureDocumentID,
        height,
        width,
      ];
}
