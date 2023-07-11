import 'package:homemakers_merchant/app/features/address/domain/entities/address_model.dart';
import 'package:homemakers_merchant/app/features/profile/common/profile_status_enum.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/business/business_profile_entity.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/business/business_type_entity.dart';
import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';

class AppUserEntity {
  AppUserEntity({
    this.id = -1,
    this.userID,
    this.phoneNumber,
    this.businessProfile,
    this.stores = const [],
    this.token = '',
    this.tokenCreationDateTime,
    this.hasUserAuthenticated = false,
    this.businessTypeEntity,
    this.currentProfileStatus = CurrentProfileStatus.none,
  });

  factory AppUserEntity.fromMap(Map<String, dynamic> map) {
    return AppUserEntity(
      id: map['id'] as int,
      userID: map['userID'] as String,
      phoneNumber: map['phoneNumber'] as String,
      businessProfile: map['businessProfile'] as BusinessProfileEntity,
      stores: map['stores'] as List<StoreEntity>,
      token: map['token'] as String,
      tokenCreationDateTime: map['tokenCreationDateTime'] as DateTime,
      hasUserAuthenticated: map['hasUserAuthenticated'] as bool,
      businessTypeEntity: map['businessTypeEntity'] as BusinessTypeEntity,
      currentProfileStatus: map['currentProfileStatus'] as CurrentProfileStatus,
    );
  }
  int id;
  String? userID;
  String? phoneNumber;
  BusinessProfileEntity? businessProfile;
  List<StoreEntity> stores;
  String token;
  DateTime? tokenCreationDateTime;
  bool hasUserAuthenticated;
  BusinessTypeEntity? businessTypeEntity;
  CurrentProfileStatus currentProfileStatus;

  AppUserEntity copyWith({
    int? id,
    String? userID,
    String? phoneNumber,
    BusinessProfileEntity? businessProfile,
    List<StoreEntity>? stores,
    String? token,
    DateTime? tokenCreationDateTime,
    bool? hasUserAuthenticated,
    BusinessTypeEntity? businessTypeEntity,
    CurrentProfileStatus? currentProfileStatus,
  }) {
    return AppUserEntity(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      businessProfile: businessProfile ?? this.businessProfile,
      stores: stores ?? this.stores,
      token: token ?? this.token,
      tokenCreationDateTime: tokenCreationDateTime ?? this.tokenCreationDateTime,
      hasUserAuthenticated: hasUserAuthenticated ?? this.hasUserAuthenticated,
      businessTypeEntity: businessTypeEntity ?? this.businessTypeEntity,
      currentProfileStatus: currentProfileStatus ?? this.currentProfileStatus,
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
      'hasUserAuthenticated': this.hasUserAuthenticated,
      'businessTypeEntity': this.businessTypeEntity,
      'currentProfileStatus': this.currentProfileStatus,
    };
  }
}
