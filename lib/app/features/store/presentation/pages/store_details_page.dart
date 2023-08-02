part of 'package:homemakers_merchant/app/features/store/index.dart';

class StoreDetailsPage extends StatefulWidget {
  const StoreDetailsPage({
    super.key,
    required this.storeEntity,
    this.index = -1,
    this.storeEntities = const [],
  });

  final StoreEntity storeEntity;
  final int index;
  final List<StoreEntity> storeEntities;

  @override
  _StoreDetailsPageController createState() => _StoreDetailsPageController();
}

class _StoreDetailsPageController extends State<StoreDetailsPage> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  List<String> listOfStoreImages = [];
  List<BannerModel> listBanners = [];
  StoreEntity storeEntity = StoreEntity();
  List<StoreEntity> storeEntities = [];
  int currentIndex = -1;
  bool isStoreOnline = false;
  List<StoreOrderInfo> listOfStoreOrderInfo = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    storeEntities = [];
    storeEntities.clear();
    listOfStoreOrderInfo = [];
    listOfStoreOrderInfo.clear();
    storeEntity = widget.storeEntity;
    currentIndex = widget.index;
    storeEntities = List<StoreEntity>.from(widget.storeEntities.toList());
    listOfStoreImages = [];
    listOfStoreImages.clear();
    listOfStoreImages = [
      'https://img.freepik.com/free-photo/smiling-asian-barista-girl-wears-apron-shows-credit-card-machine-processing-payment-suggest-p_1258-134410.jpg',
      'https://img.freepik.com/premium-photo/charming-woman-working-her-bakery-shop_130388-1288.jpg'
    ];
    listBanners = [];
    listBanners.clear();
    listBanners = [
      BannerModel(
          imagePath:
              'https://img.freepik.com/premium-photo/generative-ai-portrait-happy-restaurant-owner-standing-front-coffee-shop-with-open-signboard_28914-14863.jpg?size=626&ext=jpg',
          id: "1"),
      BannerModel(
          imagePath:
              'https://img.freepik.com/premium-photo/contemporary-young-handsome-waiter-apron-using-tablet-while-taking-online-orders-clients-come-evening_274679-13753.jpg?size=626&ext=jpg',
          id: "2"),
    ];
  }

  @override
  void dispose() {
    scrollController.dispose();
    innerScrollController.dispose();
    listOfStoreImages = [];
    listOfStoreImages.clear;
    listBanners = [];
    listBanners.clear();
    storeEntities = [];
    storeEntities.clear();
    listOfStoreOrderInfo = [];
    listOfStoreOrderInfo.clear();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listOfStoreOrderInfo = [
      StoreOrderInfo(
        title: 'New',
        subTitle: '5',
        titleTextColor: context.colorScheme.primary,
        subTitleTextColor: context.colorScheme.primary,
      ),
      StoreOrderInfo(
        title: 'Schedule',
        subTitle: '4',
        titleTextColor: Color.fromRGBO(42, 45, 50, 1),
        subTitleTextColor: Color.fromRGBO(42, 45, 50, 1),
      ),
      StoreOrderInfo(
        title: 'Ongoing',
        subTitle: '2',
        titleTextColor: Color.fromRGBO(255, 90, 39, 1),
        subTitleTextColor: Color.fromRGBO(255, 90, 39, 1),
      ),
      StoreOrderInfo(
        title: 'Delivered',
        subTitle: '75',
        titleTextColor: Color.fromRGBO(69, 201, 125, 1),
        subTitleTextColor: Color.fromRGBO(69, 201, 125, 1),
      ),
      StoreOrderInfo(
        title: 'Cancel',
        subTitle: '4',
        titleTextColor: context.colorScheme.outlineVariant,
        subTitleTextColor: context.colorScheme.outlineVariant,
      ),
    ];
  }

  void onStoreOnlineChanged(bool value) {
    setState(() {
      isStoreOnline = value;
    });
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<StoreBloc, StoreState>(
        bloc: context.watch<StoreBloc>(),
        key: const Key('store-details-page-bloc-builder-widget'),
        builder: (context, storeState) {
          return _StoreDetailsPageView(this);
        },
      );
}

