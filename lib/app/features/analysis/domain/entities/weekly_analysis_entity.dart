
part of 'package:homemakers_merchant/app/features/analysis/index.dart';

WeeklyAnalysisEntity weeklyAnalysisEntityFromJson(String str) => WeeklyAnalysisEntity.fromJson(json.decode(str));

String weeklyAnalysisEntityToJson(WeeklyAnalysisEntity data) => json.encode(data.toJson());

class WeeklyAnalysisEntity {
    const WeeklyAnalysisEntity({
        this.result=[],
    });

    final List<WeeklyAnalysisResult> result;

    factory WeeklyAnalysisEntity.fromJson(Map<dynamic, dynamic> json) => WeeklyAnalysisEntity(
        result: List<WeeklyAnalysisResult>.from(json["result"].map((x) => WeeklyAnalysisResult.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class WeeklyAnalysisResult {
    const WeeklyAnalysisResult({
         this.data=const WeeklyAnalysisData(),
         this.store=const WeeklyAnalysisStore(),
    });

    final WeeklyAnalysisData data;
    final WeeklyAnalysisStore store;

    factory WeeklyAnalysisResult.fromJson(Map<dynamic, dynamic> json) => WeeklyAnalysisResult(
        data: WeeklyAnalysisData.fromJson(json["data"]),
        store: WeeklyAnalysisStore.fromJson(json["store"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "data": data.toJson(),
        "store": store.toJson(),
    };
}

class WeeklyAnalysisData {
    const WeeklyAnalysisData({
         this.rushDate=0,
         this.totalEarnings=0,
         this.totalClosedStores=0,
         this.totalNewCustomers=0,
         this.totalCustomers=0,
         this.totalOldCustomers=0,
         this.totalOrders=const WeeklyAnalysisTotalOrders(),
         this.totalOpenStores=0,
         this.rushHours=0,
         this.totalStores=0,
         this.rushDays=0,
    });

    final int rushDate;
    final int totalEarnings;
    final int totalClosedStores;
    final int totalNewCustomers;
    final int totalCustomers;
    final int totalOldCustomers;
    final WeeklyAnalysisTotalOrders totalOrders;
    final int totalOpenStores;
    final int rushHours;
    final int totalStores;
    final int rushDays;

    factory WeeklyAnalysisData.fromJson(Map<dynamic, dynamic> json) => WeeklyAnalysisData(
        rushDate: json["rush_date"]??0,
        totalEarnings: json["total_earnings"]??0,
        totalClosedStores: json["total_closed_stores"]??0,
        totalNewCustomers: json["total_new_customers"]??0,
        totalCustomers: json["total_customers"]??0,
        totalOldCustomers: json["total_old_customers"]??0,
        totalOrders: json["total_orders"]!=null?WeeklyAnalysisTotalOrders.fromJson(json["total_orders"]):WeeklyAnalysisTotalOrders(),
        totalOpenStores: json["total_open_stores"]??0,
        rushHours: json["rush_hours"]??0,
        totalStores: json["total_stores"]??0,
        rushDays: json["rush_days"]??0,
    );

    Map<dynamic, dynamic> toJson() => {
        "rush_date": rushDate,
        "total_earnings": totalEarnings,
        "total_closed_stores": totalClosedStores,
        "total_new_customers": totalNewCustomers,
        "total_customers": totalCustomers,
        "total_old_customers": totalOldCustomers,
        "total_orders": totalOrders.toJson(),
        "total_open_stores": totalOpenStores,
        "rush_hours": rushHours,
        "total_stores": totalStores,
        "rush_days": rushDays,
    };
}

class WeeklyAnalysisTotalOrders {
    const WeeklyAnalysisTotalOrders({
         this.cancel=0,
         this.total=0,
         this.schdule=0,
         this.deliver=0,
         this.instant=0,
    });

    final int cancel;
    final int total;
    final int schdule;
    final int deliver;
    final int instant;

    factory WeeklyAnalysisTotalOrders.fromJson(Map<dynamic, dynamic> json) => WeeklyAnalysisTotalOrders(
        cancel: json["cancel"]??0,
        total: json["total"]??0,
        schdule: json["schdule"]??0,
        deliver: json["deliver"]??0,
        instant: json["instant"]??0,
    );

    Map<dynamic, dynamic> toJson() => {
        "cancel": cancel,
        "total": total,
        "schdule": schdule,
        "deliver": deliver,
        "instant": instant,
    };
}

class WeeklyAnalysisStore {
    const WeeklyAnalysisStore({
         this.month=const WeeklyAnalysisMonth(),
         this.storeName='',
         this.storeID=-1,
    });

    final WeeklyAnalysisMonth month;
    final String storeName;
    final int storeID;

    factory WeeklyAnalysisStore.fromJson(Map<dynamic, dynamic> json) => WeeklyAnalysisStore(
        month: WeeklyAnalysisMonth.fromJson(json["month"]),
        storeName: json["storeName"]??'',
        storeID: json["storeID"]??-1,
    );

    Map<dynamic, dynamic> toJson() => {
        "month": month.toJson(),
        "storeName": storeName,
        "storeID": storeID,
    };
}

class WeeklyAnalysisMonth {
    const WeeklyAnalysisMonth({
         this.days=[],
         this.monthValue='',
         this.monthCurrentWeek='',
    });

    final List<AnalysisDay> days;
    final String monthValue;
    final String monthCurrentWeek;

    factory WeeklyAnalysisMonth.fromJson(Map<dynamic, dynamic> json) => WeeklyAnalysisMonth(
        days: json["days"]!=null?List<AnalysisDay>.from(json["days"].map((x) => AnalysisDay.fromJson(x))):[],
        monthValue: json["month_value"]??'',
        monthCurrentWeek: json["month_current_week"]??'',
    );

    Map<dynamic, dynamic> toJson() => {
        "days": List<dynamic>.from(days.map((x) => x.toJson())),
        "month_value": monthValue,
        "month_current_week": monthCurrentWeek,
    };
}

class AnalysisDay {
    const AnalysisDay({
         this.sales=const AnalysisSales(),
         this.order=const AnalysisOrder(),
    });

    final AnalysisSales sales;
    final AnalysisOrder order;

    factory AnalysisDay.fromJson(Map<dynamic, dynamic> json) => AnalysisDay(
        sales: json["sales"]!=null?AnalysisSales.fromJson(json["sales"]):AnalysisSales(),
        order: json["order"]!=null?AnalysisOrder.fromJson(json["order"]):AnalysisOrder(),
    );

    Map<dynamic, dynamic> toJson() => {
        "sales": sales.toJson(),
        "order": order.toJson(),
    };
}

class AnalysisOrder {
    const AnalysisOrder({
         this.cancel=0,
         this.delay=0,
         this.deliver=0,
         this.totalOrders=0,
         this.schedule=0,
         this.instant=0,
    });

    final int cancel;
    final int delay;
    final int deliver;
    final int totalOrders;
    final int schedule;
    final int instant;

    factory AnalysisOrder.fromJson(Map<dynamic, dynamic> json) => AnalysisOrder(
        cancel: json["cancel"]??0,
        delay: json["delay"]??0,
        deliver: json["deliver"]??0,
        totalOrders: json["total_orders"]??0,
        schedule: json["schedule"]??0,
        instant: json["instant"]??0,
    );

    Map<dynamic, dynamic> toJson() => {
        "cancel": cancel,
        "delay": delay,
        "deliver": deliver,
        "total_orders": totalOrders,
        "schedule": schedule,
        "instant": instant,
    };
}

class AnalysisSales {
    const AnalysisSales({
         this.penaltyAmountBySystem=0,
         this.deliverOrderAmount=0,
         this.refundAmount=0,
         this.totalOrders=0,
         this.netEarning=0,
         this.cancelOrderAmount=0,
    });

    final int penaltyAmountBySystem;
    final int deliverOrderAmount;
    final int refundAmount;
    final int totalOrders;
    final int netEarning;
    final int cancelOrderAmount;

    factory AnalysisSales.fromJson(Map<dynamic, dynamic> json) => AnalysisSales(
        penaltyAmountBySystem: json["penalty_amount_by_system"]??0,
        deliverOrderAmount: json["deliver_order_amount"]??0,
        refundAmount: json["refund_amount"]??0,
        totalOrders: json["total_orders"]??0,
        netEarning: json["net_earning"]??0,
        cancelOrderAmount: json["cancel_order_amount"]??0,
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
