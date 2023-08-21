part of 'package:homemakers_merchant/app/features/dashboard/index.dart';

class MainDashboardPage extends StatefulWidget {
  const MainDashboardPage({super.key});

  @override
  _MainDashboardController createState() => _MainDashboardController();
}

class _MainDashboardController extends State<MainDashboardPage> {
  late final ScrollController scrollController;
  late final ScrollController customScrollViewScrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    customScrollViewScrollController = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    scrollController.dispose();
    customScrollViewScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _MainDashboardView(this);
}

class _MainDashboardView extends WidgetView<MainDashboardPage, _MainDashboardController> {
  const _MainDashboardView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = margins; // media.padding.bottom + margins;
    final double width = media.size.width;
    final ThemeData theme = Theme.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
        noAppBar: true,
      ),
      child: Scaffold(
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
              child: LanguageSelectionWidget(),
            ),
          ],
        ),
        body: SlideInLeft(
          key: const Key('main-dashboard-page-slideinleft-widget'),
          from: context.width - 10,
          child: Directionality(
            textDirection: serviceLocator<LanguageController>().targetTextDirection,
            child: PageBody(
                controller: state.scrollController,
                constraints: BoxConstraints(
                  minWidth: 1000,
                  minHeight: media.size.height - (media.padding.top + kToolbarHeight + media.padding.bottom),
                ),
                padding: EdgeInsetsDirectional.only(
                  top: topPadding,
                  //bottom: bottomPadding,
                  start: margins * 2.5,
                  end: margins * 2.5,
                ),
                child: CustomScrollView(
                  controller: state.customScrollViewScrollController,
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          const AnimatedGap(
                            12,
                            duration: Duration(milliseconds: 100),
                          ),
                          UserProfileWidget(
                            key: const Key('dashboard-user-profile-widget'),
                          ),
                          const AnimatedGap(
                            16,
                            duration: Duration(milliseconds: 100),
                          ),
                          DashboardWalletInfoWidget(
                            key: const Key('dashboard-wallet-info-widget'),
                          ),
                          const AnimatedGap(
                            16,
                            duration: Duration(milliseconds: 100),
                          ),
                          AllOrderWidget(
                            key: const Key('dashboard-all-orders-widget'),
                          ),
                          const AnimatedGap(
                            16,
                            duration: Duration(milliseconds: 100),
                          ),
                          MiscellaneousWidget(
                            key: const Key('miscellaneous-widget'),
                          ),
                          const AnimatedGap(
                            16,
                            duration: Duration(milliseconds: 100),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
