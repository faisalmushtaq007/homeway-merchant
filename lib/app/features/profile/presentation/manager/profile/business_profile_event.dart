part of 'business_profile_bloc.dart';

abstract class BusinessProfileEvent with AppEquatable {
  BusinessProfileEvent();
}

class SaveBusinessType extends BusinessProfileEvent {
  SaveBusinessType({required this.businessTypeEntity, this.hasEditBusinessType = false});
  final BusinessTypeEntity businessTypeEntity;
  final bool hasEditBusinessType;
  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [businessTypeEntity, hasEditBusinessType];
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
  SaveBusinessProfile({required this.businessProfileEntity, this.hasEditBusinessProfile = false});
  final BusinessProfileEntity businessProfileEntity;
  final bool hasEditBusinessProfile;
  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [businessProfileEntity, hasEditBusinessProfile];
}

class DeleteBusinessProfile extends BusinessProfileEvent {
  DeleteBusinessProfile({required this.businessProfileID, this.businessProfileEntity});
  final BusinessProfileEntity? businessProfileEntity;
  final int businessProfileID;
  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [businessProfileEntity, businessProfileID];
}

class GetBusinessProfile extends BusinessProfileEvent {
  GetBusinessProfile({required this.businessProfileID, this.businessProfileEntity});
  final BusinessProfileEntity? businessProfileEntity;
  final int businessProfileID;
  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [businessProfileEntity, businessProfileID];
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
