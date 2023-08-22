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

  Future<ApiResultState<List<OrderEntity>>> getAllOrder();

  Future<ApiResultState<List<OrderEntity>>> saveAllOrder({
    required List<OrderEntity> orderEntities,
    bool hasUpdateAll = false,
  });
}
