part of 'package:homemakers_merchant/app/features/rate_review/index.dart';

class RateAndReviewPage extends StatefulWidget {
  const RateAndReviewPage({super.key});

  @override
  _RateAndReviewPageController createState() => _RateAndReviewPageController();
}

class _RateAndReviewPageController extends State<RateAndReviewPage> {
  static const _pageSize = 20;
  final PagingController<int, RateAndReviewEntity> _pagingController = PagingController(firstPageKey: 1);
  String? _searchTerm;
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    saveAll();
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

  Future<void> saveAll() async {
    final result = await serviceLocator<SaveAllRateAndReviewUseCase>()(
      <RateAndReviewEntity>[
        RateAndReviewEntity(
          body: RateAndReviewBody(
            category: 'Business Profile',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
            rating: 3.36,
            reviewDescription:
                "Eiusmod Lorem ex ullamco aute proident magna aute quis ullamco. Fugiat do incididunt veniam commodo non nostrud laboris labore ad qui pariatur quis quis. Id amet labore dolore anim ad est pariatur veniam velit nisi irure Lorem consequat labore. Non aliqua adipisicing eu quis ea tempor. Qui incididunt laborum laboris incididunt.",
            ratingOrderDetails: RatingOrderDetails(
              orderID: 83,
              menuName: "excepteur irure nostrud",
              orderDate: 1668564784804,
            ),
          ),
          title: 'Registration',
          subtitle: 'Your business account is created successfully',
          flag: 0,
          priority: 1,
          type: 'Profile',
          timestamp: 1692013576,
          userID: 31,
          userImage: "https://randomuser.me/api/portraits/men/23.jpg",
          ratingID: 32,
          userName: "Hugh Swaniawski",
        ),
        RateAndReviewEntity(
          body: RateAndReviewBody(
            category: 'Business Document',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
            rating: 1.36,
            reviewDescription:
                "Eiusmod Lorem ex ullamco aute proident magna aute quis ullamco. Fugiat do incididunt veniam commodo non nostrud laboris labore ad qui pariatur quis quis. Id amet labore dolore anim ad est pariatur veniam velit nisi irure Lorem consequat labore. Non aliqua adipisicing eu quis ea tempor. Qui incididunt laborum laboris incididunt.",
            ratingOrderDetails: RatingOrderDetails(
              orderID: 83,
              menuName: "excepteur irure nostrud",
              orderDate: 1668564784804,
            ),
          ),
          title: 'Business Document',
          subtitle: 'Your document account is uploaded successfully',
          flag: 1,
          priority: 1,
          type: 'Document',
          timestamp: 1691895632,
          userID: 31,
          userImage: "https://randomuser.me/api/portraits/men/73.jpg",
          ratingID: 32,
          userName: "Miguel Denesik",
        ),
        RateAndReviewEntity(
          body: RateAndReviewBody(
            category: 'Order',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
            rating: 3.36,
            reviewDescription:
                "Eiusmod Lorem ex ullamco aute proident magna aute quis ullamco. Fugiat do incididunt veniam commodo non nostrud laboris labore ad qui pariatur quis quis. Id amet labore dolore anim ad est pariatur veniam velit nisi irure Lorem consequat labore. Non aliqua adipisicing eu quis ea tempor. Qui incididunt laborum laboris incididunt.",
            ratingOrderDetails: RatingOrderDetails(
              orderID: 183,
              menuName: "excepteur irure nostrud",
              orderDate: 1668564784804,
            ),
          ),
          title: 'New Order',
          subtitle: 'One new order is placed into your store',
          flag: 0,
          priority: 1,
          type: 'New Order',
          timestamp: 1691433798,
          userID: 31,
          userImage: 'https://randomuser.me/api/portraits/men/75.jpg',
          ratingID: 32,
          userName: "Terri Mann",
        ),
        RateAndReviewEntity(
          body: RateAndReviewBody(
            category: 'Order',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
            rating: 4.6,
            reviewDescription:
                "Eiusmod Lorem ex ullamco aute proident magna aute quis ullamco. Fugiat do incididunt veniam commodo non nostrud laboris labore ad qui pariatur quis quis. Id amet labore dolore anim ad est pariatur veniam velit nisi irure Lorem consequat labore. Non aliqua adipisicing eu quis ea tempor. Qui incididunt laborum laboris incididunt.",
            ratingOrderDetails: RatingOrderDetails(
              orderID: 11,
              menuName: "excepteur irure nostrud",
              orderDate: 1668564784804,
            ),
          ),
          title: 'Order Delivered',
          subtitle: 'Your business account is created successfully',
          flag: 0,
          priority: 2,
          type: 'Delivery',
          timestamp: 1692204161,
          userID: 31,
          userImage: "https://randomuser.me/api/portraits/men/29.jpg",
          ratingID: 32,
          userName: "Hugh Swaniawski",
        ),
        RateAndReviewEntity(
          body: RateAndReviewBody(
            category: 'Payment',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
            rating: 5.0,
            reviewDescription:
                "Eiusmod Lorem ex ullamco aute proident magna aute quis ullamco. Fugiat do incididunt veniam commodo non nostrud laboris labore ad qui pariatur quis quis. Id amet labore dolore anim ad est pariatur veniam velit nisi irure Lorem consequat labore. Non aliqua adipisicing eu quis ea tempor. Qui incididunt laborum laboris incididunt.",
            ratingOrderDetails: RatingOrderDetails(
              orderID: 110,
              menuName: "excepteur irure nostrud",
              orderDate: 1668564784804,
            ),
          ),
          title: 'Payment Send',
          subtitle: 'You have successfully send the amount from wallet to your payment bank',
          flag: 1,
          priority: 1,
          type: 'Payment',
          timestamp: 1691824678,
          userID: 31,
          userImage: "https://randomuser.me/api/portraits/men/4.jpg",
          ratingID: 32,
          userName: "Hugh Swaniawski",
        ),
        RateAndReviewEntity(
          body: RateAndReviewBody(
            category: 'Business Profile',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
            rating: 3.0,
            reviewDescription:
                "Eiusmod Lorem ex ullamco aute proident magna aute quis ullamco. Fugiat do incididunt veniam commodo non nostrud laboris labore ad qui pariatur quis quis. Id amet labore dolore anim ad est pariatur veniam velit nisi irure Lorem consequat labore. Non aliqua adipisicing eu quis ea tempor. Qui incididunt laborum laboris incididunt.",
            ratingOrderDetails: RatingOrderDetails(
              orderID: 80,
              menuName: "excepteur irure nostrud",
              orderDate: 1668564784804,
            ),
          ),
          title: 'Registration',
          subtitle: 'Your business account is created successfully',
          flag: 0,
          priority: 1,
          type: 'Profile',
          timestamp: 1691773420,
          userID: 31,
          userImage: "https://randomuser.me/api/portraits/men/61.jpg",
          ratingID: 32,
          userName: "Hugh Swaniawski",
        ),
        RateAndReviewEntity(
          body: RateAndReviewBody(
            category: 'Business Document',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
            rating: 3.36,
            reviewDescription:
                "Eiusmod Lorem ex ullamco aute proident magna aute quis ullamco. Fugiat do incididunt veniam commodo non nostrud laboris labore ad qui pariatur quis quis. Id amet labore dolore anim ad est pariatur veniam velit nisi irure Lorem consequat labore. Non aliqua adipisicing eu quis ea tempor. Qui incididunt laborum laboris incididunt.",
            ratingOrderDetails: RatingOrderDetails(
              orderID: 122,
              menuName: "excepteur irure nostrud",
              orderDate: 1668564784804,
            ),
          ),
          title: 'Business Document',
          subtitle: 'Your document account is uploaded successfully',
          flag: 0,
          priority: 1,
          type: 'Document',
          timestamp: 1692209991,
          userID: 31,
          userImage: "https://randomuser.me/api/portraits/women/41.jpg",
          ratingID: 32,
          userName: "Hugh Swaniawski",
        ),
        RateAndReviewEntity(
          body: RateAndReviewBody(
            category: 'Order',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
            rating: 5.0,
            reviewDescription:
                "Eiusmod Lorem ex ullamco aute proident magna aute quis ullamco. Fugiat do incididunt veniam commodo non nostrud laboris labore ad qui pariatur quis quis. Id amet labore dolore anim ad est pariatur veniam velit nisi irure Lorem consequat labore. Non aliqua adipisicing eu quis ea tempor. Qui incididunt laborum laboris incididunt.",
            ratingOrderDetails: RatingOrderDetails(
              orderID: 135,
              menuName: "excepteur irure nostrud",
              orderDate: 1668564784804,
            ),
          ),
          title: 'New Order',
          subtitle: 'One new order is placed into your store',
          flag: 0,
          priority: 1,
          type: 'New Order',
          timestamp: 1691834568,
          userID: 31,
          userImage: "https://randomuser.me/api/portraits/women/87.jpg",
          ratingID: 32,
          userName: "Hugh Swaniawski",
        ),
        RateAndReviewEntity(
          body: RateAndReviewBody(
            category: 'Order',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
            rating: 4.0,
            reviewDescription:
                "Eiusmod Lorem ex ullamco aute proident magna aute quis ullamco. Fugiat do incididunt veniam commodo non nostrud laboris labore ad qui pariatur quis quis. Id amet labore dolore anim ad est pariatur veniam velit nisi irure Lorem consequat labore. Non aliqua adipisicing eu quis ea tempor. Qui incididunt laborum laboris incididunt.",
            ratingOrderDetails: RatingOrderDetails(
              orderID: 44,
              menuName: "excepteur irure nostrud",
              orderDate: 1668564784804,
            ),
          ),
          title: 'Order Delivered',
          subtitle: 'Your business account is created successfully',
          flag: 0,
          priority: 2,
          type: 'Delivery',
          timestamp: 1691757092,
          userID: 31,
          userImage: "https://randomuser.me/api/portraits/men/39.jpg",
          ratingID: 32,
          userName: "Hugh Swaniawski",
        ),
      ],
    );
    result.when(
      remote: (data, meta) {
        appLog.d('Saved rate and review to remote ${data?.length}');
      },
      localDb: (data, meta) {
        appLog.d('Saved rate and review to local ${data?.length}');
      },
      error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
        appLog.d('Saved rate and review to local $reason');
      },
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      await serviceLocator<GetAllRateAndReviewUseCase>()();
      // final newItems = await RemoteApi.getBeerList(
      //   pageKey,
      //   _pageSize,
      //   searchTerm: _searchTerm,
      // );
      List<RateAndReviewEntity> newItems = [];
      final result = await serviceLocator<GetAllRateAndReviewUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('Get rate and review to remote ${data?.length}');
          if (data.isNotNull) {
            newItems = data!.toList();
          }
        },
        localDb: (data, meta) {
          appLog.d('Get rate and review to local ${data?.length}');
          if (data.isNotNull) {
            newItems = data!.toList();
          }
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Get rate and review to local $reason');
        },
      );
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
  }

  void _updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    scrollController.dispose();
    innerScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _RateAndReviewPageView(this);
}

class _RateAndReviewPageView extends WidgetView<RateAndReviewPage, _RateAndReviewPageController> {
  const _RateAndReviewPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = margins; //media.padding.bottom + margins;
    final double width = media.size.width;
    final ThemeData theme = Theme.of(context);

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
              'Your Ratings',
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
            key: const Key('get-all-rate and review-slideinleft-widget'),
            delay: const Duration(milliseconds: 500),
            from: context.width - 40,
            child: PageBody(
              controller: state.scrollController,
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: media.size.height,
              ),
              padding: EdgeInsetsDirectional.only(
                top: margins,
                bottom: bottomPadding,
                start: margins * 2.5,
                end: margins * 2.5,
              ),
              child: CustomScrollView(
                slivers: <Widget>[
                  PagedSliverList<int, RateAndReviewEntity>(
                    pagingController: state._pagingController,
                    builderDelegate: PagedChildBuilderDelegate<RateAndReviewEntity>(
                      animateTransitions: true,
                      itemBuilder: (context, rateAndReviewResult, index) => RateAndReviewCardWidget(
                        key: ValueKey(index),
                        rateAndReviewEntity: rateAndReviewResult,
                      ),
                    ),
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
