import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homemakers_merchant/app/features/order/index.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/core/common/enum/generic_enum.dart';
import 'package:homemakers_merchant/shared/states/data_source_state.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:sembast/timestamp.dart';

part 'all_order_event.dart';

part 'all_order_state.dart';

class AllOrderBloc extends Bloc<AllOrderEvent, AllOrderState> {
  AllOrderBloc() : super(AllOrderInitial()) {
    on<GetAllOrders>(getAllOrder);
  }

  FutureOr<void> getAllOrder(
      GetAllOrders event, Emitter<AllOrderState> emit) async {
    try {
      emit(const GetAllLoadingOrderState(
          isLoading: true,
          message: 'Please wait while we are fetching all orders...'));
      final DataSourceState<List<OrderEntity>> result =
          await serviceLocator<GetAllOrderUseCase>()(
        (
          event.pageKey,
          event.pageSize,
          event.searchText,
          event.orderType,
          event.filter,
          event.sorting,
          event.startTimeStamp,
          event.endTimeStamp
        ),
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Get all order bloc get all remote');
          if (data == null || data.isEmpty) {
            emit(
              GetAllEmptyOrderState(
                message: 'All order is empty',
                orderEntities: [],
                endTimeStamp: event.endTimeStamp,
                startTimeStamp: event.startTimeStamp,
                orderType: event.orderType,
                pageKey: event.pageKey,
                pageSize: event.pageSize,
                searchText: event.searchText,
                sorting: event.sorting,
                filter: event.filter,
              ),
            );
          } else {
            emit(
              GetAllOrderState(
                orderEntities: data.toList(),
                endTimeStamp: event.endTimeStamp,
                startTimeStamp: event.startTimeStamp,
                orderType: event.orderType,
                pageKey: event.pageKey,
                pageSize: event.pageSize,
                searchText: event.searchText,
                sorting: event.sorting,
                filter: event.filter,
              ),
            );
          }
        },
        localDb: (data, meta) {
          appLog.d('Get all order bloc get all local');
          if (data == null || data.isEmpty) {
            emit(
              GetAllEmptyOrderState(
                message: 'All order is empty',
                orderEntities: [],
                endTimeStamp: event.endTimeStamp,
                startTimeStamp: event.startTimeStamp,
                orderType: event.orderType,
                pageKey: event.pageKey,
                pageSize: event.pageSize,
                searchText: event.searchText,
                sorting: event.sorting,
                filter: event.filter,
              ),
            );
          } else {
            emit(
              GetAllOrderState(
                orderEntities: data.toList(),
                endTimeStamp: event.endTimeStamp,
                startTimeStamp: event.startTimeStamp,
                orderType: event.orderType,
                pageKey: event.pageKey,
                pageSize: event.pageSize,
                searchText: event.searchText,
                sorting: event.sorting,
                filter: event.filter,
              ),
            );
          }
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Get all order bloc get all error $reason');
          emit(
            GetAllExceptionOrderState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Store bloc get all $e');
      emit(
        GetAllExceptionOrderState(
          message:
              'Something went wrong during getting all orders, please try again',
          //exception: e as Exception,
          stackTrace: s,
        ),
      );
    }
  }
}
