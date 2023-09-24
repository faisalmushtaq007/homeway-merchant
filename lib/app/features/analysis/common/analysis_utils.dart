part of 'package:homemakers_merchant/app/features/analysis/index.dart';

String getWeekdayName(int weekday) {
  final DateTime now = DateTime.now().toLocal();
  final int diff = now.weekday - weekday; // weekday is our 1-7 ISO value
  var udpatedDt;
  if (diff > 0) {
    udpatedDt = now.subtract(Duration(days: diff));
  } else if (diff == 0) {
    udpatedDt = now;
  } else {
    udpatedDt = now.add(Duration(days: diff * -1));
  }
  final String weekdayName = DateFormat('EE').format(udpatedDt);
  return weekdayName;
}
