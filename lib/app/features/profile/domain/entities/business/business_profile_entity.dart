part of 'package:homemakers_merchant/app/features/profile/index.dart';

class BusinessProfileEntity with AppEquatable {
  BusinessProfileEntity({
    this.userName = '',
    this.businessProfileID = -1,
    this.businessPhoneNumber = '',
    this.businessAddress,
    this.businessEmailAddress = '',
    this.businessName = '',
    this.businessTypeEntity,
    this.businessDocumentUploadedEntity,
    this.isoCode = 'SA',
    this.countryDialCode = '+966',
    this.phoneNumberWithoutDialCode = '',
    this.newBusinessDocumentEntity,
    this.allBusinessDocuments = const [],
    this.profileImageEntity,
  });

  factory BusinessProfileEntity.fromMap(Map<String, dynamic> map) {
    return BusinessProfileEntity(
      businessProfileID: map['businessProfileID'] ?? -1,
      userName: map['userName'] ?? '',
      businessPhoneNumber: map['businessPhoneNumber'] ?? '',
      businessAddress: (map['businessAddress'] != null)
          ? AddressModel.fromJson(map['businessAddress'])
          : AddressModel(),
      businessEmailAddress: map['businessEmailAddress'] ?? '',
      businessName: map['businessName'] ?? '',
      businessTypeEntity: map['businessTypeEntity'] != null
          ? BusinessTypeEntity.fromMap(map['businessTypeEntity'])
          : BusinessTypeEntity(),
      businessDocumentUploadedEntity:
          map['businessDocumentUploadedEntity'] != null
              ? BusinessDocumentUploadedEntity.fromMap(
                  map['businessDocumentUploadedEntity'])
              : BusinessDocumentUploadedEntity(),
      isoCode: map['isoCode'] ?? 'SA',
      countryDialCode: map['country_dial_code'] ?? '+966',
      phoneNumberWithoutDialCode: map['phoneNumberWithoutDialCode'] ?? '',
      newBusinessDocumentEntity: (map['businessDocumentEntity'] != null)
          ? NewBusinessDocumentEntity.fromMap(map['businessDocumentEntity'])
          : NewBusinessDocumentEntity(),
      allBusinessDocuments: (map['allBusinessDocuments'] != null)
          ? map['allBusinessDocuments']
              .map((e) => NewBusinessDocumentEntity.fromMap(e))
              .toList()
              .cast<NewBusinessDocumentEntity>()
          : <NewBusinessDocumentEntity>[],
      profileImageEntity: map['profileImage'] != null
          ? CaptureImageEntity.fromMap(map['profileImage'])
          : null,
    );
  }

  final int businessProfileID;
  final String userName;
  final String businessPhoneNumber;
  final AddressModel? businessAddress;
  final String businessEmailAddress;
  final String businessName;
  final String countryDialCode;
  final String isoCode;
  final BusinessTypeEntity? businessTypeEntity;
  final BusinessDocumentUploadedEntity? businessDocumentUploadedEntity;
  final String phoneNumberWithoutDialCode;
  final NewBusinessDocumentEntity? newBusinessDocumentEntity;
  final List<NewBusinessDocumentEntity> allBusinessDocuments;
  final CaptureImageEntity? profileImageEntity;

  Map<String, dynamic> toMap() {
    return {
      'businessProfileID': businessProfileID,
      'userName': userName,
      'businessPhoneNumber': businessPhoneNumber,
      'businessAddress': (businessAddress.isNotNull)
          ? businessAddress?.toMap()
          : AddressModel().toMap(),
      'businessEmailAddress': businessEmailAddress,
      'businessName': businessName,
      'businessTypeEntity': (businessTypeEntity.isNotNull)
          ? businessTypeEntity?.toMap()
          : BusinessTypeEntity().toMap(),
      'businessDocumentUploadedEntity':
          (businessDocumentUploadedEntity.isNotNull)
              ? businessDocumentUploadedEntity?.toMap()
              : BusinessDocumentUploadedEntity().toMap(),
      'isoCode': isoCode ?? 'SA',
      'country_dial_code': countryDialCode ?? '+966',
      'phoneNumberWithoutDialCode': phoneNumberWithoutDialCode ?? '',
      'newBusinessDocumentEntity': newBusinessDocumentEntity?.toMap() ??
          NewBusinessDocumentEntity().toMap(),
      'allBusinessDocuments': (allBusinessDocuments.isNotNullOrEmpty)
          ? this.allBusinessDocuments.map((e) => e.toMap()).toList()
          : <NewBusinessDocumentEntity>[],
      'profileImage':
          profileImageEntity?.toMap() ?? CaptureImageEntity().toMap()
    };
  }

  BusinessProfileEntity copyWith({
    int? businessProfileID,
    String? userName,
    String? businessPhoneNumber,
    AddressModel? businessAddress,
    String? businessEmailAddress,
    String? businessName,
    String? countryDialCode,
    String? isoCode,
    BusinessTypeEntity? businessTypeEntity,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    String? phoneNumberWithoutDialCode,
    NewBusinessDocumentEntity? newBusinessDocumentEntity,
    List<NewBusinessDocumentEntity>? allBusinessDocuments,
    CaptureImageEntity? profileImageEntity,
  }) {
    return BusinessProfileEntity(
      businessProfileID: businessProfileID ?? this.businessProfileID,
      userName: userName ?? this.userName,
      businessPhoneNumber: businessPhoneNumber ?? this.businessPhoneNumber,
      businessAddress: businessAddress ?? this.businessAddress,
      businessEmailAddress: businessEmailAddress ?? this.businessEmailAddress,
      businessName: businessName ?? this.businessName,
      countryDialCode: countryDialCode ?? this.countryDialCode,
      isoCode: isoCode ?? this.isoCode,
      businessTypeEntity: businessTypeEntity ?? this.businessTypeEntity,
      businessDocumentUploadedEntity:
          businessDocumentUploadedEntity ?? this.businessDocumentUploadedEntity,
      phoneNumberWithoutDialCode:
          phoneNumberWithoutDialCode ?? this.phoneNumberWithoutDialCode,
      newBusinessDocumentEntity:
          newBusinessDocumentEntity ?? this.newBusinessDocumentEntity,
      allBusinessDocuments: allBusinessDocuments ?? this.allBusinessDocuments,
      profileImageEntity: profileImageEntity ?? this.profileImageEntity,
    );
  }

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        userName,
        businessProfileID,
        businessPhoneNumber,
        businessAddress,
        businessEmailAddress,
        businessName,
        businessTypeEntity,
        businessDocumentUploadedEntity,
        isoCode,
        countryDialCode,
        phoneNumberWithoutDialCode,
        newBusinessDocumentEntity,
        allBusinessDocuments,
        profileImageEntity,
      ];
}
