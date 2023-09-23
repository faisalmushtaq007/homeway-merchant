import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homemakers_merchant/app/features/analysis/index.dart';

part 'order_analysis_event.dart';

part 'order_analysis_state.dart';

class OrderAnalysisBloc extends Bloc<OrderAnalysisEvent, OrderAnalysisState> {
  OrderAnalysisBloc() : super(OrderAnalysisInitial()) {
    on<TodayOrderAnalysisEvent>(_todayOrderAnalysisEvent);
    on<WeeklyOrderAnalysisEvent>(_weeklyOrderAnalysisEvent);
    on<ByMonthlyOrderAnalysisEvent>(_monthlyOrderAnalysisEvent);
  }

  FutureOr<void> _todayOrderAnalysisEvent(TodayOrderAnalysisEvent event, Emitter<OrderAnalysisState> emit) async {
    final TodayOrderAnalysisEntity todayOrderAnalysisData = await readTodayOrderAnalysisData();
    List<ChartTodayEntity> chartData = [];
    List<StoreAnalysisEntity> storeOrderAnalysisData = [];
    List<String> listOfStoreName = [];
    List<OverAllAnalysisData> overAllAnalysisData = [];
    if (event.analysisBy == AnalysisBy.todayOrder) {
      for (TodayOrderResult todayOrderResult in todayOrderAnalysisData.result) {
        final StoreAnalysisEntity storeAnalysisEntity = todayOrderResult.store;
        final DayOrderStatus todayData = todayOrderResult.store.todayOrderStatus;
        final DayOrderStatus yesterdayDayData = todayOrderResult.store.yesterdayOrderStatus;
        chartData
            .add(ChartTodayEntity(storeAnalysisEntity.storeName, todayData.totalOrders, yesterdayDayData.totalOrders));
        storeOrderAnalysisData.add(storeAnalysisEntity);
        listOfStoreName.add(storeAnalysisEntity.storeName);
        overAllAnalysisData.add(todayOrderResult.data);
      }
      final OverAllAnalysisData overAllData = OverAllAnalysisData(
        totalCustomers: overAllAnalysisData.fold(0, (sum, element) => sum + element.totalCustomers),
        totalStores: overAllAnalysisData.fold(0, (sum, element) => sum + element.totalStores),
        totalOrders: TotalOrders(
          countTotalOrders: overAllAnalysisData.fold(0, (sum, element) => sum + element.totalOrders.countTotalOrders),
          totalOrdersNew: overAllAnalysisData.fold(0, (sum, element) => sum + element.totalOrders.totalOrdersNew),
          deliver: overAllAnalysisData.fold(0, (sum, element) => sum + element.totalOrders.deliver,),
        ),
        totalEarnings: overAllAnalysisData.fold(0, (sum, element) => sum + element.totalEarnings),
      );
      emit(TodayOverAllOrderAnalysisState(
        analysisBy: event.analysisBy,
        overAllAnalysisData: overAllData,
      ),);
      await Future.delayed(const Duration(milliseconds: 300),(){});
      emit(TodayOrderByStoreAnalysisState(
        analysisBy: event.analysisBy,
        chartData: chartData.toList(),
        listOfStoreName: listOfStoreName.toList(),
        storeOrderAnalysisData: storeOrderAnalysisData.toList(),
      ));
    } else if (event.analysisBy == AnalysisBy.todaySales) {}
  }

  FutureOr<void> _weeklyOrderAnalysisEvent(WeeklyOrderAnalysisEvent event, Emitter<OrderAnalysisState> emit) async {}

  FutureOr<void> _monthlyOrderAnalysisEvent(
      ByMonthlyOrderAnalysisEvent event, Emitter<OrderAnalysisState> emit) async {}
}
