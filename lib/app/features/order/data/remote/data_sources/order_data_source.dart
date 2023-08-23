part of 'package:homemakers_merchant/app/features/order/index.dart';

abstract interface class OrderDataSource {
  Future<ApiResultState<OrderEntity>> saveOrder({
    required OrderEntity orderEntity,
  });

  Future<ApiResultState<OrderEntity>> editOrder({
    required OrderEntity orderEntity,
    required int orderID,
  });

  Future<ApiResultState<bool>> deleteOrder({
    required int orderID,
    OrderEntity? orderEntity,
  });

  Future<ApiResultState<bool>> deleteAllOrder();

  Future<ApiResultState<OrderEntity>> getOrder({
    required int orderID,
    OrderEntity? orderEntity,
  });

  Future<ApiResultState<List<OrderEntity>>> getAllOrder({
    String? filter,
    String? sorting,
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.none,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });

  Future<ApiResultState<List<OrderEntity>>> saveAllOrder({
    required List<OrderEntity> orderEntities,
    bool hasUpdateAll = false,
  });

  Future<ApiResultState<List<OrderEntity>>> getAllNewOrder({
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.newOrder,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });

  Future<ApiResultState<List<OrderEntity>>> getAllRecentOrder({
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.recent,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });

  Future<ApiResultState<List<OrderEntity>>> getAllCancelOrder({
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.cancel,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });

  Future<ApiResultState<List<OrderEntity>>> getAllDeliverOrder({
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.deliver,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });

  Future<ApiResultState<List<OrderEntity>>> getAllOnProcessOrder({
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.onProcess,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });

  Future<ApiResultState<List<OrderEntity>>> getAllOnScheduleOrder({
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.onProcess,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });
}
