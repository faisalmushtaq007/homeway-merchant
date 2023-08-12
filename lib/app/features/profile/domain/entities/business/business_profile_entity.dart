part of 'package:homemakers_merchant/app/features/profile/index.dart';

class BusinessProfileEntity {
  const BusinessProfileEntity({
    this.userName = '',
    this.businessProfileID = -1,
    this.businessPhoneNumber = '',
    this.businessAddress,
    this.businessEmailAddress = '',
    this.businessName = '',
    this.businessTypeEntity,
    this.businessDocumentUploadedEntity,
  });

  factory BusinessProfileEntity.fromMap(Map<String, dynamic> map) {
    return BusinessProfileEntity(
      businessProfileID: map['businessProfileID'] as int,
      userName: map['userName'] as String,
      businessPhoneNumber: map['businessPhoneNumber'] as String,
      businessAddress: (map['businessAddress'] != null) ? AddressModel.fromJson(map['businessAddress']) : AddressModel(),
      businessEmailAddress: map['businessEmailAddress'] as String,
      businessName: map['businessName'] as String,
      businessTypeEntity: map['businessTypeEntity'] != null ? BusinessTypeEntity.fromMap(map['businessTypeEntity']) : BusinessTypeEntity(),
      businessDocumentUploadedEntity: map['businessDocumentUploadedEntity'] != null
          ? BusinessDocumentUploadedEntity.fromMap(map['businessDocumentUploadedEntity'])
          : BusinessDocumentUploadedEntity(),
    );
  }

  final int businessProfileID;
  final String? userName;
  final String? businessPhoneNumber;
  final AddressModel? businessAddress;
  final String? businessEmailAddress;
  final String? businessName;
  final BusinessTypeEntity? businessTypeEntity;
  final BusinessDocumentUploadedEntity? businessDocumentUploadedEntity;

  Map<String, dynamic> toMap() {
    return {
      'businessProfileID': this.businessProfileID,
      'userName': this.userName,
      'businessPhoneNumber': this.businessPhoneNumber,
      'businessAddress': this.businessAddress?.toMap(),
      'businessEmailAddress': this.businessEmailAddress,
      'businessName': this.businessName,
      'businessTypeEntity': this.businessTypeEntity?.toMap(),
      'businessDocumentUploadedEntity': this.businessDocumentUploadedEntity?.toMap(),
    };
  }

  BusinessProfileEntity copyWith({
    int? businessProfileID,
    String? userName,
    String? businessPhoneNumber,
    AddressModel? businessAddress,
    String? businessEmailAddress,
    String? businessName,
  }) {
    return BusinessProfileEntity(
      businessProfileID: businessProfileID ?? this.businessProfileID,
      userName: userName ?? this.userName,
      businessPhoneNumber: businessPhoneNumber ?? this.businessPhoneNumber,
      businessAddress: businessAddress ?? this.businessAddress,
      businessEmailAddress: businessEmailAddress ?? this.businessEmailAddress,
      businessName: businessName ?? this.businessName,
    );
  }
}
