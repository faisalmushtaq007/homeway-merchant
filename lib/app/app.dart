import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/login_page.dart';
import 'package:homemakers_merchant/app/features/onboarding/presentation/pages/splash_page.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/user_model.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/manager/user_model_storage_controller.dart';
import 'package:homemakers_merchant/config/permission/permission_controller.dart';
import 'package:homemakers_merchant/config/permission/permission_service.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/translate_api.dart';
import 'package:homemakers_merchant/config/translation/widgets/constants.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_app_wrapper_widget.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/service/connectivity_bloc/connectivity_bloc.dart';
import 'package:homemakers_merchant/core/service/connectivity_bloc/src/widget/connectivity_app_wrapper.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/counter/counter.dart';
import 'package:homemakers_merchant/l10n/l10n.dart';
import 'package:homemakers_merchant/shared/widgets/app/activity_indicator.dart';
import 'package:homemakers_merchant/shared/widgets/universal/async_builder/async_builder.dart';
import 'package:homemakers_merchant/theme/flex_theme_dark.dart';
import 'package:homemakers_merchant/theme/flex_theme_light.dart';
import 'package:homemakers_merchant/theme/theme_code.dart';
import 'package:homemakers_merchant/theme/theme_controller.dart';
import 'package:homemakers_merchant/utils/multi/multi_listenable_buillder.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

class App extends StatefulWidget with GetItStatefulWidgetMixin {
  App({super.key, required this.themeController});

