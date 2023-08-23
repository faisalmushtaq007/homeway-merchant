import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homemakers_merchant/app/features/order/index.dart';
import 'package:homemakers_merchant/core/common/enum/generic_enum.dart';
import 'package:sembast/timestamp.dart';

part 'on_process_order_event.dart';
part 'on_process_order_state.dart';

class OnProcessOrderBloc extends Bloc<OnProcessOrderEvent, OnProcessOrderState> {
  OnProcessOrderBloc() : super(OnProcessOrderInitial()) {
    on<OnProcessOrderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
