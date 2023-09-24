part of 'order_analysis_bloc.dart';

abstract class OrderAnalysisState extends Equatable {
  const OrderAnalysisState();
}

class OrderAnalysisInitial extends OrderAnalysisState {
  @override
  List<Object> get props => [];
}

class TodayOrderAnalysisState extends OrderAnalysisState {
  const TodayOrderAnalysisState({this.analysisBy = AnalysisBy.todayOrder});

  final AnalysisBy analysisBy;

  @override
  List<Object?> get props => [analysisBy];
}

// Today State
class TodayOverAllOrderAnalysisState extends OrderAnalysisState {
  const TodayOverAllOrderAnalysisState(
      {this.analysisBy = AnalysisBy.todayOrder, this.overAllAnalysisData});

  final AnalysisBy analysisBy;
  final OverAllAnalysisData? overAllAnalysisData;

  @override
  List<Object?> get props => [analysisBy, overAllAnalysisData];
}

class TodayOrderByStoreAnalysisState extends OrderAnalysisState {
  const TodayOrderByStoreAnalysisState({
    this.analysisBy = AnalysisBy.todayOrder,
    this.storeOrderAnalysisData = const [],
    this.chartData = const [],
    this.listOfStoreName = const [],
  });

  final AnalysisBy analysisBy;
  final List<StoreAnalysisEntity> storeOrderAnalysisData;
  final List<ChartTodayEntity> chartData;
  final List<String> listOfStoreName;

  @override
  List<Object?> get props =>
      [analysisBy, storeOrderAnalysisData, chartData, listOfStoreName];
}

class TodaySalesByStoreAnalysisState extends OrderAnalysisState {
  const TodaySalesByStoreAnalysisState({
    this.analysisBy = AnalysisBy.todayOrder,
    this.storeSalesAnalysisData = const [],
    this.chartData = const [],
    this.listOfStoreName = const [],
  });

  final AnalysisBy analysisBy;
  final List<StoreSalesAnalysisEntity> storeSalesAnalysisData;
  final List<ChartTodayEntity> chartData;
  final List<String> listOfStoreName;

  @override
  List<Object?> get props =>
      [analysisBy, storeSalesAnalysisData, chartData, listOfStoreName];
}

class TodayOrderAnalysisProcessingState extends OrderAnalysisState {
  const TodayOrderAnalysisProcessingState({
    this.analysisBy = AnalysisBy.todayOrder,
    this.processing = false,
  });

  final AnalysisBy analysisBy;
  final bool processing;

  @override
  List<Object?> get props => [analysisBy];
}

class TodayOrderAnalysisFailedState extends OrderAnalysisState {
  const TodayOrderAnalysisFailedState({
    this.analysisBy = AnalysisBy.todayOrder,
    this.reason = '',
  });

  final AnalysisBy analysisBy;
  final String reason;

  @override
  List<Object?> get props => [analysisBy];
}

// Weekly State
class WeeklyOrderAnalysisState extends OrderAnalysisState {
  const WeeklyOrderAnalysisState({this.analysisBy = AnalysisBy.todayOrder});

  final AnalysisBy analysisBy;

  @override
  List<Object?> get props => [analysisBy];
}

class WeeklyOverAllOrderAnalysisState extends OrderAnalysisState {
  const WeeklyOverAllOrderAnalysisState(
      {this.analysisBy = AnalysisBy.todayOrder, this.overAllAnalysisData=const WeeklyAnalysisOverAllData()});

  final AnalysisBy analysisBy;
  final WeeklyAnalysisOverAllData overAllAnalysisData;

  @override
  List<Object?> get props => [analysisBy, overAllAnalysisData];
}

class WeeklyOrderByStoreAnalysisState extends OrderAnalysisState {
  const WeeklyOrderByStoreAnalysisState(
      {this.analysisBy = AnalysisBy.todayOrder,
      this.storeOrderAnalysisData = const [],
      this.chartData = const [],
      this.listOfStoreName = const [],
      this.orderAnalysisData = const []});

  final AnalysisBy analysisBy;
  final List<WeeklyAnalysisStore> storeOrderAnalysisData;
  final List<AnalysisDay> chartData;
  final List<String> listOfStoreName;
  final List<AnalysisOrder> orderAnalysisData;

