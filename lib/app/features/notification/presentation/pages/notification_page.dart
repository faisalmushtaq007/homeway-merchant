part of 'package:homemakers_merchant/app/features/notification/index.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageController createState() => _NotificationPageController();
}

class _NotificationPageController extends State<NotificationPage> {
  static const _pageSize = 20;
  final PagingController<int, NotificationEntity> _pagingController = PagingController(firstPageKey: 1);
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
    final result = await serviceLocator<SaveAllNotificationUseCase>()(
      <NotificationEntity>[
        NotificationEntity(
          body: NotificationBody(
            category: 'Business Profile',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
          ),
          title: 'Registration',
          subtitle: 'Your business account is created successfully',
          flag: 0,
          priority: 1,
          type: 'Profile',
          timestamp: 1692190683,
        ),
        NotificationEntity(
          body: NotificationBody(
            category: 'Business Document',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
          ),
          title: 'Business Document',
          subtitle: 'Your document account is uploaded successfully',
          flag: 1,
          priority: 1,
          type: 'Document',
          timestamp: 1692190780,
        ),
        NotificationEntity(
          body: NotificationBody(
            category: 'Order',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
          ),
          title: 'New Order',
          subtitle: 'One new order is placed into your store',
          flag: 0,
          priority: 1,
          type: 'New Order',
          timestamp: 1692117514,
        ),
        NotificationEntity(
          body: NotificationBody(
            category: 'Order',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
          ),
          title: 'Order Delivered',
          subtitle: 'Your business account is created successfully',
          flag: 0,
          priority: 2,
          type: 'Delivery',
          timestamp: 1692172955,
        ),
        NotificationEntity(
          body: NotificationBody(
            category: 'Payment',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
          ),
          title: 'Payment Send',
          subtitle: 'You have successfully send the amount from wallet to your payment bank',
          flag: 1,
          priority: 1,
          type: 'Payment',
          timestamp: 1692223078,
        ),
        NotificationEntity(
          body: NotificationBody(
            category: 'Business Profile',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
          ),
          title: 'Registration',
          subtitle: 'Your business account is created successfully',
          flag: 0,
          priority: 1,
          type: 'Profile',
          timestamp: 1692092858,
        ),
        NotificationEntity(
          body: NotificationBody(
            category: 'Business Document',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
          ),
          title: 'Business Document',
          subtitle: 'Your document account is uploaded successfully',
          flag: 0,
          priority: 1,
          type: 'Document',
          timestamp: 1692211891,
        ),
        NotificationEntity(
          body: NotificationBody(
            category: 'Order',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
          ),
          title: 'New Order',
          subtitle: 'One new order is placed into your store',
          flag: 0,
          priority: 1,
          type: 'New Order',
          timestamp: 1692123966,
        ),
        NotificationEntity(
          body: NotificationBody(
            category: 'Order',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
          ),
          title: 'Order Delivered',
          subtitle: 'Your business account is created successfully',
          flag: 0,
          priority: 2,
          type: 'Delivery',
          timestamp: 1692188160,
        ),
        NotificationEntity(
          body: NotificationBody(
            category: 'Payment',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
          ),
          title: 'Payment Send',
          subtitle: 'You have successfully send the amount from wallet to your payment bank',
          flag: 1,
          priority: 1,
          type: 'Payment',
          timestamp: 1692223078,
        ),
        NotificationEntity(
          body: NotificationBody(
            category: 'Business Profile',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
          ),
          title: 'Registration',
          subtitle: 'Your business account is created successfully',
          flag: 0,
          priority: 1,
          type: 'Profile',
          timestamp: 1692092858,
        ),
        NotificationEntity(
          body: NotificationBody(
            category: 'Business Document',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
          ),
          title: 'Business Document',
          subtitle: 'Your document account is uploaded successfully',
          flag: 0,
          priority: 1,
          type: 'Document',
          timestamp: 1692211891,
        ),
        NotificationEntity(
          body: NotificationBody(
            category: 'Order',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
          ),
          title: 'New Order',
          subtitle: 'One new order is placed into your store',
          flag: 0,
          priority: 1,
          type: 'New Order',
          timestamp: 1692123966,
        ),
        NotificationEntity(
          body: NotificationBody(
            category: 'Order',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
          ),
          title: 'Order Delivered',
          subtitle: 'Your business account is created successfully',
          flag: 0,
          priority: 2,
          type: 'Delivery',
          timestamp: 1692188160,
        ),
        NotificationEntity(
          body: NotificationBody(
            category: 'Payment',
            message: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups',
          ),
          title: 'Payment Send',
          subtitle: 'You have successfully send the amount from wallet to your payment bank',
          flag: 1,
          priority: 1,
          type: 'Payment',
          timestamp: 1692223078,
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

  Future<void> _fetchPage(int pageKey) async {
    try {
      await serviceLocator<GetAllNotificationUseCase>()();
      // final newItems = await RemoteApi.getBeerList(
      //   pageKey,
      //   _pageSize,
      //   searchTerm: _searchTerm,
      // );
      List<NotificationEntity> newItems = [];
      final result = await serviceLocator<GetAllNotificationUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('Get notification to remote ${data?.length}');
          if (data.isNotNull) {
            newItems = data!.toList();
          }
        },
        localDb: (data, meta) {
          appLog.d('Get notification to local ${data?.length}');
          if (data.isNotNull) {
            newItems = data!.toList();
          }
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Get notification to local $reason');
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
  Widget build(BuildContext context) => _NotificationPageView(this);
}

class _NotificationPageView extends WidgetView<NotificationPage, _NotificationPageController> {
  const _NotificationPageView(super.state);

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
              'Your Notifications',
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
            key: const Key('get-all-notification-slideinleft-widget'),
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
                  PagedSliverList<int, NotificationEntity>(
                    pagingController: state._pagingController,
                    builderDelegate: PagedChildBuilderDelegate<NotificationEntity>(
                      animateTransitions: true,
                      itemBuilder: (context, notificationResult, index) => NotificationCardWidget(
                        key: ValueKey(index),
                        notificationEntity: notificationResult,
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
