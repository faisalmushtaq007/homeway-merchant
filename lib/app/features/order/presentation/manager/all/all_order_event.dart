part of 'all_order_bloc.dart';

abstract class AllOrderEvent extends Equatable {
  const AllOrderEvent();
}

class GetAllOrders extends AllOrderEvent {
  const GetAllOrders({
    this.orderType = OrderType.none,
    this.pageKey = 0,
    this.searchText,
    this.pageSize = 10,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
  });

  final int pageKey;
  final int pageSize;
  final String? searchText;
  final OrderType orderType;
  final String? filter;
  final String? sorting;
  final Timestamp? startTimeStamp;
  final Timestamp? endTimeStamp;

  @override
  List<Object?> get props => [
        orderType,
        pageKey,
        searchText,
        pageSize,
        endTimeStamp,
        filter,
        sorting,
        startTimeStamp,
      ];
}
