part of 'package:homemakers_merchant/app/features/store/index.dart';

class StoreEntity extends INetworkModel<StoreEntity> with AppEquatable {
  StoreEntity({
    this.storeName = '',
    this.storeAddress,
    this.storeImagePath = '',
    this.storeImageMetaData = const {},
    this.storeMaximumFoodDeliveryTime = -1,
    this.storeMaximumFoodDeliveryRadius = 6,
    this.storeOpeningTime = '',
    this.storeClosingTime = '',
    this.storeID = -1,
    this.hasStoreOwnDeliveryPartners = false,
    this.storeOwnDeliveryPartnersInfo = const [],
    this.storeAvailableFoodTypes = const [],
    this.storeAvailableFoodPreparationType = const [],
    this.storeAcceptedPaymentModes = const [],
    this.storeWorkingDays = const [],
    this.menuEntities = const [],
    this.hasNewStore = true,
    this.ratingAndReviewEntity,
    this.storePhoneNumber = '',
    this.isoCode = 'SA',
    this.countryDialCode = '+966',
    this.phoneNumberWithoutDialCode = '',
    this.orders = const [],
    this.hasStoreOpened = true,
    this.hasReadyToPickupOrder = true,
    this.storeCategories = const [],
  });

  factory StoreEntity.fromMap(Map<String, dynamic> map) {
    return StoreEntity(
      storeName: map['storeName'] as String,
      storeAddress: (map['storeAddress'] != null)
          ? AddressModel.fromJson(map['storeAddress'])
          : AddressModel(),
      storeImagePath: map['storeImagePath'] as String,
      storeImageMetaData: map['storeImageMetaData'] as Map<String, dynamic>,
      storeAvailableFoodTypes: map['storeAvailableFoodTypes']
          .map((e) => StoreAvailableFoodTypes.fromMap(e))
          .toList()
          .cast<StoreAvailableFoodTypes>(),
      storeAvailableFoodPreparationType:
          map['storeAvailableFoodPreparationType']
              .map((e) => StoreAvailableFoodPreparationType.fromMap(e))
              .toList()
              .cast<StoreAvailableFoodPreparationType>(),
      hasStoreOwnDeliveryPartners:
          map['hasStoreOwnDeliveryPartners'] ?? false as bool,
      storeOwnDeliveryPartnersInfo: map['storeOwnDeliveryPartnersInfo']
          .map((e) => StoreOwnDeliveryPartnersInfo.fromMap(e))
          .toList()
          .cast<StoreOwnDeliveryPartnersInfo>(),
      storeMaximumFoodDeliveryTime: map['storeMaximumFoodDeliveryTime'] as int,
      storeMaximumFoodDeliveryRadius:
          map['storeMaximumFoodDeliveryRadius'] as int,
      storeAcceptedPaymentModes: map['storeAcceptedPaymentModes']
          .map((e) => StoreAcceptedPaymentModes.fromMap(e))
          .toList()
          .cast<StoreAcceptedPaymentModes>(),
      storeWorkingDays: map['storeWorkingDays']
          .map((e) => StoreWorkingDayAndTime.fromMap(e))
          .toList()
          .cast<StoreWorkingDayAndTime>(),
      storeOpeningTime: map['storeOpeningTime'] as String,
      storeClosingTime: map['storeClosingTime'] as String,
      storeID: map['storeID'] as int,
      menuEntities: map['menuEntities']
          .map((e) => MenuEntity.fromMap(e))
          .toList()
          .cast<MenuEntity>(),
      hasNewStore: map['hasNewStore'] ?? true as bool,
      ratingAndReviewEntity: (map['ratingAndReviewEntity'] != null)
          ? RatingAndReviewEntity.fromMap(map['ratingAndReviewEntity'])
          : RatingAndReviewEntity(),
      isoCode: map['iso_code'] ?? 'SA' as String,
      countryDialCode: map['country_dial_code'] ?? '+966' as String,
      phoneNumberWithoutDialCode:
          map['phoneNumberWithoutDialCode'] ?? '' as String,
      storePhoneNumber: map['storePhoneNumber'] as String,
      orders: map['orders']
          .map((e) => OrderEntity.fromMap(e))
          .toList()
          .cast<OrderEntity>(),
      hasStoreOpened: map['hasStoreOpened'] ?? true,
      hasReadyToPickupOrder: map['hasReadyToPickupOrder'] ?? true,
      storeCategories: map['storeCategories']
          .map((e) => Category.fromMap(e))
          .toList()
          .cast<Category>(),
    );
  }

