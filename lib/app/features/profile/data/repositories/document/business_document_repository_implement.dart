part of 'package:homemakers_merchant/app/features/profile/index.dart';

class BusinessDocumentRepositoryImplement implements UserBusinessDocumentRepository {
  @override
  Future<DataSourceState<bool>> deleteAllBusinessDocument({AppUserEntity? appUserEntity}) {
    // TODO: implement deleteAllBusinessDocument
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<bool>> deleteBusinessDocument(
      {required int appUserID, AppUserEntity? appUserEntity, BusinessDocumentUploadedEntity? businessDocumentUploadedEntity}) {
    // TODO: implement deleteBusinessDocument
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<BusinessDocumentUploadedEntity>> editBusinessDocument(
      {AppUserEntity? appUserEntity, required int appUserID, required BusinessDocumentUploadedEntity businessDocumentUploadedEntity}) {
    // TODO: implement editBusinessDocument
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<List<BusinessDocumentUploadedEntity>>> getAllBusinessDocument({AppUserEntity? appUserEntity}) {
    // TODO: implement getAllBusinessDocument
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<BusinessDocumentUploadedEntity>> getBusinessDocument(
      {required int appUserID, AppUserEntity? appUserEntity, BusinessDocumentUploadedEntity? businessDocumentUploadedEntity}) {
    // TODO: implement getBusinessDocument
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<BusinessDocumentUploadedEntity>> saveBusinessDocument(
      {AppUserEntity? appUserEntity, required BusinessDocumentUploadedEntity businessDocumentUploadedEntity}) {
    // TODO: implement saveBusinessDocument
    throw UnimplementedError();
  }
}