  @override
  List<Object?> get props => [
        analysisBy,
        storeOrderAnalysisData,
        chartData,
        listOfStoreName,
        orderAnalysisData
      ];
}

class WeeklySalesByStoreAnalysisState extends OrderAnalysisState {
  const WeeklySalesByStoreAnalysisState({
    this.analysisBy = AnalysisBy.todayOrder,
    this.storeSalesAnalysisData = const [],
    this.chartData = const [],
    this.listOfStoreName = const [],
    this.salesAnalysisData = const [],
  });

  final AnalysisBy analysisBy;
  final List<WeeklyAnalysisStore> storeSalesAnalysisData;
  final List<AnalysisDay> chartData;
  final List<String> listOfStoreName;
  final List<AnalysisSales> salesAnalysisData;
  @override
  List<Object?> get props => [
        analysisBy,
        storeSalesAnalysisData,
        chartData,
        listOfStoreName,
        salesAnalysisData
      ];
}

class WeeklyOrderAnalysisProcessingState extends OrderAnalysisState {
  const WeeklyOrderAnalysisProcessingState({
    this.analysisBy = AnalysisBy.todayOrder,
    this.processing = false,
  });

  final AnalysisBy analysisBy;
  final bool processing;

  @override
  List<Object?> get props => [analysisBy];
}

class WeeklyOrderAnalysisFailedState extends OrderAnalysisState {
  const WeeklyOrderAnalysisFailedState({
    this.analysisBy = AnalysisBy.todayOrder,
    this.reason = '',
  });

  final AnalysisBy analysisBy;
  final String reason;

  @override
  List<Object?> get props => [analysisBy];
}

// Monthly State
class ByMonthlyOrderAnalysisState extends OrderAnalysisState {
  const ByMonthlyOrderAnalysisState({
    this.analysisBy = AnalysisBy.todayOrder,
    this.byMonth = 1,
  });

  final AnalysisBy analysisBy;
  final int byMonth;

  @override
  List<Object?> get props => [analysisBy, byMonth];
}

class MonthlyOverAllOrderAnalysisState extends OrderAnalysisState {
  const MonthlyOverAllOrderAnalysisState(
      {this.analysisBy = AnalysisBy.todayOrder, this.overAllAnalysisData});

  final AnalysisBy analysisBy;
  final OverAllAnalysisData? overAllAnalysisData;

  @override
  List<Object?> get props => [analysisBy, overAllAnalysisData];
}

class MonthlyOrderByStoreAnalysisState extends OrderAnalysisState {
  const MonthlyOrderByStoreAnalysisState({
    this.analysisBy = AnalysisBy.todayOrder,
    this.storeOrderAnalysisData = const [],
    this.chartData = const [],
    this.listOfStoreName = const [],
  });

  final AnalysisBy analysisBy;
  final List<StoreAnalysisEntity> storeOrderAnalysisData;
  final List<ChartMonthlyEntity> chartData;
  final List<String> listOfStoreName;

  @override
  List<Object?> get props =>
      [analysisBy, storeOrderAnalysisData, chartData, listOfStoreName];
}

class MonthlySalesByStoreAnalysisState extends OrderAnalysisState {
  const MonthlySalesByStoreAnalysisState({
    this.analysisBy = AnalysisBy.todayOrder,
    this.storeSalesAnalysisData = const [],
    this.chartData = const [],
    this.listOfStoreName = const [],
  });

  final AnalysisBy analysisBy;
  final List<StoreSalesAnalysisEntity> storeSalesAnalysisData;
  final List<ChartMonthlyEntity> chartData;
  final List<String> listOfStoreName;

  @override
  List<Object?> get props =>
      [analysisBy, storeSalesAnalysisData, chartData, listOfStoreName];
}

class MonthlyOrderAnalysisProcessingState extends OrderAnalysisState {
  const MonthlyOrderAnalysisProcessingState({
    this.analysisBy = AnalysisBy.todayOrder,
    this.processing = false,
  });

  final AnalysisBy analysisBy;
  final bool processing;

  @override
  List<Object?> get props => [analysisBy];
}

class MonthlyOrderAnalysisFailedState extends OrderAnalysisState {
  const MonthlyOrderAnalysisFailedState({
    this.analysisBy = AnalysisBy.todayOrder,
    this.reason = '',
  });

  final AnalysisBy analysisBy;
  final String reason;

  @override
  List<Object?> get props => [analysisBy];
}
