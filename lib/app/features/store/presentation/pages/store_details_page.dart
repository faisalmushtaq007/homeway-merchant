part of 'package:homemakers_merchant/app/features/store/index.dart';

class StoreDetailsPage extends StatefulWidget {
  const StoreDetailsPage({super.key});

  @override
  _StoreDetailsPageController createState() => _StoreDetailsPageController();
}

class _StoreDetailsPageController extends State<StoreDetailsPage> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  List<String> listOfStoreImages = [];
  List<BannerModel> listBanners = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
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
    super.dispose();
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
              padding: EdgeInsetsDirectional.only(
                top: topPadding,
                start: margins * 2.5,
                end: margins * 2.5,
              ),
              child: Stack(
                children: [
                  CustomScrollView(
                    controller: state.innerScrollController,
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.circular(10),
                                ),
                                child: BannerCarousel(
                                  banners: state.listBanners,
                                  customizedIndicators: IndicatorModel.animation(width: 20, height: 5, spaceBetween: 2, widthAnimation: 50),
                                  height: 150,
                                  activeColor: Colors.amberAccent,
                                  disableColor: Colors.white,
                                  animation: true,
                                  margin: EdgeInsetsDirectional.zero,
                                  borderRadius: 10,
                                  onTap: (id) => print(id),
                                  //width: 250,
                                  indicatorBottom: true,
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
