import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homemakers_merchant/app/features/order/index.dart';
import 'package:homemakers_merchant/core/common/enum/generic_enum.dart';
import 'package:sembast/timestamp.dart';

part 'deliver_order_event.dart';
part 'deliver_order_state.dart';

class DeliverOrderBloc extends Bloc<DeliverOrderEvent, DeliverOrderState> {
  DeliverOrderBloc() : super(DeliverInitial()) {
    on<DeliverOrderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
