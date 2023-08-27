// To parse this JSON data, do
//
//     final orderTracking = orderTrackingFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:homemakers_merchant/app/features/order/index.dart';

List<TrackingInfo> orderTrackingFromJson(String str) => List<TrackingInfo>.from(json.decode(str).map((x) => TrackingInfo.fromJson(x)));

String orderTrackingToJson(List<TrackingInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// Fetch content from the json file
Future<List<TrackingInfo>> readTrackingData() async {
  final String response = await rootBundle.loadString('assets/dummy_tacking_data.json');
  return orderTrackingFromJson(response) ?? [];
}
