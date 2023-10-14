part of 'package:homemakers_merchant/app/features/onboarding/index.dart';
class InitialSplashScreenPage extends StatefulWidget {
  const InitialSplashScreenPage({super.key});
  @override
  _InitialSplashScreenPageController createState() => _InitialSplashScreenPageController();
}
class _InitialSplashScreenPageController extends State<InitialSplashScreenPage> {
  bool isCurrentUserLoggedIn=false;
  String routeName=Routes.SPLASH;

  @override
  void initState() {
    super.initState();
  }

  Future<String> initialRoute() async {
    AppUserEntity cacheUserEntity = serviceLocator<UserModelStorageController>().userModel;
    if(cacheUserEntity.userID==-1){
      //
      final getCurrentUserResult = await serviceLocator<GetAllAppUserPaginationUseCase>()(
        pageSize: 10,
        pageKey: 0,
        entity: AppUserEntity(hasCurrentUser: true,),
      );
      //
      await getCurrentUserResult.when(
        remote: (data, meta) {
          if (data.isNotNullOrEmpty) {
            serviceLocator<AppUserEntity>().updateEntity(data!.last);
            appLog.d('Remote User Info ${data!.last.toMap()}');
          }
        },
        localDb: (data, meta) {
          if (data.isNotNullOrEmpty) {
            serviceLocator<AppUserEntity>().updateEntity(data!.last);

            appLog.d('Local User Info ${data!.last.toMap()}');
          }
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Error $reason');
        },
      );
      cacheUserEntity=serviceLocator<AppUserEntity>();
    }
    bool hasCurrentUserLoggedIn = cacheUserEntity.hasCurrentUser;
    appLog.d('Current Status ${hasCurrentUserLoggedIn}, ${cacheUserEntity.currentUserStage}');
    isCurrentUserLoggedIn=hasCurrentUserLoggedIn;
    if (hasCurrentUserLoggedIn) {
      final int index = cacheUserEntity.currentUserStage + 1;
      switch (index) {
        case 1:
          {
            routeName= Routes.CREATE_BUSINESS_PROFILE_PAGE;
          }
        case 2:
          {
            routeName=  Routes.CONFIRM_BUSINESS_TYPE_PAGE;
          }
        case 3:
          {
            routeName=  Routes.BANK_INFORMATION_PAGE;
          }
        case 4:
          {
            routeName=  Routes.NEW_DOCUMENT_LIST_PAGE;
          }
        case 5:
          {
            routeName=  Routes.CHANGE_PHONE_NUMBER_PAGE;
          }
        case _:
          {
            routeName=  Routes.MAIN_DASHBOARD_PAGE;
          }
      }
      return routeName;
    }else{
      return Routes.SPLASH;
    }
  }

  @override
  Widget build(BuildContext context) => _InitialSplashScreenPageView(this);
}
class _InitialSplashScreenPageView extends WidgetView<InitialSplashScreenPage, _InitialSplashScreenPageController> {
  const _InitialSplashScreenPageView(super.state);
@override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      useImmersiveMode: true,
      duration: const Duration(seconds: 3),
      defaultNextScreen: const SplashPage(),
      onInit: () async{
        await state.initialRoute();
      },
      onEnd:() async{
        appLog.d('Initial screen onEnd ${state.routeName}');
        return context.pushReplacement(state.routeName);
      },
      setStateCallback: () {

      },
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
