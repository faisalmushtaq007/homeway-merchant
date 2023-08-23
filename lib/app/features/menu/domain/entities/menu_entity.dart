part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuEntity with AppEquatable {
  MenuEntity({
    this.menuId = -1,
    this.menuImages = const [],
    this.menuName = '',
    this.menuDescription = '',
    this.menuCategories = const [],
    this.ingredients = const [],
    this.storeAvailableFoodTypes = const [],
    this.storeAvailableFoodPreparationType = const [],
    this.menuPortions = const [],
    this.hasCustomPortion = false,
    this.customPortions = const [],
    this.addons = const [],
    this.menuAvailableFromTime = '',
    this.menuAvailableToTime = '',
    this.menuAvailableInDays = const [],
    this.minStockAvailable = -1,
    this.maxStockAvailable = -1,
    this.timeOfPeriodWise = const [],
    this.metaInfoOfMenu = const {},
    this.nutrients = const [],
    this.menuTiming,
    this.tasteType,
    this.stock,
    this.customPortion,
    this.menuMaxPreparationTime = '',
    this.menuMinPreparationTime = '',
    this.ratingAndReviewEntity,
    this.hasMenuAvailable = true,
    this.hasReadyToPickupOrder = true,
  });

  factory MenuEntity.fromMap(Map<String, dynamic> map) {
    return MenuEntity(
      menuId: map['menuId'] as int,
      menuImages: (map['menuImages'] != null) ? map['menuImages'].map((e) => MenuImage.fromMap(e)).toList().cast<MenuImage>() : MenuImage(),
      menuName: map['menuName'] as String,
      menuDescription: map['menuDescription'] as String,
      menuCategories: map['menuCategories'].map((e) => Category.fromMap(e)).toList().cast<Category>(),
      ingredients: map['ingredients'].map((e) => Ingredients.fromMap(e)).toList().cast<Ingredients>(),
      storeAvailableFoodTypes: map['storeAvailableFoodTypes'].map((e) => MenuType.fromMap(e)).toList().cast<MenuType>(),
      storeAvailableFoodPreparationType:
          map['storeAvailableFoodPreparationType'].map((e) => MenuPreparationType.fromMap(e)).toList().cast<MenuPreparationType>(),
      menuPortions: map['menuPortions'].map((e) => MenuPortion.fromMap(e)).toList().cast<MenuPortion>(),
      hasCustomPortion: map['hasCustomPortion'] as bool,
      customPortions: map['customPortions'].map((e) => CustomPortion.fromMap(e)).toList().cast<CustomPortion>(),
      addons: map['addons'].map((e) => Addons.fromMap(e)).toList().cast<Addons>(),
      menuAvailableFromTime: map['menuAvailableFromTime'] as String,
      menuAvailableToTime: map['menuAvailableToTime'] as String,
      menuAvailableInDays: map['menuAvailableInDays'].map((e) => MenuAvailableDayAndTime.fromMap(e)).toList().cast<MenuAvailableDayAndTime>(),
      minStockAvailable: map['minStockAvailable'] as int,
      maxStockAvailable: map['maxStockAvailable'] as int,
      timeOfPeriodWise: map['timeOfPeriodWise'].map((e) => TimeOfPeriodWise.fromMap(e)).toList().cast<TimeOfPeriodWise>(),
      metaInfoOfMenu: map['metaInfoOfMenu'] as Map<String, dynamic>,
      nutrients: map['nutrients'].map((e) => Nutrients.fromMap(e)).toList().cast<Nutrients>(),
      menuTiming: (map['menuTiming'] != null) ? Timing.fromMap(map['menuTiming']) : Timing(),
      tasteType: (map['tasteType'] != null) ? TasteType.fromMap(map['tasteType']) : TasteType(),
      stock: (map['stock'] != null) ? Stock.fromMap(map['stock']) : Stock(),
      customPortion: (map['customPortion'] != null) ? CustomPortion.fromMap(map['customPortion']) : CustomPortion(),
      menuMinPreparationTime: map['menuMinPreparationTime'] as String,
      menuMaxPreparationTime: map['menuMaxPreparationTime'] as String,
      ratingAndReviewEntity: (map['ratingAndReviewEntity'] != null) ? RatingAndReviewEntity.fromMap(map['ratingAndReviewEntity']) : RatingAndReviewEntity(),
      hasMenuAvailable: map['hasMenuAvailable'] ?? true,
      hasReadyToPickupOrder: map['hasReadyToPickupOrder'] ?? true,
    );
  }

  int menuId;
  List<MenuImage> menuImages;
  String menuName;
  String menuDescription;
  List<Category> menuCategories;
  List<Ingredients> ingredients;
  List<MenuType> storeAvailableFoodTypes;
  List<MenuPreparationType> storeAvailableFoodPreparationType;
  List<MenuPortion> menuPortions;
  bool hasCustomPortion;
  List<CustomPortion> customPortions;
  List<Addons> addons;
  String menuAvailableFromTime;
  String menuAvailableToTime;
  List<MenuAvailableDayAndTime> menuAvailableInDays;
  int minStockAvailable;
  int maxStockAvailable;
  List<TimeOfPeriodWise> timeOfPeriodWise;
  Map<String, dynamic> metaInfoOfMenu;
  List<Nutrients> nutrients;
  Timing? menuTiming = Timing();
  TasteType? tasteType = TasteType();
  Stock? stock = Stock();
  CustomPortion? customPortion = CustomPortion();
  String menuMinPreparationTime;
  String menuMaxPreparationTime;
  RatingAndReviewEntity? ratingAndReviewEntity = RatingAndReviewEntity();
  final bool hasMenuAvailable;
  final bool hasReadyToPickupOrder;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        menuId,
        menuImages,
        menuName,
        menuDescription,
        menuCategories,
        ingredients,
        storeAvailableFoodTypes,
        storeAvailableFoodPreparationType,
        menuPortions,
        hasCustomPortion,
        customPortions,
        addons,
        menuAvailableFromTime,
        menuAvailableToTime,
        menuAvailableInDays,
        minStockAvailable,
        maxStockAvailable,
        timeOfPeriodWise,
        metaInfoOfMenu,
        nutrients,
        menuTiming,
        tasteType,
        stock,
        customPortion,
        menuMinPreparationTime,
        menuMaxPreparationTime,
        ratingAndReviewEntity,
        hasMenuAvailable,
        hasReadyToPickupOrder,
      ];

  Map<String, dynamic> toMap() {
    return {
      'menuId': this.menuId,
      'menuImages': this.menuImages.map((e) => e.toMap()).toList(),
      'menuName': this.menuName,
      'menuDescription': this.menuDescription,
      'menuCategories': this.menuCategories.map((e) => e.toMap()).toList(),
      'ingredients': this.ingredients.map((e) => e.toMap()).toList(),
      'storeAvailableFoodTypes': this.storeAvailableFoodTypes.map((e) => e.toMap()).toList(),
      'storeAvailableFoodPreparationType': this.storeAvailableFoodPreparationType.map((e) => e.toMap()).toList(),
      'menuPortions': this.menuPortions.map((e) => e.toMap()).toList(),
      'hasCustomPortion': this.hasCustomPortion,
      'customPortions': this.customPortions.map((e) => e.toMap()).toList(),
      'addons': this.addons.map((e) => e.toMap()).toList(),
      'menuAvailableFromTime': this.menuAvailableFromTime,
      'menuAvailableToTime': this.menuAvailableToTime,
      'menuAvailableInDays': this.menuAvailableInDays.map((e) => e.toMap()).toList(),
      'minStockAvailable': this.minStockAvailable,
      'maxStockAvailable': this.maxStockAvailable,
      'timeOfPeriodWise': this.timeOfPeriodWise.map((e) => e.toMap()).toList(),
      'metaInfoOfMenu': this.metaInfoOfMenu,
      'nutrients': this.nutrients.map((e) => e.toMap()).toList(),
      'menuTiming': this.menuTiming?.toMap() ?? Timing().toMap(),
      'tasteType': this.tasteType?.toMap() ?? TasteType().toMap(),
      'stock': this.stock?.toMap() ?? Stock().toMap(),
      'customPortion': this.customPortion?.toMap() ?? CustomPortion().toMap(),
      'menuMinPreparationTime': this.menuMinPreparationTime,
      'menuMaxPreparationTime': this.menuMaxPreparationTime,
      'ratingAndReviewEntity': this.ratingAndReviewEntity?.toMap() ?? RatingAndReviewEntity().toMap(),
      'hasMenuAvailable': this.hasMenuAvailable,
      'hasReadyToPickupOrder': this.hasReadyToPickupOrder,
    };
  }

  MenuEntity copyWith({
    int? menuId,
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
    List<Addons>? addons,
    String? menuAvailableFromTime,
    String? menuAvailableToTime,
    List<MenuAvailableDayAndTime>? menuAvailableInDays,
    int? minStockAvailable,
    int? maxStockAvailable,
    List<TimeOfPeriodWise>? timeOfPeriodWise,
    Map<String, dynamic>? metaInfoOfMenu,
    List<Nutrients>? nutrients,
    Timing? menuTiming,
    TasteType? tasteType,
    Stock? stock,
    CustomPortion? customPortion,
    String? menuMinPreparationTime,
    String? menuMaxPreparationTime,
    RatingAndReviewEntity? ratingAndReviewEntity,
    bool? hasMenuAvailable,
    bool? hasReadyToPickupOrder,
  }) {
    return MenuEntity(
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
      addons: addons ?? this.addons,
      menuAvailableFromTime: menuAvailableFromTime ?? this.menuAvailableFromTime,
      menuAvailableToTime: menuAvailableToTime ?? this.menuAvailableToTime,
      menuAvailableInDays: menuAvailableInDays ?? this.menuAvailableInDays,
      minStockAvailable: minStockAvailable ?? this.minStockAvailable,
      maxStockAvailable: maxStockAvailable ?? this.maxStockAvailable,
      timeOfPeriodWise: timeOfPeriodWise ?? this.timeOfPeriodWise,
      metaInfoOfMenu: metaInfoOfMenu ?? this.metaInfoOfMenu,
      nutrients: nutrients ?? this.nutrients,
      menuTiming: menuTiming ?? this.menuTiming,
      tasteType: tasteType ?? this.tasteType,
      stock: stock ?? this.stock,
      customPortion: customPortion ?? this.customPortion,
      menuMaxPreparationTime: menuMaxPreparationTime ?? this.menuMaxPreparationTime,
      menuMinPreparationTime: menuMinPreparationTime ?? this.menuMinPreparationTime,
      ratingAndReviewEntity: ratingAndReviewEntity ?? this.ratingAndReviewEntity,
      hasMenuAvailable: hasMenuAvailable ?? this.hasMenuAvailable,
      hasReadyToPickupOrder: hasReadyToPickupOrder ?? this.hasReadyToPickupOrder,
    );
  }
}

