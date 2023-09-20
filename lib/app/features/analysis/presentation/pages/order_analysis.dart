part of 'package:homemakers_merchant/app/features/analysis/index.dart';

class OrderAnalysis extends StatefulWidget {
  const OrderAnalysis({super.key});

  @override
  _OrderAnalysisController createState() => _OrderAnalysisController();
}

class _OrderAnalysisController extends State<OrderAnalysis> {
  late final ScrollController scrollController;
  late final ScrollController customScrollViewScrollController;
  String activeLocale = 'en_US';
  final Map<String, moment.MomentLocalization> locales =
      moment.MomentLocalizations.locales.map((key, value) => MapEntry(key, value()));

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    customScrollViewScrollController = ScrollController();
    activeLocale = serviceLocator<LanguageController>().targetAppLanguage.value.toString();
  }

  @override
  void dispose() {
    scrollController.dispose();
    customScrollViewScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _OrderAnalysisView(this);
}

class _OrderAnalysisView extends WidgetView<OrderAnalysis, _OrderAnalysisController> {
  const _OrderAnalysisView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = margins;
    moment.Moment.setGlobalLocalization(moment.MomentLocalizations.byLocale(state.activeLocale)!);

    final moment.Moment now = moment.Moment.now();

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
              title: const Text('Order Analysis'),
              centerTitle: false,
              titleSpacing: 0,
              actions: [
                IconButton(
                  onPressed: () {
                    final notification = context.push(Routes.NOTIFICATIONS);
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
                      style: context.labelSmall!.copyWith(color: context.colorScheme.onPrimary),
                      //Color.fromRGBO(251, 219, 11, 1)
                    ),
                    child: Icon(
                      Icons.notifications,
                      color: context.colorScheme.primary,
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                    ),
                  ),
                ),
                Directionality(
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  child: const LanguageSelectionWidget(),
                ),
              ],
            ),
            drawer: const PrimaryDashboardDrawer(
              key: const Key('order-analysis-dashboard-drawer'),
              isMainDrawerPage: false,
            ),
            body: SlideInLeft(
              key: const Key('order-details-page-slideinleft-widget'),
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
                    //top: topPadding,
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
                            const AnimatedGap(
                              6,
                              duration: Duration(milliseconds: 100),
                            ),
                            TodayOrderAnalysis(
                              key: const Key('today-order-analysis'),
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
      ),
    );
  }
}


