part of 'package:homemakers_merchant/app/features/order/index.dart';

class ManageOrderPage extends StatefulWidget {
  const ManageOrderPage({super.key});
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
    saveAll();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> saveAll() async {
    final result = await serviceLocator<SaveAllOrderUseCase>()(
      <OrderEntity>[
        OrderEntity(
          orderID: 1,
          orderDateTime: DateTime.now().addOrRemoveMinutes(15),
          userInfo: UserInfo(
            userName: 'Sonu',
            deliveryAddress: DeliveryAddress(),
          ),
          store: Store(
            storeID: 1,
            storeName: 'Good Cafe',
            location: AddressLocation(),
            menu: [
              Menu(
                quantity: 1,
                menuID: 21,
                menuName: 'Vegetable Rice Briyani',
                menuImage:
                    'https://img.freepik.com/premium-photo/dum-handi-chicken-biryani-is-prepared-earthen-clay-pot-called-haandi-popular-indian-non-vegetarian-food_466689-52225.jpg',
              ),
            ],
          ),
          orderStatus: OrderStatus.newOrder.index,
          orderType: OrderType.newOrder.index,
          driver: Driver(),
          payment: Payment(),
        ),
        OrderEntity(
          orderID: 2,
          orderDateTime: DateTime.now().addOrRemoveMinutes(25),
          userInfo: UserInfo(
            userName: 'Sonu',
            deliveryAddress: DeliveryAddress(),
          ),
          store: Store(
            storeID: 1,
            storeName: 'Good Cafe',
            location: AddressLocation(),
            menu: [
              Menu(
                quantity: 1,
                menuID: 21,
                menuName: 'Vegetable Rice Briyani',
                menuImage:
                    'https://img.freepik.com/premium-photo/dum-handi-chicken-biryani-is-prepared-earthen-clay-pot-called-haandi-popular-indian-non-vegetarian-food_466689-52225.jpg',
              ),
            ],
          ),
          orderStatus: OrderStatus.preparing.index,
          orderType: OrderType.onProcess.index,
          driver: Driver(),
          payment: Payment(),
        ),
        OrderEntity(
          orderID: 3,
          orderDateTime: DateTime.now().addOrRemoveDay(2),
          userInfo: UserInfo(
            userName: 'Sonu',
            deliveryAddress: DeliveryAddress(),
          ),
          store: Store(
            storeID: 1,
            storeName: 'Good Cafe',
            location: AddressLocation(),
            menu: [
              Menu(
                quantity: 1,
                menuID: 21,
                menuName: 'Vegetable Rice Briyani',
                menuImage:
                    'https://img.freepik.com/premium-photo/dum-handi-chicken-biryani-is-prepared-earthen-clay-pot-called-haandi-popular-indian-non-vegetarian-food_466689-52225.jpg',
              ),
            ],
          ),
          orderStatus: OrderStatus.delivered.index,
          orderType: OrderType.deliver.index,
          driver: Driver(),
          payment: Payment(),
        ),
        OrderEntity(
          orderID: 4,
          orderDateTime: DateTime.now().addOrRemoveDay(1),
          userInfo: UserInfo(
            userName: 'Sonu',
            deliveryAddress: DeliveryAddress(),
          ),
          store: Store(
            storeID: 1,
            storeName: 'Good Cafe',
            location: AddressLocation(),
            menu: [
              Menu(
                quantity: 1,
                menuID: 21,
                menuName: 'Vegetable Rice Briyani',
                menuImage:
                    'https://img.freepik.com/premium-photo/dum-handi-chicken-biryani-is-prepared-earthen-clay-pot-called-haandi-popular-indian-non-vegetarian-food_466689-52225.jpg',
              ),
            ],
          ),
          orderStatus: OrderStatus.cancelByUser.index,
          orderType: OrderType.cancel.index,
          driver: Driver(),
          payment: Payment(),
        ),
      ],
    );
    result.when(
      remote: (data, meta) {
        appLog.d('Saved notification to remote ${data?.length}');
      },
      localDb: (data, meta) {
        appLog.d('Saved notification to local ${data?.length}');
      },
      error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
        appLog.d('Saved notification to local $reason');
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    customScrollViewScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _ManageOrderPageView(this);
}

class _ManageOrderPageView extends WidgetView<ManageOrderPage, _ManageOrderPageController> {
  const _ManageOrderPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = margins;
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
                    isLabelVisible: true,
                    largeSize: 16,
                    textStyle: TextStyle(fontSize: 14),
                    textColor: Colors.yellow,
                    label: Text(
                      '10',
                      style: context.labelSmall!.copyWith(color: context.colorScheme.onPrimary),
                      //Color.fromRGBO(251, 219, 11, 1)
                    ),
                    child: Icon(Icons.notifications, color: context.colorScheme.primary),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 8),
                  child: LanguageSelectionWidget(),
                ),
              ],
            ),
            drawer: const PrimaryDashboardDrawer(
              key: const Key('main-dashboard-drawer'),
              isMainDrawerPage: false,
            ),
            body: SlideInLeft(
              key: const Key('main-dashboard-page-slideinleft-widget'),
              from: context.width / 2 - 60,
              duration: Duration(milliseconds: 500),
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
                              ManageOrderHeadlineWidget(
                                key: const Key('manage-order-headline-widget'),
                              ),
                              const AnimatedGap(
                                16,
                                duration: Duration(milliseconds: 100),
                              ),
                              OrderTypeWidget(
                                key: const Key('manage-order-type-widget'),
                              ),
                              const AnimatedGap(
                                16,
                                duration: Duration(milliseconds: 100),
                              ),
                              AllOrderPages(
                                key: const Key('manage-order-all-orders-widget'),
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
        ),
      ),
    );
  }
}
