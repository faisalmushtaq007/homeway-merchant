import 'package:homemakers_merchant/app/features/menu/common/assets_upload_status.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';

class MenuEntity with AppEquatable {
  MenuEntity({
    required this.id,
    required this.menuId,
    required this.menuImages,
    required this.menuName,
    required this.menuDescription,
    required this.menuCategories,
    required this.ingredients,
    required this.storeAvailableFoodTypes,
    required this.storeAvailableFoodPreparationType,
    required this.menuPortions,
    required this.hasCustomPortion,
    required this.customPortions,
    required this.extras,
    required this.menuAvailableFromTime,
    required this.menuAvailableToTime,
    required this.menuAvailableInDays,
    required this.minStockAvailable,
    required this.maxStockAvailable,
    required this.timeOfPeriodWise,
    required this.metaInfoOfMenu,
    required this.nutrients,
    required this.menuTiming,
  });

  factory MenuEntity.fromMap(Map<String, dynamic> map) {
    return MenuEntity(
      id: map['id'] as int,
      menuId: map['menuId'] as String,
      menuImages: map['menuImages'] as List<MenuImage>,
      menuName: map['menuName'] as String,
      menuDescription: map['menuDescription'] as String,
      menuCategories: map['menuCategories'] as List<Category>,
      ingredients: map['ingredients'] as List<Ingredients>,
      storeAvailableFoodTypes: map['storeAvailableFoodTypes'] as List<MenuType>,
      storeAvailableFoodPreparationType: map['storeAvailableFoodPreparationType'] as List<MenuPreparationType>,
      menuPortions: map['menuPortions'] as List<MenuPortion>,
      hasCustomPortion: map['hasCustomPortion'] as bool,
      customPortions: map['customPortions'] as List<CustomPortion>,
      extras: map['extras'] as List<Extras>,
      menuAvailableFromTime: map['menuAvailableFromTime'] as String,
      menuAvailableToTime: map['menuAvailableToTime'] as String,
      menuAvailableInDays: map['menuAvailableInDays'] as List<MenuAvailableDayAndTime>,
      minStockAvailable: map['minStockAvailable'] as int,
      maxStockAvailable: map['maxStockAvailable'] as int,
      timeOfPeriodWise: map['timeOfPeriodWise'] as List<TimeOfPeriodWise>,
      metaInfoOfMenu: map['metaInfoOfMenu'] as Map<String, dynamic>,
      nutrients: map['nutrients'] as List<Nutrients>,
      menuTiming: map['menuTiming'] as Timing,
    );
  }
  final int id;
  final String menuId;
  final List<MenuImage> menuImages;
  final String menuName;
  final String menuDescription;
  final List<Category> menuCategories;
  final List<Ingredients> ingredients;
  final List<MenuType> storeAvailableFoodTypes;
  final List<MenuPreparationType> storeAvailableFoodPreparationType;
  final List<MenuPortion> menuPortions;
  final bool hasCustomPortion;
  final List<CustomPortion> customPortions;
  final List<Extras> extras;
  final String menuAvailableFromTime;
  final String menuAvailableToTime;
  final List<MenuAvailableDayAndTime> menuAvailableInDays;
  final int minStockAvailable;
  final int maxStockAvailable;
  final List<TimeOfPeriodWise> timeOfPeriodWise;
  final Map<String, dynamic> metaInfoOfMenu;
  final List<Nutrients> nutrients;
  final Timing menuTiming;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [];

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'menuId': this.menuId,
      'menuImages': this.menuImages,
      'menuName': this.menuName,
      'menuDescription': this.menuDescription,
      'menuCategories': this.menuCategories,
      'ingredients': this.ingredients,
      'storeAvailableFoodTypes': this.storeAvailableFoodTypes,
      'storeAvailableFoodPreparationType': this.storeAvailableFoodPreparationType,
      'menuPortions': this.menuPortions,
      'hasCustomPortion': this.hasCustomPortion,
      'customPortions': this.customPortions,
      'extras': this.extras,
      'menuAvailableFromTime': this.menuAvailableFromTime,
      'menuAvailableToTime': this.menuAvailableToTime,
      'menuAvailableInDays': this.menuAvailableInDays,
      'minStockAvailable': this.minStockAvailable,
      'maxStockAvailable': this.maxStockAvailable,
      'timeOfPeriodWise': this.timeOfPeriodWise,
      'metaInfoOfMenu': this.metaInfoOfMenu,
      'nutrients': this.nutrients,
      'menuTiming': this.menuTiming,
    };
  }

  MenuEntity copyWith({
    int? id,
    String? menuId,
    List<MenuImage>? menuImages,
    String? menuName,
    String? menuDescription,
    List<Category>? menuCategories,
    List<Ingredients>? ingredients,
    List<MenuType>? storeAvailableFoodTypes,
    List<MenuPreparationType>? storeAvailableFoodPreparationType,
    List<MenuPortion>? menuPortions,
    bool? hasCustomPortion,
    List<CustomPortion>? customPortions,
    List<Extras>? extras,
    String? menuAvailableFromTime,
    String? menuAvailableToTime,
    List<MenuAvailableDayAndTime>? menuAvailableInDays,
    int? minStockAvailable,
    int? maxStockAvailable,
    List<TimeOfPeriodWise>? timeOfPeriodWise,
    Map<String, dynamic>? metaInfoOfMenu,
    List<Nutrients>? nutrients,
    Timing? menuTiming,
  }) {
    return MenuEntity(
      id: id ?? this.id,
      menuId: menuId ?? this.menuId,
      menuImages: menuImages ?? this.menuImages,
      menuName: menuName ?? this.menuName,
      menuDescription: menuDescription ?? this.menuDescription,
      menuCategories: menuCategories ?? this.menuCategories,
      ingredients: ingredients ?? this.ingredients,
      storeAvailableFoodTypes: storeAvailableFoodTypes ?? this.storeAvailableFoodTypes,
      storeAvailableFoodPreparationType: storeAvailableFoodPreparationType ?? this.storeAvailableFoodPreparationType,
      menuPortions: menuPortions ?? this.menuPortions,
      hasCustomPortion: hasCustomPortion ?? this.hasCustomPortion,
      customPortions: customPortions ?? this.customPortions,
      extras: extras ?? this.extras,
      menuAvailableFromTime: menuAvailableFromTime ?? this.menuAvailableFromTime,
      menuAvailableToTime: menuAvailableToTime ?? this.menuAvailableToTime,
      menuAvailableInDays: menuAvailableInDays ?? this.menuAvailableInDays,
      minStockAvailable: minStockAvailable ?? this.minStockAvailable,
      maxStockAvailable: maxStockAvailable ?? this.maxStockAvailable,
      timeOfPeriodWise: timeOfPeriodWise ?? this.timeOfPeriodWise,
      metaInfoOfMenu: metaInfoOfMenu ?? this.metaInfoOfMenu,
      nutrients: nutrients ?? this.nutrients,
      menuTiming: menuTiming ?? this.menuTiming,
    );
  }
}

