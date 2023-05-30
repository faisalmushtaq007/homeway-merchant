import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/permission/permission_controller.dart';
import 'package:homemakers_merchant/config/permission/permission_service.dart';
import 'package:homemakers_merchant/config/permission/permission_service.dart';
import 'package:homemakers_merchant/core/mixins/lifecycle_mixin.dart';
import 'package:homemakers_merchant/utils/app_scroll_behavior.dart';
import 'package:homemakers_merchant/counter/counter.dart';
import 'package:homemakers_merchant/l10n/l10n.dart';
import 'package:homemakers_merchant/theme/theme_controller.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key, this.controller});

  final ThemeController? controller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: CounterView(controller: controller),
    );
  }
}

class CounterView extends StatefulWidget with GetItStatefulWidgetMixin {
  CounterView({super.key, required this.controller});

  final ThemeController? controller;

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView>
    with GetItStateMixin, LifecycleMixin {
  final permissionController = serviceLocator<PermissionController>();
  bool _isAppInBackground = false;
  @override
  void initState() {
    super.initState();
    initPermission();
  }

  Future<void> initPermission() async {
    if (await serviceLocator<IPermissionService>().requestLocationService()) {
      final (Permission, PermissionStatus) permissionCall =
          await serviceLocator<IPermissionService>().checkPermission(
        Permission.locationWhenInUse,
      );
      log('Status - ${permissionCall.$2}');
      switch (permissionCall.$2) {
        case PermissionStatus.denied:
          {
            log('Denied');
            permissionController.setLocationWhenInUsePermission(
              permissionCall.$2,
            );
          }
        case PermissionStatus.granted || PermissionStatus.limited:
          {
            final loc.Location location = loc.Location();
            final loc.LocationData locationData = await location.getLocation();
            log('Your location ${locationData.latitude}, ${locationData.longitude}');
          }
        case PermissionStatus.permanentlyDenied:
          {
            log('permanentlyDenied');
            await serviceLocator<IPermissionService>().openAppSetting(
              androidBuilder: (openSettingsPlusAndroid) async {
                //final status = await openSettingsPlusAndroid.applicationDetails();
                final bool hasOpened = await openAppSettings();
                //await initPermission();
              },
              iOSBuilder: (openSettingsPlusIOS) async {
                //final status = await openSettingsPlusIOS.settings();
                final bool hasOpened = await openAppSettings();
                //await initPermission();
              },
            );
          }
        case PermissionStatus.restricted:
          {
            log('Os restricted');
          }
      }
    } else {
      // User enable location service
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ScrollConfiguration(
      behavior: const DragScrollBehavior(),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
        body: SafeArea(child: const Center(child: CounterText())),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => context.read<CounterCubit>().increment(),
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 8),
            FloatingActionButton(
              onPressed: () => context.read<CounterCubit>().decrement(),
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onPause() {
    if (_isAppInBackground) return;
    _isAppInBackground = true;
  }

  @override
  void onResume() {
    if (!_isAppInBackground) return;
    _isAppInBackground = false;
    initPermission();
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((CounterCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.displayLarge);
  }
}
