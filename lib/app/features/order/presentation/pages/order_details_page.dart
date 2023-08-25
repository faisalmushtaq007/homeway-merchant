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
  OrderEntity orderEntity = OrderEntity(
    orderID: 1,
    orderDateTime: DateTime.now().subtract(const Duration(minutes: 15)),
    orderDeliveryDateTime: DateTime.now().add(const Duration(minutes: 15)),
    userInfo: UserInfo(
      userName: 'Sonu',
      contactNumber: '+966 556789675',
      deliveryAddress: DeliveryAddress(contactNumber: '+966 556789675', completeAddress: '8228 Imam Ali Road,Riyadh,16789,Saudi Arabia', contactPerson: 'Sonu'),
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
          menuImage: 'https://img.freepik.com/premium-photo/fish-biriyani-south-indian-style-fish-biriyani-arranged-traditionally-brass-vessel_527904-1690.jpg',
        ),
      ],
    ),
    orderStatus: OrderStatus.newOrder.index,
    orderType: OrderType.newOrder.index,
    driver: Driver(),
    payment: Payment(
      mode: 'COD',
      amount: 30,
      paymentID: 222,
    ),
  );

  String activeLocale = 'en_US';
  final Map<String, moment.MomentLocalization> locales = moment.MomentLocalizations.locales.map((key, value) => MapEntry(key, value()));

  @override
  void initState() {
    super.initState();
    //orderEntity = widget.orderEntity;
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
  Widget build(BuildContext context) => _OrderDetailPageView(this);
}

