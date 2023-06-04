import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/translate_api.dart';
import 'dart:async';
import 'dart:ui';

import 'package:homemakers_merchant/utils/universal_platform/src/universal_platform.dart';

class AppStartConfig {
  AppStartConfig._privateConstructor();

  static var shared = AppStartConfig._privateConstructor();

  Future<void> startApp() async {
    if (UniversalPlatform.isAndroid) {
      await FlutterDisplayMode.setHighRefreshRate();
    }
    await setupGetIt();
    await hasSourceTranslateLanguageDownload();
    return;
  }

  /// Indicates to the rest of the app that bootstrap has not completed.
  /// The router will use this to prevent redirects while bootstrapping.
  bool isBootstrapComplete = false;

  /// Indicates which orientations the app will allow be default. Affects Android/iOS devices only.
  /// Default s to both landscape (hz) and portrait (vt)
  List<Axis> supportedOrientations = [Axis.vertical, Axis.horizontal];

  /// Allow a view to override the currently supported orientations. For example, [FullscreenVideoViewer] always wants to enable both landscape and portrait.
  /// If a view sets this override, they are responsible for setting it back to null when finished.
  List<Axis>? _supportedOrientationsOverride;

  set supportedOrientationsOverride(List<Axis>? value) {
    if (_supportedOrientationsOverride != value) {
      _supportedOrientationsOverride = value;
      _updateSystemOrientation();
    }
  }

  /*Future<T?> showFullscreenDialogRoute<T>(BuildContext context, Widget child, {bool transparent = false}) async {
    return await Navigator.of(context).push<T>(
      PageRoutes.dialog<T>(child, duration: $styles.times.pageTransition),
    );
  }*/

  /// Enable landscape, portrait or both. Views can call this method to override the default settings.
  /// For example, the [FullscreenVideoViewer] always wants to enable both landscape and portrait.
  /// If a view overrides this, it is responsible for setting it back to [supportedOrientations] when disposed.
  void _updateSystemOrientation() {
    final axisList = _supportedOrientationsOverride ?? supportedOrientations;
    //debugPrint('updateDeviceOrientation, supportedAxis: $axisList');
    final orientations = <DeviceOrientation>[];
    if (axisList.contains(Axis.vertical)) {
      orientations.addAll([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    if (axisList.contains(Axis.horizontal)) {
      orientations.addAll([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    SystemChrome.setPreferredOrientations(orientations);
  }

  Future<void> hasSourceTranslateLanguageDownload() async {
    final bool hasDownloaded =
        await serviceLocator<TranslateApi>().isSourceModelDownloaded();
    if (hasDownloaded) {
      return;
    } else {
      // Start downloading
      await serviceLocator<TranslateApi>().startSourceModelDownload();
      // Listen downloading
/*      serviceLocator<TranslateApi>()
          .isolateManagerSourceModelDownload
          .onMessage
          .listen(
        (status) {
          if (status) {
            serviceLocator<LanguageController>()
                .hasSourceModelDownloadedSuccess = true;
            serviceLocator<LanguageController>().hasSourceModelDownloaded =
                true;
          } else {
            serviceLocator<LanguageController>()
                .hasSourceModelDownloadedSuccess = false;
            serviceLocator<LanguageController>().hasSourceModelDownloaded =
                false;
          }
          serviceLocator<TranslateApi>().stopSourceModelDownload();
        },
        onError: (e) {
          serviceLocator<LanguageController>().hasSourceModelDownloadedSuccess =
              false;
          serviceLocator<LanguageController>().hasSourceModelDownloaded = false;
          serviceLocator<TranslateApi>().stopSourceModelDownload();
        },
        onDone: () {
          serviceLocator<TranslateApi>().stopSourceModelDownload();
        },

      );*/
    }
  }

  Future<void> hasTargetTranslateLanguageDownload() async {
    final bool hasDownloaded =
        await serviceLocator<TranslateApi>().isTargetModelDownloaded();
    if (hasDownloaded) {
      return;
    } else {
      // Start downloading
      await serviceLocator<TranslateApi>().startTargetModelDownload();
      // Listen downloading
/*      serviceLocator<TranslateApi>()
          .isolateManagerTargetModelDownload
          .onMessage
          .listen(
        (status) {
          if (status) {
            serviceLocator<LanguageController>()
                .hasTargetModelDownloadedSuccess = true;
            serviceLocator<LanguageController>().hasTargetModelDownloaded =
                true;
          } else {
            serviceLocator<LanguageController>()
                .hasTargetModelDownloadedSuccess = false;
            serviceLocator<LanguageController>().hasTargetModelDownloaded =
                false;
          }
          serviceLocator<TranslateApi>().stopTargetModelDownload();
        },
        onError: (e) {
          serviceLocator<LanguageController>().hasTargetModelDownloadedSuccess =
              false;
          serviceLocator<LanguageController>().hasTargetModelDownloaded = false;
          serviceLocator<TranslateApi>().stopTargetModelDownload();
        },
        onDone: () {
          serviceLocator<TranslateApi>().stopTargetModelDownload();
        },

      );*/
    }
  }
}

class AppImageCache extends WidgetsFlutterBinding {
  @override
  ImageCache createImageCache() {
    this.imageCache.maximumSizeBytes = 250 << 20; // 250mb
    return super.createImageCache();
  }
}
