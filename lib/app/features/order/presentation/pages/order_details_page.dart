part of 'package:homemakers_merchant/app/features/order/index.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({
    required this.orderID,
    super.key,
    this.orderEntity,
  });

  final OrderEntity? orderEntity;
  final int orderID;

  @override
  _OrderDetailPageController createState() => _OrderDetailPageController();
}

class _OrderDetailPageController extends State<OrderDetailPage> {
  late final ScrollController scrollController;
  late final ScrollController customScrollViewScrollController;
  double subTotal = 0;
  OrderEntity orderEntity = OrderEntity(
    orderID: 1,
    orderDateTime: DateTime.now().subtract(const Duration(minutes: 15)),
    orderDeliveryDateTime: DateTime.now().add(const Duration(minutes: 15)),
    userInfo: UserInfo(
      userName: 'Sonu',
      contactNumber: '+966 556789675',
      deliveryAddress: DeliveryAddress(
          contactNumber: '+966 556789675',
          completeAddress: '8228 Imam Ali Road,Riyadh,16789,Saudi Arabia',
          contactPerson: 'Sonu'),
    ),
    store: Store(
      storeID: 1,
      storeName: 'Life Cafe',
      location: AddressLocation(),
      orderMenuName: 'Chicken Biryani',
      orderMenuImage:
          'https://img.freepik.com/premium-photo/fish-biriyani-south-indian-style-fish-biriyani-arranged-traditionally-brass-vessel_527904-1690.jpg',
      menu: [
        Menu(
          quantity: 1,
          menuID: 21,
          price: 10,
          menuName: 'Chicken Biryani',
          menuImage:
              'https://img.freepik.com/premium-photo/fish-biriyani-south-indian-style-fish-biriyani-arranged-traditionally-brass-vessel_527904-1690.jpg',
          addons: [],
          tasteType: 'Spicy',
          tasteLevel: 'Medium',
          numberOfServingPerson: 2,
          unit: '2',
          orderPortion: const OrderPortion(
            portionSize: 1,
            portionUnit: 'Bowl',
          ),
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
              quantity: 1,
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
              quantity: 1,
              addonsName: 'Sweets',
              orderPortion: const OrderPortion(
                portionSize: 4,
                portionUnit: 'Pcs',
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
    orderStatus: OrderStatus.newOrder.index,
    orderType: OrderType.newOrder.index,
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
      mode: 'COD',
      amount: 30,
      paymentID: 222,
      deliveryAmount: 2,
      paymentDateTime: DateTime.now().subtract(const Duration(minutes: 15)),
      serviceAmount: 1,
    ),
    trackingInfo: [],
  );

  String activeLocale = 'en_US';
  final Map<String, moment.MomentLocalization> locales = moment
      .MomentLocalizations.locales
      .map((key, value) => MapEntry(key, value()));
  final TextEditingController cancelReason = TextEditingController();

  @override
  void initState() {
    super.initState();
    //orderEntity = widget.orderEntity;
    scrollController = ScrollController();
    customScrollViewScrollController = ScrollController();
    activeLocale =
        serviceLocator<LanguageController>().targetAppLanguage.value.toString();
    subTotal = 0.0;
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

  void calculateSubTotal(double amount) {
    subTotal += amount;
    setState(() {});
  }

  Future<bool?> confirmCancelOrder(
      BuildContext context, OrderEntity orderEntity) async {
    final bool? status = await showConfirmationDialog<bool>(
      context: context,
      barrierDismissible: true,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 700),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ResponsiveDialog(
              context: context,
              hideButtons: false,
              maxLongSide: context.height / 1.90,
              maxShortSide: context.width,
              key: const Key('order-details-cancel-confirmation-dialog'),
              title: 'Confirm Order Cancel?',
              confirmText: 'Cancel Order',
              cancelText: 'Keep Order',
              okPressed: () async {
                debugPrint('Dialog confirmed');
                Navigator.of(context).pop(true);
              },
              cancelPressed: () {
                debugPrint('Dialog cancelled');
                Navigator.of(context).pop(false);
              },
              child: SingleChildScrollView(
                child: Column(
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Wrap(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '',
                            style: context.labelMedium,
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'We would sorry to cancel your order go. Cancelling this order will cause it not to another orders but if you cancel the order your loving customer will be feel sad.\n',
                                style: context.labelMedium,
                              ),
                              TextSpan(
                                text:
                                    '\nAre you sure you want to cancel this order. The action can not be undone.\n',
                                style: context.labelMedium,
                              ),
                              TextSpan(
                                text:
                                    '\nWe are always here to help. For any question, please visit our ',
                                style: context.labelMedium,
                              ),
                              TextSpan(
                                  text: 'Help Center',
                                  style: context.labelMedium!.copyWith(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {}),
                              TextSpan(
                                text: ' for more information.\n',
                                style: context.labelMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      controller: cancelReason,
                      maxLines: 3,
                      decoration: InputDecoration(
                          hintText:
                              'Share the reason for canceling this order'),
                    ),
                    //textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    if (status != null) {
      return status;
    }
    return false;
  }

  Widget bottomWidget(int index) {
    return switch (
        OrderStatus.values.byName(OrderStatus.values[index].toString())) {
      OrderStatus.newOrder => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                onPressed: () async {
                  final result = await confirmCancelOrder(context, orderEntity);
                },
                child: Text(
                  'Cancel',
                  style: const TextStyle(color: Color.fromRGBO(42, 45, 50, 1)),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
              ),
            ),
            const AnimatedGap(
              8,
              duration: Duration(milliseconds: 100),
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                ),
                onPressed: () {},
                child: Text(
                  'Accept',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
              ),
            ),
          ],
        ),
      OrderStatus.onProcessing || OrderStatus.preparing => Row(
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Delay',
                  style: const TextStyle(color: Color.fromRGBO(42, 45, 50, 1)),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
              ),
            ),
            const AnimatedGap(
              8,
              duration: Duration(milliseconds: 100),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                ),
                child: Text(
                  'Move to Ready',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
              ),
            ),
          ],
        ),
      _ => const Offstage(),
    };
  }

  @override
  Widget build(BuildContext context) => _OrderDetailPageView(this);
}

