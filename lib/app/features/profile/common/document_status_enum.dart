part of 'package:homemakers_merchant/app/features/profile/index.dart';

enum BusinessDocumentStatus {
  none,
  saveBusinessDocument,
  deleteBusinessDocument,
  getBusinessDocument,
  navigateToAddressPage,
  exceptionForBusinessDocument,
  failedForBusinessDocument,
  loadingForBusinessDocument,
  processingForBusinessDocument,
  emptyForBusinessDocument,
  deleteAllBusinessDocument,
  getAllBusinessDocument,
  ;

  @override
  String toString() {
    return name;
  }
}
