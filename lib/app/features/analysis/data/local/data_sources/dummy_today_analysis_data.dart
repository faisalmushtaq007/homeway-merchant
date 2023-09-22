part of 'package:homemakers_merchant/app/features/analysis/index.dart';

// Fetch content from the local json file
Future<TodayOrderAnalysisEntity> readTodayOrderAnalysisData() async {
  final String response = await rootBundle.loadString('assets/dummy_today_order_analysis.json');
  return todayOrderAnalysisEntityFromJson(response);
}