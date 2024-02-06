part of 'package:homemakers_merchant/app/features/order/index.dart';

class OrderEntity extends INetworkModel<OrderEntity> with EquatableMixin {
  OrderEntity({
    required this.orderDateTime,
    required this.userInfo,
    required this.driver,
    required this.payment,
    required this.store,
    required this.orderDeliveryDateTime,
    this.orderType = 0,
    this.hasDriverAssigned = false,
    this.orderID = -1,
    this.orderStatus = 0,
    this.hasDriverReached = false,
    this.trackingInfo = const [],
  });

  factory OrderEntity.fromMap(Map<String, dynamic> json) => OrderEntity(
        orderDateTime: (json['orderDateTime'] != null)
            ? Timestamp.fromMillisecondsSinceEpoch(json['orderDateTime'])
                .toDateTime()
            : DateTime.now(),
        orderType: json['orderType'] ?? 0,
        userInfo: (json['userInfo'] != null)
            ? UserInfo.fromJson(json['userInfo'])
            : UserInfo(deliveryAddress: DeliveryAddress()),
        hasDriverAssigned: json['hasDriverAssigned'] ?? false,
        driver: (json['driver'] != null)
            ? DeliveryDriver.fromJson(json['driver'])
            : DeliveryDriver(),
        orderID: json['orderID'] ?? -1,
        orderStatus: json['orderStatus'] ?? 0,
        payment: Payment.fromJson(json['payment']),
        store: (json['store'] != null)
            ? Store.fromJson(json['store'])
            : Store(location: AddressLocation()),
        hasDriverReached: json['hasDriverReached'] ?? false,
        orderDeliveryDateTime: (json['orderDeliveryDateTime'] != null)
            ? Timestamp.fromMillisecondsSinceEpoch(
                    json['orderDeliveryDateTime'])
                .toDateTime()
            : DateTime.now(),
        trackingInfo: (json['trackingInfo'] != null)
            ? List<TrackingInfo>.from(
                json['trackingInfo'].map((x) => TrackingInfo.fromJson(x)))
            : const <TrackingInfo>[],
      );

  final DateTime orderDateTime;
  final int orderType;
  final UserInfo userInfo;
  final bool hasDriverAssigned;
  final DeliveryDriver driver;
  final int orderID;
  final int orderStatus;
  final Payment payment;
  final Store store;
  final bool hasDriverReached;
  final DateTime orderDeliveryDateTime;
  final List<TrackingInfo> trackingInfo;

  Map<String, dynamic> toMap() => {
        'orderDateTime':
            Timestamp.fromDateTime(orderDateTime).millisecondsSinceEpoch,
        'orderType': orderType,
        'userInfo': userInfo.toJson(),
        'hasDriverAssigned': hasDriverAssigned,
        'driver': driver.toJson(),
        'orderID': orderID,
        'orderStatus': orderStatus,
        'payment': payment.toJson(),
        'store': store.toJson(),
        'hasDriverReached': hasDriverReached,
        'orderDeliveryDateTime': Timestamp.fromDateTime(orderDeliveryDateTime)
            .millisecondsSinceEpoch,
        'trackingInfo': List<dynamic>.from(trackingInfo.map((x) => x.toJson())),
      };

  OrderEntity copyWith({
    DateTime? orderDateTime,
    int? orderType,
    UserInfo? userInfo,
    bool? hasDriverAssigned,
    DeliveryDriver? driver,
    int? orderID,
    int? orderStatus,
    Payment? payment,
    Store? store,
    bool? hasDriverReached,
    DateTime? orderDeliveryDateTime,
    List<TrackingInfo>? trackingInfo,
  }) {
    return OrderEntity(
      orderDateTime: orderDateTime ?? this.orderDateTime,
      orderType: orderType ?? this.orderType,
      userInfo: userInfo ?? this.userInfo,
      hasDriverAssigned: hasDriverAssigned ?? this.hasDriverAssigned,
      driver: driver ?? this.driver,
      orderID: orderID ?? this.orderID,
      orderStatus: orderStatus ?? this.orderStatus,
      payment: payment ?? this.payment,
      store: store ?? this.store,
      hasDriverReached: hasDriverReached ?? this.hasDriverReached,
      orderDeliveryDateTime:
          orderDeliveryDateTime ?? this.orderDeliveryDateTime,
      trackingInfo: trackingInfo ?? this.trackingInfo,
    );
  }

