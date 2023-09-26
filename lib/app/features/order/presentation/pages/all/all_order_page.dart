part of 'package:homemakers_merchant/app/features/order/index.dart';

class AllOrderPages extends StatefulWidget {
  const AllOrderPages({super.key});

  @override
  _AllOrderPagesController createState() => _AllOrderPagesController();
}

class _AllOrderPagesController extends State<AllOrderPages> {
  late final ScrollController listViewBuilderScrollController;
  WidgetState<OrderEntity> widgetState = const WidgetState<OrderEntity>.none();

  // Pagination
  int pageSize = 10;
  int pageKey = 0;
  String? searchText;
  String? sorting;
  String? filtering;
  final PagingController<int, OrderEntity> _pagingController =
      PagingController(firstPageKey: 0);
  List<OrderEntity> _allAvailableOrders = [];

  @override
  void initState() {
    super.initState();

    listViewBuilderScrollController = ScrollController();
    _allAvailableOrders = [];
    _allAvailableOrders.clear();
    _pagingController.nextPageKey = 0;
    _pagingController.addPageRequestListener((pageKey) {
      this.pageKey = pageKey;
      _fetchPage(pageKey);
    });

    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching a all orders.',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
  }

  Future<void> _fetchPage(int pageKey,
      {int pageSize = 10,
      String? searchItem,
      String? filter,
      String? sort}) async {
    context.read<AllOrderBloc>().add(GetAllOrders(
          pageKey: pageKey,
          orderType: OrderType.all,
          pageSize: pageSize,
          searchText: searchItem,
          filter: filtering ?? filter,
          sorting: sorting ?? sort,
        ));

    return;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    listViewBuilderScrollController.dispose();
    _allAvailableOrders = [];
    _allAvailableOrders.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<AllOrderBloc, AllOrderState>(
        bloc: context.read<AllOrderBloc>(),
        key: const Key('get-allorders-bloc-listener-widget'),
        listener: (context, allOrderState) {
          switch (allOrderState) {
            case GetAllOrderState():
              {
                try {
                  final isLastPage =
                      allOrderState.orderEntities.length < pageSize;
                  if (isLastPage) {
                    _pagingController
                        .appendLastPage(allOrderState.orderEntities.toList());
                  } else {
                    final nextPageKey = allOrderState.pageKey +
                        allOrderState.orderEntities.length;
                    _pagingController.appendPage(
                        allOrderState.orderEntities.toList(), nextPageKey);
                  }
                  widgetState = WidgetState<OrderEntity>.allData(
                    context: context,
                    data: _pagingController.value.itemList ?? [],
                  );
                  _allAvailableOrders = _pagingController.value.itemList ?? [];
                } catch (error) {
                  _pagingController.error = error;
                  widgetState = WidgetState<OrderEntity>.error(
                    context: context,
                    reason: _pagingController.error,
                  );
                }
              }
            case GetAllEmptyOrderState():
              {
                widgetState = WidgetState<OrderEntity>.empty(
                  context: context,
                  message: allOrderState.message,
                );
              }
            case GetAllFailedOrderState():
              {
                widgetState = WidgetState<OrderEntity>.error(
                  context: context,
                  reason: allOrderState.message,
                );
              }
            case GetAllExceptionOrderState():
              {
                widgetState = WidgetState<OrderEntity>.error(
                  context: context,
                  reason: allOrderState.message,
                );
              }
            case GetAllLoadingOrderState():
              {
                widgetState = WidgetState<OrderEntity>.loading(
                  context: context,
                  message: allOrderState.message,
                );
              }
            case GetAllProcessingOrderState():
              {}
          }
        },
        child: _AllOrderPagesView(this),
      );
}

class _AllOrderPagesView
    extends WidgetView<AllOrderPages, _AllOrderPagesController> {
  const _AllOrderPagesView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding =
        margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CustomScrollView(
          controller: state.listViewBuilderScrollController,
          slivers: [
            SliverToBoxAdapter(
              child: AnimatedCrossFade(
                firstChild: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  children: [
                    const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SherlockSearchBar(
                              //isFullScreen: true,
                              sherlock: Sherlock(
                                  elements: state._allAvailableOrders
                                      .map((e) => e.toMap())
                                      .toList()),
                              sherlockCompletion: SherlockCompletion(
                                  where: 'by',
                                  elements: state._allAvailableOrders
                                      .map((e) => e.toMap())
                                      .toList()),
                              sherlockCompletionMinResults: 1,
                              onSearch: (input, sherlock) {
                                /*setState(() {
                                                                  state._results = sherlock.search(input: input);
                                                                });*/
                              },
                              completionsBuilder: (context, completions) =>
                                  SherlockCompletionsBuilder(
                                completions: completions,
                                buildCompletion: (completion) => Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Text(
                                        completion,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const Spacer(),
                                      const Icon(Icons.check),
                                      const Icon(Icons.close),
                                    ],
                                  ),
                                ),
                              ),
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 16.0),
                              constraints: const BoxConstraints(
                                  minWidth: 360.0,
                                  maxWidth: 800.0,
                                  minHeight: 48.0),
                              viewConstraints: BoxConstraints(
                                minWidth: 360 - (margins * 5),
                                minHeight: 150.0,
                                maxHeight: context.height / 2 -
                                    (context.mediaQueryViewInsets.bottom +
                                        margins +
                                        media.padding.top +
                                        kToolbarHeight +
                                        media.padding.bottom),
                              ),
                              viewShape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(12),
                              ),
                              isFullScreen: false,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(12),
                              ),
                              elevation: 1,
                            ),
                          ),
                          const AnimatedGap(12,
                              duration: Duration(milliseconds: 500)),
                          SizedBox(
                            height: 48,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(10),
                                ),
                                side: const BorderSide(
                                    color: Color.fromRGBO(238, 238, 238, 1)),
                                backgroundColor: Colors.white,
                              ),
                              child: Icon(
                                Icons.filter_list,
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                                color: context.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                    ListTile(
                      dense: true,
                      title: IntrinsicHeight(
                        child: Row(
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                          children: [
                            Text(
                              'All Orders',
                              style: context.labelMedium!.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                            ),
                            const AnimatedGap(3,
                                duration: Duration(milliseconds: 500)),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 12.0, end: 12, top: 4, bottom: 4),
                                child: Text(
                                  '${state._allAvailableOrders.length}',
                                  textDirection:
                                      serviceLocator<LanguageController>()
                                          .targetTextDirection,
                                ),
                              ),
                            ),
                            Spacer(),
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: context.width / 3),
                              child: AllStoreDialogWidget(
                                key: const Key('all-order-store-dialog-widget'),
                                onChanged: (value) {},
                                icon: Icons.arrow_drop_down,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(6),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color.fromRGBO(127, 129, 132, 1),
                                  ),
                                ),
                                padding: EdgeInsetsDirectional.only(
                                  start: 8,
                                  end: 2,
                                  top: 4,
                                  bottom: 4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      horizontalTitleGap: 0,
                      minLeadingWidth: 0,
                      contentPadding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 2),
                    ),
                    const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                  ],
                ),
                secondChild: const Offstage(),
                duration: const Duration(milliseconds: 500),
                crossFadeState: (state._allAvailableOrders.isNotEmpty)
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              ),
            ),
            PagedSliverList(
              pagingController: state._pagingController,
              builderDelegate: PagedChildBuilderDelegate<OrderEntity>(
                  animateTransitions: true,
                  itemBuilder: (context, orderResult, index) {
                    return OrderCardWidget(
                      key: ValueKey(index),
                      index: index,
                      orderEntity: orderResult,
                    );
                  }),
            ),
          ],
        ),
        /* AnimatedOpacity(
          opacity: state._pagingController.value.itemList.isNotNullOrEmpty ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: AnimatedPadding(
            padding: EdgeInsetsDirectional.only(bottom: 32, end: 8),
            duration: const Duration(milliseconds: 500),
            child: FloatingActionButton(
              backgroundColor: context.colorScheme.background,
              onPressed: () {},
              child: Icon(
                Icons.filter_alt_outlined,
                color: context.colorScheme.primary,
              ),
            ),
          ),
        ),*/
      ],
    );
  }
}