class MenuImage with AppEquatable {
  MenuImage({
    this.imageId = '',
    this.assetPath = '',
    this.metaInfo = const {},
    this.assetExtension = '',
    this.hasBase64 = false,
    this.valueOfBase64 = '',
    this.assetsUploadStatus = AssetsUploadStatus.none,
  });

  factory MenuImage.fromMap(Map<String, dynamic> map) {
    return MenuImage(
      imageId: map['imageId'] as String,
      assetPath: map['assetPath'] as String,
      metaInfo: map['metaInfo'] as Map<String, dynamic>,
      assetExtension: map['assetExtension'] as String,
      hasBase64: map['hasBase64'] as bool,
      valueOfBase64: map['valueOfBase64'] as String,
      assetsUploadStatus: (map['assetsUploadStatus'] != null) ? AssetsUploadStatus.values.byName(map['assetsUploadStatus']) : AssetsUploadStatus.none,
    );
  }

  String imageId;
  String assetPath;
  Map<String, dynamic> metaInfo;
  String assetExtension;
  bool hasBase64;
  String valueOfBase64;
  AssetsUploadStatus assetsUploadStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        imageId,
        assetPath,
        metaInfo,
        assetExtension,
        hasBase64,
        valueOfBase64,
        assetsUploadStatus,
      ];

  Map<String, dynamic> toMap() {
    return {
      'imageId': this.imageId,
      'assetPath': this.assetPath,
      'metaInfo': this.metaInfo,
      'assetExtension': this.assetExtension,
      'hasBase64': this.hasBase64,
      'valueOfBase64': this.valueOfBase64 ?? '',
      'assetsUploadStatus': this.assetsUploadStatus.name,
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
      valueOfBase64: valueOfBase64 ?? this.valueOfBase64 ?? '',
      assetsUploadStatus: assetsUploadStatus ?? this.assetsUploadStatus,
    );
  }
}

