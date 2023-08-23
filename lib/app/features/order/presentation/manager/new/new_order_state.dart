part of 'new_order_bloc.dart';

abstract class NewOrderState extends Equatable {
  const NewOrderState();
}

class NewOrderInitial extends NewOrderState {
  @override
  List<Object> get props => [];
}

class GetAllNewOrderState extends NewOrderState {
  const GetAllNewOrderState({
    this.orderType = OrderType.none,
    this.pageKey = 1,
    this.searchText,
    this.pageSize = 10,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
    this.orderStateStatus = OrderStateStatus.getAllNew,
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

class GetAllNewLoadingOrderState extends NewOrderState {
  const GetAllNewLoadingOrderState({
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

class GetAllNewProcessingOrderState extends NewOrderState {
  const GetAllNewProcessingOrderState({
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

class GetAllNewFailedOrderState extends NewOrderState {
  const GetAllNewFailedOrderState({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [
        message,
      ];
}

class GetAllNewExceptionOrderState extends NewOrderState {
  const GetAllNewExceptionOrderState({
    required this.message,
    this.stackTrace,
    this.exception,
    this.orderStateStatus = OrderStateStatus.getAllNew,
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

class GetAllNewEmptyOrderState extends NewOrderState {
  const GetAllNewEmptyOrderState({
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
