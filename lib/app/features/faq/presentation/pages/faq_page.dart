part of 'package:homemakers_merchant/app/features/faq/index.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  _FaqPageController createState() => _FaqPageController();
}

class _FaqPageController extends State<FaqPage> {
  static const _pageSize = 20;
  final PagingController<int, FaqEntity> _pagingController = PagingController(firstPageKey: 1);
  String? _searchTerm;
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    //saveAll();
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

/*  Future<void> saveAll() async {
    final result = await serviceLocator<SaveAllNotificationUseCase>()(
      <FaqEntity>[
        FaqEntity(
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
        FaqEntity(
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
        FaqEntity(
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
        FaqEntity(
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
        FaqEntity(
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
        FaqEntity(
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
        FaqEntity(
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
        FaqEntity(
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
        FaqEntity(
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
        FaqEntity(
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
        FaqEntity(
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
        FaqEntity(
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
        FaqEntity(
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
        FaqEntity(
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
        FaqEntity(
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
  }*/

  Future<void> _fetchPage(int pageKey) async {
    try {
      //await serviceLocator<GetAllNotificationUseCase>()();
      // final newItems = await RemoteApi.getBeerList(
      //   pageKey,
      //   _pageSize,
      //   searchTerm: _searchTerm,
      // );
      List<FaqEntity> newItems = [
        FaqEntity(
          faqID: 1,
          question: 'I want to partner my business with HomeWay',
          answer: 'Partner with us, Send an email to partner@homeway.ar. We will revert within 24-48 hrs',
        ),
        FaqEntity(
            faqID: 2,
            question: 'What are the mandatory documents needed to list my business on HomeWay?',
            answer:
                "-  Copies of the below documents are mandatory \n-  FSSAI Licence OR FSSAI Acknowledgement \n-  Pan Card \n-  GSTIN Certificate \n-  Cancelled Cheque OR bank Passbook \n-  Menu"),
        FaqEntity(
          faqID: 3,
          question: 'After I submit all documents, how long will it take for my business to go live on HomeWay?',
          answer:
              'After all mandatory documents have been received and verified it takes upto 7-10 working days for the onboarding to be completed and make your business live on the platform.',
        ),
        FaqEntity(
          faqID: 4,
          question: 'I don’t have an FSSAI licence for my business. Can it still be onboarded?',
          answer:
              'FSSAI licence is a mandatory requirement according to the government’s policies. However, if you are yet to receive the licence at the time of onboarding, you can proceed with the acknowledgement number which you will have received from FSSAI for your registration.',
        ),
      ];
      /*final result = await serviceLocator<GetAllNotificationUseCase>()();
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
      );*/
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
  Widget build(BuildContext context) => _FaqPageView(this);
}

class _FaqPageView extends WidgetView<FaqPage, _FaqPageController> {
  const _FaqPageView(super.state);

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
              'FAQ',
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
            key: const Key('faq-page-slideinleft-widget'),
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
                  PagedSliverList<int, FaqEntity>(
                    pagingController: state._pagingController,
                    builderDelegate: PagedChildBuilderDelegate<FaqEntity>(
                      animateTransitions: true,
                      itemBuilder: (context, faqResult, index) => FaqWidget(
                        question: faqResult.question,
                        answer: faqResult.answer,
                        key: ValueKey(index),
                        ansDecoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                        queDecoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                        queStyle: context.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                        ansStyle: context.bodyMedium!.copyWith(),
                        ansPadding: const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 16),
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
