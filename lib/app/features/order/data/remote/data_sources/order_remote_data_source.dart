part of 'package:homemakers_merchant/app/features/order/index.dart';

class OrderRemoteDataSource implements OrderDataSource {
  final client = serviceLocator<INetworkManager<BaseResponseErrorModel>>();

  @override
  Future<ApiResultState<bool>> deleteAllOrder() {
    // TODO: implement deleteAllOrder
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteOrder({required int orderID, OrderEntity? orderEntity}) {
    // TODO: implement deleteOrder
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<OrderEntity>> editOrder({
    required OrderEntity orderEntity,
    required int orderID,
  }) {
    // TODO: implement editOrder
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<OrderEntity>>> getAllOrder() {
    // TODO: implement getAllOrder
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<OrderEntity>> getOrder({required int orderID, OrderEntity? orderEntity}) {
    // TODO: implement getOrder
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<OrderEntity>> saveOrder({required OrderEntity orderEntity}) {
    // TODO: implement saveOrder
    throw UnimplementedError();
  }
}
