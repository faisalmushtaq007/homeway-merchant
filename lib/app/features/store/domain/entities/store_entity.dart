import 'package:flutter/cupertino.dart';
import 'package:homemakers_merchant/app/features/address/domain/entities/address_model.dart';
import 'package:homemakers_merchant/app/features/menu/index.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';

class StoreEntity with AppEquatable {
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
  });

  factory StoreEntity.fromMap(Map<String, dynamic> map) {
    return StoreEntity(
      storeName: map['storeName'] as String,
      storeAddress: map['storeAddress'] as AddressModel,
      storeImagePath: map['storeImagePath'] as String,
      storeImageMetaData: map['storeImageMetaData'] as Map<String, dynamic>,
      storeAvailableFoodTypes: map['storeAvailableFoodTypes'] as List<StoreAvailableFoodTypes>,
      storeAvailableFoodPreparationType: map['storeAvailableFoodPreparationType'] as List<StoreAvailableFoodPreparationType>,
      hasStoreOwnDeliveryPartners: map['hasStoreOwnDeliveryPartners'] as bool,
      storeOwnDeliveryPartnersInfo: map['storeOwnDeliveryPartnersInfo'] as List<StoreOwnDeliveryPartnersInfo>,
      storeMaximumFoodDeliveryTime: map['storeMaximumFoodDeliveryTime'] as int,
      storeMaximumFoodDeliveryRadius: map['storeMaximumFoodDeliveryRadius'] as int,
      storeAcceptedPaymentModes: map['storeAcceptedPaymentModes'] as List<StoreAcceptedPaymentModes>,
      storeWorkingDays: map['storeWorkingDays'] as List<StoreWorkingDayAndTime>,
      storeOpeningTime: map['storeOpeningTime'] as String,
      storeClosingTime: map['storeClosingTime'] as String,
      storeID: map['storeID'] as int,
      menuEntities: map['menuEntities'] as List<MenuEntity>,
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
  }) {
    return StoreEntity(
      storeName: storeName ?? this.storeName,
      storeAddress: storeAddress ?? this.storeAddress,
      storeImagePath: storeImagePath ?? this.storeImagePath,
      storeImageMetaData: storeImageMetaData ?? this.storeImageMetaData,
      storeAvailableFoodTypes: storeAvailableFoodTypes ?? this.storeAvailableFoodTypes,
      storeAvailableFoodPreparationType: storeAvailableFoodPreparationType ?? this.storeAvailableFoodPreparationType,
      hasStoreOwnDeliveryPartners: hasStoreOwnDeliveryPartners ?? this.hasStoreOwnDeliveryPartners,
      storeOwnDeliveryPartnersInfo: storeOwnDeliveryPartnersInfo ?? this.storeOwnDeliveryPartnersInfo,
      storeMaximumFoodDeliveryTime: storeMaximumFoodDeliveryTime ?? this.storeMaximumFoodDeliveryTime,
      storeMaximumFoodDeliveryRadius: storeMaximumFoodDeliveryRadius ?? this.storeMaximumFoodDeliveryRadius,
      storeAcceptedPaymentModes: storeAcceptedPaymentModes ?? this.storeAcceptedPaymentModes,
      storeWorkingDays: storeWorkingDays ?? this.storeWorkingDays,
      storeOpeningTime: storeOpeningTime ?? this.storeOpeningTime,
      storeClosingTime: storeClosingTime ?? this.storeClosingTime,
      storeID: storeID ?? this.storeID,
      menuEntities: menuEntities ?? this.menuEntities,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storeName': this.storeName,
      'storeAddress': this.storeAddress,
      'storeImagePath': this.storeImagePath,
      'storeImageMetaData': this.storeImageMetaData,
      'storeAvailableFoodTypes': this.storeAvailableFoodTypes,
      'storeAvailableFoodPreparationType': this.storeAvailableFoodPreparationType,
      'hasStoreOwnDeliveryPartners': this.hasStoreOwnDeliveryPartners,
      'storeOwnDeliveryPartnersInfo': this.storeOwnDeliveryPartnersInfo,
      'storeMaximumFoodDeliveryTime': this.storeMaximumFoodDeliveryTime,
      'storeMaximumFoodDeliveryRadius': this.storeMaximumFoodDeliveryRadius,
      'storeAcceptedPaymentModes': this.storeAcceptedPaymentModes,
      'storeWorkingDays': this.storeWorkingDays,
      'storeOpeningTime': this.storeOpeningTime,
      'storeClosingTime': this.storeClosingTime,
      'storeID': this.storeID,
      'menuEntities': this.menuEntities,
    };
  }
}

