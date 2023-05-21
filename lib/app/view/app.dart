import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homemakers_merchant/app/shared/service/connectivity_bloc/connectivity_bloc.dart';
import 'package:homemakers_merchant/app/shared/service/connectivity_bloc/src/widget/connectivity_app_wrapper.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/counter/counter.dart';
import 'package:homemakers_merchant/l10n/l10n.dart';
import 'package:homemakers_merchant/theme/flex_theme_dark.dart';
import 'package:homemakers_merchant/theme/flex_theme_light.dart';
import 'package:homemakers_merchant/theme/theme_code.dart';
import 'package:homemakers_merchant/theme/theme_controller.dart';

class App extends StatelessWidget {
  const App({super.key, required this.controller});
  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    // Whenever the theme controller notifies the listenable in the
    // ListenableBuilder, the MaterialApp is rebuilt.

    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>(
          key: const Key('connectivity_bloc_provider'),
          create: (context) => serviceLocator(),
        ),
      ],
      child: ListenableBuilder(
        listenable: controller,
        builder: (BuildContext context, Widget? child) {
          final materialLightTheme = flexThemeLight(controller);
          final materialDarkTheme = flexThemeDark(controller);

          const darkDefaultCupertinoTheme =
              CupertinoThemeData(brightness: Brightness.dark);
          final cupertinoDarkTheme = MaterialBasedCupertinoThemeData(
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
          );
          final cupertinoLightTheme = MaterialBasedCupertinoThemeData(
              materialTheme: materialLightTheme);
          return ConnectivityAppWrapper(
            showNetworkUpdates: true,
            persistNoInternetNotification: false,
            bottomInternetNotificationPadding: 16.0,
            disableInteraction: true,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Merchant',
              // The Theme controller controls if we use FlexColorScheme made
              // ThemeData or standard SDK ThemeData. It also
              // controls all the configuration parameters used to define the
              // FlexColorScheme object that produces the ThemeData object.
              theme: flexThemeLight(controller), //lightTheme(controller),
              darkTheme: flexThemeDark(controller), //darkTheme(controller),
              // Use the dark or light theme based on controller setting.
              themeMode: controller.themeMode,
              // If we wrap the entire app content in a SelectionArea, it would
              // makes text selectable and copy enabled in entire app.
              // How it actually behaves, depends on current
              // platform. Not using it for now, I was not happy with its behavior.
              // SelectionArea(child: ... );
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
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
                child: CounterPage(controller: controller),
              ),
            ),
          );
        },
      ),
    );
  }
}
