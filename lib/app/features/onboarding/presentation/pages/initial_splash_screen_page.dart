part of 'package:homemakers_merchant/app/features/onboarding/index.dart';

class InitialSplashScreenPage extends StatefulWidget {
  const InitialSplashScreenPage({super.key});

  @override
  _InitialSplashScreenPageController createState() =>
      _InitialSplashScreenPageController();
}

class _InitialSplashScreenPageController
    extends State<InitialSplashScreenPage> {
  bool isCurrentUserLoggedIn = false;
  String routeName = Routes.SPLASH;

  @override
  void initState() {
    super.initState();
  }

  Future<String> initialRoute() async {
    AppUserEntity cacheUserEntity =
        serviceLocator<UserModelStorageController>().userModel;
    if (cacheUserEntity.userID == -1) {
      // Return to splash
      return Routes.SPLASH;
    } else {
      // Get User Status
      final getCurrentUserStatus =
          await serviceLocator<GetUserStatusUseCase>()();

      return await getCurrentUserStatus.maybeWhen(
        orElse: () {
          return navigateToSpecificPageByUserStage(
            stage: serviceLocator<UserModelStorageController>()
                .userModel
                .currentUserStage,
            hasCurrentUserLoggedIn: cacheUserEntity.hasCurrentUser,
          );
        },
        remote: (authStatusModel, meta) async {
          // Get user profile
          final getUserProfileData =
              await serviceLocator<GetCurrentAppUserUseCase>()();
          //
          return await getUserProfileData.maybeWhen(
            orElse: () {
              return navigateToSpecificPageByUserStage(
                stage: serviceLocator<UserModelStorageController>()
                    .userModel
                    .currentUserStage,
                hasCurrentUserLoggedIn: cacheUserEntity.hasCurrentUser,
              );
            },
            remote: (data, meta) {
              final remoteUserEntity = data;
              remoteUserEntity?.copyWith(
                hasCurrentUser: true,
                currentUserStage: authStatusModel?.status,
                userID: authStatusModel?.uid,
              );
              serviceLocator<AppUserEntity>().updateEntity(remoteUserEntity);

              return navigateToSpecificPageByUserStage(
                stage: serviceLocator<UserModelStorageController>()
                    .userModel
                    .currentUserStage,
              );
            },
            error: (dataSourceFailure, reason, error, networkException,
                stackTrace, exception, extra) {
              appLog.d('GetCurrentAppUserUseCase Error $reason');

              return navigateToSpecificPageByUserStage(
                stage: serviceLocator<UserModelStorageController>()
                    .userModel
                    .currentUserStage,
                hasCurrentUserLoggedIn: cacheUserEntity.hasCurrentUser,
              );
            },
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('GetUserStatusUseCase Error $reason');

          return navigateToSpecificPageByUserStage(
            stage: serviceLocator<UserModelStorageController>()
                .userModel
                .currentUserStage,
            hasCurrentUserLoggedIn: cacheUserEntity.hasCurrentUser,
          );
        },
      );
    }
  }

  String navigateToSpecificPageByUserStage({
    required int stage,
    bool hasCurrentUserLoggedIn = true,
  }) {
    if (hasCurrentUserLoggedIn) {
      final int index = stage + 1;
      switch (index) {
        case 0:
          {
            routeName = Routes.AUTH_PHONE_NUMBER_VERIFICATION;
          }
        case 1:
          {
            routeName = Routes.CREATE_BUSINESS_PROFILE_PAGE;
          }
        case 2:
          {
            routeName = Routes.CONFIRM_BUSINESS_TYPE_PAGE;
          }
        case 3:
          {
            routeName = Routes.BANK_INFORMATION_PAGE;
          }
        case 4:
          {
            routeName = Routes.NEW_DOCUMENT_LIST_PAGE;
          }
        case 5:
          {
            routeName = Routes.PRIMARY_DASHBOARD_PAGE;
          }
        case 6:
          {
            routeName = Routes.MAIN_DASHBOARD_PAGE;
          }
        case _:
          {
            routeName = Routes.AUTH_PHONE_NUMBER_VERIFICATION;
          }
      }
      return routeName;
    } else {
      return Routes.SPLASH;
    }
  }

  @override
  Widget build(BuildContext context) => _InitialSplashScreenPageView(this);
}

class _InitialSplashScreenPageView extends WidgetView<InitialSplashScreenPage,
    _InitialSplashScreenPageController> {
  const _InitialSplashScreenPageView(super.state);

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      useImmersiveMode: true,
      duration: const Duration(seconds: 3),
      defaultNextScreen: const SplashPage(),
      onInit: () async {
        await state.initialRoute();
      },
      onEnd: () async {
        appLog.d('Initial screen onEnd ${state.routeName}');
        return context.pushReplacement(state.routeName);
      },
      setStateCallback: () {},
      backgroundColor: Colors.white,
      splashScreenBody: Center(
        child: Lottie.asset(
          "assets/lottie/initial_screen_loader.json",
          repeat: false,
        ),
      ),
    );
  }
}