  String storeName;
  AddressModel? storeAddress;
  String storeImagePath;
  Map<String, dynamic> storeImageMetaData;
  int storeMaximumFoodDeliveryTime;
  int storeMaximumFoodDeliveryRadius;
  String storeOpeningTime;
  String storeClosingTime;
  bool hasStoreOwnDeliveryPartners;
  List<StoreOwnDeliveryPartnersInfo> storeOwnDeliveryPartnersInfo;
  List<StoreAvailableFoodTypes> storeAvailableFoodTypes;
  List<StoreAvailableFoodPreparationType> storeAvailableFoodPreparationType;
  List<StoreAcceptedPaymentModes> storeAcceptedPaymentModes;
  List<StoreWorkingDayAndTime> storeWorkingDays;
  int storeID;
  List<MenuEntity> menuEntities;
  bool hasNewStore;
  RatingAndReviewEntity? ratingAndReviewEntity;
  String storePhoneNumber;
  String countryDialCode;
  String isoCode;
  String phoneNumberWithoutDialCode;
  List<OrderEntity> orders;
  bool hasStoreOpened;
  bool hasReadyToPickupOrder;
  List<Category> storeCategories;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeName,
        storeAddress,
        storeImagePath,
        storeImageMetaData,
        storeAvailableFoodTypes,
        storeAvailableFoodPreparationType,
        hasStoreOwnDeliveryPartners,
        storeOwnDeliveryPartnersInfo,
        storeMaximumFoodDeliveryTime,
        storeMaximumFoodDeliveryRadius,
        storeAcceptedPaymentModes,
        storeWorkingDays,
        storeOpeningTime,
        storeClosingTime,
        storeID,
        menuEntities,
        hasNewStore,
        ratingAndReviewEntity,
        storePhoneNumber,
        countryDialCode,
        isoCode,
        phoneNumberWithoutDialCode,
        orders,
        hasReadyToPickupOrder,
        hasStoreOpened,
        storeCategories,
      ];

  StoreEntity copyWith({
    String? storeName,
    AddressModel? storeAddress,
    String? storeImagePath,
    Map<String, dynamic>? storeImageMetaData,
    List<StoreAvailableFoodTypes>? storeAvailableFoodTypes,
    List<StoreAvailableFoodPreparationType>? storeAvailableFoodPreparationType,
    bool? hasStoreOwnDeliveryPartners,
    List<StoreOwnDeliveryPartnersInfo>? storeOwnDeliveryPartnersInfo,
    int? storeMaximumFoodDeliveryTime,
    int? storeMaximumFoodDeliveryRadius,
    List<StoreAcceptedPaymentModes>? storeAcceptedPaymentModes,
    List<StoreWorkingDayAndTime>? storeWorkingDays,
    String? storeOpeningTime,
    String? storeClosingTime,
    int? storeID,
    List<MenuEntity>? menuEntities,
    bool? hasNewStore,
    RatingAndReviewEntity? ratingAndReviewEntity,
    String? countryDialCode,
    String? isoCode,
    String? storePhoneNumber,
    String? phoneNumberWithoutDialCode,
    List<OrderEntity>? orders,
    bool? hasStoreOpened,
    bool? hasReadyToPickupOrder,
    List<Category>? storeCategories,
  }) {
    return StoreEntity(
      storeName: storeName ?? this.storeName,
      storeAddress: storeAddress ?? this.storeAddress,
      storeImagePath: storeImagePath ?? this.storeImagePath,
      storeImageMetaData: storeImageMetaData ?? this.storeImageMetaData,
      storeAvailableFoodTypes:
          storeAvailableFoodTypes ?? this.storeAvailableFoodTypes,
      storeAvailableFoodPreparationType: storeAvailableFoodPreparationType ??
          this.storeAvailableFoodPreparationType,
      hasStoreOwnDeliveryPartners:
          hasStoreOwnDeliveryPartners ?? this.hasStoreOwnDeliveryPartners,
      storeOwnDeliveryPartnersInfo:
          storeOwnDeliveryPartnersInfo ?? this.storeOwnDeliveryPartnersInfo,
      storeMaximumFoodDeliveryTime:
          storeMaximumFoodDeliveryTime ?? this.storeMaximumFoodDeliveryTime,
      storeMaximumFoodDeliveryRadius:
          storeMaximumFoodDeliveryRadius ?? this.storeMaximumFoodDeliveryRadius,
      storeAcceptedPaymentModes:
          storeAcceptedPaymentModes ?? this.storeAcceptedPaymentModes,
      storeWorkingDays: storeWorkingDays ?? this.storeWorkingDays,
      storeOpeningTime: storeOpeningTime ?? this.storeOpeningTime,
      storeClosingTime: storeClosingTime ?? this.storeClosingTime,
      storeID: storeID ?? this.storeID,
      menuEntities: menuEntities ?? this.menuEntities,
      hasNewStore: hasNewStore ?? this.hasNewStore,
      ratingAndReviewEntity:
          ratingAndReviewEntity ?? this.ratingAndReviewEntity,
      storePhoneNumber: storePhoneNumber ?? this.storePhoneNumber,
      countryDialCode: countryDialCode ?? this.countryDialCode,
      isoCode: isoCode ?? this.isoCode,
      phoneNumberWithoutDialCode:
          phoneNumberWithoutDialCode ?? this.phoneNumberWithoutDialCode,
      orders: orders ?? this.orders,
      hasStoreOpened: hasStoreOpened ?? this.hasStoreOpened,
      hasReadyToPickupOrder:
          hasReadyToPickupOrder ?? this.hasReadyToPickupOrder,
      storeCategories: storeCategories ?? this.storeCategories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storeName': storeName,
      'storeAddress': storeAddress?.toMap() ?? AddressModel().toJson(),
      'storeImagePath': storeImagePath,
      'storeImageMetaData': storeImageMetaData,
      'storeAvailableFoodTypes':
          storeAvailableFoodTypes.map((e) => e.toMap()).toList(),
      'storeAvailableFoodPreparationType':
          storeAvailableFoodPreparationType.map((e) => e.toMap()).toList(),
      'hasStoreOwnDeliveryPartners': hasStoreOwnDeliveryPartners,
      'storeOwnDeliveryPartnersInfo':
          storeOwnDeliveryPartnersInfo.map((e) => e.toMap()).toList(),
      'storeMaximumFoodDeliveryTime': storeMaximumFoodDeliveryTime,
      'storeMaximumFoodDeliveryRadius': storeMaximumFoodDeliveryRadius,
      'storeAcceptedPaymentModes':
          storeAcceptedPaymentModes.map((e) => e.toMap()).toList(),
      'storeWorkingDays': storeWorkingDays.map((e) => e.toMap()).toList(),
      'storeOpeningTime': storeOpeningTime,
      'storeClosingTime': storeClosingTime,
      'storeID': storeID,
      'menuEntities': menuEntities.map((e) => e.toMap()).toList(),
      'hasNewStore': hasNewStore,
      'ratingAndReviewEntity': (ratingAndReviewEntity.isNotNull)
          ? ratingAndReviewEntity?.toMap()
          : RatingAndReviewEntity().toMap(),
      'iso_code': isoCode ?? 'SA',
      'country_dial_code': countryDialCode ?? '+966',
      'phoneNumberWithoutDialCode': phoneNumberWithoutDialCode ?? '',
      'storePhoneNumber': storePhoneNumber,
      'orders': orders.map((e) => e.toMap()).toList(),
      'hasStoreOpened': hasStoreOpened,
      'hasReadyToPickupOrder': hasReadyToPickupOrder,
      'storeCategories': storeCategories.map((e) => e.toMap()).toList(),
    };
  }

  @override
  StoreEntity fromJson(Map<String, dynamic> json) {
    return StoreEntity.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson() => toMap();
}

