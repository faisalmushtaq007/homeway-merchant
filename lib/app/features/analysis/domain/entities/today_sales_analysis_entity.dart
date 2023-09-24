part of 'package:homemakers_merchant/app/features/analysis/index.dart';

TodaySalesAnalysisEntity todaySalesAnalysisEntityFromJson(String str) =>
    TodaySalesAnalysisEntity.fromJson(json.decode(str));

String todaySalesAnalysisEntityToJson(TodaySalesAnalysisEntity data) =>
    json.encode(data.toJson());

class TodaySalesAnalysisEntity extends Equatable {
  TodaySalesAnalysisEntity({
    required this.result,
  });

  factory TodaySalesAnalysisEntity.fromJson(Map<dynamic, dynamic> json) =>
      TodaySalesAnalysisEntity(
        result: List<TodaySalesResult>.from(
            json['result'].map((x) => TodaySalesResult.fromJson(x))),
      );

  List<TodaySalesResult> result;

  Map<dynamic, dynamic> toJson() => {
        'result': List<dynamic>.from(result.map((x) => x.toJson())),
      };
  @override
  List<Object?> get props => [result];
}

class TodaySalesResult extends Equatable {
  const TodaySalesResult({
    required this.data,
    required this.store,
  });

  factory TodaySalesResult.fromJson(Map<dynamic, dynamic> json) =>
      TodaySalesResult(
        data: OverAllAnalysisData.fromJson(json['data']),
        store: StoreSalesAnalysisEntity.fromJson(json['store']),
      );

  final OverAllAnalysisData data;
  final StoreSalesAnalysisEntity store;

  Map<dynamic, dynamic> toJson() => {
        'data': data.toJson(),
        'store': store.toJson(),
      };
  @override
  List<Object?> get props => [data, store];
}

class StoreSalesAnalysisEntity extends Equatable {
  const StoreSalesAnalysisEntity({
    required this.storeName,
    required this.todaySalesStatus,
    required this.storeID,
    required this.yesterdaySalesStatus,
  });

  factory StoreSalesAnalysisEntity.fromJson(Map<dynamic, dynamic> json) =>
      StoreSalesAnalysisEntity(
        storeName: json['storeName'],
        todaySalesStatus: DaySalesStatus.fromJson(json['today_sales_status']),
        storeID: json['storeID'],
        yesterdaySalesStatus:
            DaySalesStatus.fromJson(json['yesterday_sales_status']),
      );

  final String storeName;
  final DaySalesStatus todaySalesStatus;
  final int storeID;
  final DaySalesStatus yesterdaySalesStatus;

  Map<dynamic, dynamic> toJson() => {
        'storeName': storeName,
        'today_sales_status': todaySalesStatus.toJson(),
        'storeID': storeID,
        'yesterday_sales_status': yesterdaySalesStatus.toJson(),
      };

  @override
  List<Object?> get props =>
      [storeName, todaySalesStatus, storeID, yesterdaySalesStatus];
}

class DaySalesStatus {
  DaySalesStatus({
    required this.penaltyAmountBySystem,
    required this.deliverOrderAmount,
    required this.refundAmount,
    required this.totalOrders,
    required this.netEarning,
    required this.cancelOrderAmount,
  });

  factory DaySalesStatus.fromJson(Map<dynamic, dynamic> json) => DaySalesStatus(
        penaltyAmountBySystem: json['penalty_amount_by_system'],
        deliverOrderAmount: json['deliver_order_amount'],
        refundAmount: json['refund_amount'],
        totalOrders: json['total_orders'],
        netEarning: json['net_earning'],
        cancelOrderAmount: json['cancel_order_amount'],
      );

  int penaltyAmountBySystem;
  int deliverOrderAmount;
  int refundAmount;
  int totalOrders;
  int netEarning;
  int cancelOrderAmount;

  Map<dynamic, dynamic> toJson() => {
        'penalty_amount_by_system': penaltyAmountBySystem,
        'deliver_order_amount': deliverOrderAmount,
        'refund_amount': refundAmount,
        'total_orders': totalOrders,
        'net_earning': netEarning,
        'cancel_order_amount': cancelOrderAmount,
      };
}