class StoreAvailableFoodTypes with AppEquatable {
  StoreAvailableFoodTypes({
    required this.title,
    required this.id,
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
      'title': this.title,
      'id': this.id,
      'hasSelected': this.hasSelected,
    };
  }

  StoreAvailableFoodTypes copyWith({
    String? titleOfStoreAvailableFoodTypes,
    int? storeAvailableFoodTypesID,
    bool? hasSelected,
  }) {
    return StoreAvailableFoodTypes(
      title: titleOfStoreAvailableFoodTypes ?? this.title,
      id: storeAvailableFoodTypesID ?? this.id,
      hasSelected: hasSelected ?? this.hasSelected,
    );
  }
}

class StoreAvailableFoodPreparationType with AppEquatable {
  StoreAvailableFoodPreparationType({
    required this.title,
    required this.id,
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
      'title': this.title,
      'id': this.id,
      'hasSelected': this.hasSelected,
    };
  }

  StoreAvailableFoodPreparationType copyWith({
    String? titleOfStoreAvailableFoodTypes,
    int? storeAvailableFoodTypesID,
    bool? hasSelected,
  }) {
    return StoreAvailableFoodPreparationType(
      title: titleOfStoreAvailableFoodTypes ?? this.title,
      id: storeAvailableFoodTypesID ?? this.id,
      hasSelected: hasSelected ?? this.hasSelected,
    );
  }
}

class StoreAcceptedPaymentModes with AppEquatable {
  StoreAcceptedPaymentModes({
    required this.title,
    required this.id,
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
      'title': this.title,
      'id': this.id,
      'hasSelected': this.hasSelected,
    };
  }

  StoreAcceptedPaymentModes copyWith({String? titleOfStoreAvailableFoodTypes, int? storeAvailableFoodTypesID, Icon? icon, bool? hasSelected}) {
    return StoreAcceptedPaymentModes(
      title: titleOfStoreAvailableFoodTypes ?? this.title,
      id: storeAvailableFoodTypesID ?? this.id,
      icon: icon ?? this.icon,
      hasSelected: hasSelected ?? this.hasSelected,
    );
  }
}

class StoreOwnDeliveryPartnersInfo with AppEquatable {
  StoreOwnDeliveryPartnersInfo({
    required this.driverName,
    required this.driverMobileNumber,
    required this.drivingLicenseNumber,
  });

  factory StoreOwnDeliveryPartnersInfo.fromMap(Map<String, dynamic> map) {
    return StoreOwnDeliveryPartnersInfo(
      driverName: map['driverName'] as String,
      driverMobileNumber: map['driverMobileNumber'] as String,
      drivingLicenseNumber: map['drivingLicenseNumber'] as String,
    );
  }

  String driverName;
  String driverMobileNumber;
  String drivingLicenseNumber;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        driverMobileNumber,
        driverName,
        drivingLicenseNumber,
      ];

  Map<String, dynamic> toMap() {
    return {
      'driverName': this.driverName,
      'driverMobileNumber': this.driverMobileNumber,
      'drivingLicenseNumber': this.drivingLicenseNumber,
    };
  }

  StoreOwnDeliveryPartnersInfo copyWith({
    String? driverName,
    String? driverMobileNumber,
    String? drivingLicenseNumber,
  }) {
    return StoreOwnDeliveryPartnersInfo(
      driverName: driverName ?? this.driverName,
      driverMobileNumber: driverMobileNumber ?? this.driverMobileNumber,
      drivingLicenseNumber: drivingLicenseNumber ?? this.drivingLicenseNumber,
    );
  }
}

class StoreWorkingDayAndTime with AppEquatable {
  StoreWorkingDayAndTime({
    required this.day,
    required this.shortName,
    required this.id,
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
      openingTime: map['openingTime'] as DateTime,
      closingTime: map['closingTime'] as DateTime,
    );
  }

  String day;
  String shortName;
  int id;
  bool hasSelected;
  DateTime? openingTime;
  DateTime? closingTime;

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
      'title': this.day,
      'id': this.id,
      'hasSelected': this.hasSelected,
      'closingTime': this.closingTime,
      'openingTime': this.openingTime,
      'shortName': this.shortName,
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
      day: titleOfStoreAvailableFoodTypes ?? this.day,
      id: storeAvailableFoodTypesID ?? this.id,
      hasSelected: hasSelected ?? this.hasSelected,
      closingTime: closingTime ?? this.closingTime,
      openingTime: openingTime ?? this.openingTime,
      shortName: shortName ?? this.shortName,
    );
  }
}