class StoreAvailableFoodTypes with AppEquatable {
  StoreAvailableFoodTypes({
    this.title = '',
    this.id = -1,
    this.hasSelected = false,
  });

  factory StoreAvailableFoodTypes.fromMap(Map<String, dynamic> map) {
    return StoreAvailableFoodTypes(
      title: map['title'] as String,
      id: map['id'] as int,
      hasSelected: map['hasSelected'] as bool,
    );
  }

  String title;
  int id;
  bool hasSelected;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [title, id, hasSelected];

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'hasSelected': hasSelected,
    };
  }

  StoreAvailableFoodTypes copyWith({
    String? titleOfStoreAvailableFoodTypes,
    int? storeAvailableFoodTypesID,
    bool? hasSelected,
  }) {
    return StoreAvailableFoodTypes(
      title: titleOfStoreAvailableFoodTypes ?? title,
      id: storeAvailableFoodTypesID ?? id,
      hasSelected: hasSelected ?? this.hasSelected,
    );
  }
}

class StoreAvailableFoodPreparationType with AppEquatable {
  StoreAvailableFoodPreparationType({
    this.title = '',
    this.id = -1,
    this.hasSelected = false,
  });

  factory StoreAvailableFoodPreparationType.fromMap(Map<String, dynamic> map) {
    return StoreAvailableFoodPreparationType(
      title: map['title'] as String,
      id: map['id'] as int,
      hasSelected: map['hasSelected'] as bool,
    );
  }

