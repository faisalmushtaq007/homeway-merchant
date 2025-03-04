import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:network_manager/src/connectivity_service.dart';
import 'package:network_manager/src/injection/injection_container.dart';
import 'package:network_manager/src/utility/padding/page_padding.dart';
import 'package:network_manager/src/utility/widget/border/top_rectangle_border.dart';

class NoNetworkManager {
  NoNetworkManager(
      {required this.context,
      required this.onRetry,
      this.isEnable = false,
      this.customNoNetwork});
  final BuildContext? context;
  final void Function()? onRetry;
  final bool isEnable;
  final _lottiePath = 'assets/lottie/lottie_no_network.json';
  final _packageName = 'network_manager';
  final Widget Function(void Function()? onRetry)? customNoNetwork;

  Future<void> show() async {
    if (!isEnable) return;
    if (context == null) return;
    if (await _checkConnectivity()) return;

    await showModalBottomSheet<void>(
      context: context!,
      shape: const TopRectangleBorder(),
      builder: (context) {
        if (customNoNetwork != null) {
          return customNoNetwork!(onRetry);
        }
        return _NoNetworkWidget(
            lottiePath: _lottiePath,
            packageName: _packageName,
            onRetry: onRetry);
      },
    );
  }

  Future<bool> _checkConnectivity() async {
    bool status = true;
    serviceLocator<ConnectivityService>()
        .offlineConnectivityStream
        .listen((state) {
      if (state case InternetConnectivityState.internet) {
        status = true;
      }
      status = false;
    });
    return status;
    /*final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) return false;
    return true;*/
  }
}

abstract class CustomNoNetworkWidget {
  Widget get child;
  Future<void> Function()? onRetry;
}

mixin CustomRetryMixin on StatelessWidget {
  VoidCallback? get onRetry;
}

class ClassName {}

class _NoNetworkWidget extends StatelessWidget with CustomRetryMixin {
  const _NoNetworkWidget({
    super.key,
    required String lottiePath,
    required String packageName,
    required this.onRetry,
  })  : _lottiePath = lottiePath,
        _packageName = packageName;

  final String _lottiePath;
  final String _packageName;
  @override
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: LottieBuilder.asset(_lottiePath, package: _packageName)),
          Padding(
            padding: const PagePadding.horizontal(),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                onRetry?.call();
              },
              child: const Center(
                child: Icon(Icons.refresh),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
