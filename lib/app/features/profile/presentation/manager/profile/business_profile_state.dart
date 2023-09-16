part of 'business_profile_bloc.dart';

abstract class BusinessProfileState with AppEquatable {
  BusinessProfileState();
}

class BusinessProfileInitial extends BusinessProfileState {
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [];
}

class SaveBusinessProfileState extends BusinessProfileState {
  SaveBusinessProfileState({
    required this.businessProfileEntity,
    this.hasEditBusinessProfile = false,
    this.currentIndex = -1,
    this.businessProfileStatus = BusinessProfileStatus.saveBusinessProfile,
    this.hasSaveBusinessType = false,
  });

  final BusinessProfileEntity businessProfileEntity;
  final bool hasEditBusinessProfile;
  final int currentIndex;
  final BusinessProfileStatus businessProfileStatus;
  final bool hasSaveBusinessType;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        businessProfileEntity,
        hasEditBusinessProfile,
        currentIndex,
        businessProfileStatus,
        hasSaveBusinessType,
      ];
}

class GetBusinessProfileState extends BusinessProfileState {
  GetBusinessProfileState({
    this.businessProfileEntity,
    this.businessProfileStatus = BusinessProfileStatus.getBusinessType,
    this.index = -1,
    this.businessProfileID = -1,
  });

  final BusinessProfileEntity? businessProfileEntity;
  final int index;
  final BusinessProfileStatus businessProfileStatus;
  final int businessProfileID;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        businessProfileEntity,
        businessProfileStatus,
        index,
        businessProfileID,
      ];
}

class SaveBusinessTypeState extends BusinessProfileState {
  SaveBusinessTypeState({
    required this.businessTypeEntity,
    this.hasEditBusinessType = false,
    this.businessProfileEntity,
    this.businessProfileStatus = BusinessProfileStatus.saveBusinessProfile,
  });

  final BusinessTypeEntity businessTypeEntity;
  final bool hasEditBusinessType;
  final BusinessProfileEntity? businessProfileEntity;
  final BusinessProfileStatus businessProfileStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        businessTypeEntity,
        hasEditBusinessType,
        businessProfileStatus,
        hasEditBusinessType,
      ];
}

class DeleteBusinessProfileState extends BusinessProfileState {
  DeleteBusinessProfileState({
    required this.businessProfileID,
    this.businessProfileEntity,
    this.businessProfileStatus = BusinessProfileStatus.deleteBusinessType,
    this.index = -1,
    this.businessProfileEntities = const [],
    this.hasDelete = false,
  });

  final BusinessProfileEntity? businessProfileEntity;
  final int businessProfileID;
  final BusinessProfileStatus businessProfileStatus;
  final int index;
  final List<BusinessProfileEntity> businessProfileEntities;
  final bool hasDelete;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        businessProfileEntity,
        businessProfileID,
        index,
        businessProfileStatus,
        businessProfileEntities,
        hasDelete,
      ];
}

class GetBusinessTypeState extends BusinessProfileState {
  GetBusinessTypeState({
    required this.businessProfileID,
    this.businessProfileEntity,
    this.businessTypeEntity,
    this.businessProfileStatus = BusinessProfileStatus.getBusinessType,
  });

  final BusinessProfileEntity? businessProfileEntity;
  final int businessProfileID;
  final BusinessTypeEntity? businessTypeEntity;
  final BusinessProfileStatus businessProfileStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [businessProfileEntity, businessProfileID, businessTypeEntity, businessProfileStatus];
}

class NavigateToAddressPageState extends BusinessProfileState {
  NavigateToAddressPageState({
    this.businessProfileEntity,
    this.businessTypeEntity,
    this.businessProfileStatus = BusinessProfileStatus.navigateToAddressPage,
  });

  final BusinessProfileEntity? businessProfileEntity;
  final BusinessTypeEntity? businessTypeEntity;
  final BusinessProfileStatus businessProfileStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [businessProfileEntity, businessTypeEntity, businessProfileStatus];
}

class DeleteAllBusinessProfileState extends BusinessProfileState {
  DeleteAllBusinessProfileState({
    this.businessProfileID = -1,
    this.businessProfileEntity,
    this.hasDeleteAll = false,
    this.businessProfileEntities = const [],
    this.businessProfileStatus = BusinessProfileStatus.deleteAllBusinessProfile,
  });

  final BusinessProfileEntity? businessProfileEntity;
  final int businessProfileID;
  final bool hasDeleteAll;
  final List<BusinessProfileEntity> businessProfileEntities;
  final BusinessProfileStatus businessProfileStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [businessProfileEntity, businessProfileID, businessProfileStatus];
}

class GetAllBusinessProfileState extends BusinessProfileState {
  GetAllBusinessProfileState({
    this.businessProfileID = -1,
    this.businessProfileEntity,
    this.businessProfileEntities = const [],
    this.businessProfileStatus = BusinessProfileStatus.getAllBusinessProfile,
    this.searchItem = '',
    this.pageSize = 10,
    this.pageKey = 1,
  });

  final BusinessProfileEntity? businessProfileEntity;
  final int businessProfileID;
  final List<BusinessProfileEntity> businessProfileEntities;
  final BusinessProfileStatus businessProfileStatus;
  final int pageKey;
  final int pageSize;
  final String searchItem;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        businessProfileEntity,
        businessProfileID,
        businessProfileStatus,
        pageKey,
        pageSize,
        searchItem,
      ];
}

class BusinessProfileEmptyState extends BusinessProfileState {
  BusinessProfileEmptyState({
    this.businessProfileEntities = const [],
    this.message = '',
    this.businessProfileStatus = BusinessProfileStatus.emptyForBusinessType,
  });

  final List<BusinessProfileEntity> businessProfileEntities;
  final String message;
  final BusinessProfileStatus businessProfileStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        businessProfileEntities,
        message,
        businessProfileStatus,
      ];
}

class BusinessProfileFailedState extends BusinessProfileState {
  BusinessProfileFailedState({
    this.businessProfileStatus = BusinessProfileStatus.failedForBusinessProfile,
    this.message = '',
  });

  final BusinessProfileStatus businessProfileStatus;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        businessProfileStatus,
        message,
      ];
}

class BusinessProfileExceptionState extends BusinessProfileState {
  BusinessProfileExceptionState({
    this.businessProfileStatus = BusinessProfileStatus.exceptionForBusinessProfile,
    this.message = '',
    this.stackTrace,
    this.exception,
  });

  final BusinessProfileStatus businessProfileStatus;
  final String message;
  final StackTrace? stackTrace;
  final Exception? exception;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => throw UnimplementedError();
}

class BusinessProfileLoadingState extends BusinessProfileState {
  BusinessProfileLoadingState({this.message = '', this.businessProfileStatus = BusinessProfileStatus.loadingForBusinessType, this.isLoading = true});

  final bool isLoading;
  final BusinessProfileStatus businessProfileStatus;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => throw UnimplementedError();
}

class BusinessProfileProcessingState extends BusinessProfileState {
  BusinessProfileProcessingState({this.message = '', this.businessProfileStatus = BusinessProfileStatus.loadingForBusinessProfile, this.isProcessing = true});

  final bool isProcessing;
  final BusinessProfileStatus businessProfileStatus;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => throw UnimplementedError();
}

class GetCurrentUserProfileState extends BusinessProfileState{
  GetCurrentUserProfileState({this.appUserEntity});
  final AppUserEntity? appUserEntity;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [appUserEntity];
}