  String title;
  int id;
  bool hasSelected;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [title, id, hasSelected];

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'hasSelected': hasSelected,
    };
  }

  StoreAvailableFoodPreparationType copyWith({
    String? titleOfStoreAvailableFoodTypes,
    int? storeAvailableFoodTypesID,
    bool? hasSelected,
  }) {
    return StoreAvailableFoodPreparationType(
      title: titleOfStoreAvailableFoodTypes ?? title,
      id: storeAvailableFoodTypesID ?? id,
      hasSelected: hasSelected ?? this.hasSelected,
    );
  }
}

class StoreAcceptedPaymentModes with AppEquatable {
  StoreAcceptedPaymentModes({
    this.title = '',
    this.id = -1,
    this.icon,
    this.hasSelected = false,
  });

  factory StoreAcceptedPaymentModes.fromMap(Map<String, dynamic> map) {
    return StoreAcceptedPaymentModes(
      title: map['title'] as String,
      id: map['id'] as int,
      hasSelected: map['hasSelected'] as bool,
    );
  }

  String title;
  int id;
  Icon? icon;
  bool hasSelected;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        title,
        id,
        icon,
        hasSelected,
      ];

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'hasSelected': hasSelected,
    };
  }

  StoreAcceptedPaymentModes copyWith(
      {String? titleOfStoreAvailableFoodTypes,
      int? storeAvailableFoodTypesID,
      Icon? icon,
      bool? hasSelected}) {
    return StoreAcceptedPaymentModes(
      title: titleOfStoreAvailableFoodTypes ?? title,
      id: storeAvailableFoodTypesID ?? id,
      icon: icon ?? this.icon,
      hasSelected: hasSelected ?? this.hasSelected,
    );
  }
}

class StoreOwnDeliveryPartnersInfo extends Equatable {
  const StoreOwnDeliveryPartnersInfo({
    this.driverID = -1,
    this.driverName = '',
    this.driverMobileNumber = '',
    this.drivingLicenseNumber = '',
    this.vehicleInfo=const VehicleInfo(),
    this.hasOnline = true,
    this.ratingAndReviewEntity=const RatingAndReviewEntity(),
    this.imageEntity=const ImageEntity(),
    this.hasDriverImage = false,
    this.deliveryMode = '',
    this.isoCode = 'SA',
    this.countryDialCode = '+966',
    this.phoneNumberWithoutDialCode = '',
    this.driverLicenseDocument,
  });

