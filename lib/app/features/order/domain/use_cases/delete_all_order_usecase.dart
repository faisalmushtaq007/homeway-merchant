part of 'package:homemakers_merchant/app/features/order/index.dart';

class DeleteAllAddressUseCase extends UseCaseOptionalIO<OrderType, DataSourceState<bool>> {
  DeleteAllAddressUseCase({
    required this.orderRepository,
  });
  final OrderRepository orderRepository;

  @override
  Future<DataSourceState<bool>?> call({OrderType? input = OrderType.none}) {
    return orderRepository.deleteAllOrder(orderType: input!);
    throw UnimplementedError();
  }
}
