part of 'package:homemakers_merchant/app/features/profile/index.dart';

class BusinessProfileRepositoryImplement implements UserBusinessProfileRepository {
  const BusinessProfileRepositoryImplement({required this.remoteDataSource, required this.userBusinessProfileLocalDbRepository});
  final ProfileDataSource remoteDataSource;
  final UserBusinessProfileLocalDbRepository<BusinessProfileEntity> userBusinessProfileLocalDbRepository;

  @override
  Future<DataSourceState<bool>> deleteAllBusinessProfile({AppUserEntity? appUserEntity}) {
    // TODO: implement deleteAllBusinessProfile
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<bool>> deleteAllBusinessType({AppUserEntity? appUserEntity, BusinessProfileEntity? businessProfileEntity}) {
    // TODO: implement deleteAllBusinessType
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<bool>> deleteBusinessProfile(
      {required int businessProfileID, BusinessProfileEntity? businessProfileEntity, AppUserEntity? appUserEntity}) {
    // TODO: implement deleteBusinessProfile
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<bool>> deleteBusinessType(
      {required int businessTypeID, BusinessTypeEntity? businessTypeEntity, AppUserEntity? appUserEntity, BusinessProfileEntity? businessProfileEntity}) {
    // TODO: implement deleteBusinessType
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<BusinessProfileEntity>> editBusinessProfile(
      {required BusinessProfileEntity businessProfileEntity, required int businessProfileID, AppUserEntity? appUserEntity}) {
    // TODO: implement editBusinessProfile
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<(BusinessProfileEntity, BusinessTypeEntity)>> editBusinessType(
      {required BusinessTypeEntity businessTypeEntity,
      required int businessTypeID,
      AppUserEntity? appUserEntity,
      BusinessProfileEntity? businessProfileEntity}) {
    // TODO: implement editBusinessType
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<List<BusinessProfileEntity>>> getAllBusinessProfile({AppUserEntity? appUserEntity}) {
    // TODO: implement getAllBusinessProfile
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<(BusinessProfileEntity, List<BusinessTypeEntity>)>> getAllBusinessType(
      {AppUserEntity? appUserEntity, BusinessProfileEntity? businessProfileEntity}) {
    // TODO: implement getAllBusinessType
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<BusinessProfileEntity>> getBusinessProfile(
      {required int businessProfileID, AppUserEntity? appUserEntity, BusinessProfileEntity? businessProfileEntity}) {
    // TODO: implement getBusinessProfile
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<(BusinessProfileEntity, BusinessTypeEntity)>> getBusinessType(
      {required int businessTypeID, AppUserEntity? appUserEntity, BusinessProfileEntity? businessProfileEntity, BusinessTypeEntity? businessTypeEntity}) {
    // TODO: implement getBusinessType
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<BusinessProfileEntity>> saveBusinessProfile({required BusinessProfileEntity businessProfileEntity, AppUserEntity? appUserEntity}) {
    // TODO: implement saveBusinessProfile
    throw UnimplementedError();
  }

  @override
  Future<DataSourceState<(BusinessProfileEntity, BusinessTypeEntity)>> saveBusinessType(
      {required BusinessTypeEntity businessTypeEntity, AppUserEntity? appUserEntity, BusinessProfileEntity? businessProfileEntity}) {
    // TODO: implement saveBusinessType
    throw UnimplementedError();
  }
}