class Ingredients with AppEquatable {
  Ingredients({
    this.ingredientsId = '',
    this.title = '',
    this.hasSelected = false,
    this.value,
    this.metaInfo = const <String, dynamic>{},
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

  String ingredientsId;
  String title;
  bool hasSelected;
  dynamic value;
  Map<String, dynamic> metaInfo;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        ingredientsId,
        title,
        hasSelected,
        value,
        metaInfo,
      ];

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
    this.nutrientsId = '',
    this.title = '',
    this.hasSelected = false,
    this.value,
    this.unit = '0',
    this.metaInfo = const <String, dynamic>{},
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

  String nutrientsId;
  String title;
  bool hasSelected;
  dynamic value;
  String unit;
  Map<String, dynamic> metaInfo;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        nutrientsId,
        title,
        hasSelected,
        value,
        unit,
        metaInfo,
      ];

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
    this.title = '',
    this.id = -1,
    this.hasSelected = false,
  });

  factory MenuType.fromMap(Map<String, dynamic> map) {
    return MenuType(
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
    this.title = '',
    this.id = -1,
    this.hasSelected = false,
  });

  factory MenuPreparationType.fromMap(Map<String, dynamic> map) {
    return MenuPreparationType(
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

class TasteType with AppEquatable {
  TasteType({
    this.tasteTypeId = '',
    this.title = '',
    this.hasSelected = false,
    this.tasteLevel = const [],
    this.hasTasteLevel = false,
  });

  factory TasteType.fromMap(Map<String, dynamic> map) {
    return TasteType(
      tasteTypeId: map['tasteTypeId'] as String,
      title: map['title'] as String,
      hasSelected: map['hasSelected'] as bool,
      tasteLevel: map['tasteLevel'].map((e) => TasteLevel.fromMap(e)).toList().cast<TasteLevel>(),
      hasTasteLevel: map['hasTasteLevel'] as bool,
    );
  }

  String tasteTypeId;
  String title;
  bool hasSelected;
  bool hasTasteLevel;
  List<TasteLevel> tasteLevel;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        tasteTypeId,
        title,
        hasSelected,
        tasteLevel,
        hasTasteLevel,
      ];

  Map<String, dynamic> toMap() {
    return {
      'tasteTypeId': this.tasteTypeId,
      'title': this.title,
      'hasSelected': this.hasSelected,
      'tasteLevel': this.tasteLevel.map((e) => e.toMap()).toList(),
      'hasTasteLevel': this.hasTasteLevel,
    };
  }

  TasteType copyWith({
    String? tasteTypeId,
    String? title,
    bool? hasSelected,
    List<TasteLevel>? tasteLevel,
    bool? hasTasteLevel,
  }) {
    return TasteType(
      tasteTypeId: tasteTypeId ?? this.tasteTypeId,
      title: title ?? this.title,
      hasSelected: hasSelected ?? this.hasSelected,
      tasteLevel: tasteLevel ?? this.tasteLevel,
      hasTasteLevel: hasTasteLevel ?? this.hasTasteLevel,
    );
  }
}

class TasteLevel with AppEquatable {
  TasteLevel({
    this.tasteLevelId = '',
    this.title = '',
    this.hasSelected = false,
  });

  factory TasteLevel.fromMap(Map<String, dynamic> map) {
    return TasteLevel(
      tasteLevelId: map['tasteLevelId'] as String,
      title: map['title'] as String,
      hasSelected: map['hasSelected'] as bool,
    );
  }

  String tasteLevelId;
  String title;
  bool hasSelected;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        tasteLevelId,
        title,
        hasSelected,
      ];

  Map<String, dynamic> toMap() {
    return {
      'tasteLevelId': this.tasteLevelId,
      'title': this.title,
      'hasSelected': this.hasSelected,
    };
  }

  TasteLevel copyWith({
    String? tasteLevelId,
    String? title,
    bool? hasSelected,
  }) {
    return TasteLevel(
      tasteLevelId: tasteLevelId ?? this.tasteLevelId,
      title: title ?? this.title,
      hasSelected: hasSelected ?? this.hasSelected,
    );
  }
}