class _OrderDetailPageView extends WidgetView<OrderDetailPage, _OrderDetailPageController> {
  const _OrderDetailPageView(super.state);

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
              title: Text('Order Details'),
              centerTitle: false,
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
              key: const Key('order-details-dashboard-drawer'),
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
                            ListTile(
                              title: Directionality(
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                child: WrapText(
                                  '${state.orderEntity.store.storeName} ',
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
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                child: WrapText(
                                  'Order ID: HMW-${state.orderEntity.orderID} ',
                                  breakWordCharacter: '-',
                                  smartSizeMode: false,
                                  asyncMode: true,
                                  minFontSize: 12,
                                  maxFontSize: 14,
                                  textStyle: context.labelLarge!.copyWith(fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              trailing: ClipRRect(
                                borderRadius: BorderRadiusDirectional.circular(24),
                                child: Container(
                                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(251, 219, 11, 1),
                                    borderRadius: BorderRadiusDirectional.circular(24),
                                    border: Border.all(
                                      color: const Color.fromRGBO(243, 188, 88, 1),
                                    ),
                                  ),
                                  child: Directionality(
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    child: WrapText(
                                      'PAID',
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
                              visualDensity: VisualDensity(horizontal: -4),
                              minLeadingWidth: 0,
                              contentPadding: EdgeInsetsDirectional.zero,
                            ),
                            /*const AnimatedGap(
                              6,
                              duration: Duration(milliseconds: 100),
                            ),*/
                            Directionality(
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              child: WrapText(
                                '${state.orderEntity.store.menu[0].menuName} ',
                                breakWordCharacter: '-',
                                smartSizeMode: false,
                                asyncMode: true,
                                minFontSize: 14,
                                maxFontSize: 16,
                                textStyle: context.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  //color: context.colorScheme.primary,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const AnimatedGap(
                              12,
                              duration: Duration(milliseconds: 100),
                            ),
                            Card(
                              margin: EdgeInsetsDirectional.zero,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: 12,
                                  end: 12,
                                  top: 12,
                                  bottom: 12,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  children: [
                                    Flexible(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                              children: [
                                                Directionality(
                                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                  child: WrapText(
                                                    'Received At',
                                                    breakWordCharacter: '-',
                                                    smartSizeMode: false,
                                                    asyncMode: true,
                                                    minFontSize: 12,
                                                    maxFontSize: 14,
                                                    textStyle: context.labelMedium!.copyWith(fontWeight: FontWeight.w500),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Directionality(
                                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                  child: WrapText(
                                                    '${now.subtract(now.difference(state.orderEntity.orderDateTime)).calendar()}',
                                                    breakWordCharacter: '-',
                                                    smartSizeMode: false,
                                                    asyncMode: true,
                                                    minFontSize: 12,
                                                    maxFontSize: 14,
                                                    textStyle: context.bodySmall!.copyWith(fontWeight: FontWeight.w600),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 60,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                children: [
                                                  Container(
                                                    height: 15,
                                                    width: 1,
                                                    color: Color.fromRGBO(165, 166, 168, 0.5),
                                                  ),
                                                  CircleAvatar(
                                                    radius: 14,
                                                    backgroundColor: Colors.white,
                                                    child: Icon(
                                                      Icons.arrow_forward,
                                                      color: context.colorScheme.primary,
                                                      size: 16,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 15,
                                                    width: 1,
                                                    color: Color.fromRGBO(165, 166, 168, 0.5),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                              children: [
                                                Directionality(
                                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                  child: WrapText(
                                                    'Delivered By',
                                                    breakWordCharacter: '-',
                                                    smartSizeMode: false,
                                                    asyncMode: true,
                                                    minFontSize: 12,
                                                    maxFontSize: 14,
                                                    textStyle: context.labelMedium!.copyWith(
                                                      fontWeight: FontWeight.w500,
                                                      color: context.colorScheme.primary,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Directionality(
                                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                  child: WrapText(
                                                    '${now.subtract(now.difference(state.orderEntity.orderDeliveryDateTime)).calendar()}',
                                                    breakWordCharacter: '-',
                                                    smartSizeMode: false,
                                                    asyncMode: true,
                                                    minFontSize: 12,
                                                    maxFontSize: 14,
                                                    textStyle: context.bodySmall!.copyWith(
                                                      fontWeight: FontWeight.w600,
                                                      color: context.colorScheme.primary,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const AnimatedGap(
                              12,
                              duration: Duration(milliseconds: 100),
                            ),
                            Card(
                              margin: EdgeInsetsDirectional.zero,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                children: [
                                  Container(
                                    padding: const EdgeInsetsDirectional.only(
                                      start: 12,
                                      end: 12,
                                      top: 12,
                                      bottom: 12,
                                    ),
                                    decoration: const BoxDecoration(
                                      //color: context.colorScheme.secondaryContainer,
                                      color: Color.fromRGBO(238, 238, 238, 1),
                                      borderRadius: BorderRadiusDirectional.only(
                                        topStart: Radius.circular(10),
                                        topEnd: Radius.circular(10),
                                      ),
                                    ),
                                    child: Directionality(
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      child: WrapText(
                                        'Customer Details',
                                        breakWordCharacter: '-',
                                        smartSizeMode: false,
                                        asyncMode: true,
                                        minFontSize: 13,
                                        maxFontSize: 14,
                                        textStyle: context.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.w600,
                                          //color: context.colorScheme.primary,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                      start: 12,
                                      end: 12,
                                      top: 12,
                                      bottom: 8,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Directionality(
                                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                child: WrapText(
                                                  'Name',
                                                  breakWordCharacter: '-',
                                                  smartSizeMode: false,
                                                  asyncMode: true,
                                                  minFontSize: 12,
                                                  maxFontSize: 13,
                                                  textStyle: context.labelMedium!.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: context.colorScheme.inverseSurface,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            const AnimatedGap(
                                              8,
                                              duration: Duration(milliseconds: 100),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Wrap(
                                                children: [
                                                  Directionality(
                                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                    child: WrapText(
                                                      '${state.orderEntity.userInfo.deliveryAddress.contactPerson}',
                                                      breakWordCharacter: '-',
                                                      smartSizeMode: false,
                                                      asyncMode: true,
                                                      minFontSize: 12,
                                                      maxFontSize: 13,
                                                      textStyle: context.bodySmall!.copyWith(
                                                        fontWeight: FontWeight.w500,
                                                        color: context.colorScheme.inverseSurface,
                                                      ),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const AnimatedGap(
                                          12,
                                          duration: Duration(milliseconds: 100),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Directionality(
                                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                child: WrapText(
                                                  'Mobile',
                                                  breakWordCharacter: '-',
                                                  smartSizeMode: false,
                                                  asyncMode: true,
                                                  minFontSize: 12,
                                                  maxFontSize: 13,
                                                  textStyle: context.labelMedium!.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: context.colorScheme.inverseSurface,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            const AnimatedGap(
                                              8,
                                              duration: Duration(milliseconds: 100),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Wrap(
                                                children: [
                                                  Directionality(
                                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                    child: WrapText(
                                                      '${state.orderEntity.userInfo.deliveryAddress.contactNumber}',
                                                      breakWordCharacter: '-',
                                                      smartSizeMode: false,
                                                      asyncMode: true,
                                                      minFontSize: 12,
                                                      maxFontSize: 13,
                                                      textStyle: context.bodySmall!.copyWith(
                                                        fontWeight: FontWeight.w500,
                                                        color: context.colorScheme.inverseSurface,
                                                      ),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const AnimatedGap(
                                          12,
                                          duration: Duration(milliseconds: 100),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Directionality(
                                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                child: WrapText(
                                                  'Address',
                                                  breakWordCharacter: '-',
                                                  smartSizeMode: false,
                                                  asyncMode: true,
                                                  minFontSize: 12,
                                                  maxFontSize: 13,
                                                  textStyle: context.labelMedium!.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: context.colorScheme.inverseSurface,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            const AnimatedGap(
                                              8,
                                              duration: Duration(milliseconds: 100),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Wrap(
                                                children: [
                                                  Directionality(
                                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                    child: WrapText(
                                                      '${state.orderEntity.userInfo.deliveryAddress.completeAddress}',
                                                      breakWordCharacter: '-',
                                                      smartSizeMode: false,
                                                      asyncMode: true,
                                                      minFontSize: 12,
                                                      maxFontSize: 13,
                                                      textStyle: context.bodySmall!.copyWith(
                                                        fontWeight: FontWeight.w500,
                                                        color: context.colorScheme.inverseSurface,
                                                      ),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const AnimatedGap(
                                          8,
                                          duration: Duration(milliseconds: 100),
                                        ),
                                        Divider(
                                          thickness: 0.75,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Directionality(
                                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                              child: WrapText(
                                                'Communication:',
                                                breakWordCharacter: '-',
                                                smartSizeMode: false,
                                                asyncMode: true,
                                                minFontSize: 12,
                                                maxFontSize: 13,
                                                textStyle: context.labelMedium!.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: context.colorScheme.inverseSurface,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Spacer(),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.map,
                                                  color: context.colorScheme.primary,
                                                ),
                                                onPressed: () {},
                                                style: IconButton.styleFrom(
                                                  shape: CircleBorder(),
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                )),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.chat,
                                                  color: context.colorScheme.primary,
                                                ),
                                                onPressed: () {},
                                                style: IconButton.styleFrom(
                                                  shape: CircleBorder(),
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                )),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.phone_in_talk,
                                                  color: context.colorScheme.primary,
                                                ),
                                                onPressed: () {},
                                                style: IconButton.styleFrom(
                                                  shape: CircleBorder(),
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const AnimatedGap(
                              12,
                              duration: Duration(milliseconds: 100),
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
