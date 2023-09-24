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
    saveAll();
    // set default index of order is zero
    onChangeOrderType(0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> saveAll() async {
    final data = <OrderEntity>[
      OrderEntity(
        orderID: 1,
        orderDateTime: DateTime.now().subtract(const Duration(minutes: 15)),
        orderDeliveryDateTime: DateTime.now().add(const Duration(minutes: 15)),
        userInfo: UserInfo(
          userName: 'Sonu',
          deliveryAddress: DeliveryAddress(),
        ),
        store: Store(
          storeID: 1,
          storeName: 'Life Cafe',
          location: AddressLocation(),
          menu: [
            Menu(
              quantity: 1,
              menuID: 21,
              menuName: 'Chicken Biryani',
              menuImage:
                  'https://img.freepik.com/premium-photo/fish-biriyani-south-indian-style-fish-biriyani-arranged-traditionally-brass-vessel_527904-1690.jpg',
              addons: [],
              tasteType: 'Spicy',
              tasteLevel: 'Medium',
              numberOfServingPerson: 2,
              unit: '1',
              orderPortion: const OrderPortion(
                portionSize: 1,
                portionUnit: 'Bowl',
              ),
              isInstantMenu: true,
            ),
          ],
        ),
        orderStatus: OrderStatus.newOrder.index,
        orderType: OrderType.newOrder.index,
        driver: DeliveryDriver(),
        payment: Payment(
          mode: 'COD',
          amount: 30,
          paymentID: 222,
          paymentDateTime: DateTime.now().subtract(const Duration(minutes: 15)),
          deliveryAmount: 2,
          serviceAmount: 2,
        ),
      ),
      OrderEntity(
        orderID: 2,
        orderDateTime: DateTime.now().subtract(const Duration(minutes: 5)),
        orderDeliveryDateTime: DateTime.now().add(const Duration(minutes: 15)),
        userInfo: UserInfo(
          userName: 'Mr Ahmed',
          deliveryAddress: DeliveryAddress(),
        ),
        store: Store(
          storeID: 2,
          storeName: 'Good Cafe',
          location: AddressLocation(),
          menu: [
            Menu(
              quantity: 2,
              menuID: 13,
              menuName: 'Vegetable Rice Briyani',
              menuImage:
                  'https://img.freepik.com/premium-photo/dum-handi-chicken-biryani-is-prepared-earthen-clay-pot-called-haandi-popular-indian-non-vegetarian-food_466689-52225.jpg',
              addons: [
                Addon(
                  addonsName: 'Sweets',
                  orderPortion: const OrderPortion(
                    portionSize: 1,
                    portionUnit: 'Medium',
                  ),
                  addonsId: 4,
                  price: 2,
                  addonsImage:
                      'https://img.freepik.com/premium-photo/gulab-jamun-indian-dessert-topped-with-pistachio_136354-1769.jpg',
                ),
              ],
              tasteType: 'Pungent',
              tasteLevel: 'Medium',
              numberOfServingPerson: 2,
              unit: '1',
              orderPortion: const OrderPortion(
                portionSize: 1,
                portionUnit: 'Bowl',
              ),
            ),
          ],
        ),
        orderStatus: OrderStatus.preparing.index,
        orderType: OrderType.onProcess.index,
        driver: DeliveryDriver(),
        payment: Payment(
          mode: 'COD',
          amount: 10,
          paymentID: 101,
          paymentDateTime: DateTime.now().subtract(const Duration(minutes: 5)),
          deliveryAmount: 2,
          serviceAmount: 2,
        ),
      ),
      OrderEntity(
        orderID: 3,
        orderDateTime: DateTime.now()
            .subtract(const Duration(days: 1, hours: 12, minutes: 30)),
        orderDeliveryDateTime: DateTime.now()
            .subtract(const Duration(days: 1, hours: 12, minutes: 45)),
        userInfo: UserInfo(
          userName: 'Nilu',
          deliveryAddress: DeliveryAddress(),
        ),
        store: Store(
          storeID: 3,
          storeName: 'Indian Cafe',
          location: AddressLocation(),
          menu: [
            Menu(
              quantity: 1,
              menuID: 2,
              menuName: 'Paneer Butter Masala',
              menuImage:
                  'https://img.freepik.com/premium-photo/traditional-indian-butter-chicken-murg-makhanwala-which-is-creamy-main-course-curry-recipe_466689-49661.jpg',
            ),
            Menu(
              quantity: 1,
              menuID: 16,
              price: 10,
              menuName: 'Veg Briyani',
              menuImage:
                  'https://img.freepik.com/premium-photo/indian-vegetable-pulav-biryani-made-using-basmati-rice-served-terracotta-bowl-selective-focus_466689-55615.jpg',
              addons: [
                Addon(
                  addonsName: 'Salad',
                  orderPortion: const OrderPortion(
                    portionSize: 1,
                    portionUnit: 'Plate',
                  ),
                  addonsId: 12,
                  price: 2,
                  addonsImage:
                      'https://img.freepik.com/free-photo/fresh-vegetables-colorful-sliced-such-as-cucumbers-red-tomatoes-onion-wooden-rustic-surface_140725-14178.jpg',
                ),
                Addon(
                  addonsName: 'Sweets',
                  orderPortion: const OrderPortion(
                    portionSize: 1,
                    portionUnit: 'Medium',
                  ),
                  addonsId: 4,
                  price: 2,
                  addonsImage:
                      'https://img.freepik.com/premium-photo/gulab-jamun-indian-dessert-topped-with-pistachio_136354-1769.jpg',
                ),
              ],
              tasteType: 'Pungent',
              tasteLevel: 'Medium',
              numberOfServingPerson: 2,
              unit: '1',
              orderPortion: const OrderPortion(
                portionSize: 1,
                portionUnit: 'Bowl',
              ),
            ),
          ],
        ),
        orderStatus: OrderStatus.delivered.index,
        orderType: OrderType.deliver.index,
        driver: DeliveryDriver(),
        payment: Payment(
          mode: 'PAID',
          amount: 22,
          paymentID: 11,
          paymentDateTime: DateTime.now()
              .subtract(const Duration(days: 1, hours: 12, minutes: 30)),
          deliveryAmount: 2,
          serviceAmount: 2,
        ),
      ),
      OrderEntity(
        orderID: 4,
        orderDateTime: DateTime.now().subtract(const Duration(minutes: 30)),
        orderDeliveryDateTime:
            DateTime.now().subtract(const Duration(minutes: 45)),
        userInfo: UserInfo(
          userName: 'Shivam',
          deliveryAddress: DeliveryAddress(),
        ),
        store: Store(
          storeID: 4,
          storeName: 'American Food Plaza',
          location: AddressLocation(),
          menu: [
            Menu(
              quantity: 1,
              menuID: 25,
              menuName: 'Burger',
              menuImage:
                  'https://img.freepik.com/free-photo/front-view-yummy-meat-cheeseburger-with-french-fries-dark-background-dinner-burgers-snack-fast-food-sandwich-salad-dish-toast_140725-159215.jpg?',
              addons: [
                Addon(
                  addonsName: 'Salad',
                  orderPortion: const OrderPortion(
                    portionSize: 1,
                    portionUnit: 'Plate',
                  ),
                  addonsId: 12,
                  price: 2,
                  addonsImage:
                      'https://img.freepik.com/free-photo/fresh-vegetables-colorful-sliced-such-as-cucumbers-red-tomatoes-onion-wooden-rustic-surface_140725-14178.jpg',
                ),
                Addon(
                  addonsName: 'Sweets',
                  orderPortion: const OrderPortion(
                    portionSize: 1,
                    portionUnit: 'Medium',
                  ),
                  addonsId: 4,
                  price: 2,
                  addonsImage:
                      'https://img.freepik.com/premium-photo/gulab-jamun-indian-dessert-topped-with-pistachio_136354-1769.jpg',
                ),
              ],
              tasteType: 'Pungent',
              tasteLevel: 'Medium',
              numberOfServingPerson: 2,
              unit: '1',
              orderPortion: const OrderPortion(
                portionSize: 1,
                portionUnit: 'Bowl',
              ),
            ),
          ],
        ),
        orderStatus: OrderStatus.cancelByUser.index,
        orderType: OrderType.cancel.index,
        driver: DeliveryDriver(),
        payment: Payment(
          mode: 'CANCEL',
          amount: 10,
          paymentID: 61,
          paymentDateTime: DateTime.now().subtract(const Duration(minutes: 30)),
          deliveryAmount: 2,
          serviceAmount: 2,
        ),
      ),
      OrderEntity(
        orderID: 8,
        orderDateTime: DateTime.now().subtract(const Duration(hours: 1)),
        orderDeliveryDateTime:
            DateTime.now().subtract(const Duration(hours: 1, minutes: 15)),
        userInfo: UserInfo(
          userName: 'Ashutosh',
          deliveryAddress: DeliveryAddress(),
        ),
        store: Store(
          storeID: 4,
          storeName: 'American Food Plaza',
          location: AddressLocation(),
          menu: [
            Menu(
              quantity: 1,
              menuID: 21,
              menuName: 'Cheese Pizza',
              menuImage:
                  'https://img.freepik.com/free-photo/crispy-mixed-pizza-with-olives-sausage_140725-3095.jpg',
              addons: [
                Addon(
                  addonsName: 'Salad',
                  orderPortion: const OrderPortion(
                    portionSize: 1,
                    portionUnit: 'Plate',
                  ),
                  addonsId: 12,
                  price: 2,
                  addonsImage:
                      'https://img.freepik.com/free-photo/fresh-vegetables-colorful-sliced-such-as-cucumbers-red-tomatoes-onion-wooden-rustic-surface_140725-14178.jpg',
                ),
                Addon(
                  addonsName: 'Sweets',
                  orderPortion: const OrderPortion(
                    portionSize: 1,
                    portionUnit: 'Medium',
                  ),
                  addonsId: 4,
                  price: 2,
                  addonsImage:
                      'https://img.freepik.com/premium-photo/gulab-jamun-indian-dessert-topped-with-pistachio_136354-1769.jpg',
                ),
              ],
              tasteType: 'Pungent',
              tasteLevel: 'Medium',
              numberOfServingPerson: 2,
              unit: '1',
              orderPortion: const OrderPortion(
                portionSize: 1,
                portionUnit: 'Bowl',
              ),
            ),
          ],
        ),
        orderStatus: OrderStatus.onTheWay.index,
        orderType: OrderType.deliver.index,
        driver: DeliveryDriver(
          driverID: 1,
          driverName: 'Mr. Abdul Wahab',
          driverContactNumber: '+966 559781276',
          driverAddress: AddressBean(
            latitude: 23.86,
            longitude: 45.27,
            displayAddressName:
                '12 King Fahd Rd, Al Islamiah, Jeddah, Jeddah,57513,Saudi Arabia',
          ),
        ),
        payment: Payment(
          mode: 'PAID',
          amount: 15,
          paymentID: 897,
          paymentDateTime: DateTime.now().subtract(const Duration(hours: 1)),
          deliveryAmount: 2,
          serviceAmount: 2,
        ),
      ),
      OrderEntity(
        orderID: 9,
        orderDateTime: DateTime.now().subtract(const Duration(hours: 2)),
        orderDeliveryDateTime:
            DateTime.now().subtract(const Duration(hours: 2, minutes: 30)),
        userInfo: UserInfo(
          userName: 'Ashutosh',
          deliveryAddress: DeliveryAddress(),
        ),
        store: Store(
          storeID: 4,
          storeName: 'American Food Plaza',
          location: AddressLocation(),
          menu: [
            Menu(
              quantity: 1,
              menuID: 21,
              menuName: 'Cheese Pizza',
              menuImage:
                  'https://img.freepik.com/free-photo/crispy-mixed-pizza-with-olives-sausage_140725-3095.jpg',
              addons: [
                Addon(
                  addonsName: 'Salad',
                  orderPortion: const OrderPortion(
                    portionSize: 1,
                    portionUnit: 'Plate',
                  ),
                  addonsId: 12,
                  price: 2,
                  addonsImage:
                      'https://img.freepik.com/free-photo/fresh-vegetables-colorful-sliced-such-as-cucumbers-red-tomatoes-onion-wooden-rustic-surface_140725-14178.jpg',
                ),
                Addon(
                  addonsName: 'Sweets',
                  orderPortion: const OrderPortion(
                    portionSize: 1,
                    portionUnit: 'Medium',
                  ),
                  addonsId: 4,
                  price: 2,
                  addonsImage:
                      'https://img.freepik.com/premium-photo/gulab-jamun-indian-dessert-topped-with-pistachio_136354-1769.jpg',
                ),
              ],
              tasteType: 'Pungent',
              tasteLevel: 'Medium',
              numberOfServingPerson: 2,
              unit: '1',
              orderPortion: const OrderPortion(
                portionSize: 1,
                portionUnit: 'Bowl',
              ),
            ),
          ],
        ),
        orderStatus: OrderStatus.readyToPickup.index,
        orderType: OrderType.onProcess.index,
        driver: DeliveryDriver(
          driverID: 1,
          driverName: 'Mr. Sakib Ahmed',
          driverContactNumber: '+966 556789456',
          driverAddress: AddressBean(
            latitude: 23.56,
            longitude: 45.67,
            displayAddressName:
                '11 Sayed Al Shouhada, Al Masani, Al Munawwarah,Buraydah,42313,Saudi Arabia',
          ),
        ),
        payment: Payment(
          mode: 'COD',
          amount: 23.0,
          paymentID: 347,
          paymentDateTime: DateTime.now().subtract(const Duration(hours: 2)),
          deliveryAmount: 2,
          serviceAmount: 2,
        ),
      ),
    ];
    final result = await serviceLocator<SaveAllOrderUseCase>()(data.toList());
    result.when(
      remote: (data, meta) {
        appLog.d('Saved all orders to remote ${data?.length}');
      },
      localDb: (data, meta) {
        appLog.d('Saved all orders to local ${data?.length}');
      },
      error: (dataSourceFailure, reason, error, networkException, stackTrace,
          exception, extra) {
        appLog.d('Saved all orders to error $reason');
      },
    );
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
        child: DoubleTapToExit(
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
            drawer: const PrimaryDashboardDrawer(
              key: const Key('manage-order-main-dashboard-drawer'),
              isMainDrawerPage: false,
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
      ),
    );
  }
}
