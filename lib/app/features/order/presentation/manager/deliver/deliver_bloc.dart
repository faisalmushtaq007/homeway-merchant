import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homemakers_merchant/app/features/order/index.dart';
import 'package:sembast/timestamp.dart';

part 'deliver_event.dart';
part 'deliver_state.dart';

class DeliverBloc extends Bloc<DeliverEvent, DeliverState> {
  DeliverBloc() : super(DeliverInitial()) {
    on<DeliverEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