class MenuPortion with AppEquatable {
  MenuPortion({
    this.portionID = '',
    this.title = '',
    this.quantity = 0.0,
    this.maxServingPerson = 0,
    this.defaultPrice = 0.0,
    this.finalPrice = 0.0,
    this.discountedPrice = 0.0,
    this.hasSelected = false,
    this.unit = '',
    this.currency = 'SAR',
    this.description = '',
  });

  factory MenuPortion.fromMap(Map<String, dynamic> map) {
    return MenuPortion(
      portionID: map['portionID'] as String,
      title: map['title'] as String,
      quantity: map['quantity'] as double,
      maxServingPerson: map['maxServingPerson'] as int,
      defaultPrice: map['defaultPrice'] as double,
      finalPrice: map['finalPrice'] as double,
      discountedPrice: map['discountedPrice'] as double,
      hasSelected: map['hasSelected'] as bool,
      unit: map['unit'] as String,
      currency: map['currency'] as String,
      description: map['description'] as String,
    );
  }

  String portionID;
  String title;
  double quantity;
  int maxServingPerson;
  double defaultPrice;
  double finalPrice;
  double discountedPrice;
  bool hasSelected;
  String unit;
  String currency;
  String description;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        portionID,
        title,
        quantity,
        maxServingPerson,
        defaultPrice,
        finalPrice,
        discountedPrice,
        hasSelected,
        unit,
        currency,
        description,
      ];

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
      'currency': this.currency,
      'description': this.description,
    };
  }

  MenuPortion copyWith({
    String? portionID,
    String? title,
    double? quantity,
    int? maxServingPerson,
    double? defaultPrice,
    double? finalPrice,
    double? discountedPrice,
    bool? hasSelected,
    String? unit,
    String? currency,
    String? description,
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
      currency: currency ?? this.currency,
      description: description ?? this.description,
    );
  }
}

