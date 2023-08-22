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
    int pageKey = 1,
    int pageSize = 10,
    String? searchText,
    OrderType orderType = OrderType.none,
  });
}
