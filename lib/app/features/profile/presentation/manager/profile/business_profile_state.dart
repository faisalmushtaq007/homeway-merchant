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

class SaveBusinessTypeState extends BusinessProfileState {
  SaveBusinessTypeState({required this.businessTypeEntity, this.hasEditBusinessType = false});

  final BusinessTypeEntity businessTypeEntity;
  final bool hasEditBusinessType;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [businessTypeEntity, hasEditBusinessType];
}

class GetBusinessTypeState extends BusinessProfileState {
  GetBusinessTypeState({required this.businessTypeEntity, this.hasEditBusinessType = false});

  final BusinessTypeEntity businessTypeEntity;
  final bool hasEditBusinessType;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [businessTypeEntity, hasEditBusinessType];
}

class SaveBusinessProfileState extends BusinessProfileState {
  SaveBusinessProfileState({required this.businessProfileEntity, this.hasEditBusinessProfile = false});

  final BusinessProfileEntity businessProfileEntity;
  final bool hasEditBusinessProfile;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [businessProfileEntity, hasEditBusinessProfile];
}

class DeleteBusinessProfileState extends BusinessProfileState {
  DeleteBusinessProfileState({required this.businessProfileID, this.businessProfileEntity});

  final BusinessProfileEntity? businessProfileEntity;
  final int businessProfileID;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [businessProfileEntity, businessProfileID];
}

class GetBusinessProfileState extends BusinessProfileState {
  GetBusinessProfileState({required this.businessProfileID, this.businessProfileEntity});

  final BusinessProfileEntity? businessProfileEntity;
  final int businessProfileID;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [businessProfileEntity, businessProfileID];
}

class NavigateToAddressPageState extends BusinessProfileState {
  NavigateToAddressPageState({this.businessProfileEntity, this.businessTypeEntity});

  final BusinessProfileEntity? businessProfileEntity;
  final BusinessTypeEntity? businessTypeEntity;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [businessProfileEntity, businessTypeEntity];
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
  BusinessProfileLoadingState({this.message = '', this.businessProfileStatus = BusinessProfileStatus.loadingBusinessProfile, this.isLoading = true});
  final bool isLoading;
  final BusinessProfileStatus businessProfileStatus;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => throw UnimplementedError();
}

class BusinessProfileProcessingState extends BusinessProfileState {
  BusinessProfileProcessingState({this.message = '', this.businessProfileStatus = BusinessProfileStatus.loadingBusinessProfile, this.isProcessing = true});
  final bool isProcessing;
  final BusinessProfileStatus businessProfileStatus;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => throw UnimplementedError();
}
