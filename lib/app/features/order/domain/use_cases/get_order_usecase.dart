part of 'package:homemakers_merchant/app/features/order/index.dart';

class GetAddressUseCase extends UseCaseByID<OrderEntity, int, DataSourceState<OrderEntity>> {
  GetAddressUseCase({
    required this.orderRepository,
  });

  final OrderRepository orderRepository;

  @override
  Future<DataSourceState<OrderEntity>> call({required int id, OrderEntity? input}) async {
    return orderRepository.getOrder(orderEntity: input, orderID: id);
  }
}
