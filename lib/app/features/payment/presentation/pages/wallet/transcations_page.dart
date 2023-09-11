part of 'package:homemakers_merchant/app/features/payment/index.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  _TransactionsPageController createState() => _TransactionsPageController();
}

class _TransactionsPageController extends State<TransactionsPage> {
  List<TransactionTypeInfo> transactionTypes = [];
  late final ScrollController scrollController;
  late final ScrollController customScrollViewScrollController;
  int currentIndex = 0;
  final PageStorageBucket _transactionBucket = PageStorageBucket();
  List<Widget> transactionWidgets = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    customScrollViewScrollController = ScrollController();
    transactionTypes = [
      TransactionTypeInfo(typeName: 'All', typeID: 0, hasSelected: false),
     /* TransactionTypeInfo(typeName: 'Income', typeID: 0, hasSelected: false),
      TransactionTypeInfo(typeName: 'Withdrawal', typeID: 0, hasSelected: false),*/
    ];
    transactionWidgets = [
      AllTranscationsWidget(
        key: PageStorageKey<String>('all-transaction-page'),
      ),
      /*IncomeTransactionWidget(
        key: PageStorageKey<String>('income-transaction-page'),
      ),
      WithdrawalTransactionWidget(
        key: PageStorageKey<String>('withdrawal-transaction-page'),
      ),*/
    ];
  }

  @override
  void dispose() {
    scrollController.dispose();
    customScrollViewScrollController.dispose();
    super.dispose();
  }

  void updateCurrentIndex(int index) {
    currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => _TransactionsPageView(this);
}

class _TransactionsPageView extends WidgetView<TransactionsPage, _TransactionsPageController> {
  const _TransactionsPageView(super.state);
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
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Transaction'),
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
          /*drawer: const PrimaryDashboardDrawer(
            key: const Key('transaction-page-drawer'),
            isMainDrawerPage: false,
          ),*/
          body: FadeInDown(
            key: const Key('transaction-page-slideinleft-widget'),
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
                          const AnimatedGap(6, duration: Duration(milliseconds: 200)),
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
                                                  backgroundColor: (state.currentIndex == index) ? '#2C73D2'.toColor : '#D4E5ED'.toColor,
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
                                                  style: context.bodyMedium!.copyWith(color: state.currentIndex == index ? Colors.white : Colors.black),
                                                ),
                                              ),
                                            );
                                          },
                                        )),
                              ),
                            ),
                          ),
                          const AnimatedGap(12, duration: Duration(milliseconds: 200)),
                        ],
                      ),
                    ),
                    SliverFillRemaining(
                      fillOverscroll: true,
                      hasScrollBody: true,
                      child: PageStorage(
                        bucket: state._transactionBucket,
                        child: state.transactionWidgets[state.currentIndex],
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

class TransactionTypeInfo {
  const TransactionTypeInfo({
    required this.typeName,
    required this.typeID,
    required this.hasSelected,
  });

  final String typeName;
  final int typeID;
  final bool hasSelected;

  TransactionTypeInfo copyWith({
    String? typeName,
    int? typeID,
    bool? hasSelected,
  }) {
    return TransactionTypeInfo(
      typeName: typeName ?? this.typeName,
      typeID: typeID ?? this.typeID,
      hasSelected: hasSelected ?? this.hasSelected,
    );
  }
}
