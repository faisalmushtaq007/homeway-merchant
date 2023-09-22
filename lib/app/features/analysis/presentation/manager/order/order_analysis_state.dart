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

class TodayOverAllOrderAnalysisState extends OrderAnalysisState {
  const TodayOverAllOrderAnalysisState({this.analysisBy = AnalysisBy.todayOrder, this.overAllAnalysisData});

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
  List<Object?> get props => [analysisBy, storeOrderAnalysisData, chartData, listOfStoreName];
}

class TodaySalesByStoreAnalysisState extends OrderAnalysisState {
  const TodaySalesByStoreAnalysisState({
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
  List<Object?> get props => [analysisBy, storeOrderAnalysisData, chartData, listOfStoreName];
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

class WeeklyOrderAnalysisState extends OrderAnalysisState {
  const WeeklyOrderAnalysisState({this.analysisBy = AnalysisBy.todayOrder});

  final AnalysisBy analysisBy;

  @override
  List<Object?> get props => [analysisBy];
}

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
