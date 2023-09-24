part of 'package:homemakers_merchant/app/features/analysis/index.dart';

WeeklyAnalysisOldEntity weeklyAnalysisOldEntityFromJson(String str) =>
    WeeklyAnalysisOldEntity.fromJson(json.decode(str));

String weeklyAnalysisOldEntityToJson(WeeklyAnalysisOldEntity data) =>
    json.encode(data.toJson());

class WeeklyAnalysisOldEntity extends Equatable {
  const WeeklyAnalysisOldEntity({
    this.result = const [],
    this.overAllData = const WeeklyOverallAnalysisData(),
  });

  factory WeeklyAnalysisOldEntity.fromJson(Map<dynamic, dynamic> json) =>
      WeeklyAnalysisOldEntity(
        result: List<WeeklyAnalysisOldResult>.from(
            json['result'].map((x) => WeeklyAnalysisOldResult.fromJson(x))),
        overAllData: WeeklyOverallAnalysisData.fromJson(json['overAllData']),
      );

  final List<WeeklyAnalysisOldResult> result;
  final WeeklyOverallAnalysisData overAllData;

  Map<dynamic, dynamic> toJson() => {
        'result': List<dynamic>.from(result.map((x) => x.toJson())),
        'overAllData': overAllData.toJson(),
      };

  @override
  List<Object?> get props => [result];
}

class WeeklyAnalysisOldResult extends Equatable {
  const WeeklyAnalysisOldResult({
    this.data = const WeeklyOverallAnalysisData(),
    this.store = const WeeklyAnalysisOldStore(),
  });

  factory WeeklyAnalysisOldResult.fromJson(Map<dynamic, dynamic> json) =>
      WeeklyAnalysisOldResult(
        data: WeeklyOverallAnalysisData.fromJson(json['data']),
        store: WeeklyAnalysisOldStore.fromJson(json['store']),
      );

  final WeeklyOverallAnalysisData data;
  final WeeklyAnalysisOldStore store;

  Map<dynamic, dynamic> toJson() => {
        'data': data.toJson(),
        'store': store.toJson(),
      };

  @override
  List<Object?> get props => [data, store];
}

class WeeklyOverallAnalysisData extends Equatable {
  const WeeklyOverallAnalysisData({
    this.rushDate = 0,
    this.totalEarnings = 0,
    this.totalClosedStores = 0,
    this.totalNewCustomers = 0,
    this.totalCustomers = 0,
    this.totalOldCustomers = 0,
    this.totalOrders = const WeeklyAnalysisOldTotalOrders(),
    this.totalOpenStores = 0,
    this.rushHours = 0,
    this.totalStores = 0,
    this.rushDays = 0,
  });

  factory WeeklyOverallAnalysisData.fromJson(Map<dynamic, dynamic> json) =>
      WeeklyOverallAnalysisData(
        rushDate: json['rush_date'] ?? 0,
        totalEarnings: json['total_earnings'] ?? 0,
        totalClosedStores: json['total_closed_stores'] ?? 0,
        totalNewCustomers: json['total_new_customers'] ?? 0,
        totalCustomers: json['total_customers'] ?? 0,
        totalOldCustomers: json['total_old_customers'] ?? 0,
        totalOrders: json['total_orders'] != null
            ? WeeklyAnalysisOldTotalOrders.fromJson(json['total_orders'])
            : WeeklyAnalysisOldTotalOrders(),
        totalOpenStores: json['total_open_stores'] ?? 0,
        rushHours: json['rush_hours'] ?? 0,
        totalStores: json['total_stores'] ?? 0,
        rushDays: json['rush_days'] ?? 0,
      );

  final int rushDate;
  final int totalEarnings;
  final int totalClosedStores;
  final int totalNewCustomers;
  final int totalCustomers;
  final int totalOldCustomers;
  final WeeklyAnalysisOldTotalOrders totalOrders;
  final int totalOpenStores;
  final int rushHours;
  final int totalStores;
  final int rushDays;

