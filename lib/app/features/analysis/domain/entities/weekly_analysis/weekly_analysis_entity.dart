part of 'package:homemakers_merchant/app/features/analysis/index.dart';

WeeklyAnalysisEntity weeklyAnalysisEntityFromJson(String str) =>
    WeeklyAnalysisEntity.fromMap(json.decode(str));

String weeklyAnalysisEntityToJson(WeeklyAnalysisEntity data) =>
    json.encode(data.toMap());

class WeeklyAnalysisEntity extends Equatable {
  const WeeklyAnalysisEntity({this.result = const WeeklyAnalysisResult()});

  factory WeeklyAnalysisEntity.fromMap(Map<String, dynamic> data) {
    return WeeklyAnalysisEntity(
      result: data['result'] == null
          ? const WeeklyAnalysisResult()
          : WeeklyAnalysisResult.fromMap(
              data['result'] as Map<String, dynamic>),
    );
  }

  final WeeklyAnalysisResult result;

  Map<String, dynamic> toMap() => {
        'result': result.toMap(),
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [result];
}

class WeeklyAnalysisResult extends Equatable {
  const WeeklyAnalysisResult({
    this.fromDate,
    this.toDate,
    this.monthValue = '',
    this.yearValue = '',
    this.monthWeek = '',
    this.days = const [],
    this.overAllData = const WeeklyAnalysisOverAllData(),
  });

  factory WeeklyAnalysisResult.fromMap(Map<String, dynamic> data) =>
      WeeklyAnalysisResult(
        fromDate: data['fromDate'] == null
            ? null
            : DateTime.parse(data['fromDate'] as String),
        toDate: data['toDate'] == null
            ? null
            : DateTime.parse(data['toDate'] as String),
        monthValue: data['month_value'] ?? '',
        yearValue: data['year_value'] ?? '',
        monthWeek: data['month_week'] ?? '',
        days: (data['days'] as List<dynamic>?)
                ?.map((e) => AnalysisDay.fromMap(e as Map<String, dynamic>))
                .toList() ??
            [],
        overAllData: data['overAllData'] == null
            ? const WeeklyAnalysisOverAllData()
            : WeeklyAnalysisOverAllData.fromMap(
                data['overAllData'] as Map<String, dynamic>),
      );

  final DateTime? fromDate;
  final DateTime? toDate;
  final String monthValue;
  final String yearValue;
  final String monthWeek;
  final List<AnalysisDay> days;
  final WeeklyAnalysisOverAllData overAllData;

  Map<String, dynamic> toMap() => {
        'fromDate': fromDate?.toIso8601String(),
        'toDate': toDate?.toIso8601String(),
        'month_value': monthValue,
        'year_value': yearValue,
        'month_week': monthWeek,
        'days': days.map((e) => e.toMap()).toList(),
        'overAllData': overAllData.toMap(),
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      fromDate,
      toDate,
      monthValue,
      yearValue,
      monthWeek,
      days,
      overAllData,
    ];
  }
}

class WeeklyAnalysisOverAllData extends Equatable {
  const WeeklyAnalysisOverAllData({
    this.totalEarnings = 0,
    this.totalCustomers = 0,
    this.totalOldCustomers = 0,
    this.totalNewCustomers = 0,
    this.totalStores = 0,
    this.totalOpenStores = 0,
    this.totalClosedStores = 0,
    this.totalOrders = const WeeklyAnalysisTotalOrders(),
    this.rushHours = const AnalysisRushHours(),
    this.rushDay = '',
    this.rushDate = const AnalysisRushDate(),
  });

  factory WeeklyAnalysisOverAllData.fromMap(Map<String, dynamic> data) =>
      WeeklyAnalysisOverAllData(
        totalEarnings: data['total_earnings'] ?? 0,
        totalCustomers: data['total_customers'] ?? 0,
        totalOldCustomers: data['total_old_customers'] ?? 0,
        totalNewCustomers: data['total_new_customers'] ?? 0,
        totalStores: data['total_stores'] ?? 0,
        totalOpenStores: data['total_open_stores'] ?? 0,
        totalClosedStores: data['total_closed_stores'] ?? 0,
        totalOrders: data['total_orders'] == null
            ? const WeeklyAnalysisTotalOrders()
            : WeeklyAnalysisTotalOrders.fromMap(
                data['total_orders'] as Map<String, dynamic>),
        rushHours: data['rush_hours'] == null
            ? const AnalysisRushHours()
            : AnalysisRushHours.fromMap(
                data['rush_hours'] as Map<String, dynamic>),
        rushDay: data['rush_day'] ?? '',
        rushDate: data['rush_date'] == null
            ? const AnalysisRushDate()
            : AnalysisRushDate.fromMap(
                data['rush_date'] as Map<String, dynamic>),
      );

