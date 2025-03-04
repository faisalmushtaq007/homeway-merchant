import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:homemakers_merchant/app/features/address/presentation/manager/address_bloc.dart';
import 'package:homemakers_merchant/app/features/analysis/presentation/manager/order/order_analysis_bloc.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/manager/otp_verification/otp_verification_bloc.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/manager/phone_number_verification_bloc.dart';
import 'package:homemakers_merchant/app/features/menu/index.dart';
import 'package:homemakers_merchant/app/features/order/index.dart';
import 'package:homemakers_merchant/app/features/order/presentation/manager/all/all_order_bloc.dart';
import 'package:homemakers_merchant/app/features/order/presentation/manager/cancel/cancel_order_bloc.dart';
import 'package:homemakers_merchant/app/features/order/presentation/manager/deliver/deliver_order_bloc.dart';
import 'package:homemakers_merchant/app/features/order/presentation/manager/new/new_order_bloc.dart';
import 'package:homemakers_merchant/app/features/order/presentation/manager/onprocess/on_process_order_bloc.dart';
import 'package:homemakers_merchant/app/features/order/presentation/manager/recents/recent_order_bloc.dart';
import 'package:homemakers_merchant/app/features/order/presentation/manager/schedule/schedule_order_bloc.dart';
import 'package:homemakers_merchant/app/features/payment/presentation/manager/wallet/wallet_bloc.dart';
import 'package:homemakers_merchant/app/features/permission/presentation/bloc/permission_bloc.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/manager/bank/payment_bank_bloc.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/manager/document/bloc/new_business_document_bloc.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/manager/document/business_document_bloc.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/manager/profile/business_profile_bloc.dart';
import 'package:homemakers_merchant/app/features/store/presentation/manager/store_bloc.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/permission/permission_controller.dart';
import 'package:homemakers_merchant/config/translation/language.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_app_wrapper_widget.dart';
import 'package:homemakers_merchant/core/service/connectivity_bloc/connectivity_bloc.dart';
import 'package:homemakers_merchant/core/service/connectivity_bloc/src/widget/connectivity_app_wrapper.dart';
import 'package:homemakers_merchant/l10n/l10n.dart';
import 'package:homemakers_merchant/shared/router/app_pages.dart';
import 'package:homemakers_merchant/shared/widgets/universal/one_context/one_context.dart';
import 'package:homemakers_merchant/shared/widgets/universal/phone_number_text_field/phone_form_field_bloc.dart';
import 'package:homemakers_merchant/shared/widgets/universal/wrap_and_more/src/wrap_and_more_controller.dart';
import 'package:homemakers_merchant/theme/flex_theme_dark.dart';
import 'package:homemakers_merchant/theme/flex_theme_light.dart';
import 'package:homemakers_merchant/theme/theme_controller.dart';
import 'package:homemakers_merchant/utils/multi/multi_listenable_buillder.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:toastification/toastification.dart';

class App extends StatefulWidget with GetItStatefulWidgetMixin {
  App({required this.themeController, super.key});

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
    final ThemeController initThemeController = get<ThemeController>();
    final WrapAndMoreController initWrapAndMoreController =
        get<WrapAndMoreController>();
    final ManageOrderController initManageOrderController =
        get<ManageOrderController>();

