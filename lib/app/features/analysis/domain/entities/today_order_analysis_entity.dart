part of 'package:homemakers_merchant/app/features/analysis/index.dart';

TodayOrderAnalysisEntity todayOrderAnalysisEntityFromJson(String str) =>
    TodayOrderAnalysisEntity.fromJson(json.decode(str));

String todayOrderAnalysisEntityToJson(TodayOrderAnalysisEntity data) =>
    json.encode(data.toJson());

class TodayOrderAnalysisEntity extends Equatable {
  const TodayOrderAnalysisEntity({
    this.result = const <TodayOrderResult>[],
  });

  factory TodayOrderAnalysisEntity.fromJson(Map<dynamic, dynamic> json) =>
      TodayOrderAnalysisEntity(
        result: json['result'] != null
            ? List<TodayOrderResult>.from(
                json['result'].map((x) => TodayOrderResult.fromJson(x)))
            : [],
      );

  final List<TodayOrderResult> result;

  Map<dynamic, dynamic> toJson() => {
        'result': List<dynamic>.from(result.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [result];
}

class TodayOrderResult extends Equatable {
  const TodayOrderResult({
    this.data = const OverAllAnalysisData(),
    this.store = const StoreAnalysisEntity(),
  });

  factory TodayOrderResult.fromJson(Map<dynamic, dynamic> json) =>
      TodayOrderResult(
        data: json['data'] != null
            ? OverAllAnalysisData.fromJson(json['data'])
            : const OverAllAnalysisData(),
        store: json['store'] != null
            ? StoreAnalysisEntity.fromJson(json['store'])
            : const StoreAnalysisEntity(),
      );

  final OverAllAnalysisData data;
  final StoreAnalysisEntity store;

  Map<dynamic, dynamic> toJson() => {
        'data': data.toJson(),
        'store': store.toJson(),
      };
  @override
  List<Object?> get props => [data, store];
}

class OverAllAnalysisData extends Equatable {
  const OverAllAnalysisData({
    this.totalEarnings = 0,
    this.totalCustomers = 0,
    this.totalOrders = const TotalOrders(),
    this.totalStores = 0,
  });

  factory OverAllAnalysisData.fromJson(Map<dynamic, dynamic> json) =>
      OverAllAnalysisData(
        totalEarnings: json['total_earnings'] ?? 0,
        totalCustomers: json['total_customers'] ?? 0,
        totalOrders: json['total_orders'] != null
            ? TotalOrders.fromJson(json['total_orders'])
            : const TotalOrders(),
        totalStores: json['total_stores'] ?? 0,
      );

  final int totalEarnings;
  final int totalCustomers;
  final TotalOrders totalOrders;
  final int totalStores;

  Map<dynamic, dynamic> toJson() => {
        'total_earnings': totalEarnings,
        'total_customers': totalCustomers,
        'total_orders': totalOrders.toJson(),
        'total_stores': totalStores,
      };

  @override
  List<Object?> get props =>
      [totalEarnings, totalCustomers, totalOrders, totalStores];
}

class TotalOrders {
  const TotalOrders({
    this.totalOrdersNew = 0,
    this.deliver = 0,
    this.countTotalOrders = 0,
  });

  factory TotalOrders.fromJson(Map<dynamic, dynamic> json) => TotalOrders(
        totalOrdersNew: json['new'] ?? 0,
        deliver: json['deliver'] ?? 0,
        countTotalOrders: json['total'] ?? 0,
      );

  final int totalOrdersNew;
  final int deliver;
  final int countTotalOrders;

  Map<dynamic, dynamic> toJson() => {
        'new': totalOrdersNew,
        'deliver': deliver,
        'total': countTotalOrders,
      };
}

class StoreAnalysisEntity {
  const StoreAnalysisEntity({
    this.todayOrderStatus = const DayOrderStatus(),
    this.storeName = '',
    this.storeId = -11,
    this.yesterdayOrderStatus = const DayOrderStatus(),
  });

  factory StoreAnalysisEntity.fromJson(Map<dynamic, dynamic> json) =>
      StoreAnalysisEntity(
        todayOrderStatus: json['today_order_status'] != null
            ? DayOrderStatus.fromJson(json['today_order_status'])
            : const DayOrderStatus(),
        storeName: json['storeName'] ?? '',
        storeId: json['storeID'] ?? -1,
        yesterdayOrderStatus: json['yesterday_order_status'] != null
            ? DayOrderStatus.fromJson(json['yesterday_order_status'])
            : const DayOrderStatus(),
      );

  final DayOrderStatus todayOrderStatus;
  final String storeName;
  final int storeId;
  final DayOrderStatus yesterdayOrderStatus;

  Map<dynamic, dynamic> toJson() => {
        'today_order_status': todayOrderStatus.toJson(),
        'storeName': storeName,
        'storeID': storeId,
        'yesterday_order_status': yesterdayOrderStatus.toJson(),
      };
}

class DayOrderStatus {
  const DayOrderStatus({
    this.cancel = 0,
    this.schedule = 0,
    this.delay = 0,
    this.pending = 0,
    this.deliver = 0,
    this.instant = 0,
    this.totalOrders = 0,
  });

  factory DayOrderStatus.fromJson(Map<dynamic, dynamic> json) => DayOrderStatus(
        cancel: json['cancel'] ?? 0,
        schedule: json['schedule'] ?? 0,
        delay: json['delay'] ?? 0,
        pending: json['pending'] ?? 0,
        deliver: json['deliver'] ?? 0,
        instant: json['instant'] ?? 0,
        totalOrders: json['total_orders'] ?? 0,
      );

  final int cancel;
  final int schedule;
  final int delay;
  final int pending;
  final int deliver;
  final int instant;
  final int totalOrders;

  Map<dynamic, dynamic> toJson() => {
        'cancel': cancel,
        'schedule': schedule,
        'delay': delay,
        'pending': pending,
        'deliver': deliver,
        'instant': instant,
        'total_orders': totalOrders,
      };
}
