import 'dart:async';
import 'dart:io';

import 'package:ac_connectivity/flutter_internet_connectivity.dart' as ac;
import 'package:homemakers_merchant/app/shared/utils/essentials/essentials.dart';
import 'package:homemakers_merchant/bootstrap.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
export 'package:ac_connectivity/flutter_internet_connectivity.dart';
export 'package:homemakers_merchant/app/shared/utils/essentials/essentials.dart';

class ConnectivityService {
  //
  late ac.ConnectivityPlusState? _lastConnectivityPlusState;
  late ac.InternetConnectivityState? _lastInternetConnectivityState;
  CancelableTimer? _connectivityChecker;
  late StreamSubscription? _internetConnectivityStreamSubscription;
  late StreamSubscription? _connectivityPlusStreamSubscription;
  //
  StreamController<ac.InternetConnectivityState> offlineConnectivityController =
      StreamController<ac.InternetConnectivityState>.broadcast();

  Stream<ac.InternetConnectivityState> get offlineConnectivityStream =>
      offlineConnectivityController.stream;
  // initConnectivityService
  void initConnectivityService() {
    _lastConnectivityPlusState = ac.Connectivity().lastConnectivityPlusState;
    _lastInternetConnectivityState =
        ac.Connectivity().lastInetConnectivityState;

    _connectivityPlusStreamSubscription =
        ac.Connectivity().getConnectivityPlusStream().listen((state) {
      _lastConnectivityPlusState = state;
      log('_lastConnectivityPlusState : $state');
      isConnected();
    });
    _internetConnectivityStreamSubscription = ac.Connectivity().listen((state) {
      _lastInternetConnectivityState = state;
      log('_lastInternetConnectivityState $state');
      isConnected();
      if (state case ac.InternetConnectivityState.connected) {
      } else if (state case ac.InternetConnectivityState.disconnected) {
      } else if (state case ac.InternetConnectivityState.internet) {
        _connectivityChecker = CancelableTimer.periodic(
          const Duration(seconds: 60),
          (_) => ac.Connectivity().checkInetConnectivityState(),
          wait: true,
        );
      }
    });
  }

  void dispose() {
    _internetConnectivityStreamSubscription?.cancel();
    _connectivityPlusStreamSubscription?.cancel();
    _connectivityChecker?.cancel();
    _connectivityChecker = null;
  }

  (ac.ConnectivityPlusState?, ac.InternetConnectivityState?)
      getCurrentInternetStatus() {
    return (lastConnectivityPlusState, lastInternetConnectivityState);
  }

  Future<ac.ConnectivityPlusState> checkConnectivityPlusState() async {
    final ac.ConnectivityPlusState state =
        await ac.Connectivity().checkConnectivityPlusState();
    return state;
  }

  Future<ac.InternetConnectivityState> checkInetConnectivityState() async {
    final cancelableOperation = ac.Connectivity().checkInetConnectivityState(
      timeout: const Duration(seconds: 3),
    );

    final state = await cancelableOperation.value;
    return state;
  }

  void notifyConnectivityChange() {
    ac.Connectivity().notifyChange();
  }

  Stream<ac.ConnectivityPlusState> onConnectivityChanged() {
    return ac.Connectivity().getConnectivityPlusStream();
  }

  Stream<ac.InternetConnectivityState> onInternetConnectivityChanged() {
    return ac.Connectivity();
  }

  void isConnected() {
    (
      ac.ConnectivityPlusState? connectivity,
      ac.InternetConnectivityState? internetState
    ) states = getCurrentInternetStatus();
    var state = lastConnectivityPlusState;
    if (state == ac.ConnectivityResult.mobile ||
        state == ac.ConnectivityResult.wifi) {
      var state = _checkInternetConnectionAndShowStatus();
      offlineConnectivityController.add(state);
    } else {
      offlineConnectivityController
          .add(ac.InternetConnectivityState.disconnected);
    }
    return;
  }

  ac.InternetConnectivityState _checkInternetConnectionAndShowStatus() {
    try {
      var state = lastInternetConnectivityState;
      if (state case ac.InternetConnectivityState.connected) {
        return ac.InternetConnectivityState.connected;
      } else if (state case ac.InternetConnectivityState.disconnected) {
        return ac.InternetConnectivityState.disconnected;
      } else {
        return ac.InternetConnectivityState.internet;
      }
    } on SocketException catch (_) {
      return ac.InternetConnectivityState.disconnected;
    }
  }

  ac.ConnectivityPlusState? get lastConnectivityPlusState =>
      _lastConnectivityPlusState;

  ac.InternetConnectivityState? get lastInternetConnectivityState =>
      _lastInternetConnectivityState;

  StreamSubscription? get internetConnectivityStreamSubscription =>
      _internetConnectivityStreamSubscription;

  StreamSubscription? get connectivityPlusStreamSubscription =>
      _connectivityPlusStreamSubscription;
  CancelableTimer? get connectivityChecker => _connectivityChecker; //
}