  final int totalEarnings;
  final int totalCustomers;
  final int totalOldCustomers;
  final int totalNewCustomers;
  final int totalStores;
  final int totalOpenStores;
  final int totalClosedStores;
  final WeeklyAnalysisTotalOrders totalOrders;
  final AnalysisRushHours rushHours;
  final String rushDay;
  final AnalysisRushDate rushDate;

  Map<String, dynamic> toMap() => {
        'total_earnings': totalEarnings,
        'total_customers': totalCustomers,
        'total_old_customers': totalOldCustomers,
        'total_new_customers': totalNewCustomers,
        'total_stores': totalStores,
        'total_open_stores': totalOpenStores,
        'total_closed_stores': totalClosedStores,
        'total_orders': totalOrders.toMap(),
        'rush_hours': rushHours.toMap(),
        'rush_day': rushDay,
        'rush_date': rushDate.toMap(),
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      totalEarnings,
      totalCustomers,
      totalOldCustomers,
      totalNewCustomers,
      totalStores,
      totalOpenStores,
      totalClosedStores,
      totalOrders,
      rushHours,
      rushDate,
      rushDay,
    ];
  }
}

class AnalysisDay extends Equatable {
  const AnalysisDay(
      {this.date,
      this.stores = const [],
      this.overAllData = const WeeklyAnalysisOverAllData()});

  factory AnalysisDay.fromMap(Map<String, dynamic> data) => AnalysisDay(
        date: data['date'] == null
            ? null
            : DateTime.parse(data['date'] as String),
        stores: (data['stores'] as List<dynamic>?)
                ?.map((e) =>
                    WeeklyAnalysisStore.fromMap(e as Map<String, dynamic>))
                .toList() ??
            [],
        overAllData: data['overAllData'] == null
            ? const WeeklyAnalysisOverAllData()
            : WeeklyAnalysisOverAllData.fromMap(
                data['overAllData'] as Map<String, dynamic>),
      );

  final DateTime? date;
  final List<WeeklyAnalysisStore> stores;
  final WeeklyAnalysisOverAllData overAllData;

  Map<String, dynamic> toMap() => {
        'date': date?.toIso8601String(),
        'stores': stores.map((e) => e.toMap()).toList(),
        'overAllData': overAllData.toMap(),
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [date, stores, overAllData];
}

class WeeklyAnalysisStore extends Equatable {
  const WeeklyAnalysisStore({
    this.storeID = -1,
    this.storeName = '',
    this.orders = const WeeklyAnalysisOrders(),
    this.sales = const WeeklyAnalysisSales(),
    this.overview = const WeeklyAnalysisOverview(),
  });

  factory WeeklyAnalysisStore.fromMap(Map<String, dynamic> data) =>
      WeeklyAnalysisStore(
        storeID: data['storeID'] ?? -1,
        storeName: data['storeName'] ?? '',
        orders: data['orders'] == null
            ? const WeeklyAnalysisOrders()
            : WeeklyAnalysisOrders.fromMap(
                data['orders'] as Map<String, dynamic>),
        sales: data['sales'] == null
            ? const WeeklyAnalysisSales()
            : WeeklyAnalysisSales.fromMap(
                data['sales'] as Map<String, dynamic>),
        overview: data['overview'] == null
            ? const WeeklyAnalysisOverview()
            : WeeklyAnalysisOverview.fromMap(
                data['overview'] as Map<String, dynamic>),
      );

  final int storeID;
  final String storeName;
  final WeeklyAnalysisOrders orders;
  final WeeklyAnalysisSales sales;
  final WeeklyAnalysisOverview overview;

  Map<String, dynamic> toMap() => {
        'storeID': storeID,
        'storeName': storeName,
        'orders': orders.toMap(),
        'sales': sales.toMap(),
        'overview': overview.toMap(),
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      storeID,
      storeName,
      orders,
      sales,
      overview,
    ];
  }
}

class WeeklyAnalysisOrders extends Equatable {
  const WeeklyAnalysisOrders({
    this.instant = 0,
    this.schedule = 0,
    this.cancel = 0,
    this.delay = 0,
    this.deliver = 0,
    this.totalOrder = 0,
  });

  factory WeeklyAnalysisOrders.fromMap(Map<String, dynamic> data) =>
      WeeklyAnalysisOrders(
        instant: data['instant'] ?? 0,
        schedule: data['schedule'] ?? 0,
        cancel: data['cancel'] ?? 0,
        delay: data['delay'] ?? 0,
        deliver: data['deliver'] ?? 0,
        totalOrder: data['total_order'] ?? 0,
      );

  final int instant;
  final int schedule;
  final int cancel;
  final int delay;
  final int deliver;
  final int totalOrder;

  Map<String, dynamic> toMap() => {
        'instant': instant,
        'schedule': schedule,
        'cancel': cancel,
        'delay': delay,
        'deliver': deliver,
        'total_order': totalOrder,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      instant,
      schedule,
      cancel,
      delay,
      deliver,
      totalOrder,
    ];
  }
}

