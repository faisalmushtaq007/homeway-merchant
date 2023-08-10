part of 'package:homemakers_merchant/app/features/profile/index.dart';

class BusinessProfileEntity {
  const BusinessProfileEntity({
    this.userName = '',
    this.id = -1,
    this.businessPhoneNumber = '',
    this.businessAddress,
    this.businessEmailAddress = '',
    this.businessName = '',
  });

  factory BusinessProfileEntity.fromMap(Map<String, dynamic> map) {
    return BusinessProfileEntity(
      id: map['id'] as int,
      userName: map['userName'] as String,
      businessPhoneNumber: map['businessPhoneNumber'] as String,
      businessAddress: map['businessAddress'] ?? AddressModel() as AddressModel,
      businessEmailAddress: map['businessEmailAddress'] as String,
      businessName: map['businessName'] as String,
    );
  }
  final int id;
  final String? userName;
  final String? businessPhoneNumber;
  final AddressModel? businessAddress;
  final String? businessEmailAddress;
  final String? businessName;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'userName': this.userName,
      'businessPhoneNumber': this.businessPhoneNumber,
      'businessAddress': this.businessAddress,
      'businessEmailAddress': this.businessEmailAddress,
      'businessName': this.businessName,
    };
  }

  BusinessProfileEntity copyWith({
    int? id,
    String? userName,
    String? businessPhoneNumber,
    AddressModel? businessAddress,
    String? businessEmailAddress,
    String? businessName,
  }) {
    return BusinessProfileEntity(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      businessPhoneNumber: businessPhoneNumber ?? this.businessPhoneNumber,
      businessAddress: businessAddress ?? this.businessAddress,
      businessEmailAddress: businessEmailAddress ?? this.businessEmailAddress,
      businessName: businessName ?? this.businessName,
    );
  }
}
