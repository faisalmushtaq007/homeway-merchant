part of 'business_profile_bloc.dart';

abstract class BusinessProfileEvent with AppEquatable {
  BusinessProfileEvent();
}

class SaveBusinessType extends BusinessProfileEvent {
  SaveBusinessType({
    required this.businessTypeEntity,
    this.hasEditBusinessType = false,
    this.businessProfileEntity,
  });

  final BusinessTypeEntity businessTypeEntity;
  final BusinessProfileEntity? businessProfileEntity;
  final bool hasEditBusinessType;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [businessTypeEntity, hasEditBusinessType, businessProfileEntity];
}

class GetBusinessType extends BusinessProfileEvent {
  GetBusinessType({required this.businessTypeEntity, this.hasEditBusinessType = false});

  final BusinessTypeEntity businessTypeEntity;
  final bool hasEditBusinessType;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [businessTypeEntity, hasEditBusinessType];
}

class SaveBusinessProfile extends BusinessProfileEvent {
  SaveBusinessProfile({
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
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters =>
      [
        businessProfileEntity,
        hasEditBusinessProfile,
        currentIndex,
        hasSaveBusinessType,
      ];
}

class DeleteBusinessProfile extends BusinessProfileEvent {
  DeleteBusinessProfile({
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
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters =>
      [
        businessProfileEntity,
        businessProfileID,
        index,
        businessProfileEntities,
      ];
}

class GetBusinessProfile extends BusinessProfileEvent {
  GetBusinessProfile({
    required this.businessProfileID,
    this.businessProfileEntity,
    this.index = -1,
  });

  final BusinessProfileEntity? businessProfileEntity;
  final int businessProfileID;
  final int index;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [businessProfileEntity, businessProfileID, index];
}

class DeleteAllBusinessProfile extends BusinessProfileEvent {
  DeleteAllBusinessProfile({this.businessProfileID = -1, this.businessProfileEntity});

  final BusinessProfileEntity? businessProfileEntity;
  final int businessProfileID;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [businessProfileEntity, businessProfileID];
}

class GetAllBusinessProfile extends BusinessProfileEvent {
  GetAllBusinessProfile({
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
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters =>
      [
        businessProfileEntity,
        businessProfileID,
        pageKey,
        pageSize,
        searchItem,
      ];
}

class NavigateToAddressPage extends BusinessProfileEvent {
  NavigateToAddressPage({this.businessProfileEntity, this.businessTypeEntity});

  final BusinessProfileEntity? businessProfileEntity;
  final BusinessTypeEntity? businessTypeEntity;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [businessProfileEntity, businessTypeEntity];
}

class GetCurrentUserProfile extends BusinessProfileEvent {
  GetCurrentUserProfile({
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
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters =>
      [businessProfileID, userID, accessToken, phoneNumberWithFormat, phoneNumberWithoutFormat,];
}
