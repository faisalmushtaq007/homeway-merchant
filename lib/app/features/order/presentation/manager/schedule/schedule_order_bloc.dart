import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homemakers_merchant/app/features/order/index.dart';
import 'package:homemakers_merchant/core/common/enum/generic_enum.dart';
import 'package:sembast/timestamp.dart';

part 'schedule_order_event.dart';
part 'schedule_order_state.dart';

class ScheduleOrderBloc extends Bloc<ScheduleOrderEvent, ScheduleOrderState> {
  ScheduleOrderBloc() : super(ScheduleOrderInitial()) {
    on<ScheduleOrderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
