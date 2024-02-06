part of 'package:homemakers_merchant/app/features/dashboard/index.dart';

class PrimaryDashboardDrawer extends StatefulWidget {
  const PrimaryDashboardDrawer({
    super.key,
    this.isMainDrawerPage = true,
  });

  final bool isMainDrawerPage;

  @override
  _PrimaryDashboardDrawerController createState() =>
      _PrimaryDashboardDrawerController();
}

class _PrimaryDashboardDrawerController extends State<PrimaryDashboardDrawer> {
  List<DrawerEntity> drawerEntities = [];
  late AppUserEntity appUserEntity;

  @override
  void initState() {
    super.initState();
    appUserEntity = serviceLocator<AppUserEntity>();
    drawerEntities = [];
    drawerEntities.clear();
    context
        .read<BusinessProfileBloc>()
        .add(const GetAllAppUserProfilePagination(pageKey: 0, pageSize: 10));
    if (mounted) {
      initializeDrawerMenu(context);
    }
  }

  void onThemeChanged(ThemeMode value) {
    serviceLocator<ThemeController>().setThemeMode(value);
    setState(() {});
  }

  void initializeDrawerMenu(BuildContext context) {
    drawerEntities = [
      DrawerEntity(
        drawerID: 0,
        drawerName: 'Profile',
        hasExpanded: true,
        leading: const Icon(Icons.settings),
        controller: ExpansionTileController(),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        onPressed: () {
          return Navigator.of(context).pop();
        },
        children: [
          DrawerEntity(
            drawerID: 01,
            drawerName: 'My Profile',
            leading: const Icon(Icons.person),
            onPressed: () async {
              Navigator.of(context).pop();
              final result = await context.push(Routes.PROFILE_SETTING_PAGE);
              return;
            },
          ),
          DrawerEntity(
            drawerID: 07,
            drawerName: 'Saved Address',
            leading: const Icon(Icons.person),
            onPressed: () async {
              Navigator.of(context).pop();
              final result = await context.push(Routes.ALL_SAVED_ADDRESS_LIST);
              return;
            },
          ),
          DrawerEntity(
            drawerID: 02,
            drawerName: 'Theme',
            leading: const Icon(Icons.dark_mode),
            onPressed: () {
              return Navigator.of(context).pop();
            },
            hasSwitchThemeMode: true,
          ),
          DrawerEntity(
            drawerID: 03,
            drawerName: 'Language',
            leading: const Icon(Icons.language),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
          DrawerEntity(
            drawerID: 04,
            drawerName: 'Notification',
            leading: const Icon(Icons.notifications),
            onPressed: () async {
              Navigator.of(context).pop();
              final result = await context.push(Routes.NOTIFICATIONS);
              return;
            },
          ),
          DrawerEntity(
            drawerID: 05,
            drawerName: 'Rate & Review',
            leading: const Icon(Icons.rate_review),
            onPressed: () async {
              Navigator.of(context).pop();
              final result = await context.push(Routes.RATE_AND_REVIEW_PAGE);
              return;
            },
          ),
        ],
      ),
      DrawerEntity(
        drawerID: 1,
        drawerName: 'Orders',
        leading: const Icon(Icons.book),
        hasExpanded: true,
        controller: ExpansionTileController(),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        onPressed: () {
          return Navigator.of(context).pop();
        },
        children: [
          DrawerEntity(
            drawerID: 10,
            drawerName: 'Manage Orders',
            leading: const Icon(Icons.book),
            onPressed: () async {
              Navigator.of(context).pop();
              final result = await context.push(Routes.MANAGE_ORDER_PAGE);
              return;
            },
          ),
          DrawerEntity(
            drawerID: 11,
            drawerName: 'Track Current Orders',
            leading: const Icon(Icons.track_changes),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
          DrawerEntity(
            drawerID: 12,
            drawerName: 'Order based on stores',
            leading: const Icon(Icons.storefront),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
          DrawerEntity(
            drawerID: 13,
            drawerName: 'History',
            leading: const Icon(Icons.history),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
        ],
      ),
      DrawerEntity(
        drawerID: 2,
        drawerName: 'Stores',
        leading: const Icon(Icons.store),
        onPressed: () async {
          Navigator.of(context).pop();
          final result = await context.push(Routes.ALL_STORES_PAGE);
          return;
        },
      ),
      DrawerEntity(
        drawerID: 3,
        drawerName: 'Menu',
        leading: const Icon(Icons.restaurant_menu),
        onPressed: () async {
          Navigator.of(context).pop();
          final result = await context.push(Routes.ALL_MENU_PAGE);
          return;
        },
      ),
      DrawerEntity(
        drawerID: 4,
        drawerName: 'Drivers',
        leading: const Icon(Icons.payment),
        controller: ExpansionTileController(),
        onPressed: () async {
          Navigator.of(context).pop();
          final result = await context.push(Routes.ALL_DRIVER_PAGE);
          return;
        },
      ),
      DrawerEntity(
        drawerID: 5,
        drawerName: 'Wallet',
        hasExpanded: true,
        leading: const Icon(Icons.payment),
        controller: ExpansionTileController(),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        onPressed: () {
          return Navigator.of(context).pop();
        },
        children: [
          DrawerEntity(
            drawerID: 50,
            drawerName: 'My Wallet',
            leading: const Icon(Icons.account_balance_wallet),
            onPressed: () async {
              Navigator.of(context).pop();
              final result = await context.push(Routes.WALLET_DASHBOARD_PAGE);
              return;
            },
          ),
          DrawerEntity(
            drawerID: 51,
            drawerName: 'Manage Bank Account',
            leading: const Icon(Icons.account_balance),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
          DrawerEntity(
            drawerID: 52,
            drawerName: 'History',
            leading: const Icon(Icons.history),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
        ],
      ),
      DrawerEntity(
        drawerID: 6,
        drawerName: 'Analysis and Monitoring',
        leading: const Icon(Icons.analytics),
        onPressed: () async {
          Navigator.of(context).pop();
          final result = await context.push(Routes.ORDER_ANALYSIS_PAGE);
          return;
        },
      ),
      DrawerEntity(
        drawerID: 7,
        drawerName: 'Invite a Friend',
        leading: const Icon(Icons.add_reaction_sharp),
        onPressed: () {
          return Navigator.of(context).pop();
        },
      ),
      DrawerEntity(
        drawerID: 8,
        drawerName: 'Help & Support',
        hasExpanded: true,
        leading: const Icon(Icons.help),
        controller: ExpansionTileController(),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        onPressed: () {
          return Navigator.of(context).pop();
        },
        children: [
          DrawerEntity(
            drawerID: 80,
            drawerName: 'FAQ',
            leading: const Icon(Icons.help),
            onPressed: () async {
              Navigator.of(context).pop();
              final result = await context.push(Routes.FAQ_PAGE);
              return;
            },
          ),
          DrawerEntity(
            drawerID: 81,
            drawerName: 'Submit Your Query',
            leading: const Icon(Icons.query_builder),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
          DrawerEntity(
            drawerID: 82,
            drawerName: 'Privacy and Policy',
            leading: const Icon(Icons.privacy_tip_sharp),
            onPressed: () async {
              Navigator.of(context).pop();
              final result = await context.push(Routes.PRIVACY_AND_POLICY);
              return;
            },
          ),
          DrawerEntity(
            drawerID: 83,
            drawerName: 'Terms & Conditions',
            leading: const Icon(Icons.privacy_tip_sharp),
            onPressed: () async {
              Navigator.of(context).pop();
              final result = await context.push(Routes.TERMS_AND_CONDITIONS);
              return;
            },
          ),
          DrawerEntity(
            drawerID: 84,
            drawerName: 'Chat with us',
            leading: const Icon(Icons.chat),
            onPressed: () async {
              Navigator.of(context).pop();
              final result = await context.push(Routes.ROOM_PAGE);
              return;
            },
          ),
        ],
      ),
      DrawerEntity(
        drawerID: 9,
        drawerName: 'Logout',
        leading: const Icon(Icons.logout),
        onPressed: () {
          return Navigator.of(context).pop();
        },
      ),
      DrawerEntity(
        drawerID: 11,
        drawerName: 'About Us',
        leading: const Icon(Icons.person),
        onPressed: () async {
          Navigator.of(context).pop();
          await context.push(Routes.ABOUT_US);
          return;
        },
      ),
    ];
    if (!widget.isMainDrawerPage) {
      drawerEntities.insert(
        0,
        DrawerEntity(
          drawerID: 10,
          drawerName: 'Dashboard',
          leading: const Icon(Icons.dashboard),
          onPressed: () async {
            final result = await context.push(Routes.MAIN_DASHBOARD_PAGE);
            return;
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    drawerEntities = [];
    drawerEntities.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<BusinessProfileBloc, BusinessProfileState>(
        builder: (context, businessProfileState) {
          if (businessProfileState is GetAllAppUserProfileEmptyState) {
          } else if (businessProfileState
              is GetAllAppUserProfilePaginationState) {
            appUserEntity = businessProfileState.appUserEntities.last;
          }
          return _PrimaryDashboardDrawerView(this);
        },
      );
}

class _PrimaryDashboardDrawerView extends WidgetView<PrimaryDashboardDrawer,
    _PrimaryDashboardDrawerController> {
  const _PrimaryDashboardDrawerView(super.state);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: UserAccountsDrawerHeader(
                accountName: Text(
                  (state.appUserEntity.businessProfile.isNull &&
                          state.appUserEntity.businessProfile!.userName
                              .isEmptyOrNull &&
                          state.appUserEntity.businessProfile!.userName[0]
                              .isEmptyOrNull)
                      ? ''
                      : (state.appUserEntity.businessProfile!.userName.length >
                                  0 &&
                              state.appUserEntity.businessProfile!.userName[0]
                                  .isNotEmpty)
                          ? state.appUserEntity.businessProfile!.userName
                          : '',
                  style: context.titleLarge!.copyWith(
                    color: context.colorScheme.background,
                    fontWeight: FontWeight.w900,
                  ),
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
                accountEmail: Text(
                  state.appUserEntity.businessProfile?.businessName ??
                      state.appUserEntity.businessProfile
                          ?.businessEmailAddress ??
                      '',
                  style: context.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.background,
                  ),
                ).translate(),
                currentAccountPictureSize: Size.square(45),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white70,
                  child: Text(
                    (state.appUserEntity.businessProfile.isNull &&
                            state.appUserEntity.businessProfile!.userName
                                .isEmptyOrNull &&
                            state.appUserEntity.businessProfile!.userName[0]
                                .isEmptyOrNull)
                        ? ''
                        : (state.appUserEntity.businessProfile!.userName
                                        .length >
                                    0 &&
                                state.appUserEntity.businessProfile!.userName[0]
                                    .isNotEmpty)
                            ? state.appUserEntity.businessProfile!.userName[0]
                                .toUpperCase()
                            : '',
                    style: context.titleMedium!.copyWith(),
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                  ).translate(), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ),
            for (final DrawerEntity drawerEntity in state.drawerEntities)
              buildDrawerTiles(context, drawerEntity),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerTiles(BuildContext context, DrawerEntity drawerEntity) {
    return Conditional.single(
      context: context,
      conditionBuilder: (BuildContext context) => drawerEntity.hasExpanded,
      widgetBuilder: (BuildContext context) => ExpansionTile(
        key: PageStorageKey<DrawerEntity>(drawerEntity),
        maintainState: true,
        leading: drawerEntity.leading,
        controller: drawerEntity.controller,
        expandedCrossAxisAlignment: drawerEntity.expandedCrossAxisAlignment,
        title: Text(
          drawerEntity.drawerName,
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
        ).translate(),
        children: drawerEntity.children
            .map<Widget>(
                (DrawerEntity entity) => buildDrawerTiles(context, entity))
            .toList()
            .cast<Widget>(),
      ),
      fallbackBuilder: (BuildContext context) => ListTile(
        leading: drawerEntity.leading,
        onTap: drawerEntity.onPressed,
        title: Text(
          drawerEntity.drawerName,
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
        ).translate(),
        trailing: StatefulBuilder(
          builder: (context, setState) {
            Widget? trailing;
            if (drawerEntity.hasSwitchThemeMode) {
              trailing = ThemeModeSwitch(
                key: const Key('theme-change-drawer-widget'),
                onChanged: state.onThemeChanged,
                themeMode: serviceLocator<ThemeController>().themeMode,
              );
            } else {
              trailing = nil;
            }
            return trailing;
          },
        ),
      ),
    );
  }
}
