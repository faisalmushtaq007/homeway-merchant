part of 'package:homemakers_merchant/app/features/order/index.dart';

class EditOrderUseCase extends UseCaseByIDAndEntity<OrderEntity, int, DataSourceState<OrderEntity>> {
  EditOrderUseCase({
    required this.orderRepository,
  });
  final OrderRepository orderRepository;

  @override
  Future<DataSourceState<OrderEntity>> call({required OrderEntity input, required int id}) async {
    return orderRepository.editOrder(orderEntity: input, orderID: id);
  }
}
