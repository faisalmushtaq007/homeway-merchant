import 'package:homemakers_merchant/app/features/address/domain/entities/address_model.dart';
import 'package:homemakers_merchant/app/features/menu/index.dart';
import 'package:homemakers_merchant/app/features/profile/common/profile_status_enum.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/business/business_profile_entity.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/business/business_type_entity.dart';
import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';
import 'package:homemakers_merchant/core/common/entity/ratingAndReviewEntity.dart';

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
    this.menus = const [],
    this.drivers = const [],
    this.addons = const [],
    this.ratingAndReviewEntity,
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
      menus: map['menus'] as List<MenuEntity>,
      drivers: map['drivers'] as List<StoreOwnDeliveryPartnersInfo>,
      addons: map['addons'] as List<Addons>,
      ratingAndReviewEntity: map['ratingAndReviewEntity'] as RatingAndReviewEntity,
    );
  }

  int id;
  String? userID;
  String? phoneNumber;
  BusinessProfileEntity? businessProfile;
  List<StoreEntity> stores;
  List<MenuEntity> menus;
  List<StoreOwnDeliveryPartnersInfo> drivers;
  String token;
  DateTime? tokenCreationDateTime;
  bool hasUserAuthenticated;
  BusinessTypeEntity? businessTypeEntity;
  CurrentProfileStatus currentProfileStatus;
  List<Addons> addons;
  RatingAndReviewEntity? ratingAndReviewEntity;

  AppUserEntity copyWith(
      {int? id,
      String? userID,
      String? phoneNumber,
      BusinessProfileEntity? businessProfile,
      List<StoreEntity>? stores,
      String? token,
      DateTime? tokenCreationDateTime,
      bool? hasUserAuthenticated,
      BusinessTypeEntity? businessTypeEntity,
      CurrentProfileStatus? currentProfileStatus,
      List<MenuEntity>? menus,
      List<StoreOwnDeliveryPartnersInfo>? drivers,
      List<Addons>? addons,
      RatingAndReviewEntity? ratingAndReviewEntity}) {
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
      menus: menus ?? this.menus,
      drivers: drivers ?? this.drivers,
      addons: addons ?? this.addons,
      ratingAndReviewEntity: ratingAndReviewEntity ?? this.ratingAndReviewEntity,
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
      'menus': this.menus,
      'drivers': this.drivers,
      'addons': this.addons,
      'ratingAndReviewEntity': this.ratingAndReviewEntity,
    };
  }
}