class MenuImage with AppEquatable {
  MenuImage({
    required this.imageId,
    required this.assetPath,
    required this.metaInfo,
    required this.assetExtension,
    required this.hasBase64,
    required this.valueOfBase64,
    required this.assetsUploadStatus,
  });

  factory MenuImage.fromMap(Map<String, dynamic> map) {
    return MenuImage(
      imageId: map['imageId'] as String,
      assetPath: map['assetPath'] as String,
      metaInfo: map['metaInfo'] as Map<String, dynamic>,
      assetExtension: map['assetExtension'] as String,
      hasBase64: map['hasBase64'] as bool,
      valueOfBase64: map['valueOfBase64'] as String,
      assetsUploadStatus: map['assetsUploadStatus'] as AssetsUploadStatus,
    );
  }
  final String imageId;
  final String assetPath;
  final Map<String, dynamic> metaInfo;
  final String assetExtension;
  final bool hasBase64;
  final String valueOfBase64;
  final AssetsUploadStatus assetsUploadStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [];

  Map<String, dynamic> toMap() {
    return {
      'imageId': this.imageId,
      'assetPath': this.assetPath,
      'metaInfo': this.metaInfo,
      'assetExtension': this.assetExtension,
      'hasBase64': this.hasBase64,
      'valueOfBase64': this.valueOfBase64,
      'assetsUploadStatus': this.assetsUploadStatus,
    };
  }

  MenuImage copyWith({
    String? imageId,
    String? assetPath,
    Map<String, dynamic>? metaInfo,
    String? assetExtension,
    bool? hasBase64,
    String? valueOfBase64,
    AssetsUploadStatus? assetsUploadStatus,
  }) {
    return MenuImage(
      imageId: imageId ?? this.imageId,
      assetPath: assetPath ?? this.assetPath,
      metaInfo: metaInfo ?? this.metaInfo,
      assetExtension: assetExtension ?? this.assetExtension,
      hasBase64: hasBase64 ?? this.hasBase64,
      valueOfBase64: valueOfBase64 ?? this.valueOfBase64,
      assetsUploadStatus: assetsUploadStatus ?? this.assetsUploadStatus,
    );
  }
}

