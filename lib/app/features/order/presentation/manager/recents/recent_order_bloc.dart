import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recent_order_event.dart';
part 'recent_order_state.dart';

class RecentOrderBloc extends Bloc<RecentOrderEvent, RecentOrderState> {
  RecentOrderBloc() : super(RecentOrderInitial()) {
    on<RecentOrderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
