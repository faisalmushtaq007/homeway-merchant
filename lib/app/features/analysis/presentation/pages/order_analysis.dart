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
  List<Widget> transactionWidgets = [];
  List<OrderAnalysisByPeriodType> transactionTypes = [];
  int currentIndex = 0;
  final PageStorageBucket _transactionBucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    customScrollViewScrollController = ScrollController();
    activeLocale = serviceLocator<LanguageController>().targetAppLanguage.value.toString();
    transactionTypes = [
      OrderAnalysisByPeriodType(typeName: 'Today', typeID: 0, hasSelected: false),
      OrderAnalysisByPeriodType(typeName: 'This Week', typeID: 1, hasSelected: false),
      OrderAnalysisByPeriodType(typeName: 'By Month', typeID: 2, hasSelected: false),
    ];
    transactionWidgets = [
      TodayOrderAnalysis(
        key: PageStorageKey<String>('today-order-analysis'),
      ),
      WeeklyOrderAnalysis(
        key: PageStorageKey<String>('weekly-order-analysis'),
      ),
      MonthlyOrderAnalysis(
        key: PageStorageKey<String>('monthly-order-analysis'),
      ),
    ];
  }

  @override
  void dispose() {
    transactionTypes = [];
    transactionWidgets = [];
    scrollController.dispose();
    customScrollViewScrollController.dispose();
    super.dispose();
  }

  void updateCurrentIndex(int index) {
    currentIndex = index;
    switch (currentIndex) {
      case 0:
        {
          context.read<OrderAnalysisBloc>().add(
                const TodayOrderAnalysisEvent(),
              );
        }
      case 1:
        {
          context.read<OrderAnalysisBloc>().add(
                const WeeklyOrderAnalysisEvent(),
              );
        }
      case 2:
        {
          final int month = DateTime.now().month;
          context.read<OrderAnalysisBloc>().add(
                ByMonthlyOrderAnalysisEvent(
                  byMonth: month,
                ),
              );
        }
      default:
        {}
    }
    setState(() {});
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
                    //shrinkWrap: true,
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            const AnimatedGap(
                              6,
                              duration: Duration(milliseconds: 100),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 65,
                                width: context.width,
                                color: Colors.grey.shade200,
                                child: ScrollableRow(
                                  controller: state.scrollController,
                                  padding: EdgeInsetsDirectional.zero,
                                  mainAxisSize: MainAxisSize.min,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  physics: const BouncingScrollPhysics(),
                                  constraintsBuilder: (constraints) => BoxConstraints(
                                    minWidth: constraints.maxWidth,
                                  ),
                                  flexible: false,
                                  children: List.generate(
                                      state.transactionTypes.length,
                                      (index) => StatefulBuilder(
                                            builder: (context, setState) {
                                              return Padding(
                                                padding: const EdgeInsetsDirectional.only(start: 8, end: 8.0),
                                                child: ElevatedButton(
                                                  key: ValueKey(index),
                                                  style: ElevatedButton.styleFrom(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadiusDirectional.circular(10),
                                                    ),
                                                    minimumSize: Size(74, 42),
                                                    maximumSize: Size(104, 42),
                                                    //fixedSize: Size(104, 42),
                                                    backgroundColor: (state.currentIndex == index)
                                                        ? flexExt.FlexStringExtensions('#2C73D2').toColor
                                                        : flexExt.FlexStringExtensions('#D4E5ED').toColor,
                                                    //disabledBackgroundColor: '#B0A8B9'.toColor,
                                                  ),
                                                  onPressed: () {
                                                    state.updateCurrentIndex(index);
                                                  },
                                                  child: Text(
                                                    state.transactionTypes[index].typeName,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    textAlign: TextAlign.center,
                                                    style: context.bodyMedium!.copyWith(
                                                        color:
                                                            state.currentIndex == index ? Colors.white : Colors.black),
                                                  ),
                                                ),
                                              );
                                            },
                                          )),
                                ),
                              ),
                            ),
                            const AnimatedGap(12, duration: Duration(milliseconds: 200)),
                            PageStorage(
                              bucket: state._transactionBucket,
                              child: state.transactionWidgets[state.currentIndex],
                            ),
                          ],
                        ),
                      ),
                      /*SliverFillRemaining(
                        fillOverscroll: true,
                        hasScrollBody: true,
                        child: PageStorage(
                          bucket: state._transactionBucket,
                          child: state.transactionWidgets[state.currentIndex],
                        ),
                      ),*/
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

class OrderAnalysisByPeriodType {
  const OrderAnalysisByPeriodType({
    required this.typeName,
    required this.typeID,
    required this.hasSelected,
  });

  final String typeName;
  final int typeID;
  final bool hasSelected;

  OrderAnalysisByPeriodType copyWith({
    String? typeName,
    int? typeID,
    bool? hasSelected,
  }) {
    return OrderAnalysisByPeriodType(
      typeName: typeName ?? this.typeName,
      typeID: typeID ?? this.typeID,
      hasSelected: hasSelected ?? this.hasSelected,
    );
  }
}
