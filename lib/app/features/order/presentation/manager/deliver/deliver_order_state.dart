part of 'deliver_order_bloc.dart';

abstract class DeliverOrderState extends Equatable {
  const DeliverOrderState();
}

class DeliverInitial extends DeliverOrderState {
  @override
  List<Object> get props => [];
}

class GetAllDeliverOrderState extends DeliverOrderState {
  const GetAllDeliverOrderState({
    this.orderType = OrderType.none,
    this.pageKey = 1,
    this.searchText,
    this.pageSize = 10,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
    this.orderStateStatus = OrderStateStatus.getAllDeliver,
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

class GetAllDeliverLoadingOrderState extends DeliverOrderState {
  const GetAllDeliverLoadingOrderState({
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

class GetAllDeliverProcessingOrderState extends DeliverOrderState {
  const GetAllDeliverProcessingOrderState({
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

class GetAllDeliverFailedOrderState extends DeliverOrderState {
  const GetAllDeliverFailedOrderState({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [
        message,
      ];
}

class GetAllDeliverExceptionOrderState extends DeliverOrderState {
  const GetAllDeliverExceptionOrderState({
    required this.message,
    this.stackTrace,
    this.exception,
    this.orderStateStatus = OrderStateStatus.getAllDeliver,
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

class GetAllDeliverEmptyOrderState extends DeliverOrderState {
  const GetAllDeliverEmptyOrderState({
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
