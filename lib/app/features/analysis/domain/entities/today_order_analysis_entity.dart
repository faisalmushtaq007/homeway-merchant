part of 'package:homemakers_merchant/app/features/analysis/index.dart';

TodayOrderAnalysisEntity todayOrderAnalysisEntityFromJson(String str) => TodayOrderAnalysisEntity.fromJson(json.decode(str));

String todayOrderAnalysisEntityToJson(TodayOrderAnalysisEntity data) => json.encode(data.toJson());

class TodayOrderAnalysisEntity {
    TodayOrderAnalysisEntity({
        required this.result,
    });

    List<TodayOrderResult> result;

    factory TodayOrderAnalysisEntity.fromJson(Map<dynamic, dynamic> json) => TodayOrderAnalysisEntity(
        result: List<TodayOrderResult>.from(json["result"].map((x) => TodayOrderResult.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class TodayOrderResult {
    TodayOrderResult({
        required this.data,
        required this.store,
    });

    OverAllAnalysisData data;
    StoreAnalysisEntity store;

    factory TodayOrderResult.fromJson(Map<dynamic, dynamic> json) => TodayOrderResult(
        data: OverAllAnalysisData.fromJson(json["data"]),
        store: StoreAnalysisEntity.fromJson(json["store"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "data": data.toJson(),
        "store": store.toJson(),
    };
}

class OverAllAnalysisData {
    OverAllAnalysisData({
        required this.totalEarnings,
        required this.totalCustomers,
        required this.totalOrders,
        required this.totalStores,
    });

    int totalEarnings;
    int totalCustomers;
    TotalOrders totalOrders;
    int totalStores;

    factory OverAllAnalysisData.fromJson(Map<dynamic, dynamic> json) => OverAllAnalysisData(
        totalEarnings: json["total_earnings"],
        totalCustomers: json["total_customers"],
        totalOrders: TotalOrders.fromJson(json["total_orders"]),
        totalStores: json["total_stores"],
    );

    Map<dynamic, dynamic> toJson() => {
        "total_earnings": totalEarnings,
        "total_customers": totalCustomers,
        "total_orders": totalOrders.toJson(),
        "total_stores": totalStores,
    };
}

class TotalOrders {
    TotalOrders({
        required this.totalOrdersNew,
        required this.deliver,
        this.countTotalOrders=0,
    });

    int totalOrdersNew;
    int deliver;
    int countTotalOrders;

    factory TotalOrders.fromJson(Map<dynamic, dynamic> json) => TotalOrders(
        totalOrdersNew: json["new"],
        deliver: json["deliver"],
        countTotalOrders:json['total']
    );

    Map<dynamic, dynamic> toJson() => {
        "new": totalOrdersNew,
        "deliver": deliver,
        'total':countTotalOrders,
    };
}

class StoreAnalysisEntity {
    StoreAnalysisEntity({
        required this.todayOrderStatus,
        required this.storeName,
        required this.storeId,
        required this.yesterdayOrderStatus,
    });

    DayOrderStatus todayOrderStatus;
    String storeName;
    int storeId;
    DayOrderStatus yesterdayOrderStatus;

    factory StoreAnalysisEntity.fromJson(Map<dynamic, dynamic> json) => StoreAnalysisEntity(
        todayOrderStatus: DayOrderStatus.fromJson(json["today_order_status"]),
        storeName: json["storeName"],
        storeId: json["storeID"],
        yesterdayOrderStatus: DayOrderStatus.fromJson(json["yesterday_order_status"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "today_order_status": todayOrderStatus.toJson(),
        "storeName": storeName,
        "storeID": storeId,
        "yesterday_order_status": yesterdayOrderStatus.toJson(),
    };
}

class DayOrderStatus {
    DayOrderStatus({
        required this.cancel,
        required this.schedule,
        required this.delay,
        required this.pending,
        required this.deliver,
        required this.instant,
        required this.totalOrders,
    });

    int cancel;
    int schedule;
    int delay;
    int pending;
    int deliver;
    int instant;
    int totalOrders;

    factory DayOrderStatus.fromJson(Map<dynamic, dynamic> json) => DayOrderStatus(
        cancel: json["cancel"],
        schedule: json["schedule"],
        delay: json["delay"],
        pending: json["pending"],
        deliver: json["deliver"],
        instant: json["instant"],
        totalOrders: json["total_orders"],
    );

    Map<dynamic, dynamic> toJson() => {
        "cancel": cancel,
        "schedule": schedule,
        "delay": delay,
        "pending": pending,
        "deliver": deliver,
        "instant": instant,
        "total_orders": totalOrders,
    };
}
