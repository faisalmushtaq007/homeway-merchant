part of 'package:homemakers_merchant/app/features/order/index.dart';

class DeleteOrderUseCase
    extends UseCaseByID<OrderEntity, int, DataSourceState<bool>> {
  DeleteOrderUseCase({
    required this.oderRepository,
  });
  final OrderRepository oderRepository;
  @override
  Future<DataSourceState<bool>> call(
      {required int id, OrderEntity? input}) async {
    return oderRepository.deleteOrder(orderEntity: input, orderID: id);
  }
}