class Ingredients with AppEquatable {
  Ingredients({
    required this.ingredientsId,
    required this.title,
    required this.hasSelected,
    required this.value,
    required this.metaInfo,
  });

  factory Ingredients.fromMap(Map<String, dynamic> map) {
    return Ingredients(
      ingredientsId: map['ingredientsId'] as String,
      title: map['title'] as String,
      hasSelected: map['hasSelected'] as bool,
      value: map['value'] as dynamic,
      metaInfo: map['metaInfo'] as Map<String, dynamic>,
    );
  }
  final String ingredientsId;
  final String title;
  final bool hasSelected;
  final dynamic value;
  final Map<String, dynamic> metaInfo;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [];

  Map<String, dynamic> toMap() {
    return {
      'ingredientsId': this.ingredientsId,
      'title': this.title,
      'hasSelected': this.hasSelected,
      'value': this.value,
      'metaInfo': this.metaInfo,
    };
  }

  Ingredients copyWith({
    String? ingredientsId,
    String? title,
    bool? hasSelected,
    dynamic value,
    Map<String, dynamic>? metaInfo,
  }) {
    return Ingredients(
      ingredientsId: ingredientsId ?? this.ingredientsId,
      title: title ?? this.title,
      hasSelected: hasSelected ?? this.hasSelected,
      value: value ?? this.value,
      metaInfo: metaInfo ?? this.metaInfo,
    );
  }
}

class Nutrients with AppEquatable {
  Nutrients({
    required this.nutrientsId,
    required this.title,
    required this.hasSelected,
    required this.value,
    required this.unit,
    required this.metaInfo,
  });

  factory Nutrients.fromMap(Map<String, dynamic> map) {
    return Nutrients(
      nutrientsId: map['nutrientsId'] as String,
      title: map['title'] as String,
      hasSelected: map['hasSelected'] as bool,
      value: map['value'] as dynamic,
      unit: map['unit'] as String,
      metaInfo: map['metaInfo'] as Map<String, dynamic>,
    );
  }
  final String nutrientsId;
  final String title;
  final bool hasSelected;
  final dynamic value;
  final String unit;
  final Map<String, dynamic> metaInfo;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [];

  Map<String, dynamic> toMap() {
    return {
      'nutrientsId': this.nutrientsId,
      'title': this.title,
      'hasSelected': this.hasSelected,
      'value': this.value,
      'unit': this.unit,
      'metaInfo': this.metaInfo,
    };
  }

  Nutrients copyWith({
    String? nutrientsId,
    String? title,
    bool? hasSelected,
    dynamic value,
    String? unit,
    Map<String, dynamic>? metaInfo,
  }) {
    return Nutrients(
      nutrientsId: nutrientsId ?? this.nutrientsId,
      title: title ?? this.title,
      hasSelected: hasSelected ?? this.hasSelected,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      metaInfo: metaInfo ?? this.metaInfo,
    );
  }
}

class MenuType with AppEquatable {
  MenuType({
    required this.title,
    required this.id,
    this.hasSelected = false,
  });

  factory MenuType.fromMap(Map<String, dynamic> map) {
    return MenuType(
      title: map['title'] as String,
      id: map['id'] as int,
      hasSelected: map['hasSelected'] as bool,
    );
  }

  final String title;
  final int id;
  final bool hasSelected;

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

  MenuType copyWith({
    String? titleOfStoreAvailableFoodTypes,
    int? storeAvailableFoodTypesID,
    bool? hasSelected,
  }) {
    return MenuType(
      title: titleOfStoreAvailableFoodTypes ?? this.title,
      id: storeAvailableFoodTypesID ?? this.id,
      hasSelected: hasSelected ?? this.hasSelected,
    );
  }
}

class MenuPreparationType with AppEquatable {
  MenuPreparationType({
    required this.title,
    required this.id,
    this.hasSelected = false,
  });

  factory MenuPreparationType.fromMap(Map<String, dynamic> map) {
    return MenuPreparationType(
      title: map['title'] as String,
      id: map['id'] as int,
      hasSelected: map['hasSelected'] as bool,
    );
  }

  final String title;
  final int id;
  final bool hasSelected;

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

