part of 'package:homemakers_merchant/app/features/order/index.dart';

class SaveAllOrderUseCase extends UseCaseIO<List<OrderEntity>, DataSourceState<List<OrderEntity>>> {
  SaveAllOrderUseCase({
    required this.orderRepository,
  });
  final OrderRepository orderRepository;
  @override
  Future<DataSourceState<List<OrderEntity>>> call(List<OrderEntity> input) async {
    return await orderRepository.saveAllOrder(
      orderEntities: input,
      hasUpdateAll: false,
    );
  }
}
