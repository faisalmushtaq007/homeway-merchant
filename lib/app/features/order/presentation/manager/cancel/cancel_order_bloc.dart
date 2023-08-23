import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homemakers_merchant/app/features/order/index.dart';
import 'package:homemakers_merchant/core/common/enum/generic_enum.dart';
import 'package:sembast/timestamp.dart';

part 'cancel_order_event.dart';
part 'cancel_order_state.dart';

class CancelOrderBloc extends Bloc<CancelOrderEvent, CancelOrderState> {
  CancelOrderBloc() : super(CancelOrderInitial()) {
    on<CancelOrderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