class CustomPortion with AppEquatable {
  CustomPortion({
    this.customPortionID = '0',
    this.title = '',
    this.maxServingPerson = 0,
    this.quantity = 0.0,
    this.defaultPrice = 0.0,
    this.finalPrice = 0.0,
    this.discountedPrice = 0.0,
    this.otherInfo = const {},
    this.hasSelected = false,
    this.unit = '0',
    this.currency = 'SAR',
    this.description = '',
  });

  factory CustomPortion.fromMap(Map<String, dynamic> map) {
    return CustomPortion(
      customPortionID: map['customPortionID'] as String,
      title: map['title'] as String,
      maxServingPerson: map['maxServingPerson'] as int,
      quantity: map['quantity'] as double,
      defaultPrice: map['defaultPrice'] as double,
      finalPrice: map['finalPrice'] as double,
      discountedPrice: map['discountedPrice'] as double,
      otherInfo: map['otherInfo'] as Map<String, dynamic>,
      hasSelected: map['hasSelected'] as bool,
      unit: map['unit'] as String,
      currency: map['currency'] as String,
      description: map['description'] as String,
    );
  }

  String customPortionID;
  String title;
  int maxServingPerson;
  double quantity;
  double defaultPrice;
  double finalPrice;
  double discountedPrice;
  Map<String, dynamic> otherInfo;
  bool hasSelected;
  String unit;
  String currency;
  String description;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        customPortionID,
        title,
        maxServingPerson,
        quantity,
        defaultPrice,
        finalPrice,
        discountedPrice,
        otherInfo,
        hasSelected,
        unit,
        currency,
        description,
      ];

  Map<String, dynamic> toMap() {
    return {
      'customPortionID': this.customPortionID,
      'title': this.title,
      'maxServingPerson': this.maxServingPerson,
      'quantity': this.quantity,
      'defaultPrice': this.defaultPrice,
      'finalPrice': this.finalPrice,
      'discountedPrice': this.discountedPrice,
      'otherInfo': this.otherInfo,
      'hasSelected': this.hasSelected,
      'unit': this.unit,
      'currency': this.currency,
      'description': this.description,
    };
  }

  CustomPortion copyWith({
    String? customPortionID,
    String? title,
    int? maxServingPerson,
    double? quantity,
    double? defaultPrice,
    double? finalPrice,
    double? discountedPrice,
    Map<String, dynamic>? otherInfo,
    bool? hasSelected,
    String? unit,
    String? currency,
    String? description,
  }) {
    return CustomPortion(
      customPortionID: customPortionID ?? this.customPortionID,
      title: title ?? this.title,
      maxServingPerson: maxServingPerson ?? this.maxServingPerson,
      quantity: quantity ?? this.quantity,
      defaultPrice: defaultPrice ?? this.defaultPrice,
      finalPrice: finalPrice ?? this.finalPrice,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      otherInfo: otherInfo ?? this.otherInfo,
      hasSelected: hasSelected ?? this.hasSelected,
      unit: unit ?? this.unit,
      currency: currency ?? this.currency,
      description: description ?? this.description,
    );
  }
}

