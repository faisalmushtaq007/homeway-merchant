part of 'business_profile_bloc.dart';

abstract class BusinessProfileState extends Equatable {
  const BusinessProfileState();
}

class BusinessProfileInitial extends BusinessProfileState {
  const BusinessProfileInitial();

  @override
  List<Object?> get props => [];
}

class SaveBusinessProfileState extends BusinessProfileState {
  const SaveBusinessProfileState({
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
  List<Object?> get props => [
        businessProfileEntity,
        hasEditBusinessProfile,
        currentIndex,
        businessProfileStatus,
        hasSaveBusinessType,
      ];
}

class GetBusinessProfileState extends BusinessProfileState {
  const GetBusinessProfileState({
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
  List<Object?> get props => [
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
  List<Object?> get props => [
        businessTypeEntity,
        hasEditBusinessType,
        businessProfileStatus,
        hasEditBusinessType,
      ];
}

class DeleteBusinessProfileState extends BusinessProfileState {
  const DeleteBusinessProfileState({
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
  List<Object?> get props => [
        businessProfileEntity,
        businessProfileID,
        index,
        businessProfileStatus,
        businessProfileEntities,
        hasDelete,
      ];
}

class GetBusinessTypeState extends BusinessProfileState {
  const GetBusinessTypeState({
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
  List<Object?> get props => [
        businessProfileEntity,
        businessProfileID,
        businessTypeEntity,
        businessProfileStatus
      ];
}

class NavigateToAddressPageState extends BusinessProfileState {
  const NavigateToAddressPageState({
    this.businessProfileEntity,
    this.businessTypeEntity,
    this.businessProfileStatus = BusinessProfileStatus.navigateToAddressPage,
  });

  final BusinessProfileEntity? businessProfileEntity;
  final BusinessTypeEntity? businessTypeEntity;
  final BusinessProfileStatus businessProfileStatus;

  @override
  List<Object?> get props =>
      [businessProfileEntity, businessTypeEntity, businessProfileStatus];
}

class DeleteAllBusinessProfileState extends BusinessProfileState {
  const DeleteAllBusinessProfileState({
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
  List<Object?> get props =>
      [businessProfileEntity, businessProfileID, businessProfileStatus];
}

class GetAllBusinessProfileState extends BusinessProfileState {
  const GetAllBusinessProfileState({
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
  List<Object?> get props => [
        businessProfileEntity,
        businessProfileID,
        businessProfileStatus,
        pageKey,
        pageSize,
        searchItem,
      ];
}

class BusinessProfileEmptyState extends BusinessProfileState {
  const BusinessProfileEmptyState({
    this.businessProfileEntities = const [],
    this.message = '',
    this.businessProfileStatus = BusinessProfileStatus.emptyForBusinessType,
  });

  final List<BusinessProfileEntity> businessProfileEntities;
  final String message;
  final BusinessProfileStatus businessProfileStatus;

  @override
  List<Object?> get props => [
        businessProfileEntities,
        message,
        businessProfileStatus,
      ];
}

class BusinessProfileFailedState extends BusinessProfileState {
  const BusinessProfileFailedState({
    this.businessProfileStatus = BusinessProfileStatus.failedForBusinessProfile,
    this.message = '',
  });

  final BusinessProfileStatus businessProfileStatus;
  final String message;

  @override
  List<Object?> get props => [
        businessProfileStatus,
        message,
      ];
}

class BusinessProfileExceptionState extends BusinessProfileState {
  const BusinessProfileExceptionState({
    this.businessProfileStatus =
        BusinessProfileStatus.exceptionForBusinessProfile,
    this.message = '',
    this.stackTrace,
    this.exception,
  });

  final BusinessProfileStatus businessProfileStatus;
  final String message;
  final StackTrace? stackTrace;
  final Exception? exception;

  @override
  List<Object?> get props =>
      [stackTrace, businessProfileStatus, message, exception];
}

class BusinessProfileLoadingState extends BusinessProfileState {
  const BusinessProfileLoadingState(
      {this.message = '',
      this.businessProfileStatus = BusinessProfileStatus.loadingForBusinessType,
      this.isLoading = true});

  final bool isLoading;
  final BusinessProfileStatus businessProfileStatus;
  final String message;

  @override
  List<Object?> get props => [isLoading, businessProfileStatus, message];
}

class BusinessProfileProcessingState extends BusinessProfileState {
  const BusinessProfileProcessingState(
      {this.message = '',
      this.businessProfileStatus =
          BusinessProfileStatus.loadingForBusinessProfile,
      this.isProcessing = true});

  final bool isProcessing;
  final BusinessProfileStatus businessProfileStatus;
  final String message;

  @override
  List<Object?> get props => [isProcessing, businessProfileStatus, message];
}

class GetCurrentUserProfileState extends BusinessProfileState {
  const GetCurrentUserProfileState({this.appUserEntity});

  final AppUserEntity? appUserEntity;

  @override
  List<Object?> get props => [appUserEntity];
}

class GetAllBusinessProfilePaginationState extends BusinessProfileState {
  const GetAllBusinessProfilePaginationState({
    this.businessProfileID = -1,
    this.businessProfileEntities = const [],
    this.searchItem = '',
    this.pageSize = 10,
    this.pageKey = 1,
    this.endTime,
    this.filtering = '',
    this.sorting = '',
    this.startTime,
  });

  final List<BusinessProfileEntity> businessProfileEntities;
  final int businessProfileID;

  final int pageKey;
  final int pageSize;
  final String searchItem;
  final String? filtering;
  final String? sorting;
  final Timestamp? startTime;
  final Timestamp? endTime;

  @override
  List<Object?> get props => [
        businessProfileEntities,
        businessProfileID,
        pageKey,
        pageSize,
        searchItem,
        endTime,
        filtering,
        sorting,
        startTime,
      ];
}

class GetAllBusinessProfilePaginationEmptyState extends BusinessProfileState {
  const GetAllBusinessProfilePaginationEmptyState({
    this.businessProfileEntities = const [],
    this.message = '',
    this.businessProfileStatus = BusinessProfileStatus.emptyForBusinessType,
  });

  final List<BusinessProfileEntity> businessProfileEntities;
  final String message;
  final BusinessProfileStatus businessProfileStatus;

  @override
  List<Object?> get props => [
        businessProfileEntities,
        message,
        businessProfileStatus,
      ];
}

class GetAllBusinessProfilePaginationFailedState extends BusinessProfileState {
  const GetAllBusinessProfilePaginationFailedState({
    this.businessProfileStatus = BusinessProfileStatus.failedForBusinessProfile,
    this.message = '',
  });

  final BusinessProfileStatus businessProfileStatus;
  final String message;

  @override
  List<Object?> get props => [
        businessProfileStatus,
        message,
      ];
}

class GetAllBusinessProfilePaginationExceptionState
    extends BusinessProfileState {
  const GetAllBusinessProfilePaginationExceptionState({
    this.businessProfileStatus =
        BusinessProfileStatus.exceptionForBusinessProfile,
    this.message = '',
    this.stackTrace,
    this.exception,
  });

  final BusinessProfileStatus businessProfileStatus;
  final String message;
  final StackTrace? stackTrace;
  final Exception? exception;

  @override
  List<Object?> get props =>
      [stackTrace, businessProfileStatus, message, exception];
}

class GetAllBusinessProfilePaginationLoadingState extends BusinessProfileState {
  const GetAllBusinessProfilePaginationLoadingState(
      {this.message = '',
      this.businessProfileStatus = BusinessProfileStatus.loadingForBusinessType,
      this.isLoading = true});

  final bool isLoading;
  final BusinessProfileStatus businessProfileStatus;
  final String message;

  @override
  List<Object?> get props => [isLoading, businessProfileStatus, message];
}

class GetAllBusinessProfilePaginationProcessingState
    extends BusinessProfileState {
  const GetAllBusinessProfilePaginationProcessingState(
      {this.message = '',
      this.businessProfileStatus =
          BusinessProfileStatus.loadingForBusinessProfile,
      this.isProcessing = true});

  final bool isProcessing;
  final BusinessProfileStatus businessProfileStatus;
  final String message;

  @override
  List<Object?> get props => [isProcessing, businessProfileStatus, message];
}

// Get All User with Pagination
class GetAllAppUserProfilePaginationState extends BusinessProfileState {
  const GetAllAppUserProfilePaginationState({
    this.businessProfileID = -1,
    this.appUserEntities = const [],
    this.searchItem = '',
    this.pageSize = 10,
    this.pageKey = 1,
    this.endTime,
    this.filtering = '',
    this.sorting = '',
    this.startTime,
  });

  final List<AppUserEntity> appUserEntities;
  final int businessProfileID;

  final int pageKey;
  final int pageSize;
  final String searchItem;
  final String? filtering;
  final String? sorting;
  final Timestamp? startTime;
  final Timestamp? endTime;

  @override
  List<Object?> get props => [
        appUserEntities,
        businessProfileID,
        pageKey,
        pageSize,
        searchItem,
        endTime,
        filtering,
        sorting,
        startTime,
      ];
}

class GetAllAppUserProfileEmptyState extends BusinessProfileState {
  const GetAllAppUserProfileEmptyState({
    this.appUserEntities = const [],
    this.message = '',
    this.businessProfileStatus = BusinessProfileStatus.emptyForBusinessType,
  });

  final List<AppUserEntity> appUserEntities;
  final String message;
  final BusinessProfileStatus businessProfileStatus;

  @override
  List<Object?> get props => [
        appUserEntities,
        message,
        businessProfileStatus,
      ];
}

class GetAllAppUserProfileFailedState extends BusinessProfileState {
  const GetAllAppUserProfileFailedState({
    this.businessProfileStatus = BusinessProfileStatus.failedForBusinessProfile,
    this.message = '',
  });

  final BusinessProfileStatus businessProfileStatus;
  final String message;

  @override
  List<Object?> get props => [
        businessProfileStatus,
        message,
      ];
}

class GetAllAppUserProfileExceptionState extends BusinessProfileState {
  const GetAllAppUserProfileExceptionState({
    this.businessProfileStatus =
        BusinessProfileStatus.exceptionForBusinessProfile,
    this.message = '',
    this.stackTrace,
    this.exception,
  });

  final BusinessProfileStatus businessProfileStatus;
  final String message;
  final StackTrace? stackTrace;
  final Exception? exception;

  @override
  List<Object?> get props =>
      [businessProfileStatus, message, stackTrace, exception];
}

class GetAllAppUserProfileLoadingState extends BusinessProfileState {
  const GetAllAppUserProfileLoadingState(
      {this.message = '',
      this.businessProfileStatus = BusinessProfileStatus.loadingForBusinessType,
      this.isLoading = true});

  final bool isLoading;
  final BusinessProfileStatus businessProfileStatus;
  final String message;

  @override
  List<Object?> get props => [
        businessProfileStatus,
        isLoading,
        message,
      ];
}

class GetAllAppUserProfileProcessingState extends BusinessProfileState {
  const GetAllAppUserProfileProcessingState(
      {this.message = '',
      this.businessProfileStatus =
          BusinessProfileStatus.loadingForBusinessProfile,
      this.isProcessing = true});

  final bool isProcessing;
  final BusinessProfileStatus businessProfileStatus;
  final String message;

  @override
  List<Object?> get props => [isProcessing, businessProfileStatus, message];
}
