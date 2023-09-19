part of 'package:homemakers_merchant/app/features/profile/index.dart';

class AppUserEntity extends INetworkModel<AppUserEntity> with AppEquatable {
  AppUserEntity({
    this.userID = -1,
    this.phoneNumber = '',
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
    this.paymentBankEntity,
    this.hasMultiplePaymentBanks = false,
    this.paymentBankEntities = const [],
    this.hasCurrentUser = false,
    this.country_dial_code = '+966',
    this.user_type = 'merchant',
    this.isoCode = 'SA',
    this.access_token = '',
    this.uid = '',
    this.currentUserStage = 0,
    this.phoneNumberWithoutDialCode = '',
  });

  factory AppUserEntity.fromMap(Map<String, dynamic> map) {
    return AppUserEntity(
      userID: map['userID'] ?? -1 as int,
      phoneNumber: map['phoneNumber'] ?? '' as String,
      country_dial_code: map['country_dial_code'] ?? '+966' as String,
      user_type: map['user_type'] ?? 'merchant' as String,
      isoCode: map['isoCode'] ?? 'SA' as String,
      businessProfile: (map['businessProfile'] != null)
          ? BusinessProfileEntity.fromMap(map['businessProfile'])
          : BusinessProfileEntity(),
      stores: map['stores'] != null
          ? map['stores'].map((e) => StoreEntity.fromMap(e)).toList().cast<StoreEntity>()
          : StoreEntity(),
      token: map['token'] ?? '' as String,
      tokenCreationDateTime: (map['tokenCreationDateTime'] != null &&
              (!(map['tokenCreationDateTime'].runtimeType is DateTime)) &&
              (map['tokenCreationDateTime'].runtimeType is Timestamp ||
                  map['tokenCreationDateTime'].runtimeType is String))
          ? Timestamp.parse(map['tokenCreationDateTime'].toString()).toDateTime()
          : DateTime.now(),
      hasUserAuthenticated: map['hasUserAuthenticated'] as bool,
      businessTypeEntity: (map['businessTypeEntity'] != null)
          ? BusinessTypeEntity.fromMap(map['businessTypeEntity'])
          : BusinessTypeEntity(),
      currentProfileStatus: (map['currentProfileStatus'] != null)
          ? CurrentProfileStatus.values.byName(map['currentProfileStatus'])
          : CurrentProfileStatus.none,
      menus: (map['menus'] != null)
          ? map['menus'].map((e) => MenuEntity.fromMap(e)).toList().cast<MenuEntity>()
          : MenuEntity(),
      drivers: (map['drivers'] != null)
          ? map['drivers']
              .map((e) => StoreOwnDeliveryPartnersInfo.fromMap(e))
              .toList()
              .cast<StoreOwnDeliveryPartnersInfo>()
          : StoreOwnDeliveryPartnersInfo(),
      addons: (map['addons']) != null ? map['addons'].map((e) => Addons.fromMap(e)).toList().cast<Addons>() : Addons(),
      ratingAndReviewEntity: (map['ratingAndReviewEntity'] != null)
          ? RatingAndReviewEntity.fromMap(map['ratingAndReviewEntity'])
          : RatingAndReviewEntity(),
      paymentBankEntities: (map['paymentBankEntities'] != null)
          ? map['paymentBankEntities'].map((e) => PaymentBankEntity.fromMap(e)).toList().cast<PaymentBankEntity>()
          : <PaymentBankEntity>[],
      hasMultiplePaymentBanks: (map['hasMultiplePaymentBanks'] != null) ? map['hasMultiplePaymentBanks'] : false,
      paymentBankEntity: (map['paymentBankEntity'] != null)
          ? PaymentBankEntity.fromMap(map['paymentBankEntity'])
          : PaymentBankEntity(),
      hasCurrentUser: (map['hasCurrentUser'] != null) ? map['hasCurrentUser'] : false,
      uid: map['uid'] ?? '' as String,
      access_token: map['access_token'] ?? '' as String,
      currentUserStage: map['currentUserStage'] ?? 0 as int,
      phoneNumberWithoutDialCode: map['phoneNumberWithoutDialCode'] ?? '' as String,
    );
  }

  int userID;
  String phoneNumber;
  String phoneNumberWithoutDialCode;
  String country_dial_code;
  String isoCode;
  String user_type;
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
  PaymentBankEntity? paymentBankEntity;
  bool hasMultiplePaymentBanks;
  List<PaymentBankEntity> paymentBankEntities;
  bool hasCurrentUser;
  String uid;
  String access_token;
  int currentUserStage;

