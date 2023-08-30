part of 'package:homemakers_merchant/app/features/payment/index.dart';

String convertDateTimeToHumanReadable(moment.Moment now, int timestamp) {
  return now.subtract(now.difference(moment.Moment.fromMillisecondsSinceEpoch(timestamp))).calendar(customFormat: "llll" /*"LLLL"*/) ?? '';
}
