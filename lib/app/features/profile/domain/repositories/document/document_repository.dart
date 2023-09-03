part of 'package:homemakers_merchant/app/features/profile/index.dart';

abstract interface class UserBusinessDocumentRepository {
  Future<DataSourceState<NewBusinessDocumentEntity>> saveBusinessDocument({
    AppUserEntity? appUserEntity,
    required NewBusinessDocumentEntity businessDocumentUploadedEntity,
  });

  Future<DataSourceState<NewBusinessDocumentEntity>> editBusinessDocument({
    AppUserEntity? appUserEntity,
    int? appUserID,
    required NewBusinessDocumentEntity businessDocumentUploadedEntity,
    required int documentID,
  });

  Future<DataSourceState<bool>> deleteBusinessDocument({
    required int documentID,
    int? appUserID,
    AppUserEntity? appUserEntity,
    NewBusinessDocumentEntity? businessDocumentUploadedEntity,
  });

  Future<DataSourceState<bool>> deleteAllBusinessDocument({
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<NewBusinessDocumentEntity>> getBusinessDocument({
    int? appUserID,
    required int documentID,
    AppUserEntity? appUserEntity,
    NewBusinessDocumentEntity? businessDocumentUploadedEntity,
  });

  Future<DataSourceState<List<NewBusinessDocumentEntity>>> getAllBusinessDocument({
    AppUserEntity? appUserEntity,
  });
}