  AppUserEntity copyWith({
    int? userID,
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
    RatingAndReviewEntity? ratingAndReviewEntity,
    bool? hasCurrentUser,
    String? country_dial_code,
    String? isoCode,
    String? user_type,
    String? uid,
    String? access_token,
    int? currentUserStage,
    PaymentBankEntity? paymentBankEntity,
    bool? hasMultiplePaymentBanks,
    List<PaymentBankEntity>? paymentBankEntities,
    String? phoneNumberWithoutDialCode,
  }) {
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
      hasCurrentUser: hasCurrentUser ?? this.hasCurrentUser,
      country_dial_code: country_dial_code ?? this.country_dial_code,
      isoCode: isoCode ?? this.isoCode,
      user_type: user_type ?? this.user_type,
      uid: uid ?? this.uid,
      access_token: access_token ?? this.access_token,
      currentUserStage: currentUserStage ?? this.currentUserStage,
      paymentBankEntity: paymentBankEntity ?? this.paymentBankEntity,
      hasMultiplePaymentBanks: hasMultiplePaymentBanks ?? this.hasMultiplePaymentBanks,
      paymentBankEntities: paymentBankEntities ?? this.paymentBankEntities,
      phoneNumberWithoutDialCode: phoneNumberWithoutDialCode ?? this.phoneNumberWithoutDialCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': this.userID,
      'phoneNumber': this.phoneNumber,
      'businessProfile': (businessProfile.isNotNull) ? this.businessProfile?.toMap() : BusinessProfileEntity().toMap(),
      'stores': (stores.isNotNullOrEmpty)?this.stores.map((e) => e.toMap()).toList():<StoreEntity>[],
      'token': this.token,
      'tokenCreationDateTime': Timestamp.fromDateTime(this.tokenCreationDateTime ?? DateTime.now().toUtc()),
      'hasUserAuthenticated': this.hasUserAuthenticated,
      'businessTypeEntity':
          (businessTypeEntity.isNotNull) ? this.businessTypeEntity?.toMap() : BusinessTypeEntity().toMap(),
      'currentProfileStatus': this.currentProfileStatus.name,
      'menus': (menus.isNotNullOrEmpty)?this.menus.map((e) => e.toMap()).toList():<MenuEntity>[],
      'drivers':(drivers.isNotNullOrEmpty)?  this.drivers.map((e) => e.toMap()).toList():<StoreOwnDeliveryPartnersInfo>[],
      'addons':(addons.isNotNullOrEmpty)?  this.addons.map((e) => e.toMap()).toList():<Addons>[],
      'ratingAndReviewEntity':
          (ratingAndReviewEntity.isNotNull) ? this.ratingAndReviewEntity?.toMap() : RatingAndReviewEntity().toMap(),
      'hasCurrentUser': this.hasCurrentUser,
      'country_dial_code': this.country_dial_code,
      'user_type': this.user_type,
      'isoCode': this.isoCode,
      'uid': this.uid,
      'access_token': this.access_token,
      'currentUserStage': this.currentUserStage,
      'paymentBankEntity': paymentBankEntity.isNotNull ? paymentBankEntity?.toMap() : PaymentBankEntity().toMap(),
      'hasMultiplePaymentBanks': hasMultiplePaymentBanks,
      'paymentBankEntities':(paymentBankEntities.isNotNullOrEmpty)?this.paymentBankEntities.map((e) => e.toMap()).toList():<PaymentBankEntity>[],
      'phoneNumberWithoutDialCode': this.phoneNumberWithoutDialCode ?? '',
    };
  }

  @override
  AppUserEntity fromJson(Map<String, dynamic> json) => AppUserEntity.fromMap(json);

  @override
  Map<String, dynamic>? toJson() => toMap();

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        userID,
        phoneNumber,
        businessProfile,
        stores,
        token,
        tokenCreationDateTime,
        hasUserAuthenticated,
        businessTypeEntity,
        currentProfileStatus,
        menus,
        drivers,
        addons,
        ratingAndReviewEntity,
        hasCurrentUser,
        country_dial_code,
        isoCode,
        user_type,
        uid,
        access_token,
        currentUserStage,
        paymentBankEntity,
        hasMultiplePaymentBanks,
        paymentBankEntities,
        phoneNumberWithoutDialCode,
      ];
}