  @override
  OrderEntity fromJson(Map<String, dynamic> json) {
    return OrderEntity.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  List<Object?> get props => [
        orderDateTime,
        orderType,
        userInfo,
        hasDriverAssigned,
        driver,
        orderID,
        orderStatus,
        payment,
        store,
        hasDriverReached,
        orderDeliveryDateTime,
      ];
}

class Payment extends Equatable {
  const Payment({
    this.mode = '',
    this.amount = 0.0,
    this.paymentID = -1,
    this.currency = 'SAR',
    required this.paymentDateTime,
    this.deliveryAmount = 0.0,
    this.discountAmount = 0.0,
    this.serviceAmount = 0.0,
    this.tax = 0.0,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        mode: json['mode'] ?? 'COD',
        amount: json['amount'] ?? 0.0,
        paymentID: json['paymentID'] ?? -1,
        currency: json['currency'] ?? 'SAR',
        paymentDateTime: (json['paymentDateTime'] != null)
            ? Timestamp.fromMillisecondsSinceEpoch(json['paymentDateTime'])
                .toDateTime()
            : DateTime.now(),
        deliveryAmount: json['deliveryAmount'] ?? 0.0,
        discountAmount: json['discountAmount'],
        serviceAmount: json['serviceAmount'] ?? 0.0,
        tax: json['tax'] ?? 0.0,
      );

  final String mode;
  final double amount;
  final int paymentID;
  final String currency;
  final DateTime paymentDateTime;
  final double deliveryAmount;
  final double discountAmount;
  final double serviceAmount;
  final double tax;

  Map<String, dynamic> toJson() => {
        'mode': mode,
        'amount': amount,
        'paymentID': paymentID,
        'currency': currency,
        'deliveryAmount': deliveryAmount,
        'discountAmount': discountAmount,
        'serviceAmount': serviceAmount,
        'tax': tax,
        'paymentDateTime':
            Timestamp.fromDateTime(paymentDateTime).millisecondsSinceEpoch,
      };

  @override
  List<Object?> get props => [
        mode,
        amount,
        paymentID,
        currency,
        deliveryAmount,
        discountAmount,
        serviceAmount,
        tax,
        paymentDateTime,
      ];
}

class Store extends Equatable {
  const Store({
    required this.location,
    this.storeName = '',
    this.storeID = -1,
    this.menu = const [],
    this.orderMenuName = '',
    this.orderMenuImage = '',
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        storeName: json['storeName'] ?? '',
        location: (json['location'] != null)
            ? AddressLocation.fromJson(json['location'])
            : AddressLocation(),
        storeID: json['storeID'] ?? -1,
        orderMenuName: json['orderMenuName'] ?? '',
        orderMenuImage: json['orderMenuImage'] ?? '',
        menu: (json['menu'] != null)
            ? List<Menu>.from(json['menu'].map((x) => Menu.fromJson(x)))
            : const <Menu>[],
      );

  final String storeName;
  final AddressLocation location;
  final int storeID;
  final String orderMenuName;
  final String orderMenuImage;
  final List<Menu> menu;

  Map<String, dynamic> toJson() => {
        'storeName': storeName,
        'location': location.toJson(),
        'storeID': storeID,
        'menu': List<dynamic>.from(menu.map((x) => x.toJson())),
        'orderMenuImage': orderMenuImage,
        'orderMenuName': orderMenuName,
      };

  @override
  List<Object?> get props => [
        storeName,
        location,
        storeID,
        menu,
        orderMenuImage,
        orderMenuName,
      ];
}

class AddressLocation extends Equatable {
  const AddressLocation({
    this.lng = 0.0,
    this.lat = 0.0,
  });

