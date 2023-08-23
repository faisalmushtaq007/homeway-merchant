part of 'cancel_order_bloc.dart';

abstract class CancelOrderState extends Equatable {
  const CancelOrderState();
}

class CancelOrderInitial extends CancelOrderState {
  @override
  List<Object> get props => [];
}

class GetAllCancelOrderState extends CancelOrderState {
  const GetAllCancelOrderState({
    this.orderType = OrderType.none,
    this.pageKey = 1,
    this.searchText,
    this.pageSize = 10,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
    this.orderStateStatus = OrderStateStatus.getAll,
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

class GetAllCancelLoadingOrderState extends CancelOrderState {
  const GetAllCancelLoadingOrderState({
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

class GetAllCancelProcessingOrderState extends CancelOrderState {
  const GetAllCancelProcessingOrderState({
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

class GetAllCancelFailedOrderState extends CancelOrderState {
  const GetAllCancelFailedOrderState({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [
    message,
  ];
}

class GetAllCancelExceptionOrderState extends CancelOrderState {
  const GetAllCancelExceptionOrderState({
    required this.message,
    this.stackTrace,
    this.exception,
    this.orderStateStatus = OrderStateStatus.getAll,
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