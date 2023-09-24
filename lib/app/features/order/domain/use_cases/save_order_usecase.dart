part of 'package:homemakers_merchant/app/features/order/index.dart';

class SaveOrderUseCase
    extends UseCaseIO<OrderEntity, DataSourceState<OrderEntity>> {
  SaveOrderUseCase({
    required this.orderRepository,
  });
  final OrderRepository orderRepository;
  @override
  Future<DataSourceState<OrderEntity>> call(OrderEntity input) async {
    return orderRepository.saveOrder(orderEntity: input);
  }
}