  factory AddressLocation.fromJson(Map<String, dynamic> json) =>
      AddressLocation(
        lng: json['lng'],
        lat: json['lat'],
      );

  final double lng;
  final double lat;

  Map<String, dynamic> toJson() => {
        'lng': lng,
        'lat': lat,
      };

  @override
  List<Object?> get props => [
        lng,
        lat,
      ];
}

class Menu extends Equatable {
  const Menu({
    this.quantity = 1,
    this.unit = '',
    this.numberOfServingPerson = 1,
    this.addons = const [],
    this.instruction = '',
    this.menuID = -1,
    this.menuName = '',
    this.menuImage = '',
    this.tasteLevel = '',
    this.tasteType = '',
    this.menuCategory = '',
    this.menuSubCategory = '',
    this.orderPortion,
    this.price = 0.0,
    this.discountPrice = 0.0,
    this.currency = 'SAR',
    this.isInstantMenu = true,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        quantity: json['quantity'] ?? 1,
        unit: json['unit'] ?? '',
        numberOfServingPerson: json['numberOfServingPerson'] ?? 0,
        addons: (json['addons'] != null)
            ? List<Addon>.from(json['addons'].map((x) => Addon.fromJson(x)))
            : const <Addon>[],
        instruction: json['instruction'] ?? '',
        menuID: json['menuID'] ?? -1,
        menuName: json['menuName'] ?? '',
        menuImage: json['menuImage'] ?? '',
        tasteLevel: json['tasteLevel'] ?? '',
        tasteType: json['tasteType'] ?? '',
        menuCategory: json['menuCategory'] ?? '',
        menuSubCategory: json['menuSubCategory'] ?? '',
        orderPortion: json['orderPortion'] != null
            ? OrderPortion.fromJson(json['orderPortion'])
            : const OrderPortion(),
        price: json['price'] ?? 0.0,
        discountPrice: json['discountPrice'] ?? 0.0,
        currency: json['currency'] ?? 'SAR',
        isInstantMenu: json['isInstantMenu'] ?? true,
      );

  final int quantity;
  final String unit;
  final int numberOfServingPerson;
  final List<Addon> addons;
  final String instruction;
  final int menuID;
  final String menuName;
  final String menuImage;
  final String tasteLevel;
  final String tasteType;
  final String menuCategory;
  final String menuSubCategory;
  final OrderPortion? orderPortion;
  final double price;
  final double discountPrice;
  final String currency;
  final bool isInstantMenu;

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'unit': unit,
        'numberOfServingPerson': numberOfServingPerson,
        'addons': List<dynamic>.from(addons.map((x) => x.toJson())),
        'instruction': instruction,
        'menuID': menuID,
        'menuName': menuName,
        'menuImage': menuImage,
        'tasteLevel': tasteLevel,
        'tasteType': tasteType,
        'menuCategory': menuCategory,
        'menuSubCategory': menuSubCategory,
        'orderPortion': orderPortion?.toJson() ?? <String, dynamic>{},
        'price': price,
        'discountPrice': discountPrice,
        'currency': currency,
        'isInstantMenu': isInstantMenu,
      };

  @override
  List<Object?> get props => [
        quantity,
        unit,
        numberOfServingPerson,
        addons,
        instruction,
        menuID,
        menuName,
        menuImage,
        tasteLevel,
        tasteType,
        menuCategory,
        menuSubCategory,
        orderPortion,
        price,
        discountPrice,
        currency,
        isInstantMenu,
      ];
}

class OrderPortion extends Equatable {
  const OrderPortion({
    this.portionSize = 0.0,
    this.portionUnit = '',
  });

  factory OrderPortion.fromJson(Map<String, dynamic> map) {
    return OrderPortion(
      portionSize: map['portionSize'] ?? 0.0 as double,
      portionUnit: map['portionUnit'] ?? '' as String,
    );
  }

  final double portionSize;
  final String portionUnit;

  Map<String, dynamic> toJson() {
    return {
      'portionSize': portionSize,
      'portionUnit': portionUnit,
    };
  }