class Addons with AppEquatable {
  Addons({
    this.addonsID = -1,
    this.title = '',
    this.quantity = 0.0,
    this.defaultPrice = 0.0,
    this.finalPrice = 0.0,
    this.discountedPrice = 0.0,
    this.hasSelected = false,
    this.unit = '1',
    this.addonsImage,
    this.currency = 'SAR',
    this.description = '',
    this.hasOwnAddons = false,
  });

  factory Addons.fromMap(Map<String, dynamic> map) {
    return Addons(
      addonsID: map['addonsID'] as int,
      title: map['title'] as String,
      quantity: map['quantity'] as double,
      defaultPrice: map['defaultPrice'] as double,
      finalPrice: map['finalPrice'] as double,
      discountedPrice: map['discountedPrice'] as double,
      hasSelected: map['hasSelected'] as bool,
      unit: map['unit'] as String,
      addonsImage: (map['addonsImage'] != null) ? MenuImage.fromMap(map['addonsImage']) : MenuImage(),
      currency: map['currency'] as String,
      description: map['description'] as String,
      hasOwnAddons: map['hasOwnAddons'] as bool,
    );
  }

  int addonsID;
  String title;
  double quantity;
  double defaultPrice;
  double finalPrice;
  double discountedPrice;
  bool hasSelected;
  String unit;
  MenuImage? addonsImage;
  String currency;
  String description;
  bool hasOwnAddons;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        addonsID,
        title,
        quantity,
        defaultPrice,
        finalPrice,
        discountedPrice,
        hasSelected,
        unit,
        addonsImage,
        currency,
        description,
        hasOwnAddons,
      ];

  Map<String, dynamic> toMap() {
    return {
      'addonsID': this.addonsID,
      'title': this.title,
      'quantity': this.quantity,
      'defaultPrice': this.defaultPrice,
      'finalPrice': this.finalPrice,
      'discountedPrice': this.discountedPrice,
      'hasSelected': this.hasSelected,
      'unit': this.unit,
      'addonsImage': this.addonsImage?.toMap() ?? MenuImage().toMap(),
      'currency': this.currency,
      'description': this.description,
      'hasOwnAddons': this.hasOwnAddons,
    };
  }

  Addons copyWith({
    int? addonsID,
    String? title,
    double? quantity,
    double? defaultPrice,
    double? finalPrice,
    double? discountedPrice,
    bool? hasSelected,
    String? unit,
    MenuImage? addonsImage,
    String? currency,
    String? description,
    bool? hasOwnAddons,
    int? id,
  }) {
    return Addons(
      addonsID: addonsID ?? this.addonsID,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      defaultPrice: defaultPrice ?? this.defaultPrice,
      finalPrice: finalPrice ?? this.finalPrice,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      hasSelected: hasSelected ?? this.hasSelected,
      unit: unit ?? this.unit,
      addonsImage: addonsImage ?? this.addonsImage,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      hasOwnAddons: hasOwnAddons ?? this.hasOwnAddons,
    );
  }
}