  MenuPreparationType copyWith({
    String? titleOfStoreAvailableFoodTypes,
    int? storeAvailableFoodTypesID,
    bool? hasSelected,
  }) {
    return MenuPreparationType(
      title: titleOfStoreAvailableFoodTypes ?? this.title,
      id: storeAvailableFoodTypesID ?? this.id,
      hasSelected: hasSelected ?? this.hasSelected,
    );
  }
}

class SpiceLevel with AppEquatable {
  SpiceLevel({
    required this.spiceLevelId,
    required this.title,
    required this.hasSelected,
  });

  factory SpiceLevel.fromMap(Map<String, dynamic> map) {
    return SpiceLevel(
      spiceLevelId: map['spiceLevelId'] as String,
      title: map['title'] as String,
      hasSelected: map['hasSelected'] as bool,
    );
  }
  final String spiceLevelId;
  final String title;
  final bool hasSelected;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [];

  Map<String, dynamic> toMap() {
    return {
      'spiceLevelId': this.spiceLevelId,
      'title': this.title,
      'hasSelected': this.hasSelected,
    };
  }

  SpiceLevel copyWith({
    String? spiceLevelId,
    String? title,
    bool? hasSelected,
  }) {
    return SpiceLevel(
      spiceLevelId: spiceLevelId ?? this.spiceLevelId,
      title: title ?? this.title,
      hasSelected: hasSelected ?? this.hasSelected,
    );
  }
}

class MenuPortion with AppEquatable {
  MenuPortion({
    required this.portionID,
    required this.title,
    required this.quantity,
    required this.maxServingPerson,
    required this.defaultPrice,
    required this.finalPrice,
    required this.discountedPrice,
    required this.hasSelected,
    required this.unit,
  });

  factory MenuPortion.fromMap(Map<String, dynamic> map) {
    return MenuPortion(
      portionID: map['portionID'] as String,
      title: map['title'] as String,
      quantity: map['quantity'] as String,
      maxServingPerson: map['maxServingPerson'] as int,
      defaultPrice: map['defaultPrice'] as double,
      finalPrice: map['finalPrice'] as double,
      discountedPrice: map['discountedPrice'] as double,
      hasSelected: map['hasSelected'] as bool,
      unit: map['unit'] as String,
    );
  }
  final String portionID;
  final String title;
  final String quantity;
  final int maxServingPerson;
  final double defaultPrice;
  final double finalPrice;
  final double discountedPrice;
  final bool hasSelected;
  final String unit;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [];

  Map<String, dynamic> toMap() {
    return {
      'portionID': this.portionID,
      'title': this.title,
      'quantity': this.quantity,
      'maxServingPerson': this.maxServingPerson,
      'defaultPrice': this.defaultPrice,
      'finalPrice': this.finalPrice,
      'discountedPrice': this.discountedPrice,
      'hasSelected': this.hasSelected,
      'unit': this.unit,
    };
  }

  MenuPortion copyWith({
    String? portionID,
    String? title,
    String? quantity,
    int? maxServingPerson,
    double? defaultPrice,
    double? finalPrice,
    double? discountedPrice,
    bool? hasSelected,
    String? unit,
  }) {
    return MenuPortion(
      portionID: portionID ?? this.portionID,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      maxServingPerson: maxServingPerson ?? this.maxServingPerson,
      defaultPrice: defaultPrice ?? this.defaultPrice,
      finalPrice: finalPrice ?? this.finalPrice,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      hasSelected: hasSelected ?? this.hasSelected,
      unit: unit ?? this.unit,
    );
  }
}

class CustomPortion with AppEquatable {
  CustomPortion({
    required this.cutsomePortionID,
    required this.title,
    required this.maxServingPerson,
    required this.quantity,
    required this.defaultPrice,
    required this.finalPrice,
    required this.discountedPrice,
    required this.otherInfo,
    required this.hasSelected,
    required this.unit,
  });

  factory CustomPortion.fromMap(Map<String, dynamic> map) {
    return CustomPortion(
      cutsomePortionID: map['cutsomePortionID'] as String,
      title: map['title'] as String,
      maxServingPerson: map['maxServingPerson'] as int,
      quantity: map['quantity'] as String,
      defaultPrice: map['defaultPrice'] as double,
      finalPrice: map['finalPrice'] as double,
      discountedPrice: map['discountedPrice'] as double,
      otherInfo: map['otherInfo'] as Map<String, dynamic>,
      hasSelected: map['hasSelected'] as bool,
      unit: map['unit'] as String,
    );
  }
  final String cutsomePortionID;
  final String title;
  final int maxServingPerson;
  final String quantity;
  final double defaultPrice;
  final double finalPrice;
  final double discountedPrice;
  final Map<String, dynamic> otherInfo;
  final bool hasSelected;
  final String unit;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [];

