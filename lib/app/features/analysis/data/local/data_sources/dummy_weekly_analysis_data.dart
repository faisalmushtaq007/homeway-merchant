part of 'package:homemakers_merchant/app/features/analysis/index.dart';

// Fetch content from the local json file
Future<WeeklyAnalysisOldEntity> readWeeklyOldAnalysisData() async {
  final String response =
      await rootBundle.loadString('assets/dummy_weekly_old_analysis.json');
  return weeklyAnalysisOldEntityFromJson(response);
}

Future<WeeklyAnalysisEntity> readWeeklyAnalysisData() async {
  final response =
      await rootBundle.loadString('assets/dummy_weekly_analysis.json');
  return weeklyAnalysisEntityFromJson(response);
}