class MenuAvailableDayAndTime with AppEquatable {
  MenuAvailableDayAndTime({
    this.day = '',
    this.shortName = '',
    this.id = -1,
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
      openingTime: (map['openingTime'] != null &&
              (!(map['openingTime'].runtimeType is DateTime)) &&
              (map['openingTime'].runtimeType is Timestamp || map['openingTime'].runtimeType is String))
          ? Timestamp.parse(map['openingTime'].toString()).toDateTime()
          : DateTime.now(),
      closingTime: (map['closingTime'] != null &&
              (!(map['closingTime'].runtimeType is DateTime)) &&
              (map['closingTime'].runtimeType is Timestamp || map['closingTime'].runtimeType is String))
          ? Timestamp.parse(map['closingTime'].toString()).toDateTime()
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
      'title': this.day,
      'id': this.id,
      'hasSelected': this.hasSelected,
      'closingTime': Timestamp.fromDateTime(this.closingTime ?? DateTime.now().toUtc()),
      'openingTime': Timestamp.fromDateTime(this.openingTime ?? DateTime.now().toUtc()),
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
    this.timeOfPeriodWiseId = '',
    this.title = '',
    this.hasSelected = false,
  });

  factory TimeOfPeriodWise.fromMap(Map<String, dynamic> map) {
    return TimeOfPeriodWise(
      timeOfPeriodWiseId: map['timeOfPeriodWiseId'] as String,
      title: map['title'] as String,
      hasSelected: map['hasSelected'] as bool,
    );
  }

  String timeOfPeriodWiseId;
  String title;
  bool hasSelected;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        timeOfPeriodWiseId,
        title,
        hasSelected,
      ];

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
    this.timingID = '',
    this.minPreparingTime = '',
    this.maxPreparingTime = '',
    this.minDeliveryTime = '',
    this.maxDeliveryTiming = '',
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

  String timingID;
  String minPreparingTime;
  String maxPreparingTime;
  String minDeliveryTime;
  String maxDeliveryTiming;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        timingID,
        minPreparingTime,
        maxPreparingTime,
        minDeliveryTime,
        maxDeliveryTiming,
      ];

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
    this.categoryId = '0',
    this.title = '',
    this.hasSelected = false,
    this.subCategory = const [],
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      categoryId: map['categoryId'] as String,
      title: map['title'] as String,
      hasSelected: map['hasSelected'] as bool,
      subCategory: map['subCategory'].map((e) => Category.fromMap(e)).toList().cast<Category>(),
    );
  }

  String categoryId;
  String title;
  bool hasSelected;
  List<Category> subCategory;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        categoryId,
        title,
        hasSelected,
        subCategory,
      ];

  Map<String, dynamic> toMap() {
    return {
      'categoryId': this.categoryId,
      'title': this.title,
      'hasSelected': this.hasSelected,
      'subCategory': this.subCategory.map((e) => e.toMap()).toList(),
    };
  }

  Category copyWith({
    String? categoryId,
    String? title,
    bool? hasSelected,
    List<Category>? subCategory,
  }) {
    return Category(
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      hasSelected: hasSelected ?? this.hasSelected,
      subCategory: subCategory ?? this.subCategory,
    );
  }
}

class Stock with AppEquatable {
  Stock({
    this.stockID = '',
    this.minStockQuantity = 0,
    this.maxStockQuantity = 0,
  });

  factory Stock.fromMap(Map<String, dynamic> map) {
    return Stock(
      stockID: map['stockID'] as String,
      minStockQuantity: map['minStockQuantity'] as int,
      maxStockQuantity: map['maxStockQuantity'] as int,
    );
  }

  String stockID;
  int minStockQuantity;
  int maxStockQuantity;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        stockID,
        minStockQuantity,
        maxStockQuantity,
      ];

  Map<String, dynamic> toMap() {
    return {
      'stockID': this.stockID,
      'minStockQuantity': this.minStockQuantity,
      'maxStockQuantity': this.maxStockQuantity,
    };
  }

  Stock copyWith({
    String? stockID,
    int? minStockQuantity,
    int? maxStockQuantity,
  }) {
    return Stock(
      stockID: stockID ?? this.stockID,
      minStockQuantity: minStockQuantity ?? this.minStockQuantity,
      maxStockQuantity: maxStockQuantity ?? this.maxStockQuantity,
    );
  }
}
