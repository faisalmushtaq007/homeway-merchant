part of 'package:homemakers_merchant/app/features/dashboard/index.dart';

class PrimaryDashboardPage extends StatefulWidget {
  const PrimaryDashboardPage({
    super.key,
    this.primaryDashboardMenuEntities = const [],
  });

  final List<PrimaryDashboardEntity> primaryDashboardMenuEntities;

  @override
  _PrimaryDashboardPageController createState() => _PrimaryDashboardPageController();
}

class _PrimaryDashboardPageController extends State<PrimaryDashboardPage> {
  final ScrollController scrollController = ScrollController();
  final ScrollController innerScrollController = ScrollController();
  List<PrimaryDashboardEntity> primaryDashboardMenuEntities = [];
  late AppUserEntity appUserEntity;

  @override
  void initState() {
    super.initState();
    appUserEntity = serviceLocator<AppUserEntity>();
    context.read<PermissionBloc>().add(const RequestLocationPermissionEvent());
    primaryDashboardMenuEntities.clear();
    /*primaryDashboardMenuEntities.add(
      PrimaryDashboardEntity(
        title: 'Upload Documents',
        titleID: 0,
        onPressed: () {
          return;
        },
        leading: const Icon(
          Icons.edit_document,
        ),
        hasEntityStored: false,
      ),
    );
    primaryDashboardMenuEntities.add(
      PrimaryDashboardEntity(
        title: 'Payment details',
        titleID: 1,
        onPressed: () {
          return;
        },
        leading: const Icon(
          Icons.payment,
        ),
        hasEntityStored: false,
      ),
    );*/
    primaryDashboardMenuEntities.add(
      PrimaryDashboardEntity(
        title: 'My Stores',
        titleID: 2,
        onPressed: () async {
          final navigateToStorePage = await context.push(Routes.ALL_STORES_PAGE);
          return;
        },
        leading: const Icon(
          Icons.store,
        ),
        hasEntityStored: false,
      ),
    );
    primaryDashboardMenuEntities.add(
      PrimaryDashboardEntity(
        title: 'My Menus',
        titleID: 3,
        onPressed: () async {
          final navigateToMenuPage = await context.push(Routes.ALL_MENU_PAGE);
          return;
        },
        leading: const Icon(
          Icons.restaurant_menu,
        ),
        hasEntityStored: false,
      ),
    );
    primaryDashboardMenuEntities.add(
      PrimaryDashboardEntity(
        title: 'My Drivers',
        titleID: 4,
        onPressed: () async {
          final navigateToMenuPage = await context.push(Routes.ALL_DRIVER_PAGE);
          return;
        },
        leading: const Icon(
          Icons.person,
        ),
        hasEntityStored: false,
      ),
    );
    primaryDashboardMenuEntities.add(
      PrimaryDashboardEntity(
        title: 'My Address',
        titleID: 5,
        onPressed: () async {
          final navigateToMenuPage = await context.push(Routes.ALL_SAVED_ADDRESS_LIST);
          return;
        },
        leading: const Icon(
          Icons.location_history,
        ),
        hasEntityStored: false,
      ),
    );
    initData();
  }

  Future<void> initData() async {
    context.read<BusinessProfileBloc>().add(const GetAllAppUserProfilePagination(pageKey: 0, pageSize: 10));
    final cacheUserEntity = serviceLocator<AppUserEntity>();
    AppUserEntity input = AppUserEntity(
      hasCurrentUser: true,
      isoCode: !cacheUserEntity.isoCode.isEmptyOrNull
          ? cacheUserEntity.isoCode
          : cacheUserEntity.businessProfile?.isoCode ?? '',
      country_dial_code: !cacheUserEntity.country_dial_code.isEmptyOrNull
          ? cacheUserEntity.country_dial_code
          : cacheUserEntity.businessProfile?.countryDialCode ?? '',
      phoneNumber: !cacheUserEntity.phoneNumber.isEmptyOrNull
          ? cacheUserEntity.phoneNumber
          : cacheUserEntity.businessProfile?.businessPhoneNumber ?? '',
      uid: cacheUserEntity.userID.toString(),
      access_token: cacheUserEntity.access_token ?? '',
      phoneNumberWithoutDialCode: !cacheUserEntity.phoneNumberWithoutDialCode.isEmptyOrNull
          ? cacheUserEntity.phoneNumberWithoutDialCode
          : cacheUserEntity.businessProfile?.phoneNumberWithoutDialCode ?? '',
    );
    final getCurrentUserResult = await serviceLocator<GetAllAppUserPaginationUseCase>()(
      pageSize: 10,
      pageKey: 0,
      entity: input,
    );
    await getCurrentUserResult.when(
      remote: (data, meta) {
        if (data.isNotNullOrEmpty) {
          appUserEntity = data!.last;
          serviceLocator<AppUserEntity>().updateEntity(data.last);
          setState(() {});
          appLog.d('Remote User Info ${data.last.toMap()}');
        }
      },
      localDb: (data, meta) {
        if (data.isNotNullOrEmpty) {
          appUserEntity = data!.last;
          serviceLocator<AppUserEntity>().updateEntity(data.last);
          setState(() {});
          appLog.d('Local User Info ${data.last.toMap()}');
        }
      },
      error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
        appLog.d('Error $reason');
      },
    );
  }

  @override
  void dispose() {
    innerScrollController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<BusinessProfileBloc, BusinessProfileState>(
        builder: (context, businessProfileState) {
          if (businessProfileState is GetAllAppUserProfileEmptyState) {
          } else if (businessProfileState is GetAllAppUserProfilePaginationState) {
            appUserEntity = businessProfileState.appUserEntities.last;
          }
          return _PrimaryDashboardPageView(this);
        },
      );
}

