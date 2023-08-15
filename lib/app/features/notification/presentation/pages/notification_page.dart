part of 'package:homemakers_merchant/app/features/notification/index.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageController createState() => _NotificationPageController();
}

class _NotificationPageController extends State<NotificationPage> {
  static const _pageSize = 17;

  final PagingController<int, NotificationEntity> _pagingController = PagingController(firstPageKey: 1);

  String? _searchTerm;

  @override
  void initState() {
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
          body: NotificationBody(category: 'Business Profile'),
          title: 'Registration',
          subtitle: 'Your business account is created successfully',
          flag: 0,
          priority: 1,
          type: 'Profile',
        ),
        NotificationEntity(
          body: NotificationBody(category: 'Business Document'),
          title: 'Business Document',
          subtitle: 'Your document account is uploaded successfully',
          flag: 0,
          priority: 1,
          type: 'Document',
        ),
        NotificationEntity(
          body: NotificationBody(category: 'Order'),
          title: 'New Order',
          subtitle: 'One new order is placed into your store',
          flag: 0,
          priority: 1,
          type: 'New Order',
        ),
        NotificationEntity(
          body: NotificationBody(category: 'Order'),
          title: 'Order Delivered',
          subtitle: 'Your business account is created successfully',
          flag: 0,
          priority: 2,
          type: 'Delivery',
        ),
        NotificationEntity(
          body: NotificationBody(category: 'Payment'),
          title: 'Payment Send',
          subtitle: 'You have successfully send the amount from wallet to your payment bank',
          flag: 1,
          priority: 1,
          type: 'Payment',
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _NotificationPageView(this);
}

class _NotificationPageView extends WidgetView<NotificationPage, _NotificationPageController> {
  const _NotificationPageView(super.state);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        PagedSliverList<int, NotificationEntity>(
          pagingController: state._pagingController,
          builderDelegate: PagedChildBuilderDelegate<NotificationEntity>(
            animateTransitions: true,
            itemBuilder: (context, notificationResult, index) => NotificationCardWidget(
              notificationEntity: notificationResult,
            ),
          ),
        ),
      ],
    );
  }
}
