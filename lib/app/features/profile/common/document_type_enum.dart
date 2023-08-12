part of 'package:homemakers_merchant/app/features/profile/index.dart';

enum DocumentType {
  tradeLicence(
    documentTypeID: 1,
    documentTypeName: 'Trade License',
  ),
  nationalID(
    documentTypeID: 2,
    documentTypeName: 'National ID',
  ),
  selfie(
    documentTypeID: 3,
    documentTypeName: 'Selfie',
  ),
  other(
    documentTypeID: 4,
    documentTypeName: 'Other',
  ),
  ;

  const DocumentType({required this.documentTypeName, required this.documentTypeID});

  final int documentTypeID;
  final String documentTypeName;

  @override
  String toString() {
    return '$name:($documentTypeID)';
  }
}

enum DocumentUploadStatus {
  none,
  pending,
  uploaded,
  removed,
  added,
  ;

  @override
  String toString() {
    return name;
  }
}

List<DocumentType> documentTypes = [
  DocumentType.tradeLicence,
  DocumentType.nationalID,
  DocumentType.selfie,
];