class _StoreDetailsPageView extends WidgetView<StoreDetailsPage, _StoreDetailsPageController> {
  const _StoreDetailsPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = margins; //media.padding.bottom + margins;
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: FlexColorScheme.themedSystemNavigationBar(
          context,
          useDivider: false,
          opacity: 0.60,
          noAppBar: true,
        ),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              'Your store',
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
            ),
            actions: const [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          body: SlideInLeft(
            key: const Key('store-details-slideinleft-widget'),
            delay: const Duration(milliseconds: 500),
            from: context.width - 40,
            child: PageBody(
              controller: state.scrollController,
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: media.size.height,
              ),
              /*padding: EdgeInsetsDirectional.only(
                top: topPadding,
                start: margins * 2.5,
                end: margins * 2.5,
              ),*/
              child: NestedScrollView(
                physics: ClampingScrollPhysics(),
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    AdaptiveHeightSliverPersistentHeader(
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        child: BannerCarousel(
                          banners: state.listBanners,
                          customizedIndicators: IndicatorModel.animation(width: 20, height: 5, spaceBetween: 2, widthAnimation: 50),
                          height: 150,
                          activeColor: Colors.amberAccent,
                          disableColor: Colors.white,
                          animation: true,
                          margin: EdgeInsetsDirectional.zero,
                          onTap: (id) => print(id),
                          borderRadius: 0,
                          //width: 250,
                          indicatorBottom: true,
                          outerBorderRadius: BorderRadiusDirectional.zero,
                          bannerWidgetBorderRadius: BorderRadiusDirectional.zero,
                        ),
                      ),
                      floating: true,
                    ),
                  ];
                },
                body: CustomScrollView(
                  controller: state.innerScrollController,
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: margins,
                              bottom: margins,
                              start: margins * 2.5,
                              end: margins * 2.5,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const AnimatedGap(12, duration: Duration(milliseconds: 200)),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.store,
                                      color: context.colorScheme.primary,
                                      size: 32,
                                    ),
                                    const AnimatedGap(12, duration: Duration(milliseconds: 200)),
                                    Text(
                                      'Nura Birayani', //state.storeEntity.storeName,
                                      style: context.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                const AnimatedGap(8, duration: Duration(milliseconds: 200)),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      'Macs Eatery ماكس ايتري  18th Street, As Salam, Dammam 32416, Saudi Arabia', //state.storeEntity.storeName,

                                      style: context.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                const AnimatedGap(8, duration: Duration(milliseconds: 200)),
                                Divider(),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      IntrinsicHeight(
                                        child: TextButton.icon(
                                          onPressed: () {},
                                          icon: Icon(Icons.share),
                                          label: Text('Share Store'),
                                        ),
                                      ),
                                      Spacer(),
                                      IntrinsicHeight(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Transform.scale(
                                              //scale: 0.8,
                                              scaleX: 0.80,
                                              scaleY: 0.7,
                                              child: CupertinoSwitch(
                                                value: state.isStoreOnline,
                                                onChanged: state.onStoreOnlineChanged,
                                              ),
                                            ),
                                            Text('Store Online'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                                const AnimatedGap(8, duration: Duration(milliseconds: 200)),
                                Card(
                                  child: ListTile(
                                    title: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          'Customer Review',
                                          style: context.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                                        ),
                                        IntrinsicHeight(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              RatingBar.readOnly(
                                                filledIcon: Icons.star,
                                                emptyIcon: Icons.star_border,
                                                initialRating: 4.5,
                                                maxRating: 5,
                                                size: 28,
                                              ),
                                              Container(
                                                padding: EdgeInsetsDirectional.symmetric(vertical: 1, horizontal: 8),
                                                margin: EdgeInsetsDirectional.only(end: 8),
                                                child: Text(
                                                  "${4.5.toStringAsPrecision(2)}/${5.toStringAsPrecision(2)}",
                                                ),
                                                decoration: BoxDecoration(
                                                    color: const Color(0xff9b9b9b), shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10)),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    subtitle: Text(
                                      '450 Ratings',
                                    ),
                                  ),
                                ),
                                const AnimatedGap(12, duration: Duration(milliseconds: 200)),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 13),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        const AnimatedGap(6, duration: Duration(milliseconds: 200)),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Store Orders',
                                                style: context.titleLarge!.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: context.colorScheme.primary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 55,
                                          child: IntrinsicHeight(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                StoreOrderCardWidget(
                                                  storeOrderInfo: StoreOrderInfo(
                                                    title: 'Total',
                                                    subTitle: '90',
                                                    titleTextColor: context.colorScheme.onPrimaryContainer,
                                                    subTitleTextColor: context.colorScheme.onPrimaryContainer,
                                                  ),
                                                ),
                                                const AnimatedGap(6, duration: Duration(milliseconds: 200)),
                                                VerticalDivider(
                                                  thickness: 0.75,
                                                  indent: 6,
                                                  endIndent: 6,
                                                ),
                                                const AnimatedGap(6, duration: Duration(milliseconds: 200)),
                                                Expanded(
                                                  child: ListView.separated(
                                                    scrollDirection: Axis.horizontal,
                                                    shrinkWrap: true,
                                                    separatorBuilder: (context, index) {
                                                      return Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          const AnimatedGap(4, duration: Duration(milliseconds: 200)),
                                                          VerticalDivider(
                                                            thickness: 0.75,
                                                            indent: 6,
                                                            endIndent: 6,
                                                          ),
                                                          const AnimatedGap(4, duration: Duration(milliseconds: 200)),
                                                        ],
                                                      );
                                                    },
                                                    itemCount: state.listOfStoreOrderInfo.length,
                                                    itemBuilder: (context, index) {
                                                      return StoreOrderCardWidget(
                                                        key: ValueKey(index),
                                                        storeOrderInfo: state.listOfStoreOrderInfo[index],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const AnimatedGap(6, duration: Duration(milliseconds: 200)),
                                      ],
                                    ),
                                  ),
                                ),
                                const AnimatedGap(12, duration: Duration(milliseconds: 200)),
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
          ),
        ),
      ),
    );
  }
}
