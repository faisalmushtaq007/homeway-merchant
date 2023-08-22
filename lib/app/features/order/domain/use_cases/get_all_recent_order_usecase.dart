part of 'package:homemakers_merchant/app/features/order/index.dart';

class GetAllRecentOrderUseCase extends OrderQueryAllUseCaseIORecord<OrderType, int, int, String?, DataSourceState<List<OrderEntity>>> {
  GetAllRecentOrderUseCase({
    required this.orderRepository,
  });
  final OrderRepository orderRepository;

  @override
  Future<DataSourceState<List<OrderEntity>>> call((int pageKey, int pageSize, String? searchText, OrderType orderType) record) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
