import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

TimeOfDay parseTimeOfDay(String t) {
  final DateTime dateTime = DateFormat('hh:mm aa').parse(t);
  return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
}

bool compareOpenAndCloseTime({
  required String openingTime,
  required String closingTime,
}) {
  final TimeOfDay openTimeOfDay = parseTimeOfDay(openingTime);
  final TimeOfDay closeTimeOfDay = parseTimeOfDay(closingTime);
  var now = DateTime.now();
  var openTime = DateTime(now.year, now.month, now.day, openTimeOfDay.hour, openTimeOfDay.minute);
  var closeTime = DateTime(now.year, now.month, now.day, closeTimeOfDay.hour, closeTimeOfDay.minute);
  // If the time precedes the current time, treat it as a time for tomorrow.
  if (Jiffy.parseFromDateTime(openTime).isSameOrAfter(Jiffy.parseFromDateTime(closeTime))) {
    return true;
  } else {
    return false;
  }
}
