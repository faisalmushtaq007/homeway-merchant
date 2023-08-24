part of 'package:homemakers_merchant/app/features/order/index.dart';

class OrderEntity extends INetworkModel<OrderEntity> with AppEquatable {
  OrderEntity({
    required this.orderDateTime,
    this.orderType = 0,
    required this.userInfo,
    this.hasDriverAssigned = false,
    required this.driver,
    this.orderID = -1,
    this.orderStatus = 0,
    required this.payment,
    required this.store,
    this.hasDriverReached = false,
    required this.orderDeliveryDateTime,
  });

  factory OrderEntity.fromMap(Map<String, dynamic> json) {
    print('Runtime type Order date time ${json['orderDateTime'].runtimeType}, ${json['orderDateTime']}');
    print('Runtime type Delivery date time ${json['orderDeliveryDateTime'].runtimeType}, ${json['orderDeliveryDateTime']}');
    return OrderEntity(
      orderDateTime: (json['orderDateTime'] != null &&
              (!(json['orderDateTime'].runtimeType is DateTime)) &&
              (json['orderDateTime'].runtimeType is Timestamp || json['orderDateTime'].runtimeType is String))
          ? Timestamp.parse(json['orderDateTime'].toString()).toDateTime()
          : DateTime.now(),
      orderType: json['orderType'] ?? 0,
      userInfo: (json['userInfo'] != null) ? UserInfo.fromJson(json['userInfo']) : UserInfo(deliveryAddress: DeliveryAddress()),
      hasDriverAssigned: json['hasDriverAssigned'] ?? false,
      driver: (json['driver'] != null) ? Driver.fromJson(json['driver']) : Driver(),
      orderID: json['orderID'] ?? -1,
      orderStatus: json['orderStatus'] ?? 0,
      payment: (json['payment'] != null) ? Payment.fromJson(json['payment']) : Payment(),
      store: (json['store'] != null) ? Store.fromJson(json['store']) : Store(location: AddressLocation()),
      hasDriverReached: json['hasDriverReached'] ?? false,
      orderDeliveryDateTime: (json['orderDeliveryDateTime'] != null &&
              (!(json['orderDeliveryDateTime'].runtimeType is DateTime)) &&
              (json['orderDeliveryDateTime'].runtimeType is Timestamp || json['orderDeliveryDateTime'].runtimeType is String))
          ? Timestamp.parse(json['orderDeliveryDateTime'].toString()).toDateTime()
          : DateTime.now(),
    );
  }

  final DateTime orderDateTime;
  final int orderType;
  final UserInfo userInfo;
  final bool hasDriverAssigned;
  final Driver driver;
  final int orderID;
  final int orderStatus;
  final Payment payment;
  final Store store;
  final bool hasDriverReached;
  final DateTime orderDeliveryDateTime;

  Map<String, dynamic> toMap() => {
        'orderDateTime': Timestamp.fromDateTime(orderDateTime),
        'orderType': orderType,
        'userInfo': userInfo.toJson(),
        'hasDriverAssigned': hasDriverAssigned,
        'driver': driver.toJson(),
        'orderID': orderID,
        'orderStatus': orderStatus,
        'payment': payment.toJson(),
        'store': store.toJson(),
        'hasDriverReached': hasDriverReached,
        'orderDeliveryDateTime': Timestamp.fromDateTime(orderDeliveryDateTime),
      };

