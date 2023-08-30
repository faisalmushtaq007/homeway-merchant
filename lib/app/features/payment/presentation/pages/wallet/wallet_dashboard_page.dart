part of 'package:homemakers_merchant/app/features/payment/index.dart';

class WalletDashboardPage extends StatefulWidget {
  const WalletDashboardPage({super.key});
  @override
  _WalletDashboardPageController createState() => _WalletDashboardPageController();
}

class _WalletDashboardPageController extends State<WalletDashboardPage> {
  late final ScrollController scrollController;
  late final ScrollController customScrollViewScrollController;

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) => _WalletDashboardPageView(this);
}

class _WalletDashboardPageView extends WidgetView<WalletDashboardPage, _WalletDashboardPageController> {
  const _WalletDashboardPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
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
              title: const Text('Wallet'),
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
                    isLabelVisible: true,
                    largeSize: 16,
                    textStyle: const TextStyle(fontSize: 14),
                    textColor: Colors.yellow,
                    label: Text(
                      '10',
                      style: context.labelSmall!.copyWith(color: context.colorScheme.onPrimary),
                      //Color.fromRGBO(251, 219, 11, 1)
                    ),
                    child: Icon(Icons.notifications, color: context.colorScheme.primary),
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.only(end: 8),
                  child: LanguageSelectionWidget(),
                ),
              ],
            ),
            drawer: const PrimaryDashboardDrawer(
              key: const Key('wallet-dashboard-drawer'),
              isMainDrawerPage: false,
            ),
            body: FadeInDown(
              key: const Key('wallet-dashboard-slideinleft-widget'),
              from: context.width / 2 - 60,
              duration: const Duration(milliseconds: 500),
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
                    shrinkWrap: true,
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            /*WalletUserInfoWidget(
                              key: const Key('wallet-dashboard-user-info'),
                            ),
                            const AnimatedGap(
                              12,
                              duration: Duration(milliseconds: 100),
                            ),
                            Text(
                              'Account Overview',
                              style: context.headlineSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 19,
                              ),
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ).translate(),
                             */
                            const AnimatedGap(6, duration: Duration(milliseconds: 200)),
                            WalletAccountSummaryWidget(
                              key: const Key('wallet-dashboard-account-summary-widget'),
                            ),
                            const AnimatedGap(16, duration: Duration(milliseconds: 200)),
                            WalletMenuWidget(
                              key: const Key('wallet-dashboard-menus-widget'),
                            ),
                            const AnimatedGap(16, duration: Duration(milliseconds: 200)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Recents',
                                    style: context.labelMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 19,
                                    ),
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    maxLines: 1,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ).translate(),
                                ),
                                Text(
                                  'View All',
                                  style: context.labelMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: context.colorScheme.secondary,
                                    fontSize: 17,
                                  ),
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  maxLines: 1,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ).translate(),
                              ],
                            ),
                            const AnimatedGap(
                              6,
                              duration: Duration(milliseconds: 100),
                            ),
                          ],
                        ),
                      ),
                      SliverFillRemaining(
                        fillOverscroll: true,
                        hasScrollBody: true,
                        child: AllTranscationsWidget(
                          key: const Key('waller-dashboard-all-transcation-widget'),
                          hasShownInWalletDashboard: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