class _OrderDetailPageView
    extends WidgetView<OrderDetailPage, _OrderDetailPageController> {
  const _OrderDetailPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding =
        margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = margins;
    moment.Moment.setGlobalLocalization(
        moment.MomentLocalizations.byLocale(state.activeLocale)!);

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
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Order Details'),
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
                    style: context.labelSmall!
                        .copyWith(color: context.colorScheme.onPrimary),
                    //Color.fromRGBO(251, 219, 11, 1)
                  ),
                  child: Icon(
                    Icons.notifications,
                    color: context.colorScheme.primary,
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                  ),
                ),
              ),
              Directionality(
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.help,
                    color: context.colorScheme.primary,
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.only(end: 8),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          body: SlideInLeft(
            key: const Key('order-details-page-slideinleft-widget'),
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
                          ListTile(
                            title: Directionality(
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                              child: WrapText(
                                state.orderEntity.store.storeName,
                                breakWordCharacter: '-',
                                smartSizeMode: false,
                                asyncMode: true,
                                minFontSize: 12,
                                maxFontSize: 14,
                                textStyle: context.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: context.colorScheme.primary,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            subtitle: Directionality(
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                              child: WrapText(
                                'Order ID: HMW-${state.orderEntity.orderID}',
                                breakWordCharacter: '-',
                                smartSizeMode: false,
                                asyncMode: true,
                                minFontSize: 12,
                                maxFontSize: 14,
                                textStyle: context.labelLarge!
                                    .copyWith(fontWeight: FontWeight.w500),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            trailing: ClipRRect(
                              borderRadius:
                                  BorderRadiusDirectional.circular(24),
                              child: Container(
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(251, 219, 11, 1),
                                  borderRadius:
                                      BorderRadiusDirectional.circular(24),
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(243, 188, 88, 1),
                                  ),
                                ),
                                child: Directionality(
                                  textDirection:
                                      serviceLocator<LanguageController>()
                                          .targetTextDirection,
                                  child: WrapText(
                                    state.orderEntity.payment.mode,
                                    breakWordCharacter: '-',
                                    smartSizeMode: false,
                                    asyncMode: true,
                                    minFontSize: 12,
                                    maxFontSize: 13,
                                    textStyle: context.bodySmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            horizontalTitleGap: 0,
                            visualDensity: const VisualDensity(horizontal: -4),
                            minLeadingWidth: 0,
                            contentPadding: EdgeInsetsDirectional.zero,
                          ),
                          /*const AnimatedGap(
                            6,
                            duration: Duration(milliseconds: 100),
                          ),*/

                          OrderTimeLineCardWidget(
                            key:
                                const Key('order-details-timeline-card-widget'),
                            orderEntity: state.orderEntity,
                            activeLocale: state.activeLocale,
                          ),
                          const AnimatedGap(
                            12,
                            duration: Duration(milliseconds: 100),
                          ),
                          Wrap(
                            children: [
                              OrderTimelineTrackingWidget(
                                key: const Key(
                                    'order-details-timeline--tracking-card-widget'),
                                orderEntity: state.orderEntity,
                                activeLocale: state.activeLocale,
                              ),
                            ],
                          ),
                          const AnimatedGap(
                            12,
                            duration: Duration(milliseconds: 100),
                          ),
                          Directionality(
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            child: Wrap(
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                              children: [
                                Text(
                                  'Ordered Menu',
                                  style: context.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    //color: context.colorScheme.primary,
                                  ),
                                  maxLines: 3,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const AnimatedGap(
                            6,
                            duration: Duration(milliseconds: 100),
                          ),
                          Wrap(
                            //direction: Axis.vertical,
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            children: [
                              OrderMenuDetailsWidget(
                                key: const Key(
                                    'order-details-menu-details-widget'),
                                orderEntity: state.orderEntity,
                                subTotalOnChange: (value) {},
                              ),
                            ],
                          ),
                          const AnimatedGap(
                            12,
                            duration: Duration(milliseconds: 100),
                          ),
                          OrderDeliveryInfoWidget(
                              key: const Key(
                                  'order-details-customer-info-widget'),
                              orderEntity: state.orderEntity),
                          const AnimatedGap(
                            12,
                            duration: Duration(milliseconds: 100),
                          ),
                          Text(
                            'Assigned Delivery Executive',
                            style: context.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 1,
                          ),
                          const AnimatedGap(
                            6,
                            duration: Duration(milliseconds: 100),
                          ),
                          AssignDriverWidget(
                            key:
                                const Key('order-details-assign-driver-widget'),
                            orderEntity: state.orderEntity,
                          ),
                          const AnimatedGap(
                            12,
                            duration: Duration(milliseconds: 100),
                          ),
                          Text(
                            'Payment Summary',
                            style: context.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 1,
                          ),
                          const AnimatedGap(
                            6,
                            duration: Duration(milliseconds: 100),
                          ),
                          OrderPaymentSummary(
                            key: const Key(
                                'order-details-payment-summary-widget'),
                            orderEntity: state.orderEntity,
                          ),
                          const AnimatedGap(
                            12,
                            duration: Duration(milliseconds: 100),
                          ),
                          state.bottomWidget(state.orderEntity.orderStatus),
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
    );
  }
}