  Map<String, dynamic> toMap() {
    return {
      'cutsomePortionID': this.cutsomePortionID,
      'title': this.title,
      'maxServingPerson': this.maxServingPerson,
      'quantity': this.quantity,
      'defaultPrice': this.defaultPrice,
      'finalPrice': this.finalPrice,
      'discountedPrice': this.discountedPrice,
      'otherInfo': this.otherInfo,
      'hasSelected': this.hasSelected,
      'unit': this.unit,
    };
  }

  CustomPortion copyWith({
    String? cutsomePortionID,
    String? title,
    int? maxServingPerson,
    String? quantity,
    double? defaultPrice,
    double? finalPrice,
    double? discountedPrice,
    Map<String, dynamic>? otherInfo,
    bool? hasSelected,
    String? unit,
  }) {
    return CustomPortion(
      cutsomePortionID: cutsomePortionID ?? this.cutsomePortionID,
      title: title ?? this.title,
      maxServingPerson: maxServingPerson ?? this.maxServingPerson,
      quantity: quantity ?? this.quantity,
      defaultPrice: defaultPrice ?? this.defaultPrice,
      finalPrice: finalPrice ?? this.finalPrice,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      otherInfo: otherInfo ?? this.otherInfo,
      hasSelected: hasSelected ?? this.hasSelected,
      unit: unit ?? this.unit,
    );
  }
}

class Extras with AppEquatable {
  Extras({
    required this.extrasID,
    required this.title,
    required this.quantity,
    required this.defaultPrice,
    required this.finalPrice,
    required this.discountedPrice,
    required this.hasSelected,
    required this.unit,
    required this.extrasImage,
  });

  factory Extras.fromMap(Map<String, dynamic> map) {
    return Extras(
      extrasID: map['extrasID'] as String,
      title: map['title'] as String,
      quantity: map['quantity'] as String,
      defaultPrice: map['defaultPrice'] as double,
      finalPrice: map['finalPrice'] as double,
      discountedPrice: map['discountedPrice'] as double,
      hasSelected: map['hasSelected'] as bool,
      unit: map['unit'] as String,
      extrasImage: map['extrasImage'] as MenuImage,
    );
  }
  final String extrasID;
  final String title;
  final String quantity;
  final double defaultPrice;
  final double finalPrice;
  final double discountedPrice;
  final bool hasSelected;
  final String unit;
  final MenuImage extrasImage;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [];

  Map<String, dynamic> toMap() {
    return {
      'extrasID': this.extrasID,
      'title': this.title,
      'quantity': this.quantity,
      'defaultPrice': this.defaultPrice,
      'finalPrice': this.finalPrice,
      'discountedPrice': this.discountedPrice,
      'hasSelected': this.hasSelected,
      'unit': this.unit,
      'extrasImage': this.extrasImage,
    };
  }

  Extras copyWith({
    String? extrasID,
    String? title,
    String? quantity,
    double? defaultPrice,
    double? finalPrice,
    double? discountedPrice,
    bool? hasSelected,
    String? unit,
    MenuImage? extrasImage,
  }) {
    return Extras(
      extrasID: extrasID ?? this.extrasID,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      defaultPrice: defaultPrice ?? this.defaultPrice,
      finalPrice: finalPrice ?? this.finalPrice,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      hasSelected: hasSelected ?? this.hasSelected,
      unit: unit ?? this.unit,
      extrasImage: extrasImage ?? this.extrasImage,
    );
  }
}

class MenuAvailableDayAndTime with AppEquatable {
  MenuAvailableDayAndTime({
    required this.day,
    required this.shortName,
    required this.id,
    this.hasSelected = false,
    this.closingTime,
    this.openingTime,
  });

  factory MenuAvailableDayAndTime.fromMap(Map<String, dynamic> map) {
    return MenuAvailableDayAndTime(
      day: map['title'] as String,
      shortName: map['shortName'] as String,
      id: map['id'] as int,
      hasSelected: map['hasSelected'] as bool,
      openingTime: map['openingTime'] as DateTime,
      closingTime: map['closingTime'] as DateTime,
    );
  }

