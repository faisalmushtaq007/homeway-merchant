part of 'package:homemakers_merchant/app/features/order/index.dart';

class EditAllOrderUseCase extends UseCaseIO<List<OrderEntity>, DataSourceState<List<OrderEntity>>> {
  EditAllOrderUseCase({
    required this.orderRepository,
  });
  final OrderRepository orderRepository;
  @override
  Future<DataSourceState<List<OrderEntity>>> call(List<OrderEntity> input) async {
    return orderRepository.saveAllOrder(
      orderEntities: input,
      hasUpdateAll: true,
    );
  }
}
