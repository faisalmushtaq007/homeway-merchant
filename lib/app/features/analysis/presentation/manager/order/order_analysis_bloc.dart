import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homemakers_merchant/app/features/analysis/index.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/src/object.dart';

part 'order_analysis_event.dart';

part 'order_analysis_state.dart';

class OrderAnalysisBloc extends Bloc<OrderAnalysisEvent, OrderAnalysisState> {
  OrderAnalysisBloc() : super(OrderAnalysisInitial()) {
    on<TodayOrderAnalysisEvent>(_todayOrderAnalysisEvent);
    on<WeeklyOrderAnalysisEvent>(_weeklyOrderAnalysisEvent);
    on<ByMonthlyOrderAnalysisEvent>(_monthlyOrderAnalysisEvent);
  }

  FutureOr<void> _todayOrderAnalysisEvent(TodayOrderAnalysisEvent event, Emitter<OrderAnalysisState> emit) async {
    if (event.analysisBy == AnalysisBy.todayOrder) {
      // local: readTodayOrderAnalysisData
      final TodayOrderAnalysisEntity todayOrderAnalysisData = await readTodayOrderAnalysisData();

      List<OverAllAnalysisData> overAllAnalysisData = [];
      List<ChartTodayEntity> chartData = [];
      List<StoreAnalysisEntity> storeOrderAnalysisData = [];
      List<String> listOfStoreName = [];

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
          deliver: overAllAnalysisData.fold(
            0,
            (sum, element) => sum + element.totalOrders.deliver,
          ),
        ),
        totalEarnings: overAllAnalysisData.fold(0, (sum, element) => sum + element.totalEarnings),
      );

      emit(
        TodayOverAllOrderAnalysisState(
          analysisBy: event.analysisBy,
          overAllAnalysisData: overAllData,
        ),
      );
      await Future.delayed(const Duration(milliseconds: 300), () {});

      emit(TodayOrderByStoreAnalysisState(
        analysisBy: event.analysisBy,
        chartData: chartData.toList(),
        listOfStoreName: listOfStoreName.toList(),
        storeOrderAnalysisData: storeOrderAnalysisData.toList(),
      ));
    } else if (event.analysisBy == AnalysisBy.todaySales) {
      // local: readTodaySalesAnalysisData
      final TodaySalesAnalysisEntity todaySalesAnalysisData = await readTodaySalesAnalysisData();

      List<ChartTodayEntity> chartData = [];
      List<StoreSalesAnalysisEntity> storeSalesAnalysisData = [];
      List<String> listOfStoreName = [];
      List<OverAllAnalysisData> overAllAnalysisData = [];

      for (TodaySalesResult todaySalesResult in todaySalesAnalysisData.result) {
        final StoreSalesAnalysisEntity storeAnalysisEntity = todaySalesResult.store;
        final DaySalesStatus todayData = todaySalesResult.store.todaySalesStatus;
        final DaySalesStatus yesterdayDayData = todaySalesResult.store.yesterdaySalesStatus;
        chartData
            .add(ChartTodayEntity(storeAnalysisEntity.storeName, todayData.totalOrders, yesterdayDayData.totalOrders));
        storeSalesAnalysisData.add(storeAnalysisEntity);
        listOfStoreName.add(storeAnalysisEntity.storeName);
        overAllAnalysisData.add(todaySalesResult.data);
      }
      /*final OverAllAnalysisData overAllData = OverAllAnalysisData(
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
        await Future.delayed(const Duration(milliseconds: 300),(){});*/
      emit(TodaySalesByStoreAnalysisState(
        analysisBy: event.analysisBy,
        chartData: chartData.toList(),
        listOfStoreName: listOfStoreName.toList(),
        storeSalesAnalysisData: storeSalesAnalysisData.toList(),
      ));
    }
  }

  FutureOr<void> _weeklyOrderAnalysisEvent(WeeklyOrderAnalysisEvent event, Emitter<OrderAnalysisState> emit) async {
    final WeeklyAnalysisEntity weeklyAnalysisData = await readWeeklyAnalysisData();

    List<WeeklyOverallAnalysisData> overAllAnalysisData = [];
    List<AnalysisDay> chartData = [];
    final WeeklyAnalysisResult weeklyResult = weeklyAnalysisData.result;
    final WeeklyAnalysisOverAllData weeklyOverallAnalysisData = weeklyResult.overAllData;
    if (weeklyResult.fromDate.isNotNull && weeklyResult.toDate.isNotNull) {
      chartData = List<AnalysisDay>.from(weeklyResult.days.toList());
    }

    if (event.analysisBy == AnalysisBy.weeklyOrder) {
      emit(
        WeeklyOverAllOrderAnalysisState(
          analysisBy: event.analysisBy,
          overAllAnalysisData: weeklyOverallAnalysisData,
        ),
      );
      await Future.delayed(const Duration(milliseconds: 300), () {});
      emit(WeeklyOrderByStoreAnalysisState(
        analysisBy: event.analysisBy,
        chartData: chartData.toList(),
      ));
    } else if (event.analysisBy == AnalysisBy.weeklySales) {
      emit(WeeklySalesByStoreAnalysisState(
        analysisBy: event.analysisBy,
        chartData: chartData.toList(),
      ));
    }
  }

  FutureOr<void> _monthlyOrderAnalysisEvent(
      ByMonthlyOrderAnalysisEvent event, Emitter<OrderAnalysisState> emit) async {}
}
