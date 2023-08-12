import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';
import 'package:meta/meta.dart';

part 'payment_bank_event.dart';
part 'payment_bank_state.dart';

class PaymentBankBloc extends Bloc<PaymentBankEvent, PaymentBankState> {
  PaymentBankBloc() : super(PaymentBankInitial()) {
    on<PaymentBankEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
