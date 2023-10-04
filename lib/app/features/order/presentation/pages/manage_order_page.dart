part of 'package:homemakers_merchant/app/features/order/index.dart';

class ManageOrderPage extends StatefulWidget {
  const ManageOrderPage({super.key, this.storeEntity, this.storeID = -1});
  final StoreEntity? storeEntity;
  final int storeID;

  @override
  _ManageOrderPageController createState() => _ManageOrderPageController();
}

class _ManageOrderPageController extends State<ManageOrderPage> {
  late final ScrollController scrollController;
  late final ScrollController customScrollViewScrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    customScrollViewScrollController = ScrollController();
    // set default index of order is zero
    onChangeOrderType(0);
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

  void onChangeOrderType(int index) {
    serviceLocator<ManageOrderController>().setCurrentOrderIndex(index);
  }

  @override
  Widget build(BuildContext context) => _ManageOrderPageView(this);
}

class _ManageOrderPageView
    extends WidgetView<ManageOrderPage, _ManageOrderPageController> {
  const _ManageOrderPageView(super.state);

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
            title: const Text('Manage Orders'),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () async {
                  final notification =
                      await context.push(Routes.NOTIFICATIONS);
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
          body: SlideInLeft(
            key: const Key('manage-order-slideinleft-widget'),
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
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          /*const AnimatedGap(
                            12,
                            duration: Duration(milliseconds: 100),
                          ),
                          const ManageOrderHeadlineWidget(
                            key: Key('manage-order-headline-widget'),
                          ),
                          const AnimatedGap(
                            12,
                            duration: Duration(milliseconds: 100),
                          ),*/
                          OrderTypeWidget(
                            key: const Key('manage-order-type-widget'),
                            onChanged: state.onChangeOrderType,
                          ),
                          const AnimatedGap(
                            8,
                            duration: Duration(milliseconds: 100),
                          ),
                        ],
                      ),
                    ),
                    SliverFillRemaining(
                      fillOverscroll: true,
                      hasScrollBody: true,
                      child: switch (serviceLocator<ManageOrderController>()
                          .currentOrderIndex) {
                        0 => const AllOrderPages(
                            key: Key('manage-order-all-orders-widget'),
                          ),
                        1 => const AllNewOrderPage(
                            key: Key('manage-order-new-orders-widget'),
                          ),
                        2 => const AllScheduleOrderPage(
                            key: Key('manage-order-schedule-orders-widget'),
                          ),
                        3 => const AllOnProcessOrderPage(
                            key: Key('manage-order-onprocess-orders-widget'),
                          ),
                        4 => const AllDeliverOrderPage(
                            key: Key('manage-order-deliver-orders-widget'),
                          ),
                        5 => const AllCancelOrderPage(
                            key: Key('manage-order-cancel-orders-widget'),
                          ),
                        _ => const AllNewOrderPage(
                            key: Key('manage-order-all-orders-widget'),
                          ),
                      },
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
