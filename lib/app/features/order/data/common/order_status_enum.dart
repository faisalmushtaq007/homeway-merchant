part of 'package:homemakers_merchant/app/features/order/index.dart';

enum OrderStatus {
  none,
  newOrder,
  ongoing,
  onProcessing,
  schedule,
  cancelByUser,
  delivered,
  onTheWay,
  cancelBySystem,
  cancelByYou,
  onTime,
  delay,
  partialDelay,
  moderateDelay,
  tooMuchDelay,
  paymentNotReceived,
  paymentReceived,
  cashOnDelivery,
  pickUpByDriver,
  orderReceivedByCustomer,
  readyToPickup,
  prepared,
  preparing,
  cancel,
  ;

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
  cancel;
}
