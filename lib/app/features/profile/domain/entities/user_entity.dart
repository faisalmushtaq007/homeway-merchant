import 'package:homemakers_merchant/app/features/address/domain/entities/address_model.dart';
import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';

class UserEntity {
  final String? userID;
  final String? phoneNumber;
  final BusinessProfile? businessProfile;
  final List<StoreEntity> stores;

  const UserEntity({
    this.userID,
    this.phoneNumber,
    this.businessProfile,
    this.stores = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': this.userID,
      'phoneNumber': this.phoneNumber,
      'businessProfile': this.businessProfile,
      'stores': this.stores,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      userID: map['userID'] as String,
      phoneNumber: map['phoneNumber'] as String,
      businessProfile: map['businessProfile'] as BusinessProfile,
      stores: map['stores'] as List<StoreEntity>,
    );
  }

  UserEntity copyWith({
    String? userID,
    String? phoneNumber,
    BusinessProfile? businessProfile,
    List<StoreEntity>? stores,
  }) {
    return UserEntity(
      userID: userID ?? this.userID,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      businessProfile: businessProfile ?? this.businessProfile,
      stores: stores ?? this.stores,
    );
  }
}

class BusinessProfile {
  final String? userName;
  final String? businessPhoneNumber;
  final AddressModel? businessAddress;
  final String? businessEmailAddress;
  final String? businessName;

  const BusinessProfile({
    this.userName,
    this.businessPhoneNumber,
    this.businessAddress,
    this.businessEmailAddress,
    this.businessName,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': this.userName,
      'businessPhoneNumber': this.businessPhoneNumber,
      'businessAddress': this.businessAddress,
      'businessEmailAddress': this.businessEmailAddress,
      'businessName': this.businessName,
    };
  }

  factory BusinessProfile.fromMap(Map<String, dynamic> map) {
    return BusinessProfile(
      userName: map['userName'] as String,
      businessPhoneNumber: map['businessPhoneNumber'] as String,
      businessAddress: map['businessAddress'] as AddressModel,
      businessEmailAddress: map['businessEmailAddress'] as String,
      businessName: map['businessName'] as String,
    );
  }

  BusinessProfile copyWith({
    String? userName,
    String? businessPhoneNumber,
    AddressModel? businessAddress,
    String? businessEmailAddress,
    String? businessName,
  }) {
    return BusinessProfile(
      userName: userName ?? this.userName,
      businessPhoneNumber: businessPhoneNumber ?? this.businessPhoneNumber,
      businessAddress: businessAddress ?? this.businessAddress,
      businessEmailAddress: businessEmailAddress ?? this.businessEmailAddress,
      businessName: businessName ?? this.businessName,
    );
  }
}
