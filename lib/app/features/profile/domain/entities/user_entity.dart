import 'package:homemakers_merchant/app/features/address/domain/entities/address_model.dart';
import 'package:homemakers_merchant/app/features/menu/index.dart';
import 'package:homemakers_merchant/app/features/profile/common/profile_status_enum.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/business/business_profile_entity.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/business/business_type_entity.dart';
import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';
import 'package:homemakers_merchant/core/common/entity/ratingAndReviewEntity.dart';
import 'package:network_manager/network_manager.dart';

class AppUserEntity extends INetworkModel<AppUserEntity> {
  AppUserEntity({
    this.userID = -1,
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
      userID: map['userID'] as int,
      phoneNumber: map['phoneNumber'] as String,
      businessProfile: (map['businessProfile'] != null) ? BusinessProfileEntity.fromMap(map['businessProfile']) : null,
      stores: map['stores'].map((e) => StoreEntity.fromMap(e)).toList().cast<StoreEntity>(),
      token: map['token'] as String,
      tokenCreationDateTime: map['tokenCreationDateTime'] as DateTime,
      hasUserAuthenticated: map['hasUserAuthenticated'] as bool,
      businessTypeEntity: (map['businessTypeEntity'] != null) ? BusinessTypeEntity.fromMap(map['businessTypeEntity']) : null,
      currentProfileStatus: (map['currentProfileStatus'] != null) ? CurrentProfileStatus.values.byName(map['currentProfileStatus']) : CurrentProfileStatus.none,
      menus: map['menus'].map((e) => MenuEntity.fromMap(e)).toList().cast<MenuEntity>(),
      drivers: map['drivers'].map((e) => StoreOwnDeliveryPartnersInfo.fromMap(e)).toList().cast<StoreOwnDeliveryPartnersInfo>(),
      addons: map['addons'].map((e) => Addons.fromMap(e)).toList().cast<Addons>(),
      ratingAndReviewEntity: (map['ratingAndReviewEntity'] != null) ? RatingAndReviewEntity.fromMap(map['ratingAndReviewEntity']) : null,
    );
  }

  int userID;
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
      {int? userID,
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
      'userID': this.userID,
      'phoneNumber': this.phoneNumber,
      'businessProfile': this.businessProfile?.toMap(),
      'stores': this.stores.map((e) => e.toMap()).toList(growable: false),
      'token': this.token,
      'tokenCreationDateTime': this.tokenCreationDateTime,
      'hasUserAuthenticated': this.hasUserAuthenticated,
      'businessTypeEntity': this.businessTypeEntity?.toMap(),
      'currentProfileStatus': this.currentProfileStatus.name,
      'menus': this.menus.map((e) => e.toMap()).toList(growable: false),
      'drivers': this.drivers.map((e) => e.toMap()).toList(growable: false),
      'addons': this.addons.map((e) => e.toMap()).toList(growable: false),
      'ratingAndReviewEntity': this.ratingAndReviewEntity?.toMap(),
    };
  }

  @override
  AppUserEntity fromJson(Map<String, dynamic> json) => AppUserEntity.fromMap(json);

  @override
  Map<String, dynamic>? toJson() => toMap();
}