  factory StoreOwnDeliveryPartnersInfo.fromMap(Map<String, dynamic> map) {
    return StoreOwnDeliveryPartnersInfo(
      driverName: map['driverName'] as String,
      driverID: map['driverID'] as int,
      driverMobileNumber: map['driverMobileNumber'] as String,
      drivingLicenseNumber: map['drivingLicenseNumber'] as String,
      vehicleInfo: (map['vehicleInfo'] != null)
          ? VehicleInfo.fromMap(map['vehicleInfo'])
          : const VehicleInfo(),
      hasOnline: map['hasOnline'] as bool,
      ratingAndReviewEntity: (map['ratingAndReviewEntity'] != null)
          ? RatingAndReviewEntity.fromMap(map['ratingAndReviewEntity'])
          : RatingAndReviewEntity(),
      hasDriverImage: map['hasDriverImage'] as bool,
      imageEntity: (map['imageEntity'] != null)
          ? ImageEntity.fromMap(map['imageEntity'])
          : const ImageEntity(),
      deliveryMode: (map['deliveryMode'] != null) ? map['deliveryMode'] : '',
      isoCode: map['isoCode'] ?? 'SA',
      countryDialCode: map['country_dial_code'] ?? '+966',
      phoneNumberWithoutDialCode: map['phoneNumberWithoutDialCode'] ?? '',
      driverLicenseDocument: map['driverLicenseDocument'] != null
          ?NewBusinessDocumentEntity.fromMap(map['driverLicenseDocument'])
          : NewBusinessDocumentEntity(),
    );
  }

  final int driverID;
  final String driverName;
  final String driverMobileNumber;
  final String drivingLicenseNumber;
  final VehicleInfo vehicleInfo;
  final bool hasOnline;
  final RatingAndReviewEntity ratingAndReviewEntity;
  final ImageEntity imageEntity;
  final bool hasDriverImage;
  final String deliveryMode;
  final String countryDialCode;
  final String isoCode;
  final String phoneNumberWithoutDialCode;
  final NewBusinessDocumentEntity? driverLicenseDocument;

  @override
  List<Object?> get props => [
        driverID,
        driverMobileNumber,
        driverName,
        drivingLicenseNumber,
        vehicleInfo,
        hasOnline,
        ratingAndReviewEntity,
        hasDriverImage,
        imageEntity,
        deliveryMode,
        countryDialCode,
        isoCode,
        phoneNumberWithoutDialCode,
        driverLicenseDocument,
      ];

  Map<String, dynamic> toMap() {
    return {
      'driverName': driverName,
      'driverMobileNumber': driverMobileNumber,
      'drivingLicenseNumber': drivingLicenseNumber,
      'vehicleInfo': vehicleInfo?.toMap() ?? VehicleInfo().toMap(),
      'driverID': driverID,
      'hasOnline': hasOnline,
      'ratingAndReviewEntity': ratingAndReviewEntity?.toMap() ??
          RatingAndReviewEntity().toMap(),
      'hasDriverImage': hasDriverImage,
      'imageEntity': (imageEntity != null)
          ? imageEntity?.toMap()
          : ImageEntity().toMap(),
      'deliveryMode': deliveryMode,
      'isoCode': isoCode ?? 'SA',
      'country_dial_code': countryDialCode ?? '+966',
      'phoneNumberWithoutDialCode': phoneNumberWithoutDialCode ?? '',
      'driverLicenseDocument': (driverLicenseDocument != null)
          ? driverLicenseDocument?.toMap()
          : NewBusinessDocumentEntity().toMap(),
    };
  }

  StoreOwnDeliveryPartnersInfo copyWith({
    String? driverName,
    String? driverMobileNumber,
    String? drivingLicenseNumber,
    VehicleInfo? vehicleInfo,
    int? driverID,
    bool? hasOnline,
    RatingAndReviewEntity? ratingAndReviewEntity,
    ImageEntity? imageEntity,
    bool? hasDriverImage,
    int? id,
    String? deliveryMode,
    String? countryDialCode,
    String? isoCode,
    String? phoneNumberWithoutDialCode,
    NewBusinessDocumentEntity? driverLicenseDocument,
  }) {
    return StoreOwnDeliveryPartnersInfo(
      driverName: driverName ?? this.driverName,
      driverMobileNumber: driverMobileNumber ?? this.driverMobileNumber,
      drivingLicenseNumber: drivingLicenseNumber ?? this.drivingLicenseNumber,
      vehicleInfo: vehicleInfo ?? this.vehicleInfo,
      driverID: driverID ?? this.driverID,
      hasOnline: hasOnline ?? this.hasOnline,
      ratingAndReviewEntity:
          ratingAndReviewEntity ?? this.ratingAndReviewEntity,
      hasDriverImage: hasDriverImage ?? this.hasDriverImage,
      imageEntity: imageEntity ?? this.imageEntity,
      deliveryMode: deliveryMode ?? this.deliveryMode,
      countryDialCode: countryDialCode ?? this.countryDialCode,
      isoCode: isoCode ?? this.isoCode,
      phoneNumberWithoutDialCode:
          phoneNumberWithoutDialCode ?? this.phoneNumberWithoutDialCode,
      driverLicenseDocument:
          driverLicenseDocument ?? this.driverLicenseDocument,
    );
  }
}

