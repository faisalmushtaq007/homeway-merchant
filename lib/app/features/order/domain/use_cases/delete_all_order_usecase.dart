part of 'package:homemakers_merchant/app/features/order/index.dart';

class DeleteAllOrderUseCase extends UseCaseOptionalIO<OrderType, DataSourceState<bool>> {
  DeleteAllOrderUseCase({
    required this.orderRepository,
  });
  final OrderRepository orderRepository;

  @override
  Future<DataSourceState<bool>?> call({OrderType? input = OrderType.none}) {
    return orderRepository.deleteAllOrder(orderType: input!);
    throw UnimplementedError();
  }
}
