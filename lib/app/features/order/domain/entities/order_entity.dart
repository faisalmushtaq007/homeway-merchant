part of 'package:homemakers_merchant/app/features/order/index.dart';

class OrderEntity {
  const OrderEntity({
    required this.orderID,
    required this.orderDateTime,
    required this.menuEntity,
    this.appUserEntity,
    this.businessProfileEntity,
    this.orderStatus = OrderStatus.none,
    this.quantity = 0,
    this.orderType = OrderType.none,
    this.storeEntity,
  });

  factory OrderEntity.fromMap(Map<String, dynamic> map) {
    return OrderEntity(
      orderID: map['orderID'] as int,
      orderDateTime: (map['orderDateTime'] != null &&
              (!(map['orderDateTime'].runtimeType is DateTime)) &&
              (map['orderDateTime'].runtimeType is Timestamp || map['orderDateTime'].runtimeType is String))
          ? Timestamp.parse(map['orderDateTime'].toString()).toDateTime()
          : DateTime.now(),
      appUserEntity: map['appUserEntity'] ?? AppUserEntity(),
      businessProfileEntity: map['businessProfileEntity'] ?? BusinessProfileEntity(),
      orderStatus: OrderStatus.values.byName(map['orderStatus']),
      quantity: map['quantity'] as int,
      orderType: OrderType.values.byName(map['orderType']),
      menuEntity: map['menuEntity'] as MenuEntity,
      storeEntity: map['storeEntity'] as StoreEntity,
    );
  }

  final int orderID;
  final DateTime orderDateTime;
  final AppUserEntity? appUserEntity;
  final BusinessProfileEntity? businessProfileEntity;
  final OrderStatus orderStatus;
  final int quantity;
  final OrderType orderType;
  final MenuEntity menuEntity;
  final StoreEntity? storeEntity;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderEntity &&
          runtimeType == other.runtimeType &&
          orderID == other.orderID &&
          orderDateTime == other.orderDateTime &&
          appUserEntity == other.appUserEntity &&
          businessProfileEntity == other.businessProfileEntity &&
          orderStatus == other.orderStatus &&
          quantity == other.quantity &&
          orderType == other.orderType &&
          menuEntity == other.menuEntity &&
          storeEntity == other.storeEntity);

  @override
  int get hashCode =>
      orderID.hashCode ^
      orderDateTime.hashCode ^
      appUserEntity.hashCode ^
      businessProfileEntity.hashCode ^
      orderStatus.hashCode ^
      quantity.hashCode ^
      orderType.hashCode ^
      menuEntity.hashCode ^
      storeEntity.hashCode;

  @override
  String toString() {
    return 'OrderEntity{ orderID: $orderID, orderDateTime: $orderDateTime, appUserEntity: $appUserEntity, businessProfileEntity: $businessProfileEntity, orderStatus: $orderStatus, quantity: $quantity, orderType: $orderType, menuEntity: $menuEntity, storeEntity: $storeEntity,}';
  }

  OrderEntity copyWith({
    int? orderID,
    DateTime? orderDateTime,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
    OrderStatus? orderStatus,
    int? quantity,
    OrderType? orderType,
    MenuEntity? menuEntity,
    StoreEntity? storeEntity,
  }) {
    return OrderEntity(
      orderID: orderID ?? this.orderID,
      orderDateTime: orderDateTime ?? this.orderDateTime,
      appUserEntity: appUserEntity ?? this.appUserEntity,
      businessProfileEntity: businessProfileEntity ?? this.businessProfileEntity,
      orderStatus: orderStatus ?? this.orderStatus,
      quantity: quantity ?? this.quantity,
      orderType: orderType ?? this.orderType,
      menuEntity: menuEntity ?? this.menuEntity,
      storeEntity: storeEntity ?? this.storeEntity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderID': this.orderID,
      'orderDateTime': Timestamp.fromDateTime(this.orderDateTime ?? DateTime.now().toUtc()),
      'appUserEntity': this.appUserEntity ?? AppUserEntity().toMap(),
      'businessProfileEntity': this.businessProfileEntity ?? BusinessProfileEntity().toMap(),
      'orderStatus': this.orderStatus.name,
      'quantity': this.quantity,
      'orderType': this.orderType.name,
      'menuEntity': this.menuEntity ?? MenuEntity().toMap(),
      'storeEntity': this.storeEntity ?? StoreEntity().toMap(),
    };
  }
}
