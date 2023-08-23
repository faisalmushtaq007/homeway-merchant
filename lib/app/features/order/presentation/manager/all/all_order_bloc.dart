import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homemakers_merchant/app/features/order/index.dart';
import 'package:homemakers_merchant/core/common/enum/generic_enum.dart';
import 'package:sembast/timestamp.dart';

part 'all_order_event.dart';
part 'all_order_state.dart';

class AllOrderBloc extends Bloc<AllOrderEvent, AllOrderState> {
  AllOrderBloc() : super(AllOrderInitial()) {
    on<AllOrderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
