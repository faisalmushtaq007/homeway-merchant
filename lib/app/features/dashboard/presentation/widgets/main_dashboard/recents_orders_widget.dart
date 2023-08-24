part of 'package:homemakers_merchant/app/features/dashboard/index.dart';

class DashboardRecentOrders extends StatefulWidget {
  const DashboardRecentOrders({super.key});

  @override
  _DashboardRecentOrdersController createState() => _DashboardRecentOrdersController();
}

class _DashboardRecentOrdersController extends State<DashboardRecentOrders> {
  static const _pageSize = 10;
  int pageSize = 1;
  final PagingController<int, OrderEntity> _pagingController = PagingController(firstPageKey: 1);
  String? _searchTerm;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(
      viewportFraction: 0.5,
    );
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching a new page.',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<OrderEntity> newItems = [
        OrderEntity(
          orderID: 1,
          orderDateTime: DateTime.now(),
          orderDeliveryDateTime: DateTime.now().add(Duration(minutes: 15)),
          userInfo: UserInfo(
            userName: 'Sonu',
            deliveryAddress: DeliveryAddress(),
          ),
          store: Store(
            storeID: 12,
            storeName: 'Arabic Kitchen',
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
          orderType: OrderType.recent.index,
          driver: Driver(),
          payment: Payment(),
        ),
        OrderEntity(
          orderID: 2,
          orderDateTime: DateTime.now().subtract(Duration(minutes: 30)),
          orderDeliveryDateTime: DateTime.now().add(Duration(minutes: 5)),
          userInfo: UserInfo(
            userName: 'Sonu',
            deliveryAddress: DeliveryAddress(),
          ),
          store: Store(
            storeID: 12,
            storeName: 'Arabic Kitchen',
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
          orderType: OrderType.recent.index,
          driver: Driver(),
          payment: Payment(),
        ),
        OrderEntity(
          orderID: 3,
          orderDateTime: DateTime.now().subtract(Duration(minutes: 20)),
          orderDeliveryDateTime: DateTime.now().add(Duration(minutes: 15)),
          userInfo: UserInfo(
            userName: 'Sonu',
            deliveryAddress: DeliveryAddress(),
          ),
          store: Store(
            storeID: 12,
            storeName: 'Arabic Kitchen',
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
          orderType: OrderType.recent.index,
          driver: Driver(),
          payment: Payment(),
        ),
        OrderEntity(
          orderID: 4,
          orderDateTime: DateTime.now(),
          orderDeliveryDateTime: DateTime.now().add(Duration(minutes: 15)),
          userInfo: UserInfo(
            userName: 'Sonu',
            deliveryAddress: DeliveryAddress(),
          ),
          store: Store(
            storeID: 12,
            storeName: 'Arabic Kitchen',
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
          orderType: OrderType.recent.index,
          driver: Driver(),
          payment: Payment(),
        ),
      ];

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
    return;
  }

  @override
  void dispose() {
    _pagingController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _DashboardRecentOrdersView(this);
}

class _DashboardRecentOrdersView extends WidgetView<DashboardRecentOrders, _DashboardRecentOrdersController> {
  const _DashboardRecentOrdersView(super.state);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              children: [
                Text(
                  'Recent Orders',
                  style: context.titleMedium!.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ],
            ),
            /*Spacer(),
            Wrap(
              children: [
                InkWell(
                  onTap: () {},
                  child: Text(
                    'View All',
                    style: context.titleMedium!.copyWith(color: context.colorScheme.primary),
                  ),
                ),
              ],
            ),*/
          ],
        ),
        const AnimatedGap(4, duration: Duration(milliseconds: 100)),
        SizedBox(
          height: context.width / 1.8,
          child: PagedPageView<int, OrderEntity>(
            scrollDirection: Axis.horizontal,
            pagingController: state._pagingController,
            pageController: state.pageController,
            pageSnapping: false,
            padEnds: false,
            builderDelegate: PagedChildBuilderDelegate<OrderEntity>(
              animateTransitions: true,
              itemBuilder: (context, item, index) => RecentOrderTileWidget(
                entity: item,
                index: index,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RecentOrderTileWidget extends StatelessWidget {
  const RecentOrderTileWidget({
    required this.entity,
    required this.index,
    super.key,
  });

  final OrderEntity entity;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(index),
      margin: const EdgeInsetsDirectional.only(bottom: 4, end: 8, start: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(6),
      ),
      color: const Color.fromRGBO(242, 242, 242, 1),
      child: Padding(
        padding: EdgeInsetsDirectional.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                clipBehavior: Clip.none,
                children: [
                  ImageHelper(
                    image: entity.store.menu[0].menuImage,
                    //'https://img.freepik.com/premium-photo/dum-handi-chicken-biryani-is-prepared-earthen-clay-pot-called-haandi-popular-indian-non-vegetarian-food_466689-52225.jpg',
                    // image scale
                    scale: 1.0,
                    // Quality levels for image sampling in [ImageFilter] and [Shader] objects that sample
                    filterQuality: FilterQuality.high,
                    // border radius only work with [ImageShape.rounded]
                    borderRadius: BorderRadiusDirectional.circular(0),
                    // alignment of image
                    //alignment: Alignment.center,
                    // indicates where image will be loaded from, types are [network, asset,file]
                    imageType: findImageType(entity.store.menu[0].menuImage),
                    // indicates what shape you would like to be with image [rectangle, oval,circle or none]
                    imageShape: ImageShape.rectangle,
                    // image default box fit
                    boxFit: BoxFit.fill,
                    width: context.width,
                    //height: context.width / 2.5,
                    // imagePath: 'assets/images/image.png',
                    // default loader color, default value is null
                    //defaultLoaderColor: Colors.red,
                    // default error builder color, default value is null
                    defaultErrorBuilderColor: Colors.blueGrey,
                    // the color you want to change image with
                    //color: Colors.blue,
                    // blend mode with image only
                    //blendMode: BlendMode.srcIn,
                    // error builder widget, default as icon if null
                    errorBuilder: const Icon(
                      Icons.image_not_supported,
                      size: 10000,
                    ),
                    // loader builder widget, default as icon if null
                    loaderBuilder: const CircularProgressIndicator(),
                    matchTextDirection: true,
                    placeholderText: entity.store.menu[0].menuName,
                    placeholderTextStyle: context.labelLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(242, 242, 242, 1),
                  ),
                ),
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const AnimatedGap(16, duration: Duration(milliseconds: 100)),
                          Wrap(
                            children: [
                              Text(
                                entity.store.menu[0].menuName,
                                style: context.labelLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 2,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          const AnimatedGap(4, duration: Duration(milliseconds: 100)),
                          Text(
                            'Qty: ${entity.store.menu[0].quantity.toString()}',
                            style: context.labelMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.start,
                          ),
                          const AnimatedGap(4, duration: Duration(milliseconds: 100)),
                          Wrap(
                            children: [
                              Text(
                                '10.0 SAR',
                                style: context.labelLarge!
                                    .copyWith(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis, color: context.colorScheme.primary),
                                maxLines: 1,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      top: -20,
                      child: Center(
                        child: Chip(
                          labelPadding: const EdgeInsetsDirectional.all(3),
                          label: Text(
                            'Cooking',
                            style: context.labelSmall!.copyWith(
                              //color: const Color.fromRGBO(42, 45, 50, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          backgroundColor: const Color.fromRGBO(69, 201, 125, 1),
                          elevation: 0.0,
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: const EdgeInsetsDirectional.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            side: const BorderSide(
                              color: Color.fromRGBO(242, 242, 242, 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //const AnimatedGap(4, duration: Duration(milliseconds: 200)),
          ],
        ),
      ),
    );
  }
}
