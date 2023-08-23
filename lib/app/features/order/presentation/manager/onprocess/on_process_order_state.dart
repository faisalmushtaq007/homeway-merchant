part of 'on_process_order_bloc.dart';

abstract class OnProcessOrderState extends Equatable {
  const OnProcessOrderState();
}

class OnProcessOrderInitial extends OnProcessOrderState {
  @override
  List<Object> get props => [];
}

class GetAllOnProcessOrderState extends OnProcessOrderState {
  const GetAllOnProcessOrderState({
    this.orderType = OrderType.none,
    this.pageKey = 1,
    this.searchText,
    this.pageSize = 10,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
    this.orderStateStatus = OrderStateStatus.getAllProcessing,
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

class GetAllOnProcessLoadingOrderState extends OnProcessOrderState {
  const GetAllOnProcessLoadingOrderState({
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

class GetAllOnProcessProcessingOrderState extends OnProcessOrderState {
  const GetAllOnProcessProcessingOrderState({
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

class GetAllOnProcessFailedOrderState extends OnProcessOrderState {
  const GetAllOnProcessFailedOrderState({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [
        message,
      ];
}

class GetAllOnProcessExceptionOrderState extends OnProcessOrderState {
  const GetAllOnProcessExceptionOrderState({
    required this.message,
    this.stackTrace,
    this.exception,
    this.orderStateStatus = OrderStateStatus.getAllProcessing,
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

class GetAllOnProcessEmptyOrderState extends OnProcessOrderState {
  const GetAllOnProcessEmptyOrderState({
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
