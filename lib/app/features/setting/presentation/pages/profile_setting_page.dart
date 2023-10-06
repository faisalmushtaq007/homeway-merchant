part of 'package:homemakers_merchant/app/features/setting/index.dart';
class ProfileSettingPage extends StatefulWidget {
  const ProfileSettingPage({super.key});
  @override
  _ProfileSettingPageController createState() => _ProfileSettingPageController();
}
class _ProfileSettingPageController extends State<ProfileSettingPage> {
  late final ScrollController scrollController;
  late final ScrollController customScrollViewScrollController;
  late AppUserEntity appUserEntity;
  String userImagePath = '';
  bool hasSelectedDarkTheme=false;

  @override
  void initState() {
    appUserEntity=serviceLocator<AppUserEntity>();
    super.initState();
    scrollController = ScrollController();
    customScrollViewScrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    customScrollViewScrollController.dispose();
    super.dispose();
  }

  void updateUserProfileImage(String profileImage) {
    userImagePath = profileImage;
    setState(() {});
  }

  void switchToDarkTheme({bool value=false}){
    hasSelectedDarkTheme=value;
    setState(() {});
  }

  void onThemeChanged(ThemeMode value){
    serviceLocator<ThemeController>().setThemeMode(value);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) => _ProfileSettingPageView(this);
}
class _ProfileSettingPageView extends WidgetView<ProfileSettingPage, _ProfileSettingPageController> {
  const _ProfileSettingPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding =
        margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
        noAppBar: true,
      ),
      child: Directionality(
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('My Profile'),
            centerTitle: false,
            titleSpacing: 0,
            actions: [
              IconButton(
                onPressed: () async {
                  final notification = await context.push(Routes.NOTIFICATIONS);
                  return;
                },
                icon: Badge(
                  alignment: AlignmentDirectional.topEnd,
                  //padding: EdgeInsets.all(4),
                  backgroundColor: context.colorScheme.secondary,
                  largeSize: 16,
                  textStyle: const TextStyle(fontSize: 14),
                  textColor: Colors.yellow,
                  label: Text(
                    '10',
                    style: context.labelSmall!
                        .copyWith(color: context.colorScheme.onPrimary),
                    //Color.fromRGBO(251, 219, 11, 1)
                  ),
                  child: Icon(Icons.notifications,
                      color: context.colorScheme.primary),
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.only(end: 8),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          /*drawer: const PrimaryDashboardDrawer(
            key: const Key('transaction-page-drawer'),
            isMainDrawerPage: false,
          ),*/
          body: FadeInDown(
            key: const Key('profile-setting-page-slideinleft-widget'),
            from: context.width / 2 - 60,
            duration: const Duration(milliseconds: 500),
            child: Directionality(
              textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
              child: PageBody(
                controller: state.scrollController,
                constraints: BoxConstraints(
                  minWidth: 1000,
                  minHeight: media.size.height -
                      (media.padding.top +
                          kToolbarHeight +
                          media.padding.bottom),
                ),
                padding: EdgeInsetsDirectional.only(
                  top: topPadding,
                  //bottom: bottomPadding,
                  start: margins * 2.5,
                  end: margins * 2.5,
                ),
                child: CustomScrollView(
                  controller: state.customScrollViewScrollController,
                  shrinkWrap: true,
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          const AnimatedGap(6,
                              duration: Duration(milliseconds: 200)),
                          BigUserCard(
                            backgroundColor: Colors.red,
                            userName: "${(state.appUserEntity.isNotNull && state.appUserEntity!.businessProfile.isNotNull && !state.appUserEntity!.businessProfile!.userName.isEmptyOrNull) ? state.appUserEntity!.businessProfile!.userName : 'Hello User'}",
                            //userProfilePic: AssetImage("assets/image/app_logo_light.jpg"),
                            userProfileImageWidget: ImageHelper(
                              image: (state.appUserEntity.businessProfile.isNull && state.appUserEntity.businessProfile!.profileImageEntity.isNull)
                                  ? 'assets/svg/user_avatar.svg'
                                  : state.appUserEntity.businessProfile?.profileImageEntity?.originalFilePath??'assets/svg/user_avatar.svg',
                              filterQuality: FilterQuality.high,
                              borderRadius:
                              BorderRadiusDirectional.circular(10),
                              imageType: findImageType(
                                  (state.appUserEntity.businessProfile.isNull && state.appUserEntity.businessProfile!.profileImageEntity.isNull)
                                      ? 'assets/svg/user_avatar.svg'
                                      : state.appUserEntity.businessProfile?.profileImageEntity?.originalFilePath??'assets/svg/user_avatar.svg'),
                              imageShape: ImageShape.rectangle,
                              boxFit: BoxFit.cover,
                              defaultErrorBuilderColor: Colors.blueGrey,
                              errorBuilder: const Icon(
                                Icons.image_not_supported,
                                size: 10000,
                              ),
                              height: context.width/5,
                              width: context.width/5,
                              loaderBuilder:
                              const CircularProgressIndicator(),
                              matchTextDirection: true,
                              placeholderText:
                              "${(state.appUserEntity.isNotNull && state.appUserEntity!.businessProfile.isNotNull && !state.appUserEntity!.businessProfile!.userName.isEmptyOrNull) ? state.appUserEntity!.businessProfile!.userName : 'Hello User'}",
                              placeholderTextStyle:
                              context.labelLarge!.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            subTitle: "${(state.appUserEntity.isNotNull && state.appUserEntity!.businessProfile.isNotNull && !state.appUserEntity!.businessProfile!.businessName.isEmptyOrNull) ? state.appUserEntity!.businessProfile!.businessName : ''}",
                            customProfileImageWidget: DisplayImage(
                              imagePath: state.userImagePath,
                              onPressed: () async {
                                final result = await UploadImageUtils()
                                    .selectImagePicker(context);
                                if (result.imagePath.isNotEmpty) {
                                  state.updateUserProfileImage(
                                    result.metaData['filePath'],
                                  );
                                } else {}
                              },
                              hasIconImage:
                              state.userImagePath.isEmpty ? true : false,
                              hasEditButton:
                              state.userImagePath.isEmpty ? false : true,
                              hasCustomIcon:
                              state.userImagePath.isEmpty ? true : false,
                              customIcon: const Icon(Icons.camera_alt),
                              circularRadius: 36,
                              borderRadius: 36,
                              end: -2,
                              bottom: 1,
                              innerCircularRadius: state.userImagePath.isEmpty ? 32 : 40,
                            ),
                            cardActionWidget: SettingsItem(
                              hasDense: true,
                              icons: Icons.edit,
                              iconStyle: IconStyle(
                                borderRadius: 50,
                                backgroundColor: Colors.yellow[600],
                              ),
                              title: 'Modify',
                              titleStyle: context.titleMedium!.copyWith(),
                              subtitle: 'Tap to change your data',
                              onTap: () {
                                print('OK');
                              },
                            ),
                          ),
                          SettingsGroup(
                            //settingsGroupTitle: "Profile",
                            items: [
                              SettingsItem(
                                onTap: () {},
                                icons: FontAwesomeIcons.addressBook,
                                title: 'Address Book',
                                iconStyle: IconStyle(
                                  backgroundColor: context.colorScheme.tertiary,
                                ),
                              ),
                              SettingsItem(
                                onTap: () {},
                                icons: Icons.account_balance,
                                title: 'Payments',
                                iconStyle: IconStyle(
                                  backgroundColor: context.colorScheme.primary,
                                ),
                              ),

                              SettingsItem(
                                onTap: () {},
                                icons: CupertinoIcons.cloud_upload,
                                title: 'Documents',
                                iconStyle: IconStyle(
                                  backgroundColor: context.colorScheme.primary,
                                ),
                              ),
                              SettingsItem(
                                onTap: () {},
                                icons: CupertinoIcons.repeat,
                                title: 'Change Phone Number',
                                iconStyle: IconStyle(
                                  backgroundColor: context.colorScheme.error,
                                ),
                              ),

                              SettingsItem(
                                onTap: () {},
                                icons: CupertinoIcons.repeat,
                                title: 'Change email',
                                iconStyle: IconStyle(
                                  backgroundColor: context.colorScheme.error,
                                ),
                              ),
                            ],
                          ),
                          SettingsGroup(
                            settingsGroupTitle: 'Business',
                            items: [
                              SettingsItem(
                                onTap: () {},
                                icons: FontAwesomeIcons.bagShopping,
                                title: 'Your Orders',
                                iconStyle: IconStyle(
                                  backgroundColor: context.colorScheme.tertiary,
                                ),
                              ),
                              SettingsItem(
                                onTap: () {},
                                icons: FontAwesomeIcons.store,
                                title: 'Your Stores',
                                iconStyle: IconStyle(
                                  backgroundColor: context.colorScheme.primary,
                                ),
                              ),
                              SettingsItem(
                                onTap: () {},
                                icons: FontAwesomeIcons.burger,
                                title: 'Your Menu',
                                iconStyle: IconStyle(
                                  backgroundColor: context.colorScheme.primary,
                                ),
                              ),
                              SettingsItem(
                                onTap: () {},
                                icons: FontAwesomeIcons.users,
                                title: 'Your Drivers',
                                iconStyle: IconStyle(
                                  backgroundColor: context.colorScheme.tertiary,
                                ),
                              ),
                            ],
                          ),
                          SettingsGroup(
                            items: [
                              SettingsItem(
                                onTap: () {},
                                icons:Icons.notifications,
                                iconStyle: const IconStyle(),
                                title: 'Notification',
                                subtitle: 'Set your notification',
                                titleMaxLine: 1,
                                subtitleMaxLine: 1,
                              ),
                              SettingsItem(
                                onTap: () {},
                                icons: Icons.fingerprint,
                                iconStyle: const IconStyle(
                                  backgroundColor: Colors.red,
                                ),
                                title: 'Privacy',
                                subtitle: 'Improve your privacy',
                              ),
                              SettingsItem(
                                onTap: () {},
                                icons: Icons.dark_mode_rounded,
                                iconStyle: const IconStyle(
                                  backgroundColor: Colors.red,
                                ),
                                title: 'Dark mode',
                                subtitle: 'Automatic',
                                trailing: ThemeModeSwitch(
                                  key: const Key('theme-change-profile-setting-widget'),
                                  onChanged: state.onThemeChanged,
                                  themeMode: serviceLocator<ThemeController>().themeMode,
                                ),
                                /*trailing: Switch.adaptive(
                                  value: state.hasSelectedDarkTheme,
                                  onChanged: (value) {
                                    return state.switchToDarkTheme(value:value);
                                  },
                                ),*/
                              ),
                            ],
                          ),
                          SettingsGroup(
                            items: [
                              SettingsItem(
                                onTap: () {},
                                icons: Icons.help,
                                iconStyle: const IconStyle(
                                  backgroundColor: Colors.purple,
                                ),
                                title: 'Help & Support',
                                subtitle: 'Chat with us',
                              ),
                            ],
                          ),
                          SettingsGroup(
                            items: [
                              SettingsItem(
                                onTap: () {},
                                icons: Icons.info_rounded,
                                iconStyle: const IconStyle(
                                  backgroundColor: Colors.purple,
                                ),
                                title: 'About',
                                subtitle: 'About the HomeWay App',
                              ),
                            ],
                          ),

                          // You can add a settings title
                          SettingsGroup(
                            settingsGroupTitle: 'Account',
                            items: [
                              SettingsItem(
                                onTap: () {},
                                icons: CupertinoIcons.star_circle_fill,
                                title: 'Your Rating',
                                iconStyle: IconStyle(
                                  backgroundColor: context.colorScheme.error,
                                ),
                              ),
                              SettingsItem(
                                onTap: () {},
                                icons: Icons.exit_to_app_rounded,
                                title: 'Sign Out',
                                titleStyle: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}