part of 'package:homemakers_merchant/app/features/profile/index.dart';

class AppUserEntity extends INetworkModel<AppUserEntity> {
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
  });

  factory AppUserEntity.fromMap(Map<String, dynamic> map) {
    return AppUserEntity(
      userID: map['userID'] as int,
      phoneNumber: map['phoneNumber'] as String,
      country_dial_code: map['country_dial_code'] ?? '+966' as String,
      user_type: map['user_type'] ?? 'merchant' as String,
      isoCode: map['isoCode'] ?? 'SA' as String,
      businessProfile: (map['businessProfile'] != null) ? BusinessProfileEntity.fromMap(map['businessProfile']) : BusinessProfileEntity(),
      stores: map['stores'].map((e) => StoreEntity.fromMap(e)).toList().cast<StoreEntity>(),
      token: map['token'] as String,
      tokenCreationDateTime: (map['tokenCreationDateTime'] != null &&
              (!(map['tokenCreationDateTime'].runtimeType is DateTime)) &&
              (map['tokenCreationDateTime'].runtimeType is Timestamp || map['tokenCreationDateTime'].runtimeType is String))
          ? Timestamp.parse(map['tokenCreationDateTime'].toString()).toDateTime()
          : DateTime.now(),
      hasUserAuthenticated: map['hasUserAuthenticated'] as bool,
      businessTypeEntity: (map['businessTypeEntity'] != null) ? BusinessTypeEntity.fromMap(map['businessTypeEntity']) : BusinessTypeEntity(),
      currentProfileStatus: (map['currentProfileStatus'] != null) ? CurrentProfileStatus.values.byName(map['currentProfileStatus']) : CurrentProfileStatus.none,
      menus: map['menus'].map((e) => MenuEntity.fromMap(e)).toList().cast<MenuEntity>(),
      drivers: map['drivers'].map((e) => StoreOwnDeliveryPartnersInfo.fromMap(e)).toList().cast<StoreOwnDeliveryPartnersInfo>(),
      addons: map['addons'].map((e) => Addons.fromMap(e)).toList().cast<Addons>(),
      ratingAndReviewEntity: (map['ratingAndReviewEntity'] != null) ? RatingAndReviewEntity.fromMap(map['ratingAndReviewEntity']) : RatingAndReviewEntity(),
      paymentBankEntities: (map['paymentBankEntities'] != null)
          ? map['paymentBankEntities'].map((e) => PaymentBankEntity.fromMap(e)).toList().cast<PaymentBankEntity>()
          : <PaymentBankEntity>[],
      hasMultiplePaymentBanks: (map['hasMultiplePaymentBanks'] != null) ? map['paymentBankEntity'] : false,
      paymentBankEntity: (map['paymentBankEntity'] != null) ? PaymentBankEntity.fromMap(map['paymentBankEntity']) : PaymentBankEntity(),
      hasCurrentUser: (map['hasCurrentUser'] != null) ? map['hasCurrentUser'] : false,
    );
  }

  int userID;
  String phoneNumber;
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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': this.userID,
      'phoneNumber': this.phoneNumber,
      'businessProfile': this.businessProfile?.toMap(),
      'stores': this.stores.map((e) => e.toMap()).toList(growable: false),
      'token': this.token,
      'tokenCreationDateTime': Timestamp.fromDateTime(this.tokenCreationDateTime ?? DateTime.now().toUtc()),
      'hasUserAuthenticated': this.hasUserAuthenticated,
      'businessTypeEntity': this.businessTypeEntity?.toMap(),
      'currentProfileStatus': this.currentProfileStatus.name,
      'menus': this.menus.map((e) => e.toMap()).toList(growable: false),
      'drivers': this.drivers.map((e) => e.toMap()).toList(growable: false),
      'addons': this.addons.map((e) => e.toMap()).toList(growable: false),
      'ratingAndReviewEntity': this.ratingAndReviewEntity?.toMap(),
      'hasCurrentUser': this.hasCurrentUser,
      'country_dial_code': this.country_dial_code,
      'user_type': this.user_type,
      'isoCode': this.isoCode,
    };
  }

  @override
  AppUserEntity fromJson(Map<String, dynamic> json) => AppUserEntity.fromMap(json);

  @override
  Map<String, dynamic>? toJson() => toMap();
}
