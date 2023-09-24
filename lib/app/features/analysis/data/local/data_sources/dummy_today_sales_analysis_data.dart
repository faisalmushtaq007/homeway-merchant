part of 'package:homemakers_merchant/app/features/analysis/index.dart';

// Fetch content from the local json file

Future<TodaySalesAnalysisEntity> readTodaySalesAnalysisData() async {
  final String response =
      await rootBundle.loadString('assets/dummy_today_sales_analysis.json');
  return todaySalesAnalysisEntityFromJson(response);
}
