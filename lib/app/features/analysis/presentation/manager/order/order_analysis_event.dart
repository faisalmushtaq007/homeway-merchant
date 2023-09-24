part of 'order_analysis_bloc.dart';

abstract class OrderAnalysisEvent extends Equatable {
  const OrderAnalysisEvent();
}

class TodayOrderAnalysisEvent extends OrderAnalysisEvent {
  const TodayOrderAnalysisEvent({this.analysisBy = AnalysisBy.todayOrder});
  final AnalysisBy analysisBy;
  @override
  List<Object?> get props => [analysisBy];
}

class WeeklyOrderAnalysisEvent extends OrderAnalysisEvent {
  const WeeklyOrderAnalysisEvent({this.analysisBy = AnalysisBy.weeklyOrder});
  final AnalysisBy analysisBy;
  @override
  List<Object?> get props => [analysisBy];
}

class ByMonthlyOrderAnalysisEvent extends OrderAnalysisEvent {
  const ByMonthlyOrderAnalysisEvent({
    this.analysisBy = AnalysisBy.monthlyOrder,
    this.byMonth = 1,
  });
  final AnalysisBy analysisBy;
  final int byMonth;
  @override
  List<Object?> get props => [analysisBy, byMonth];
}