class WeeklyAnalysisOverview extends Equatable {
  const WeeklyAnalysisOverview({
    this.totalCustomers = 0,
    this.totalOldCustomers = 0,
    this.totalNewCustomers = 0,
    this.rushHours = const AnalysisRushHours(),
  });

  factory WeeklyAnalysisOverview.fromMap(Map<String, dynamic> data) =>
      WeeklyAnalysisOverview(
        totalCustomers: data['total_customers'] ?? 0,
        totalOldCustomers: data['total_old_customers'] ?? 0,
        totalNewCustomers: data['total_new_customers'] ?? 0,
        rushHours: data['rush_hours'] == null
            ? const AnalysisRushHours()
            : AnalysisRushHours.fromMap(
                data['rush_hours'] as Map<String, dynamic>),
      );

  final int totalCustomers;
  final int totalOldCustomers;
  final int totalNewCustomers;
  final AnalysisRushHours rushHours;

  Map<String, dynamic> toMap() => {
        'total_customers': totalCustomers,
        'total_old_customers': totalOldCustomers,
        'total_new_customers': totalNewCustomers,
        'rush_hours': rushHours.toMap(),
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      totalCustomers,
      totalOldCustomers,
      totalNewCustomers,
      rushHours,
    ];
  }
}

class WeeklyAnalysisSales extends Equatable {
  const WeeklyAnalysisSales({
    this.totalOrders = 0,
    this.netEarning = 0,
    this.cancelOrderAmount = 0,
    this.penaltyAmountBySystem = 0,
    this.refundAmount = 0,
    this.deliverOrderAmount = 0,
  });

  factory WeeklyAnalysisSales.fromMap(Map<String, dynamic> data) =>
      WeeklyAnalysisSales(
        totalOrders: data['total_orders'] ?? 0,
        netEarning: data['net_earning'] ?? 0,
        cancelOrderAmount: data['cancel_order_amount'] ?? 0,
        penaltyAmountBySystem: data['penalty_amount_by_system'] ?? 0,
        refundAmount: data['refund_amount'] ?? 0,
        deliverOrderAmount: data['deliver_order_amount'] ?? 0,
      );

  final int totalOrders;
  final int netEarning;
  final int cancelOrderAmount;
  final int penaltyAmountBySystem;
  final int refundAmount;
  final int deliverOrderAmount;

  Map<String, dynamic> toMap() => {
        'total_orders': totalOrders,
        'net_earning': netEarning,
        'cancel_order_amount': cancelOrderAmount,
        'penalty_amount_by_system': penaltyAmountBySystem,
        'refund_amount': refundAmount,
        'deliver_order_amount': deliverOrderAmount,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      totalOrders,
      netEarning,
      cancelOrderAmount,
      penaltyAmountBySystem,
      refundAmount,
      deliverOrderAmount,
    ];
  }
}

class AnalysisRushDate extends Equatable {
  const AnalysisRushDate({this.fromDateTime, this.toDateTime});

  factory AnalysisRushDate.fromMap(Map<String, dynamic> data) =>
      AnalysisRushDate(
        fromDateTime: data['fromDateTime'] == null
            ? null
            : DateTime.parse(data['fromDateTime'] as String),
        toDateTime: data['toDateTime'] == null
            ? null
            : DateTime.parse(data['toDateTime'] as String),
      );

  final DateTime? fromDateTime;
  final DateTime? toDateTime;

  Map<String, dynamic> toMap() => {
        'fromDateTime': fromDateTime?.toIso8601String(),
        'toDateTime': toDateTime?.toIso8601String(),
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [fromDateTime, toDateTime];
}

class AnalysisRushHours extends Equatable {
  const AnalysisRushHours({this.fromTime = '', this.toTime = ''});

  factory AnalysisRushHours.fromMap(Map<String, dynamic> data) =>
      AnalysisRushHours(
        fromTime: data['fromTime'] ?? '',
        toTime: data['toTime'] ?? '',
      );

  final String fromTime;
  final String toTime;

  Map<String, dynamic> toMap() => {
        'fromTime': fromTime,
        'toTime': toTime,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [fromTime, toTime];
}

class WeeklyAnalysisTotalOrders extends Equatable {
  const WeeklyAnalysisTotalOrders({
    this.instant = 0,
    this.deliver = 0,
    this.total = 0,
    this.schedule = 0,
    this.cancel = 0,
  });

  factory WeeklyAnalysisTotalOrders.fromMap(Map<String, dynamic> data) =>
      WeeklyAnalysisTotalOrders(
        instant: data['instant'] ?? 0,
        deliver: data['deliver'] ?? 0,
        total: data['total'] ?? 0,
        schedule: data['schedule'] ?? 0,
        cancel: data['cancel'] ?? 0,
      );

  final int instant;
  final int deliver;
  final int total;
  final int schedule;
  final int cancel;

  Map<String, dynamic> toMap() => {
        'instant': instant,
        'deliver': deliver,
        'total': total,
        'schedule': schedule,
        'cancel': cancel,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [instant, deliver, total, schedule, cancel];
}
