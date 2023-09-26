part of 'package:homemakers_merchant/app/features/order/index.dart';

abstract interface class OrderRepository {
  Future<DataSourceState<OrderEntity>> saveOrder({
    required OrderEntity orderEntity,
    OrderType orderType = OrderType.none,
  });

  Future<DataSourceState<OrderEntity>> editOrder({
    required OrderEntity orderEntity,
    required int orderID,
    OrderType orderType = OrderType.none,
  });

  Future<DataSourceState<bool>> deleteOrder({
    required int orderID,
    OrderEntity? orderEntity,
    OrderType orderType = OrderType.none,
  });

  Future<DataSourceState<bool>> deleteAllOrder({
    OrderType orderType = OrderType.none,
  });

  Future<DataSourceState<OrderEntity>> getOrder({
    required int orderID,
    OrderEntity? orderEntity,
    OrderType orderType = OrderType.none,
  });

  Future<DataSourceState<List<OrderEntity>>> getAllOrder({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    String? filter,
    String? sorting,
    OrderType orderType = OrderType.none,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });

  Future<DataSourceState<List<OrderEntity>>> getAllNewOrder({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.newOrder,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });

  Future<DataSourceState<List<OrderEntity>>> getAllRecentOrder({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.recent,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });

  Future<DataSourceState<List<OrderEntity>>> getAllCancelOrder({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.cancel,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });

  Future<DataSourceState<List<OrderEntity>>> getAllDeliverOrder({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.deliver,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });

  Future<DataSourceState<List<OrderEntity>>> getAllOnProcessOrder({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.onProcess,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });

  Future<DataSourceState<List<OrderEntity>>> getAllOnScheduleOrder({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.onProcess,
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  });

  Future<DataSourceState<List<OrderEntity>>> saveAllOrder({
    required List<OrderEntity> orderEntities,
    bool hasUpdateAll = false,
  });
}
