import 'package:ac_connectivity/flutter_internet_connectivity.dart';
import 'package:flutter/widgets.dart';

typedef ConnectivityWidgetBuilder = Widget Function(
    BuildContext context,
    ConnectivityPlusState? status,
    InternetConnectivityState internetStatus,
    String? message);

typedef ConnectivityBuilder = void Function(ConnectivityPlusState? status,
    InternetConnectivityState internetStatus, String? message);