    final permissionController =
        watchOnly((PermissionController controller) => controller);
    final userModelStorageController =
        watchOnly((UserModelStorageController controller) => controller);
    final languageController =
        watchOnly((LanguageController controller) => controller);
    final themeController =
        watchOnly((ThemeController controller) => controller);
    final wrapAndMoreController =
        watchOnly((WrapAndMoreController controller) => controller);
    final manageOrderController =
        watchOnly((ManageOrderController controller) => controller);

    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>(
          key: const Key('connectivity_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<PhoneFormFieldBloc>(
          key: const Key('phone_form_field_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<PhoneNumberVerificationBloc>(
          key: const Key('phone_number_verification_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<OtpVerificationBloc>(
          key: const Key('otp_verification_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<PermissionBloc>(
          key: const Key('permission_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<BusinessDocumentBloc>(
          key: const Key('business_document_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<PaymentBankBloc>(
          key: const Key('payment_bank_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<StoreBloc>(
          key: const Key('store_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<MenuBloc>(
          key: const Key('menu_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<BusinessProfileBloc>(
          key: const Key('business_profile_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<AddressBloc>(
          key: const Key('address_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<WalletBloc>(
          key: const Key('wallet_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<AllOrderBloc>(
          key: const Key('all_order__bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<RecentOrderBloc>(
          key: const Key('recent_order_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<CancelOrderBloc>(
          key: const Key('cance_order_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<DeliverOrderBloc>(
          key: const Key('deliver_order_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<NewOrderBloc>(
          key: const Key('new_order_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<ScheduleOrderBloc>(
          key: const Key('schedule_order_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<OnProcessOrderBloc>(
          key: const Key('onprocess_order_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<NewBusinessDocumentBloc>(
          key: const Key('newBusiness_document_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
        BlocProvider<OrderAnalysisBloc>(
          key: const Key('order_analysis_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
      ],
      child: MultiListenableBuilder(
        listenables: [
          themeController,
          permissionController,
          userModelStorageController,
          languageController,
          wrapAndMoreController,
          manageOrderController,
        ],
        builder: (BuildContext context, Widget? child) {
          final materialLightTheme = flexThemeLight(themeController);
          final materialDarkTheme = flexThemeDark(themeController);

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
          // Connectivity app wrapper
          return ConnectivityAppWrapper(
            showNetworkUpdates: true,
            bottomInternetNotificationPadding: 16,
            disableInteraction: true,
            // Language app wrapper
            child: LanguageAppWrapper(
              builder: (
                BuildContext context,
                Map<TranslateLanguage, Language> allLanguages,
                Map<TranslateLanguage, Language> arabicLanguages,
              ) {
                // Platform provider
                return PlatformProvider(
                  settings: PlatformSettingsData(
                    iosUsesMaterialWidgets: true,
                    iosUseZeroPaddingForAppbarPlatformIcon: true,
                  ),
                  builder: (context) => PlatformTheme(
                    themeMode: themeController.themeMode,
                    materialLightTheme: materialLightTheme,
                    materialDarkTheme: materialDarkTheme,
                    cupertinoLightTheme: cupertinoLightTheme,
                    cupertinoDarkTheme: cupertinoDarkTheme,
                    onThemeModeChanged: (themeMode) {
                      //this.themeMode = themeMode; /* you can save to storage */
                    },
                    builder: (context) => Directionality(
                      textDirection: serviceLocator<LanguageController>()
                          .targetTextDirection,
                      child: PlatformApp.router(
                        debugShowCheckedModeBanner: false,
                        title: 'Merchant',
                        // Providing a restorationScopeId allows the Navigator built by the
                        // MaterialApp to restore the navigation stack when a user leaves and
                        // returns to the app after it has been killed while running in the
                        // background.
                        restorationScopeId: 'merchant_app',
                        localizationsDelegates: const [
                          ...AppLocalizations.localizationsDelegates,
                          DefaultMaterialLocalizations.delegate,
                          DefaultWidgetsLocalizations.delegate,
                          DefaultCupertinoLocalizations.delegate,
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                          SfGlobalLocalizations.delegate,
                          ...PhoneFieldLocalization.delegates,
                        ],
                        locale: languageController.targetAppLanguage.value,
                        supportedLocales: AppLocalizations.supportedLocales,
                        builder: (context, child) {
                          return Directionality(
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            child: ResponsiveBreakpoints.builder(
                              child: Builder(builder: (context) {
                                final widget = ToastificationConfigProvider(
                                  config: ToastificationConfig(
                                    alignment: Alignment.bottomCenter,
                                    itemWidth: 440,
                                    animationDuration:
                                        Duration(milliseconds: 500),
                                  ),
                                  child: child!,
                                );
                                return OneContext().builder(context, widget);
                              }),
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
                          );
                        },
                        routerConfig: AppRouter.router,
                        //routeInformationParser: AppPages.router.routeInformationParser,
                        //routerDelegate: AppPages.router.routerDelegate,
                        //routeInformationProvider: AppRouter.router.routeInformationProvider,
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
