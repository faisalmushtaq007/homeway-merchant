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
  late final PagingController<int, OrderEntity> _pagingController ;
  List<OrderEntity> _allAvailableOrders = [];

  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: 0);
    _allAvailableOrders = [];
    _allAvailableOrders.clear();
    _refreshOrdersList();
    listViewBuilderScrollController = ScrollController();
    super.initState();
  }

  Future<void> _fetchPage(int pageKey,
      {int pageSize = 10,
        String? searchItem,
        String? filter,
        String? sort}) async {
    /*if (pageKey == 0) {
      _pagingController.itemList = [];
    }*/
    int sectionNumber = pageKey ~/ pageSize;
    try {
      context.read<AllOrderBloc>().add(
        GetAllOrders(
          pageKey: pageKey,
          pageSize: pageSize,
          searchText: searchText??searchItem,
          filter: filtering ?? filter,
          sorting: sorting ?? sort,
          orderType: OrderType.all,
        ),
      );
      appLog.i('Fetch Store');
      return;
    } catch (error) {
      _pagingController.error = error;
      debugPrint(error.toString());
    }
  }

  void _refreshOrdersList() {
    //_pagingController.refresh();
    _pagingController.nextPageKey = 0;
    _fetchPage(0);
    _pagingController.addPageRequestListener((pageKey) {
      this.pageKey = pageKey;
      appLog.d('Page key addPageRequestListener ${pageKey}');
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

  Future<void> _updateSearchTerm(String searchTerm) async {
    searchText = searchTerm;
    if (_pagingController.value
        .itemList ==
        null ||
        _pagingController.value.itemList
            .isEmptyOrNull) {
      await _fetchPage(0, searchItem: searchTerm,);
    } else {
      _pagingController.refresh();
    }
  }


  @override
  void dispose() {
    _pagingController.removeListener(() {});
    _pagingController.removePageRequestListener((pageKey) {});
    _pagingController.removeStatusListener((status) {});
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
                    _pagingController.appendLastPage(
                        allOrderState.orderEntities.toList());
                  } else {
                    final nextPageKey = allOrderState.pageKey +
                        allOrderState.orderEntities.length;
                    //final nextPageKey = addressState.pageKey + 1;
                    _pagingController.appendPage(
                        allOrderState.orderEntities.toList(),
                        nextPageKey);
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
    return CustomScrollView(
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
                      Expanded(child:  AppSearchInputSliverWidget(
                        key: const Key('all-orders-search-field-widget'),
                        onChanged: state._updateSearchTerm,
                        height: 48,
                        hintText: 'Search Store',

                      ),),
                      const AnimatedGap(12,
                          duration: Duration(milliseconds: 500)),
                      SizedBox(
                        height: 46,
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
            duration: const Duration(milliseconds: 300),
            crossFadeState: (state._pagingController.value.itemList.isNotNullOrEmpty && state._allAvailableOrders.length>0)
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
    );
  }
}
