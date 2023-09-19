part of 'business_profile_bloc.dart';

abstract class BusinessProfileEvent extends Equatable {
  const BusinessProfileEvent();
}

class SaveBusinessType extends BusinessProfileEvent {
  const SaveBusinessType({
    required this.businessTypeEntity,
    this.hasEditBusinessType = false,
    this.businessProfileEntity,
  });

  final BusinessTypeEntity businessTypeEntity;
  final BusinessProfileEntity? businessProfileEntity;
  final bool hasEditBusinessType;

  @override
  List<Object?> get props => [businessTypeEntity, hasEditBusinessType, businessProfileEntity];
}

class GetBusinessType extends BusinessProfileEvent {
  const GetBusinessType({required this.businessTypeEntity, this.hasEditBusinessType = false});

  final BusinessTypeEntity businessTypeEntity;
  final bool hasEditBusinessType;

  @override
  List<Object?> get props => [businessTypeEntity, hasEditBusinessType];
}

class SaveBusinessProfile extends BusinessProfileEvent {
  const SaveBusinessProfile({
    required this.businessProfileEntity,
    this.hasEditBusinessProfile = false,
    this.currentIndex = -1,
    this.hasSaveBusinessType = false,
  });

  final BusinessProfileEntity businessProfileEntity;
  final bool hasEditBusinessProfile;
  final int currentIndex;
  final bool hasSaveBusinessType;

  @override
  List<Object?> get props => [
        businessProfileEntity,
        hasEditBusinessProfile,
        currentIndex,
        hasSaveBusinessType,
      ];
}

class DeleteBusinessProfile extends BusinessProfileEvent {
  const DeleteBusinessProfile({
    required this.businessProfileID,
    this.businessProfileEntity,
    this.index = -1,
    this.businessProfileEntities = const [],
  });

  final BusinessProfileEntity? businessProfileEntity;
  final int businessProfileID;
  final int index;
  final List<BusinessProfileEntity> businessProfileEntities;

  @override
  List<Object?> get props => [
        businessProfileEntity,
        businessProfileID,
        index,
        businessProfileEntities,
      ];
}

class GetBusinessProfile extends BusinessProfileEvent {
  const GetBusinessProfile({
    required this.businessProfileID,
    this.businessProfileEntity,
    this.index = -1,
  });

  final BusinessProfileEntity? businessProfileEntity;
  final int businessProfileID;
  final int index;

  @override
  List<Object?> get props => [businessProfileEntity, businessProfileID, index];
}

class DeleteAllBusinessProfile extends BusinessProfileEvent {
  const DeleteAllBusinessProfile({this.businessProfileID = -1, this.businessProfileEntity});

  final BusinessProfileEntity? businessProfileEntity;
  final int businessProfileID;

  @override
  List<Object?> get props => [businessProfileEntity, businessProfileID];
}

class GetAllBusinessProfile extends BusinessProfileEvent {
  const GetAllBusinessProfile({
    this.businessProfileID = -1,
    this.businessProfileEntity,
    this.searchItem = '',
    this.pageSize = 10,
    this.pageKey = 1,
  });

  final BusinessProfileEntity? businessProfileEntity;
  final int businessProfileID;

  final int pageKey;
  final int pageSize;
  final String searchItem;

  @override
  List<Object?> get props => [
        businessProfileEntity,
        businessProfileID,
        pageKey,
        pageSize,
        searchItem,
      ];
}

class NavigateToAddressPage extends BusinessProfileEvent {
  const NavigateToAddressPage({this.businessProfileEntity, this.businessTypeEntity});

  final BusinessProfileEntity? businessProfileEntity;
  final BusinessTypeEntity? businessTypeEntity;

  @override
  List<Object?> get props => [businessProfileEntity, businessTypeEntity];
}

class GetCurrentUserProfile extends BusinessProfileEvent {
  const GetCurrentUserProfile({
    this.businessProfileID = 1,
    this.userID = -1,
    this.phoneNumberWithFormat = '',
    this.phoneNumberWithoutFormat = '',
    this.accessToken = '',
  });

  final int businessProfileID;
  final int userID;
  final String phoneNumberWithFormat;
  final String phoneNumberWithoutFormat;
  final String accessToken;

  @override
  List<Object?> get props => [
        businessProfileID,
        userID,
        accessToken,
        phoneNumberWithFormat,
        phoneNumberWithoutFormat,
      ];
}

class GetAllBusinessProfilePagination extends BusinessProfileEvent {
  const GetAllBusinessProfilePagination({
    this.businessProfileID = -1,
    this.businessProfileEntity,
    this.searchItem = '',
    this.pageSize = 10,
    this.pageKey = 1,
    this.endTime,
    this.filtering = '',
    this.sorting = '',
    this.startTime,
  });

  final BusinessProfileEntity? businessProfileEntity;
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
        businessProfileEntity,
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

class GetAllAppUserProfilePagination extends BusinessProfileEvent {
  const GetAllAppUserProfilePagination({
    this.businessProfileID = -1,
    this.appUserEntity,
    this.searchItem = '',
    this.pageSize = 10,
    this.pageKey = 1,
    this.endTime,
    this.filtering = '',
    this.sorting = '',
    this.startTime,
  });

  final AppUserEntity? appUserEntity;
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
    appUserEntity,
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
