import 'dart:async';

import 'package:ac_connectivity/flutter_internet_connectivity.dart' as ac;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';

import 'connectivity_service.dart';

part 'connectivity_event.dart';

part 'connectivity_state.dart';

part 'connectivity_enum.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  StreamSubscription? subscription;
  ac.ConnectivityPlusState? _lastConnectivityPlusState;
  ac.InternetConnectivityState? _lastInetConnectivityState;
  StreamSubscription? _inetConnectivityStreamSubscription;
  StreamSubscription? _connectivityPlusStreamSubscription;

  ConnectivityBloc() : super(ConnectivityInitialState()) {
    on<OnConnectivityEvent>((event, emit) => emit(ConnectivityConnectedState(
          connectivityStatus: event.connectivityStatus,
          connectivityResult: event.connectivityResult,
        )));
    on<OnNotConnectivityEvent>(
        (event, emit) => emit(ConnectivityDisconnectedState(
              connectivityStatus: event.connectivityStatus,
              connectivityResult: event.connectivityResult,
            )));
    on<OnWeakConnectivityEvent>(
        (event, emit) => emit(ConnectivityWeakConnectedState(
              connectivityStatus: event.connectivityStatus,
              connectivityResult: event.connectivityResult,
            )));

    // ac
    _lastConnectivityPlusState =
        serviceLocator<ConnectivityService>().lastConnectivityPlusState;
    _lastInetConnectivityState =
        serviceLocator<ConnectivityService>().lastInternetConnectivityState;

    _connectivityPlusStreamSubscription = serviceLocator<ConnectivityService>()
        .onConnectivityChanged()
        .listen((state) {
      _lastConnectivityPlusState = state;
    });

    _inetConnectivityStreamSubscription = serviceLocator<ConnectivityService>()
        .onInternetConnectivityChanged()
        .listen((state) {
      _lastInetConnectivityState = state;
      if (state case ac.InternetConnectivityState.connected) {
        add(OnWeakConnectivityEvent(
            connectivityResult:
                _lastConnectivityPlusState ?? ac.ConnectivityPlusState.mobile,
            connectivityStatus:
                InternetConnectivityStatus.connectedButNotInternet));
      } else if (state case ac.InternetConnectivityState.disconnected) {
        add(OnNotConnectivityEvent(
            connectivityResult:
                _lastConnectivityPlusState ?? ac.ConnectivityPlusState.none,
            connectivityStatus: InternetConnectivityStatus.noConnected));
      } else if (state case ac.InternetConnectivityState.internet) {
        add(OnConnectivityEvent(
            connectivityResult:
                _lastConnectivityPlusState ?? ac.ConnectivityPlusState.mobile,
            connectivityStatus: InternetConnectivityStatus.connected));
      }
    });
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    _inetConnectivityStreamSubscription?.cancel();
    _connectivityPlusStreamSubscription?.cancel();
    return super.close();
  }
}
