part of 'package:homemakers_merchant/app/features/profile/index.dart';

abstract interface class UserBusinessProfileRepository {
  Future<DataSourceState<BusinessProfileEntity>> saveBusinessProfile({
    required BusinessProfileEntity businessProfileEntity,
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<BusinessProfileEntity>> editBusinessProfile({
    required BusinessProfileEntity businessProfileEntity,
    required int businessProfileID,
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<bool>> deleteBusinessProfile({
    required int businessProfileID,
    BusinessProfileEntity? businessProfileEntity,
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<bool>> deleteAllBusinessProfile({
    AppUserEntity? appUserEntity,
  });

  Future<DataSourceState<BusinessProfileEntity>> getBusinessProfile({
    required int businessProfileID,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  });

  Future<DataSourceState<List<BusinessProfileEntity>>> getAllBusinessProfile({
    AppUserEntity? appUserEntity,
  });

  // BusinessType
  Future<DataSourceState<(BusinessProfileEntity, BusinessTypeEntity)>> saveBusinessType({
    required BusinessTypeEntity businessTypeEntity,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  });

  Future<DataSourceState<(BusinessProfileEntity, BusinessTypeEntity)>> editBusinessType({
    required BusinessTypeEntity businessTypeEntity,
    required int businessTypeID,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  });

  Future<DataSourceState<bool>> deleteBusinessType({
    required int businessTypeID,
    BusinessTypeEntity? businessTypeEntity,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  });

  Future<DataSourceState<bool>> deleteAllBusinessType({
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  });

  Future<DataSourceState<(BusinessProfileEntity, BusinessTypeEntity)>> getBusinessType({
    required int businessTypeID,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
    BusinessTypeEntity? businessTypeEntity,
  });

  Future<DataSourceState<(BusinessProfileEntity, List<BusinessTypeEntity>)>> getAllBusinessType({
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  });

  Future<AppUserEntity?> getCurrentUserBusinessProfileFromLocalDB({
    Map<String, dynamic> metaInfo = const {},
    String byID = '',
    String byToken = '',
  });

  Future<String> getCurrentUserTokenFromLocalDB({
    Map<String, dynamic> metaInfo = const {},
  });

  Future<DataSourceState<List<BusinessProfileEntity>>> getAllBusinessProfilePagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    Map<String, dynamic> extras = const <String, dynamic>{},
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  });

  Future<DataSourceState<List<BusinessProfileEntity>>> saveAllBusinessProfiles({
    required List<BusinessProfileEntity> businessProfiles,
    bool hasUpdateAll = false,
  });


}
