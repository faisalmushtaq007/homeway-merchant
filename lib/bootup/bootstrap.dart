import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemakers_merchant/app/app.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/theme/theme_service.dart';
import 'package:homemakers_merchant/theme/theme_service_hive.dart';
import 'package:homemakers_merchant/theme/theme_service_prefs.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';
import 'package:homemakers_merchant/bootup/app_start_config.dart';
import 'package:homemakers_merchant/l10n/l10n.dart';
import 'package:homemakers_merchant/theme/theme_code.dart';
import 'package:homemakers_merchant/theme/theme_controller.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:developer' as dev;

import 'package:app_runner/app_runner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:homemakers_merchant/utils/app_log.dart';

void log(
  Object? message, {
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  String name = '',
  Zone? zone,
  Object? error,
  StackTrace? stackTrace,
}) {
  dev.log(
    message?.toString() ?? '',
    time: time,
    sequenceNumber: sequenceNumber,
    level: level,
    name: name,
    zone: zone,
    error: error,
    stackTrace: stackTrace,
  );
}

class CustomWidgetsFlutterBinding extends WidgetsFlutterBinding {
  // @override
  // ViewConfiguration createViewConfiguration() {
  //   const double ratio = 4.0;
  //   return ViewConfiguration(
  //     size: window.physicalSize / ratio,
  //     devicePixelRatio: ratio,
  //   );
  // }
}

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) appLog.i('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    appLog.e('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    appLog.i('onTransition(${bloc.runtimeType}, $transition)');
  }
}

Future<void> bootstrap(FutureOr<dynamic> Function() builder) async {
  FlutterError.onError = (details) {
    appLog.e(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();
  await Zone.current.fork().run(() async {
    final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    GestureBinding.instance.resamplingEnabled = true;
    final ui.RootIsolateToken rootIsolateToken = ui.RootIsolateToken.instance!;
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
    // Portrait Orientation
    await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp],
    );
    // Keep native splash screen up until app is finished bootstrapping
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    // AppStartConfig
    serviceLocator.allowReassignment = true;
    await AppStartConfig.shared.startApp();
    await builder();
    //final ThemeService themeService = ThemeServicePrefs();
    //final ThemeService themeService = ThemeServiceHive('app_color_scheme_box');
    // Initialize the theme service.
    //await themeService.init();
    // Create a ThemeController that uses the ThemeService.
    //final ThemeController themeController = ThemeController(themeService);
    // Load preferred theme settings, while the app is loading, before MaterialApp
    // is created, this prevents a theme change when the app is first displayed.
    //await themeController.loadAll();
    // Only use Google fonts via asset provided fonts.
    GoogleFonts.config.allowRuntimeFetching = true;
    GoRouter.optionURLReflectsImperativeAPIs = true;
    runApp(
      App(
        themeController: serviceLocator<ThemeController>(),
      ),
    );
    // Remove splash screen when bootstrap is complete
    FlutterNativeSplash.remove();
  });
}
