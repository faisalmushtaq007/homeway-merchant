part of 'recent_order_bloc.dart';

abstract class RecentOrderState extends Equatable {
  const RecentOrderState();
}

class RecentOrderInitial extends RecentOrderState {
  @override
  List<Object> get props => [];
}

class GetAllRecentOrderState extends RecentOrderState {
  const GetAllRecentOrderState({
    this.orderType = OrderType.none,
    this.pageKey = 1,
    this.searchText,
    this.pageSize = 10,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
    this.orderStateStatus = OrderStateStatus.getAllRecent,
    this.orderEntities = const [],
  });

  final int pageKey;
  final int pageSize;
  final String? searchText;
  final OrderType orderType;
  final String? filter;
  final String? sorting;
  final Timestamp? startTimeStamp;
  final Timestamp? endTimeStamp;
  final OrderStateStatus orderStateStatus;
  final List<OrderEntity> orderEntities;

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
        orderStateStatus,
        orderEntities,
      ];
}

class GetAllRecentLoadingOrderState extends RecentOrderState {
  const GetAllRecentLoadingOrderState({
    required this.isLoading,
    required this.message,
  });

  final bool isLoading;
  final String message;

  @override
  List<Object?> get props => [
        isLoading,
        message,
      ];
}

class GetAllRecentProcessingOrderState extends RecentOrderState {
  const GetAllRecentProcessingOrderState({
    required this.isProcessing,
    required this.message,
  });

  final bool isProcessing;
  final String message;

  @override
  List<Object?> get props => [
        isProcessing,
        message,
      ];
}

class GetAllRecentFailedOrderState extends RecentOrderState {
  const GetAllRecentFailedOrderState({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [
        message,
      ];
}

class GetAllRecentExceptionOrderState extends RecentOrderState {
  const GetAllRecentExceptionOrderState({
    required this.message,
    this.stackTrace,
    this.exception,
    this.orderStateStatus = OrderStateStatus.getAllRecent,
  });

  final OrderStateStatus orderStateStatus;
  final String message;
  final StackTrace? stackTrace;
  final Exception? exception;

  @override
  List<Object?> get props => [
        message,
        stackTrace,
        exception,
        orderStateStatus,
      ];
}

class GetAllRecentEmptyOrderState extends RecentOrderState {
  const GetAllRecentEmptyOrderState({
    this.orderEntities = const [],
    this.message = '',
    this.orderStateStatus = OrderStateStatus.empty,
  });

  final List<OrderEntity> orderEntities;
  final String message;
  final OrderStateStatus orderStateStatus;

  @override
  List<Object?> get props => [
        orderEntities,
        message,
        orderStateStatus,
      ];
}