  OrderEntity copyWith({
    DateTime? orderDateTime,
    int? orderType,
    UserInfo? userInfo,
    bool? hasDriverAssigned,
    Driver? driver,
    int? orderID,
    int? orderStatus,
    Payment? payment,
    Store? store,
    bool? hasDriverReached,
    DateTime? orderDeliveryDateTime,
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
      orderDeliveryDateTime: orderDeliveryDateTime ?? this.orderDeliveryDateTime,
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
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
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

class Driver {
  Driver({
    this.driverID = -1,
    this.lng = 0.0,
    this.contactNumber = '',
    this.driverName = '',
    this.lat = 0.0,
    this.completeAddress = '',
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        driverID: json['driverID'] ?? -1,
        lng: json['lng'] ?? 0.0,
        contactNumber: json['contactNumber'] ?? '',
        driverName: json['driverName'] ?? '',
        lat: json['lat'] ?? 0.0,
        completeAddress: json['completeAddress'] ?? '',
      );

  final int driverID;
  final double lng;
  final String contactNumber;
  final String driverName;
  final double lat;
  final String completeAddress;

  Map<String, dynamic> toJson() => {
        'driverID': driverID,
        'lng': lng,
        'contactNumber': contactNumber,
        'driverName': driverName,
        'lat': lat,
        'completeAddress': completeAddress,
      };
}

class Payment {
  Payment({
    this.mode = '',
    this.amount = 0.0,
    this.paymentID = -1,
    this.currency = 'SAR',
    this.paymentDateTime = '',
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        mode: json['mode'],
        amount: json['amount'],
        paymentID: json['paymentID'],
        currency: json['currency'],
        paymentDateTime: json['paymentDateTime'],
      );

  final String mode;
  final double amount;
  final int paymentID;
  final String currency;
  final String paymentDateTime;

  Map<String, dynamic> toJson() => {
        'mode': mode,
        'amount': amount,
        'paymentID': paymentID,
        'currency': currency,
        'paymentDateTime': paymentDateTime,
      };
}

class Store {
  Store({
    this.storeName = '',
    required this.location,
    this.storeID = -1,
    this.menu = const [],
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        storeName: json['storeName'] ?? '',
        location: (json['location'] != null) ? AddressLocation.fromJson(json['location']) : AddressLocation(),
        storeID: json['storeID'] ?? -1,
        menu: (json['menu'] != null) ? List<Menu>.from(json['menu'].map((x) => Menu.fromJson(x))) : const <Menu>[],
      );

  final String storeName;
  final AddressLocation location;
  final int storeID;
  final List<Menu> menu;

  Map<String, dynamic> toJson() => {
        'storeName': storeName,
        'location': location.toJson(),
        'storeID': storeID,
        'menu': List<dynamic>.from(menu.map((x) => x.toJson())),
      };
}

class AddressLocation {
  AddressLocation({
    this.lng = 0.0,
    this.lat = 0.0,
  });

  factory AddressLocation.fromJson(Map<String, dynamic> json) => AddressLocation(
        lng: json['lng'],
        lat: json['lat'],
      );

  final double lng;
  final double lat;

  Map<String, dynamic> toJson() => {
        'lng': lng,
        'lat': lat,
      };
}

class Menu {
  Menu({
    this.quantity = 0,
    this.unit = '',
    this.numberOfServingPerson = 0,
    this.addons = const [],
    this.instruction = '',
    this.menuID = -1,
    this.menuName = '',
    this.menuImage = '',
    this.tasteLevel = '',
    this.tasteType = '',
    this.menuCategory = '',
    this.menuSubCategory = '',
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        quantity: json['quantity'] ?? 0,
        unit: json['unit'] ?? '',
        numberOfServingPerson: json['numberOfServingPerson'] ?? 0,
        addons: (json['addons'] != null) ? List<Addon>.from(json['addons'].map((x) => Addon.fromJson(x))) : const <Addon>[],
        instruction: json['instruction'] ?? '',
        menuID: json['menuID'] ?? -1,
        menuName: json['menuName'] ?? '',
        menuImage: json['menuImage'] ?? '',
        tasteLevel: json['tasteLevel'] ?? '',
        tasteType: json['tasteType'] ?? '',
        menuCategory: json['menuCategory'] ?? '',
        menuSubCategory: json['menuSubCategory'] ?? '',
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
      };
}

class Addon {
  Addon({
    this.addonsImage = '',
    this.qunatity = 1.0,
    this.addonsName = '',
    this.addonsId = -1,
  });

  factory Addon.fromJson(Map<String, dynamic> json) => Addon(
        addonsImage: json['addonsImage'] ?? '',
        qunatity: json['qunatity'] ?? 1.0,
        addonsName: json['addonsName'] ?? '',
        addonsId: json['addonsID'] ?? -1,
      );

  final String addonsImage;
  final double qunatity;
  final String addonsName;
  final int addonsId;

  Map<String, dynamic> toJson() => {
        'addonsImage': addonsImage,
        'qunatity': qunatity,
        'addonsName': addonsName,
        'addonsID': addonsId,
      };
}

class UserInfo {
  UserInfo({
    this.lng = 0.0,
    required this.deliveryAddress,
    this.contactNumber = '',
    this.userName = '',
    this.userId = -1,
    this.lat = 0.0,
    this.completeAddress = '',
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        lng: json['lng'] ?? 0.0,
        deliveryAddress: json['deliveryAddress'] != null ? DeliveryAddress.fromJson(json['deliveryAddress']) : DeliveryAddress(),
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
}

class DeliveryAddress {
  DeliveryAddress({
    this.contactPerson = '',
    this.lng = 0.0,
    this.contactNumber = '',
    this.lat = 0.0,
    this.completeAddress = '',
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) => DeliveryAddress(
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
}