  Map<dynamic, dynamic> toJson() => {
        'rush_date': rushDate,
        'total_earnings': totalEarnings,
        'total_closed_stores': totalClosedStores,
        'total_new_customers': totalNewCustomers,
        'total_customers': totalCustomers,
        'total_old_customers': totalOldCustomers,
        'total_orders': totalOrders.toJson(),
        'total_open_stores': totalOpenStores,
        'rush_hours': rushHours,
        'total_stores': totalStores,
        'rush_days': rushDays,
      };

  @override
  List<Object?> get props => [];
}

class WeeklyAnalysisOldTotalOrders extends Equatable {
  const WeeklyAnalysisOldTotalOrders({
    this.cancel = 0,
    this.total = 0,
    this.schedule = 0,
    this.deliver = 0,
    this.instant = 0,
  });

  factory WeeklyAnalysisOldTotalOrders.fromJson(Map<dynamic, dynamic> json) =>
      WeeklyAnalysisOldTotalOrders(
        cancel: json['cancel'] ?? 0,
        total: json['total'] ?? 0,
        schedule: json['schedule'] ?? 0,
        deliver: json['deliver'] ?? 0,
        instant: json['instant'] ?? 0,
      );

  final int cancel;
  final int total;
  final int schedule;
  final int deliver;
  final int instant;

  Map<dynamic, dynamic> toJson() => {
        'cancel': cancel,
        'total': total,
        'schedule': schedule,
        'deliver': deliver,
        'instant': instant,
      };

  @override
  List<Object?> get props => [cancel, total, schedule, deliver, instant];
}

class WeeklyAnalysisOldStore extends Equatable {
  const WeeklyAnalysisOldStore({
    this.month = const WeeklyAnalysisOldMonth(),
    this.storeName = '',
    this.storeID = -1,
  });

  factory WeeklyAnalysisOldStore.fromJson(Map<dynamic, dynamic> json) =>
      WeeklyAnalysisOldStore(
        month: WeeklyAnalysisOldMonth.fromJson(json['month']),
        storeName: json['storeName'] ?? '',
        storeID: json['storeID'] ?? -1,
      );

  final WeeklyAnalysisOldMonth month;
  final String storeName;
  final int storeID;

  Map<dynamic, dynamic> toJson() => {
        'month': month.toJson(),
        'storeName': storeName,
        'storeID': storeID,
      };

  @override
  List<Object?> get props => [month, storeName, storeID];
}

class WeeklyAnalysisOldMonth extends Equatable {
  const WeeklyAnalysisOldMonth({
    this.days = const [],
    this.monthValue = '',
    this.monthCurrentWeek = '',
    this.fromDate,
    this.toDate,
  });

  factory WeeklyAnalysisOldMonth.fromJson(Map<dynamic, dynamic> json) =>
      WeeklyAnalysisOldMonth(
        days: json['days'] != null
            ? List<AnalysisOldDay>.from(
                json['days'].map((x) => AnalysisOldDay.fromJson(x)))
            : [],
        monthValue: json['month_value'] ?? '',
        monthCurrentWeek: json['month_current_week'] ?? '',
        fromDate: json['fromDate'] != null
            ? Jiffy.parse(json['fromDate']).dateTime
            : Jiffy.now().dateTime,
        toDate: json['toDate'] != null
            ? Jiffy.parse(json['toDate']).dateTime
            : Jiffy.now().dateTime,
      );

  final List<AnalysisOldDay> days;
  final String monthValue;
  final String monthCurrentWeek;
  final DateTime? fromDate;
  final DateTime? toDate;

  Map<dynamic, dynamic> toJson() => {
        'days': List<dynamic>.from(days.map((x) => x.toJson())),
        'month_value': monthValue,
        'month_current_week': monthCurrentWeek,
        'fromDate': fromDate,
        'toDate': toDate,
      };