class _PrimaryDashboardPageView extends WidgetView<PrimaryDashboardPage, _PrimaryDashboardPageController> {
  const _PrimaryDashboardPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = media.padding.bottom + margins;
    final double width = media.size.width;
    final ThemeData theme = Theme.of(context);

    DateTime now = DateTime.now();
    var timeNow = int.parse(DateFormat('kk').format(now));
    TimeOfDay day = TimeOfDay.now();
    final int hour = TimeOfDay.now().hour;
    var message = '';
    var imageName = '';
    switch(day.period){
      case DayPeriod.am: {
        if (hour>=0 && hour < 4) {
          message = 'Good Night';
          break;
        } else if ((hour >= 4) && (hour <12)) {
          message = 'Good Morning';
          break;
        }else{
          message = 'Good Morning';
          break;
        }
      }
      case DayPeriod.pm: {
        if ((hour >= 12) && (hour < 16)) {
          message = 'Good Afernoon';
          break;
        }if ((hour >= 16) && (hour <= 20)) {
          message = 'Good Evening';
          break;
        }else {
          message = 'Good Night';
          break;
        }
      }
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
        noAppBar: true,
      ),
      child: Directionality(
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        child: DoubleTapToExit(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Dashboard'),
              titleSpacing: 4,
              actions: const [
                NotificationIconWidget(),
                LanguageSelectionWidget(),
              ],
            ),
            drawer: const PrimaryDashboardDrawer(
              key: const Key('primary-dashboard-drawer-menu'),
            ),
            body: SlideInLeft(
              key: const Key('primary-dashboard-page-slideinleft-widget'),
              delay: const Duration(milliseconds: 500),
              from: 200,
              child: PageBody(
                controller: state.scrollController,
                constraints: BoxConstraints(
                  minWidth: 1000,
                  minHeight: context.height,
                ),
                padding: EdgeInsetsDirectional.only(
                  top: topPadding,
                  //bottom: margins,
                  start: margins * 2.5,
                  end: margins * 2.5,
                ),
                child: BlocBuilder<PermissionBloc, PermissionState>(
                  bloc: context.read<PermissionBloc>(),
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, permissionState) {
                    return Container(
                      constraints: BoxConstraints(
                        minWidth: 1000,
                        minHeight: context.height,
                      ),
                      child: CustomScrollView(
                        controller: state.innerScrollController,
                        //physics: const ClampingScrollPhysics(),
                        slivers: [
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                const AnimatedGap(
                                  8,
                                  duration: Duration(milliseconds: 500),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Wrap(
                                            textDirection: serviceLocator<LanguageController>()
                                                .targetTextDirection,
                                            children: [
                                              Text(
                                                'Hi, ',
                                                textDirection:
                                                serviceLocator<LanguageController>()
                                                    .targetTextDirection,
                                                style: context.headlineLarge!.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  height: 0.9,
                                                  fontSize: 30,
                                                  color: Color.fromRGBO(255, 125, 113, 1),
                                                ),
                                              ).translate(),
                                              Text(
                                                "${(state.appUserEntity.isNotNull && state.appUserEntity!.businessProfile.isNotNull && !state.appUserEntity!.businessProfile!.userName.isEmptyOrNull) ? state.appUserEntity!.businessProfile!.userName : 'Hello User'}",
                                                style: context.headlineLarge!.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  height: 0.9,
                                                  fontSize: 30,
                                                  color: Color.fromRGBO(255, 125, 113, 1),
                                                ),
                                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                softWrap: true,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ).translate(),
                                            ],
                                          ),
                                          const AnimatedGap(6,
                                              duration: Duration(milliseconds: 500)),
                                          Wrap(
                                            textDirection: serviceLocator<LanguageController>()
                                                .targetTextDirection,
                                            children: [
                                              Text(
                                                message,
                                                textDirection:
                                                serviceLocator<LanguageController>()
                                                    .targetTextDirection,
                                                style: GoogleFonts.raleway(
                                                  textStyle: context.bodyLarge!.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                    height: 0.9,
                                                  ),
                                                ),
                                              ).translate(),
                                            ],
                                          ),
                                        ],
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                      ),
                                    ),
                                    AnimatedCrossFade(
                                      duration: const Duration(milliseconds: 500),
                                      crossFadeState:  (state.appUserEntity.businessProfile.isNull &&
                                          state.appUserEntity.businessProfile!.userName.isEmptyOrNull && state.appUserEntity.businessProfile!.userName[0].isEmptyOrNull)
                                          ?CrossFadeState.showFirst:CrossFadeState.showSecond,
                                      firstChild: const Offstage(),
                                      secondChild: Wrap(
                                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        alignment: WrapAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 26,
                                            backgroundColor: context.colorScheme.primaryContainer,
                                            child: Text(
                                              (state.appUserEntity.businessProfile.isNull &&
                                                  state.appUserEntity.businessProfile!.userName.isEmptyOrNull && state.appUserEntity.businessProfile!.userName[0].isEmptyOrNull)
                                                  ? ''
                                                  : (state.appUserEntity.businessProfile!.userName.length>0 && state.appUserEntity.businessProfile!.userName[0].isNotEmpty)?state.appUserEntity.businessProfile!.userName[0].toUpperCase(): '',
                                              style: context.titleLarge!.copyWith(),
                                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                            ).translate(), //Text
                                          ), //circleA
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const AnimatedGap(
                                  24,
                                  duration: Duration(milliseconds: 500),
                                ),
                                /*Wrap(
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.grey[300],
                                      child: Text(
                                        (state.appUserEntity.businessProfile.isNull &&
                                                state.appUserEntity.businessProfile!.userName.isEmptyOrNull)
                                            ? ''
                                            : state.appUserEntity.businessProfile?.userName?[0].toUpperCase() ?? '',
                                        style: context.titleLarge!.copyWith(),
                                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      ).translate(), //Text
                                    ), //circleA
                                  ],
                                ),
                                const AnimatedGap(
                                  12,
                                  duration: Duration(milliseconds: 500),
                                ),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  children: [
                                    Text(
                                      "${(state.appUserEntity.isNotNull && state.appUserEntity!.businessProfile.isNotNull && !state.appUserEntity!.businessProfile!.userName.isEmptyOrNull) ? state.appUserEntity!.businessProfile!.userName : 'Hello User'}",
                                      style: context.titleLarge!.copyWith(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                      ),
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    ).translate(),
                                  ],
                                ),
                                if ((state.appUserEntity.isNotNull &&
                                    state.appUserEntity!.businessProfile.isNotNull &&
                                    !state.appUserEntity!.businessProfile!.businessEmailAddress.isEmptyOrNull))
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    children: [
                                      Text(
                                        "${state.appUserEntity?.businessProfile!.businessName ?? state.appUserEntity.businessProfile?.businessEmailAddress ?? ''}",
                                        style:context.titleMedium!.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ).translate(),
                                    ],
                                  ),
                                const AnimatedGap(
                                  16,
                                  duration: Duration(milliseconds: 500),
                                ),*/
                                Wrap(
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    DecoratedBox(
                                      decoration: const BoxDecoration(color: Color.fromRGBO(252, 240, 218, 1)),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.only(top: 8, bottom: 8, start: 4, end: 4),
                                        child: Text(
                                          'Your business verification is under review process. Thank you so much for being our partner.',
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          textAlign: TextAlign.center,
                                          style: context.bodyMedium!
                                              .copyWith(color: const Color.fromRGBO(207, 138, 10, 1)),
                                        ).translate(),
                                      ),
                                    ),
                                  ],
                                ),
                                const AnimatedGap(
                                  25,
                                  duration: Duration(milliseconds: 500),
                                ),

                                StaggeredGrid.count(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 4,
                                  children: state.primaryDashboardMenuEntities.map((e) => StaggeredGridTile.count(
                                    crossAxisCellCount: 2,
                                    mainAxisCellCount: 2,
                                    child: PrimaryDashboardMenuCard(
                                      key: ObjectKey(e),
                                      primaryDashboardMenuEntity: e,
                                      hasGridViewParent: true,
                                    ),
                                  )).toList().cast<Widget>(),
                                  /*children:  [
                                    StaggeredGridTile.count(
                                      crossAxisCellCount: 2,
                                      mainAxisCellCount: 2,
                                      child: Offstage(),
                                    ),
                                    StaggeredGridTile.count(
                                      crossAxisCellCount: 2,
                                      mainAxisCellCount: 2,
                                      child: Offstage(),
                                    ),
                                    StaggeredGridTile.count(
                                      crossAxisCellCount: 2,
                                      mainAxisCellCount: 2,
                                      child: Offstage(),
                                    ),

                                  ],*/
                                )
                              ],
                            ),
                          ),
                          /*SliverFillRemaining(
                            child: ListView.builder(
                              shrinkWrap: true,
                              //physics: const ClampingScrollPhysics(),
                              itemCount: state.primaryDashboardMenuEntities.length,
                              itemBuilder: (context, index) {
                                return PrimaryDashboardMenuCard(
                                  key: ValueKey(index),
                                  primaryDashboardMenuEntity: state.primaryDashboardMenuEntities[index],
                                );
                              },
                            ),
                          ),*/
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
