part of 'package:homemakers_merchant/app/features/profile/index.dart';

abstract interface class UserBusinessDocumentRepository {
  Future<DataSourceState<BusinessDocumentUploadedEntity>> saveBusinessDocument({
    AppUserEntity? appUserEntity,
    required BusinessDocumentUploadedEntity businessDocumentUploadedEntity,
  });

  Future<DataSourceState<BusinessDocumentUploadedEntity>> editBusinessDocument({
    AppUserEntity? appUserEntity,
    required int appUserID,
    required BusinessDocumentUploadedEntity businessDocumentUploadedEntity,
  });

  Future<DataSourceState<bool>> deleteBusinessDocument({
    required int appUserID,
    AppUserEntity? appUserEntity,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
  });

  Future<DataSourceState<bool>> deleteAllBusinessDocument({
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<BusinessDocumentUploadedEntity>> getBusinessDocument({
    required int appUserID,
    AppUserEntity? appUserEntity,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
  });

  Future<DataSourceState<List<BusinessDocumentUploadedEntity>>> getAllBusinessDocument({
    AppUserEntity? appUserEntity,
  });
}
