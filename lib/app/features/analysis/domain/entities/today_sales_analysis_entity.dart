part of 'package:homemakers_merchant/app/features/analysis/index.dart';

TodaySalesAnalysisEntity todaySalesAnalysisEntityFromJson(String str) => TodaySalesAnalysisEntity.fromJson(json.decode(str));

String todaySalesAnalysisEntityToJson(TodaySalesAnalysisEntity data) => json.encode(data.toJson());

class TodaySalesAnalysisEntity {
    TodaySalesAnalysisEntity({
        required this.result,
    });

    List<TodaySalesResult> result;

    factory TodaySalesAnalysisEntity.fromJson(Map<dynamic, dynamic> json) => TodaySalesAnalysisEntity(
        result: List<TodaySalesResult>.from(json["result"].map((x) => TodaySalesResult.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class TodaySalesResult {
    TodaySalesResult({
        required this.data,
        required this.store,
    });

    OverAllAnalysisData data;
    StoreSalesAnalysisEntity store;

    factory TodaySalesResult.fromJson(Map<dynamic, dynamic> json) => TodaySalesResult(
        data: OverAllAnalysisData.fromJson(json["data"]),
        store: StoreSalesAnalysisEntity.fromJson(json["store"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "data": data.toJson(),
        "store": store.toJson(),
    };
}


class StoreSalesAnalysisEntity {
    StoreSalesAnalysisEntity({
        required this.storeName,
        required this.todaySalesStatus,
        required this.storeId,
        required this.yesterdaySalesStatus,
    });

    String storeName;
    DaySalesStatus todaySalesStatus;
    int storeId;
    DaySalesStatus yesterdaySalesStatus;

    factory StoreSalesAnalysisEntity.fromJson(Map<dynamic, dynamic> json) => StoreSalesAnalysisEntity(
        storeName: json["storeName"],
        todaySalesStatus: DaySalesStatus.fromJson(json["today_sales_status"]),
        storeId: json["storeID"],
        yesterdaySalesStatus: DaySalesStatus.fromJson(json["yesterday_sales_status"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "storeName": storeName,
        "today_sales_status": todaySalesStatus.toJson(),
        "storeID": storeId,
        "yesterday_sales_status": yesterdaySalesStatus.toJson(),
    };
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

    int penaltyAmountBySystem;
    int deliverOrderAmount;
    int refundAmount;
    int totalOrders;
    int netEarning;
    int cancelOrderAmount;

    factory DaySalesStatus.fromJson(Map<dynamic, dynamic> json) => DaySalesStatus(
        penaltyAmountBySystem: json["penalty_amount_by_system"],
        deliverOrderAmount: json["deliver_order_amount"],
        refundAmount: json["refund_amount"],
        totalOrders: json["total_orders"],
        netEarning: json["net_earning"],
        cancelOrderAmount: json["cancel_order_amount"],
    );

    Map<dynamic, dynamic> toJson() => {
        "penalty_amount_by_system": penaltyAmountBySystem,
        "deliver_order_amount": deliverOrderAmount,
        "refund_amount": refundAmount,
        "total_orders": totalOrders,
        "net_earning": netEarning,
        "cancel_order_amount": cancelOrderAmount,
    };
}
