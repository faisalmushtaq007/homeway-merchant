part of 'package:homemakers_merchant/app/features/order/index.dart';

enum OrderStatus {
  none(),
  newOrder(
    title: 'New Order',
    borderColor: Color.fromRGBO(255, 90, 39, 1),
  ),
  ongoing(
    title: 'On Going',
    backgroundColor: Color.fromRGBO(255, 90, 39, 1),
  ),
  onProcessing(
    title: 'On Process',
    backgroundColor: Color.fromRGBO(255, 90, 39, 1),
  ),
  schedule(
    title: 'Schedule',
    backgroundColor: Color.fromRGBO(255, 156, 125, 1),
  ),
  cancelByUser(
    title: 'Cancel',
    backgroundColor: Color.fromRGBO(165, 166, 168, 1),
  ),
  delivered(
    title: 'Delivered',
    backgroundColor: Color.fromRGBO(69, 201, 125, 1),
    borderColor: Color.fromRGBO(69, 201, 125, 1),
  ),
  onTheWay(
    title: 'On the way',
    backgroundColor: Color.fromRGBO(69, 201, 125, 1),
    borderColor: Color.fromRGBO(69, 201, 125, 1),
  ),
  cancelBySystem(
    title: 'Cancel',
    backgroundColor: Color.fromRGBO(165, 166, 168, 1),
  ),
  cancelByYou(
    title: 'Cancel',
    backgroundColor: Color.fromRGBO(165, 166, 168, 1),
  ),
  onTime(),
  delay(
    title: 'Delay',
    backgroundColor: Color.fromRGBO(255, 39, 19, 1),
  ),
  partialDelay(
    title: 'Delay',
    backgroundColor: Color.fromRGBO(255, 39, 19, 1),
  ),
  moderateDelay(
    title: 'Delay',
    backgroundColor: Color.fromRGBO(255, 39, 19, 1),
  ),
  tooMuchDelay(
    title: 'Delay',
    backgroundColor: Color.fromRGBO(255, 39, 19, 1),
  ),
  paymentNotReceived(),
  paymentReceived(),
  cashOnDelivery(),
  pickUpByDriver(
    title: 'PickUp',
    backgroundColor: Color.fromRGBO(143, 222, 177, 1),
    borderColor: Color.fromRGBO(69, 201, 125, 1),
  ),
  orderReceivedByCustomer(
    title: 'Received',
    backgroundColor: Color.fromRGBO(215, 243, 227, 1),
  ),
  readyToPickup(
    title: 'Ready',
    backgroundColor: Color.fromRGBO(215, 243, 227, 1),
    borderColor: Color.fromRGBO(69, 201, 125, 1),
  ),
  prepared(
    backgroundColor: Color.fromRGBO(215, 243, 227, 1),
    borderColor: Color.fromRGBO(69, 201, 125, 1),
  ),
  preparing(
    title: 'Processing',
    backgroundColor: Color.fromRGBO(255, 90, 39, 1),
  ),
  cancel(
    title: 'Cancel',
    backgroundColor: Color.fromRGBO(165, 166, 168, 1),
  ),
  ;

  final int progress;
  final String title;
  final String subTitle;
  final Color backgroundColor;
  final Color borderColor;

  const OrderStatus({
    this.progress = 0,
    this.title = '',
    this.subTitle = '',
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.white,
  });
  @override
  String toString() {
    return name;
  }
}

enum OrderType {
  none,
  all,
  recent,
  current,
  newOrder,
  onProcess,
  schedule,
  deliver,
  cancel,
  instant,
  ;

  @override
  String toString() {
    return name;
  }
}

enum TrackingTitle {
  DRIVER_ASSIGNED(groupTitle: 'Driver assigned'),
  ORDER_ACCEPT(groupTitle: 'Order accept'),
  ORDER_ARRIVED(groupTitle: 'Order arrived'),
  ORDER_CANCEL_BY_SYSTEM(groupTitle: 'Cancel by system'),
  ORDER_CANCEL_BY_USER(groupTitle: 'Cancel by user'),
  ORDER_CANCEL_BY_YOU(groupTitle: 'Cancel by you'),
  ORDER_DELAY(groupTitle: 'Order delay'),
  ORDER_DELIVERY_ON_THE_WAY(groupTitle: 'Delivery on the way'),
  ORDER_ONPROCESSING(groupTitle: 'On processing'),
  ORDER_PICKUP_BY_DRIVER(groupTitle: 'Pickup by driver'),
  ORDER_REACHED_TO_DESTINATION(groupTitle: 'Reached to destination'),
  ORDER_READY(groupTitle: 'Order ready'),
  ORDER_RECEIVED_BY_USER(groupTitle: 'Received by user'),
  PAYMENT_DECLINE(groupTitle: 'Payment decline'),
  PAYMENT_RECEIVED(groupTitle: 'Payment received'),
  SCHEDULE_ORDER(groupTitle: 'Schedule Order'),
  ORDER_DELIVERED(groupTitle: 'Order Delivered'),
  ;

  const TrackingTitle({
    this.title = '',
    this.groupTitle = '',
  });
  final String title;
  final String groupTitle;
}

final tackingTitleValues = EnumValues({
  'driver_assigned': TrackingTitle.DRIVER_ASSIGNED,
  'order_accept': TrackingTitle.ORDER_ACCEPT,
  'order_arrived': TrackingTitle.ORDER_ARRIVED,
  'order_cancel_by_system': TrackingTitle.ORDER_CANCEL_BY_SYSTEM,
  'order_cancel_by_user': TrackingTitle.ORDER_CANCEL_BY_USER,
  'order_cancel_by_you': TrackingTitle.ORDER_CANCEL_BY_YOU,
  'order_delay': TrackingTitle.ORDER_DELAY,
  'order_delivery_on_the_way': TrackingTitle.ORDER_DELIVERY_ON_THE_WAY,
  'order_onprocessing': TrackingTitle.ORDER_ONPROCESSING,
  'order_pickup_by_driver': TrackingTitle.ORDER_PICKUP_BY_DRIVER,
  'order_reached_to_destination': TrackingTitle.ORDER_REACHED_TO_DESTINATION,
  'order_ready': TrackingTitle.ORDER_READY,
  'order_received_by_user': TrackingTitle.ORDER_RECEIVED_BY_USER,
  'payment_decline': TrackingTitle.PAYMENT_DECLINE,
  'payment_received': TrackingTitle.PAYMENT_RECEIVED,
  'schedule_order': TrackingTitle.SCHEDULE_ORDER,
  'order_delivered': TrackingTitle.ORDER_DELIVERED,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