  final ThemeController themeController;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with GetItStateMixin {
  @override
  Widget build(BuildContext context) {
    // Whenever the theme controller notifies the listenable in the
    // ListenableBuilder, the MaterialApp is rebuilt.
    final PermissionController initPermissionController =
        get<PermissionController>();
    final UserModelStorageController initUserModelStorageController =
        get<UserModelStorageController>();
    final LanguageController initLanguageController = get<LanguageController>();

    final permissionController =
        watchOnly((PermissionController controller) => controller);
    final userModelStorageController =
        watchOnly((UserModelStorageController controller) => controller);
    final languageController =
        watchOnly((LanguageController controller) => controller);
    // TranslateApi init
    TranslateApi.instance
        .init(sourceLanguage: GlobalApp.defaultSourceTranslateLanguage);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>(
          key: const Key('connectivity_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
      ],
      child: MultiListenableBuilder(
        listenables: [
          widget.themeController,
          permissionController,
          userModelStorageController,
          languageController,
        ],
        builder: (BuildContext context, Widget? child) {
          final materialLightTheme = flexThemeLight(widget.themeController);
          final materialDarkTheme = flexThemeDark(widget.themeController);

          const darkDefaultCupertinoTheme =
              CupertinoThemeData(brightness: Brightness.dark);
          /*final cupertinoDarkTheme = MaterialBasedCupertinoThemeData(
            materialTheme: materialDarkTheme.copyWith(
              cupertinoOverrideTheme: CupertinoThemeData(
                brightness: Brightness.dark,
                barBackgroundColor:
                    darkDefaultCupertinoTheme.barBackgroundColor,
                textTheme: CupertinoTextThemeData(
                  primaryColor: Colors.white,
                  navActionTextStyle: darkDefaultCupertinoTheme
                      .textTheme.navActionTextStyle
                      .copyWith(
                    color: const Color(0xF0F9F9F9),
                  ),
                  navLargeTitleTextStyle: darkDefaultCupertinoTheme
                      .textTheme.navLargeTitleTextStyle
                      .copyWith(color: const Color(0xF0F9F9F9)),
                ),
              ),
            ),
          );*/
          final cupertinoLightTheme = MaterialBasedCupertinoThemeData(
            materialTheme: materialLightTheme,
          );
          final cupertinoDarkTheme =
              MaterialBasedCupertinoThemeData(materialTheme: materialDarkTheme);
          return ConnectivityAppWrapper(
            showNetworkUpdates: true,
            persistNoInternetNotification: false,
            bottomInternetNotificationPadding: 16.0,
            disableInteraction: true,
            child: LanguageAppWrapper(
              builder: (
                BuildContext context,
                LanguageModelStatus sourceLanguageModelStatus,
                LanguageDownloadStatus sourceLanguageDownloadStatus,
                NewLanguageDownloadStatus newLanguageDownloadStatus,
              ) {
                return PlatformProvider(
                  settings: PlatformSettingsData(
                    iosUsesMaterialWidgets: true,
                    iosUseZeroPaddingForAppbarPlatformIcon: true,
                  ),
                  builder: (context) => PlatformTheme(
                    themeMode: widget.themeController.themeMode,
                    materialLightTheme: materialLightTheme,
                    materialDarkTheme: materialDarkTheme,
                    cupertinoLightTheme: cupertinoLightTheme,
                    cupertinoDarkTheme: cupertinoDarkTheme,
                    matchCupertinoSystemChromeBrightness: true,
                    onThemeModeChanged: (themeMode) {
                      //this.themeMode = themeMode; /* you can save to storage */
                    },
                    builder: (context) => PlatformApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Merchant',
                      // Providing a restorationScopeId allows the Navigator built by the
                      // MaterialApp to restore the navigation stack when a user leaves and
                      // returns to the app after it has been killed while running in the
                      // background.
                      restorationScopeId: 'merchant_app',
                      localizationsDelegates: const <LocalizationsDelegate<
                          dynamic>>[
                        ...AppLocalizations.localizationsDelegates,
                        DefaultMaterialLocalizations.delegate,
                        DefaultWidgetsLocalizations.delegate,
                        DefaultCupertinoLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      locale: languageController.language.value,
                      supportedLocales: AppLocalizations.supportedLocales,
                      builder: (context, child) =>
                          ResponsiveBreakpoints.builder(
                        child: child!,
                        breakpoints: [
                          const Breakpoint(
                            start: 0,
                            end: 149,
                            name: 'XSMALLWATCH',
                          ),
                          const Breakpoint(
                            start: 150,
                            end: 320,
                            name: 'WATCH',
                          ),
                          const Breakpoint(
                            start: 321,
                            end: 399,
                            name: 'MEDIUMMOBILE',
                          ),
                          const Breakpoint(
                            start: 400,
                            end: 480,
                            name: 'LARGEMOBILE',
                          ),
                          const Breakpoint(
                            start: 481,
                            end: 600,
                            name: 'XSMALLTABLET',
                          ),
                          const Breakpoint(
                            start: 601,
                            end: 719,
                            name: 'MEDIUMTABLET',
                          ),
                          const Breakpoint(
                            start: 720,
                            end: 839,
                            name: 'LARGETABLET',
                          ),
                          const Breakpoint(
                            start: 840,
                            end: 959,
                            name: 'XLARGETABLET',
                          ),
                          const Breakpoint(
                            start: 960,
                            end: 1023,
                            name: 'NORMALDESKTOP',
                          ),
                          const Breakpoint(
                            start: 1024,
                            end: 1279,
                            name: 'MEDIUMDESKTOP',
                          ),
                          const Breakpoint(
                            start: 1440,
                            end: 1599,
                            name: 'LARGEDESKTOP',
                          ),
                          const Breakpoint(
                            start: 1600,
                            end: 1920,
                            name: 'XLARGEDESKTOP',
                          ),
                          const Breakpoint(
                            start: 1921,
                            end: double.infinity,
                            name: '4K',
                          ),
                        ],
                      ),
                      home: GestureDetector(
                        // This allows us to un-focus a widget, typically a TextField
                        // with focus by tapping somewhere outside it. It is no longer
                        // needed on desktop builds, it is done automatically there for
                        // TextField, but not on tablet and phone app. In this app we
                        // want it on them too and to unfocus other widgets with focus
                        // on desktop too.
                        onTap: () => FocusScope.of(context).unfocus(),
                        // Pass the controller to the HomePage where we use it to change
                        // the theme settings that will cause themes above to change and
                        // rebuild the entire look of the app based on modified theme.
                        //
                        // There are more than 250 properties in the controller that can
                        // be used to control the two light and dark mode themes.
                        // Every time one of them is modified, the themed app is rebuilt
                        // with the new ThemeData applied.
                        // The code that one need to use the same theme is also updated
                        // interactively for each change when the cod gent panel is
                        // in view.
                        child: LoginPage(
                          key: Key('login-page'),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
