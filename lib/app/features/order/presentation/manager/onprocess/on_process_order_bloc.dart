import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'on_process_order_event.dart';
part 'on_process_order_state.dart';

class OnProcessOrderBloc extends Bloc<OnProcessOrderEvent, OnProcessOrderState> {
  OnProcessOrderBloc() : super(OnProcessOrderInitial()) {
    on<OnProcessOrderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