  @override
  List<Object?> get props => [portionSize, portionUnit];
}

class Addon extends Equatable {
  const Addon({
    this.addonsImage = '',
    this.quantity = 1,
    this.addonsName = '',
    this.addonsId = -1,
    this.orderPortion,
    this.price = 0.0,
    this.discountPrice = 0.0,
    this.currency = 'SAR',
  });

  factory Addon.fromJson(Map<String, dynamic> json) => Addon(
        addonsImage: json['addonsImage'] ?? '',
        quantity: json['quantity'] ?? 1,
        addonsName: json['addonsName'] ?? '',
        addonsId: json['addonsID'] ?? -1,
        orderPortion: json['orderPortion'] != null
            ? OrderPortion.fromJson(json['orderPortion'])
            : OrderPortion(),
        price: json['price'] ?? 0.0,
        discountPrice: json['discountPrice'] ?? 0.0,
        currency: json['currency'] ?? 'SAR',
      );

  final String addonsImage;
  final double quantity;
  final String addonsName;
  final int addonsId;
  final OrderPortion? orderPortion;
  final double price;
  final double discountPrice;
  final String currency;

  Map<String, dynamic> toJson() => {
        'addonsImage': addonsImage,
        'quantity': quantity,
        'addonsName': addonsName,
        'addonsID': addonsId,
        'orderPortion': orderPortion?.toJson() ?? <String, dynamic>{},
        'price': price,
        'discountPrice': discountPrice,
        'currency': currency,
      };

  @override
  List<Object?> get props => [
        addonsImage,
        quantity,
        addonsName,
        addonsId,
        orderPortion,
        price,
        discountPrice,
        currency,
      ];
}

class UserInfo extends Equatable {
  const UserInfo({
    required this.deliveryAddress,
    this.lng = 0.0,
    this.contactNumber = '',
    this.userName = '',
    this.userId = -1,
    this.lat = 0.0,
    this.completeAddress = '',
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        lng: json['lng'] ?? 0.0,
        deliveryAddress: json['deliveryAddress'] != null
            ? DeliveryAddress.fromJson(json['deliveryAddress'])
            : DeliveryAddress(),
        contactNumber: json['contactNumber'] ?? '',
        userName: json['userName'] ?? '',
        userId: json['userID'] ?? -1,
        lat: json['lat'] ?? 0.0,
        completeAddress: json['completeAddress'] ?? '',
      );

  final double lng;
  final DeliveryAddress deliveryAddress;
  final String contactNumber;
  final String userName;
  final int userId;
  final double lat;
  final String completeAddress;

  Map<String, dynamic> toJson() => {
        'lng': lng,
        'deliveryAddress': deliveryAddress.toJson(),
        'contactNumber': contactNumber,
        'userName': userName,
        'userID': userId,
        'lat': lat,
        'completeAddress': completeAddress,
      };

  @override
  List<Object?> get props => [
        deliveryAddress,
        lng,
        contactNumber,
        userName,
        userId,
        lat,
        completeAddress,
      ];
}

class DeliveryAddress extends Equatable {
  const DeliveryAddress({
    this.contactPerson = '',
    this.lng = 0.0,
    this.contactNumber = '',
    this.lat = 0.0,
    this.completeAddress = '',
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) =>
      DeliveryAddress(
        lng: json['lng'] ?? 0.0,
        contactNumber: json['contactNumber'] ?? '',
        lat: json['lat'] ?? 0.00,
        completeAddress: json['completeAddress'] ?? '',
        contactPerson: json['contactPerson'] ?? '',
      );

  final double lng;
  final String contactNumber;
  final double lat;
  final String completeAddress;
  final String contactPerson;

  Map<String, dynamic> toJson() => {
        'lng': lng,
        'contactNumber': contactNumber,
        'lat': lat,
        'completeAddress': completeAddress,
        'contactPerson': contactPerson,
      };

  @override
  List<Object?> get props => [
        contactPerson,
        lng,
        contactNumber,
        lat,
        completeAddress,
      ];
}
