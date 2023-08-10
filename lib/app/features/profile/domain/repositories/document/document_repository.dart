part of 'package:homemakers_merchant/app/features/profile/index.dart';

abstract interface class UserDocumentRepository {
  Future<DataSourceState<AppUserEntity>> saveAppUser({
    required AppUserEntity appUserEntity,
  });

  Future<DataSourceState<AppUserEntity>> editAppUser({
    required AppUserEntity appUserEntity,
    required int appUserID,
  });

  Future<DataSourceState<bool>> deleteAppUser({
    required int appUserID,
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<bool>> deleteAllAppUser();

  Future<DataSourceState<AppUserEntity>> getAppUser({
    required int appUserID,
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<List<AppUserEntity>>> getAllAppUser();
}
