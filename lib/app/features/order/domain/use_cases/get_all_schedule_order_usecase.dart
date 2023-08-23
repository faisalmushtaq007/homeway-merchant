part of 'package:homemakers_merchant/app/features/order/index.dart';

class GetAllScheduleOrderUseCase
    extends OrderQueryAllUseCaseIORecord<OrderType, int, int, String?, String?, String?, Timestamp?, Timestamp?, DataSourceState<List<OrderEntity>>> {
  GetAllScheduleOrderUseCase({
    required this.orderRepository,
  });
  final OrderRepository orderRepository;

  @override
  Future<DataSourceState<List<OrderEntity>>> call(
      (
        int pageKey,
        int pageSize,
        String? searchText,
        OrderType orderType,
        String? filtering,
        String? sorting,
        Timestamp? startTimeStamp,
        Timestamp? endTimeStamp,
      ) record) {
    return orderRepository.getAllOnScheduleOrder(
      pageKey: record.$1,
      pageSize: record.$2,
      searchText: record.$3,
      orderType: record.$4,
      filter: record.$5,
      sorting: record.$6,
      startTimeStamp: record.$7,
      endTimeStamp: record.$8,
    );
  }
}
