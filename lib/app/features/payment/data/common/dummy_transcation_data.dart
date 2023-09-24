part of 'package:homemakers_merchant/app/features/payment/index.dart';

List<TranscationEntity> orderTrackingFromJson(String str) =>
    List<TranscationEntity>.from(
        json.decode(str).map((x) => TranscationEntity.fromJson(x)));

String orderTrackingToJson(List<TranscationEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// Fetch content from the json file
Future<List<TranscationEntity>> readTrackingData() async {
  final String response =
      await rootBundle.loadString('assets/dummy_transcation_data.json');
  return orderTrackingFromJson(response) ?? [];
}
