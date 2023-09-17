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

  Future<DataSourceState<List<NewBusinessDocumentEntity>>> getAllBusinessDocumentsPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    Map<String, dynamic> extras = const <String, dynamic>{},
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  });

  Future<DataSourceState<List<NewBusinessDocumentEntity>>> saveAllBusinessDocuments({
    required List<NewBusinessDocumentEntity> businessDocuments,
    bool hasUpdateAll = false,
  });
}