class VehicleInfo extends Equatable {
  const VehicleInfo({
    this.vehicleID = '',
    this.vehicleType = '',
    this.vehicleNumber = '',
    this.vehicleIconPath = '',
  });

  factory VehicleInfo.fromMap(Map<String, dynamic> map) {
    return VehicleInfo(
      vehicleID: map['vehicleID'] as String,
      vehicleType: map['vehicleType'] as String,
      vehicleNumber: map['vehicleNumber'] as String,
      vehicleIconPath: map['vehicleIconPath'] as String,
    );
  }

  final String vehicleID;
  final String vehicleType;
  final String vehicleNumber;
  final String vehicleIconPath;

  @override
  List<Object?> get props => [
        vehicleID,
        vehicleType,
        vehicleNumber,
        vehicleIconPath,
      ];

  Map<String, dynamic> toMap() {
    return {
      'vehicleID': vehicleID,
      'vehicleType': vehicleType,
      'vehicleNumber': vehicleNumber,
      'vehicleIconPath': vehicleIconPath,
    };
  }

  VehicleInfo copyWith({
    String? vehicleID,
    String? vehicleType,
    String? vehicleNumber,
    String? vehicleIconPath,
  }) {
    return VehicleInfo(
      vehicleID: vehicleID ?? this.vehicleID,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      vehicleIconPath: vehicleIconPath ?? this.vehicleIconPath,
    );
  }
}

class StoreWorkingDayAndTime with AppEquatable {
  StoreWorkingDayAndTime({
    this.day = '',
    this.shortName = '',
    this.id = -1,
    this.hasSelected = false,
    this.closingTime,
    this.openingTime,
  });

  factory StoreWorkingDayAndTime.fromMap(Map<String, dynamic> map) {
    return StoreWorkingDayAndTime(
      day: map['title'] as String,
      shortName: map['shortName'] as String,
      id: map['id'] as int,
      hasSelected: map['hasSelected'] as bool,
      openingTime: (map['openingTime'] != null)
          ? Timestamp.fromMillisecondsSinceEpoch(map['openingTime'])
              .toDateTime()
          : DateTime.now(),
      closingTime: (map['closingTime'] != null)
          ? Timestamp.fromMillisecondsSinceEpoch(map['closingTime'])
              .toDateTime()
          : DateTime.now(),
    );
  }

  String day;
  String shortName;
  int id;
  bool hasSelected;
  DateTime? openingTime = DateTime.now();
  DateTime? closingTime = DateTime.now();

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        day,
        id,
        hasSelected,
        closingTime,
        openingTime,
        shortName,
      ];

  Map<String, dynamic> toMap() {
    return {
      'title': day,
      'id': id,
      'hasSelected': hasSelected,
      'closingTime': Timestamp.fromDateTime(closingTime ?? DateTime.now())
          .millisecondsSinceEpoch,
      'openingTime': Timestamp.fromDateTime(openingTime ?? DateTime.now())
          .millisecondsSinceEpoch,
      'shortName': shortName,
    };
  }

  StoreWorkingDayAndTime copyWith({
    String? titleOfStoreAvailableFoodTypes,
    int? storeAvailableFoodTypesID,
    bool? hasSelected,
    DateTime? closingTime,
    DateTime? openingTime,
    String? shortName,
  }) {
    return StoreWorkingDayAndTime(
      day: titleOfStoreAvailableFoodTypes ?? day,
      id: storeAvailableFoodTypesID ?? id,
      hasSelected: hasSelected ?? this.hasSelected,
      closingTime: closingTime ?? this.closingTime,
      openingTime: openingTime ?? this.openingTime,
      shortName: shortName ?? this.shortName,
    );
  }
}
