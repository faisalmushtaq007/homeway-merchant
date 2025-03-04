part of 'package:homemakers_merchant/app/features/order/index.dart';

class OrderRemoteDataSource implements OrderDataSource {
  final client = serviceLocator<IRestApiManager>();

  @override
  Future<ApiResultState<bool>> deleteAllOrder() {
    // TODO: implement deleteAllOrder
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteOrder(
      {required int orderID, OrderEntity? orderEntity}) {
    // TODO: implement deleteOrder
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<OrderEntity>> editOrder(
      {required OrderEntity orderEntity, required int orderID}) {
    // TODO: implement editOrder
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<OrderEntity>>> getAllCancelOrder({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.cancel,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  }) {
    // TODO: implement getAllCancelOrder
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<OrderEntity>>> getAllDeliverOrder({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.deliver,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  }) {
    // TODO: implement getAllDeliverOrder
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<OrderEntity>>> getAllNewOrder({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.newOrder,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  }) {
    // TODO: implement getAllNewOrder
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<OrderEntity>>> getAllOnProcessOrder({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.onProcess,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  }) {
    // TODO: implement getAllOnProcessOrder
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<OrderEntity>>> getAllOnScheduleOrder(
      {int pageKey = 0,
      int pageSize = 10,
      String? searchText,
      OrderType orderType = OrderType.onProcess,
      String? filter,
      String? sorting,
      Timestamp? startTimeStamp,
      Timestamp? endTimeStamp}) {
    // TODO: implement getAllOnScheduleOrder
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<OrderEntity>>> getAllOrder({
    String? filter,
    String? sorting,
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.none,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  }) {
    // TODO: implement getAllOrder
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<OrderEntity>>> getAllRecentOrder({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.recent,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  }) {
    // TODO: implement getAllRecentOrder
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<OrderEntity>> getOrder(
      {required int orderID, OrderEntity? orderEntity}) {
    // TODO: implement getOrder
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<OrderEntity>>> saveAllOrder(
      {required List<OrderEntity> orderEntities, bool hasUpdateAll = false}) {
    // TODO: implement saveAllOrder
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<OrderEntity>> saveOrder(
      {required OrderEntity orderEntity}) {
    // TODO: implement saveOrder
    throw UnimplementedError();
  }
}
