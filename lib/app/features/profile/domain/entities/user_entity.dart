import 'package:homemakers_merchant/app/features/address/domain/entities/address_model.dart';
import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';

class AppUserEntity {
  final int id;
  final String? userID;
  final String? phoneNumber;
  final BusinessProfile? businessProfile;
  final List<StoreEntity> stores;
  final String token;
  final DateTime? tokenCreationDateTime;
  final bool hasUserAuthenticated;

  const AppUserEntity({
    this.userID,
    this.id=-1,
    this.phoneNumber,
    this.businessProfile,
    this.stores = const [],
    this.token='',
    this.tokenCreationDateTime,
    this.hasUserAuthenticated=false,
  });

  AppUserEntity copyWith({
    int? id,
    String? userID,
    String? phoneNumber,
    BusinessProfile? businessProfile,
    List<StoreEntity>? stores,
    String? token,
    DateTime? tokenCreationDateTime,
    bool? hasUserAuthenticated,
  }) {
    return AppUserEntity(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      businessProfile: businessProfile ?? this.businessProfile,
      stores: stores ?? this.stores,
      token: token ?? this.token,
      tokenCreationDateTime:
          tokenCreationDateTime ?? this.tokenCreationDateTime,
        hasUserAuthenticated:hasUserAuthenticated??this.hasUserAuthenticated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'userID': this.userID,
      'phoneNumber': this.phoneNumber,
      'businessProfile': this.businessProfile,
      'stores': this.stores,
      'token': this.token,
      'tokenCreationDateTime': this.tokenCreationDateTime,
      'hasUserAuthenticated':this.hasUserAuthenticated,
    };
  }

  factory AppUserEntity.fromMap(Map<String, dynamic> map) {
    return AppUserEntity(
      id: map['id'] as int,
      userID: map['userID'] as String,
      phoneNumber: map['phoneNumber'] as String,
      businessProfile: map['businessProfile'] as BusinessProfile,
      stores: map['stores'] as List<StoreEntity>,
      token: map['token'] as String,
      tokenCreationDateTime: map['tokenCreationDateTime'] as DateTime,
        hasUserAuthenticated:map['hasUserAuthenticated'] as bool,
    );
  }
}

class BusinessProfile {
  final int id;
  final String? userName;
  final String? businessPhoneNumber;
  final AddressModel? businessAddress;
  final String? businessEmailAddress;
  final String? businessName;

  const BusinessProfile({
    this.userName,
    this.id=-1,
    this.businessPhoneNumber,
    this.businessAddress,
    this.businessEmailAddress,
    this.businessName,
  });

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

  factory BusinessProfile.fromMap(Map<String, dynamic> map) {
    return BusinessProfile(
      id: map['id'] as int,
      userName: map['userName'] as String,
      businessPhoneNumber: map['businessPhoneNumber'] as String,
      businessAddress: map['businessAddress'] as AddressModel,
      businessEmailAddress: map['businessEmailAddress'] as String,
      businessName: map['businessName'] as String,
    );
  }

  BusinessProfile copyWith({
    int? id,
    String? userName,
    String? businessPhoneNumber,
    AddressModel? businessAddress,
    String? businessEmailAddress,
    String? businessName,
  }) {
    return BusinessProfile(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      businessPhoneNumber: businessPhoneNumber ?? this.businessPhoneNumber,
      businessAddress: businessAddress ?? this.businessAddress,
      businessEmailAddress: businessEmailAddress ?? this.businessEmailAddress,
      businessName: businessName ?? this.businessName,
    );
  }
}
