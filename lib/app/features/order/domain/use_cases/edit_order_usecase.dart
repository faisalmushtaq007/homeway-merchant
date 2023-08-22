part of 'package:homemakers_merchant/app/features/order/index.dart';

class EditAddressUseCase extends UseCaseByIDAndEntity<OrderEntity, int, DataSourceState<OrderEntity>> {
  EditAddressUseCase({
    required this.orderRepository,
  });
  final OrderRepository orderRepository;

  @override
  Future<DataSourceState<OrderEntity>> call({required OrderEntity input, required int id}) async {
    return orderRepository.editOrder(orderEntity: input, orderID: id);
  }
}
