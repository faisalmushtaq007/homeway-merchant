part of 'schedule_order_bloc.dart';

abstract class ScheduleOrderState extends Equatable {
  const ScheduleOrderState();
}

class ScheduleOrderInitial extends ScheduleOrderState {
  @override
  List<Object> get props => [];
}

class GetAllScheduleOrderState extends ScheduleOrderState {
  const GetAllScheduleOrderState({
    this.orderType = OrderType.none,
    this.pageKey = 1,
    this.searchText,
    this.pageSize = 10,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
    this.orderStateStatus = OrderStateStatus.getAllSchedule,
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

class GetAllScheduleLoadingOrderState extends ScheduleOrderState {
  const GetAllScheduleLoadingOrderState({
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

class GetAllScheduleProcessingOrderState extends ScheduleOrderState {
  const GetAllScheduleProcessingOrderState({
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

class GetAllScheduleFailedOrderState extends ScheduleOrderState {
  const GetAllScheduleFailedOrderState({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [
        message,
      ];
}

class GetAllScheduleExceptionOrderState extends ScheduleOrderState {
  const GetAllScheduleExceptionOrderState({
    required this.message,
    this.stackTrace,
    this.exception,
    this.orderStateStatus = OrderStateStatus.getAllSchedule,
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

class GetAllScheduleEmptyOrderState extends ScheduleOrderState {
  const GetAllScheduleEmptyOrderState({
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