  final String day;
  final String shortName;
  final int id;
  final bool hasSelected;
  final DateTime? openingTime;
  final DateTime? closingTime;

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

  MenuAvailableDayAndTime copyWith({
    String? titleOfStoreAvailableFoodTypes,
    int? storeAvailableFoodTypesID,
    bool? hasSelected,
    DateTime? closingTime,
    DateTime? openingTime,
    String? shortName,
  }) {
    return MenuAvailableDayAndTime(
      day: titleOfStoreAvailableFoodTypes ?? this.day,
      id: storeAvailableFoodTypesID ?? this.id,
      hasSelected: hasSelected ?? this.hasSelected,
      closingTime: closingTime ?? this.closingTime,
      openingTime: openingTime ?? this.openingTime,
      shortName: shortName ?? this.shortName,
    );
  }
}

class TimeOfPeriodWise with AppEquatable {
  TimeOfPeriodWise({
    required this.timeOfPeriodWiseId,
    required this.title,
    required this.hasSelected,
  });

  factory TimeOfPeriodWise.fromMap(Map<String, dynamic> map) {
    return TimeOfPeriodWise(
      timeOfPeriodWiseId: map['timeOfPeriodWiseId'] as String,
      title: map['title'] as String,
      hasSelected: map['hasSelected'] as bool,
    );
  }
  final String timeOfPeriodWiseId;
  final String title;
  final bool hasSelected;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [];

  Map<String, dynamic> toMap() {
    return {
      'timeOfPeriodWiseId': this.timeOfPeriodWiseId,
      'title': this.title,
      'hasSelected': this.hasSelected,
    };
  }

  TimeOfPeriodWise copyWith({
    String? timeOfPeriodWiseId,
    String? title,
    bool? hasSelected,
  }) {
    return TimeOfPeriodWise(
      timeOfPeriodWiseId: timeOfPeriodWiseId ?? this.timeOfPeriodWiseId,
      title: title ?? this.title,
      hasSelected: hasSelected ?? this.hasSelected,
    );
  }
}

class Timing with AppEquatable {
  Timing({
    required this.timingID,
    required this.minPreparingTime,
    required this.maxPreparingTime,
    required this.minDeliveryTime,
    required this.maxDeliveryTiming,
  });

  factory Timing.fromMap(Map<String, dynamic> map) {
    return Timing(
      timingID: map['timingID'] as String,
      minPreparingTime: map['minPreparingTime'] as String,
      maxPreparingTime: map['maxPreparingTime'] as String,
      minDeliveryTime: map['minDeliveryTime'] as String,
      maxDeliveryTiming: map['maxDeliveryTiming'] as String,
    );
  }
  final String timingID;
  final String minPreparingTime;
  final String maxPreparingTime;
  final String minDeliveryTime;
  final String maxDeliveryTiming;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [];

  Map<String, dynamic> toMap() {
    return {
      'timingID': this.timingID,
      'minPreparingTime': this.minPreparingTime,
      'maxPreparingTime': this.maxPreparingTime,
      'minDeliveryTime': this.minDeliveryTime,
      'maxDeliveryTiming': this.maxDeliveryTiming,
    };
  }

  Timing copyWith({
    String? timingID,
    String? minPreparingTime,
    String? maxPreparingTime,
    String? minDeliveryTime,
    String? maxDeliveryTiming,
  }) {
    return Timing(
      timingID: timingID ?? this.timingID,
      minPreparingTime: minPreparingTime ?? this.minPreparingTime,
      maxPreparingTime: maxPreparingTime ?? this.maxPreparingTime,
      minDeliveryTime: minDeliveryTime ?? this.minDeliveryTime,
      maxDeliveryTiming: maxDeliveryTiming ?? this.maxDeliveryTiming,
    );
  }
}

class Category with AppEquatable {
  Category({
    required this.categoryId,
    required this.title,
    required this.hasSelected,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      categoryId: map['categoryId'] as String,
      title: map['title'] as String,
      hasSelected: map['hasSelected'] as bool,
    );
  }
  final String categoryId;
  final String title;
  final bool hasSelected;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [];

  Map<String, dynamic> toMap() {
    return {
      'categoryId': this.categoryId,
      'title': this.title,
      'hasSelected': this.hasSelected,
    };
  }

  Category copyWith({
    String? categoryId,
    String? title,
    bool? hasSelected,
  }) {
    return Category(
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      hasSelected: hasSelected ?? this.hasSelected,
    );
  }
}