  @override
  List<Object?> get props => [
        days,
        monthValue,
        monthCurrentWeek,
        fromDate,
        toDate,
      ];
}

class AnalysisOldDay extends Equatable {
  const AnalysisOldDay({
    this.sales = const AnalysisSales(),
    this.order = const AnalysisOrder(),
    this.analysisDate,
  });

  factory AnalysisOldDay.fromJson(Map<dynamic, dynamic> json) => AnalysisOldDay(
        sales: json['sales'] != null
            ? AnalysisSales.fromJson(json['sales'])
            : AnalysisSales(),
        order: json['order'] != null
            ? AnalysisOrder.fromJson(json['order'])
            : AnalysisOrder(),
        analysisDate: json['date'] != null
            ? Jiffy.parse(json['order']).dateTime
            : Jiffy.now().dateTime,
      );
  final DateTime? analysisDate;
  final AnalysisSales sales;
  final AnalysisOrder order;

  Map<dynamic, dynamic> toJson() => {
        'sales': sales.toJson(),
        'order': order.toJson(),
        'date': analysisDate,
      };

  @override
  List<Object?> get props => [sales, order, analysisDate];
}

class AnalysisOrder extends Equatable {
  const AnalysisOrder({
    this.cancel = 0,
    this.delay = 0,
    this.deliver = 0,
    this.totalOrders = 0,
    this.schedule = 0,
    this.instant = 0,
  });

  factory AnalysisOrder.fromJson(Map<dynamic, dynamic> json) => AnalysisOrder(
        cancel: json['cancel'] ?? 0,
        delay: json['delay'] ?? 0,
        deliver: json['deliver'] ?? 0,
        totalOrders: json['total_orders'] ?? 0,
        schedule: json['schedule'] ?? 0,
        instant: json['instant'] ?? 0,
      );

  final int cancel;
  final int delay;
  final int deliver;
  final int totalOrders;
  final int schedule;
  final int instant;

  Map<dynamic, dynamic> toJson() => {
        'cancel': cancel,
        'delay': delay,
        'deliver': deliver,
        'total_orders': totalOrders,
        'schedule': schedule,
        'instant': instant,
      };

  @override
  List<Object?> get props => [
        cancel,
        delay,
        deliver,
        totalOrders,
        schedule,
        instant,
      ];
}

class AnalysisSales extends Equatable {
  const AnalysisSales({
    this.penaltyAmountBySystem = 0,
    this.deliverOrderAmount = 0,
    this.refundAmount = 0,
    this.totalOrders = 0,
    this.netEarning = 0,
    this.cancelOrderAmount = 0,
  });

  factory AnalysisSales.fromJson(Map<dynamic, dynamic> json) => AnalysisSales(
        penaltyAmountBySystem: json['penalty_amount_by_system'] ?? 0,
        deliverOrderAmount: json['deliver_order_amount'] ?? 0,
        refundAmount: json['refund_amount'] ?? 0,
        totalOrders: json['total_orders'] ?? 0,
        netEarning: json['net_earning'] ?? 0,
        cancelOrderAmount: json['cancel_order_amount'] ?? 0,
      );

  final int penaltyAmountBySystem;
  final int deliverOrderAmount;
  final int refundAmount;
  final int totalOrders;
  final int netEarning;
  final int cancelOrderAmount;

  Map<dynamic, dynamic> toJson() => {
        'penalty_amount_by_system': penaltyAmountBySystem,
        'deliver_order_amount': deliverOrderAmount,
        'refund_amount': refundAmount,
        'total_orders': totalOrders,
        'net_earning': netEarning,
        'cancel_order_amount': cancelOrderAmount,
      };

  @override
  List<Object?> get props => [
        penaltyAmountBySystem,
        deliverOrderAmount,
        refundAmount,
        totalOrders,
        netEarning,
        cancelOrderAmount,
      ];
}
