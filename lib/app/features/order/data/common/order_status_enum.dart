part of 'package:homemakers_merchant/app/features/order/index.dart';

enum OrderStatus {
  none(),
  newOrder(
    title: 'New',
    borderColor: Color.fromRGBO(255, 90, 39, 1),
  ),
  ongoing(
    title: 'On Going',
    backgroundColor: Color.fromRGBO(255, 90, 39, 1),
  ),
  onProcessing(
    title: 'Processing',
    backgroundColor: Color.fromRGBO(255, 90, 39, 1),
  ),
  schedule(
    title: 'Schedule',
    backgroundColor: Color.fromRGBO(255, 156, 125, 1),
  ),
  cancelByUser(
    title: 'Cancel By User',
    backgroundColor: Color.fromRGBO(165, 166, 168, 1),
  ),
  delivered(
    title: 'Delivered',
    backgroundColor: Color.fromRGBO(69, 201, 125, 1),
    borderColor: Color.fromRGBO(69, 201, 125, 1),
  ),
  onTheWay(),
  cancelBySystem(
    title: 'Cancel By System',
    backgroundColor: Color.fromRGBO(165, 166, 168, 1),
  ),
  cancelByYou(
    title: 'Cancel By You',
    backgroundColor: Color.fromRGBO(165, 166, 168, 1),
  ),
  onTime(),
  delay(
    title: 'Delay',
    backgroundColor: Color.fromRGBO(255, 39, 19, 1),
  ),
  partialDelay(
    title: 'Partial Delay',
    backgroundColor: Color.fromRGBO(255, 39, 19, 1),
  ),
  moderateDelay(
    title: 'Moderate Delay',
    backgroundColor: Color.fromRGBO(255, 39, 19, 1),
  ),
  tooMuchDelay(
    title: 'Too Much Delay',
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
    title: 'Received By Customer',
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
    title: 'Preparing',
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
  ;

  @override
  String toString() {
    return name;
  }
}
