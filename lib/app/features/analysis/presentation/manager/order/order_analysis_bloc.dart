import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homemakers_merchant/app/features/analysis/index.dart';

part 'order_analysis_event.dart';
part 'order_analysis_state.dart';

class OrderAnalysisBloc extends Bloc<OrderAnalysisEvent, OrderAnalysisState> {
  OrderAnalysisBloc() : super(OrderAnalysisInitial()) {
    on<OrderAnalysisEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
