import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_information_event.dart';
part 'bank_information_state.dart';
part 'bank_information_bloc.freezed.dart';

class BankInformationBloc extends Bloc<BankInformationEvent, BankInformationState> {
  BankInformationBloc() : super(const BankInformationInitial()) {
    on<BankInformationEvent>((event, emit) {
      // TODO(prasant): implement event handler
    });
  }
}
