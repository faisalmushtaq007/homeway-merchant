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
  int pageSize = 20;
  int pageKey = 0;
  String? searchText;
  String? sorting;
  String? filtering;
  final PagingController<int, OrderEntity> _pagingController = PagingController(firstPageKey: 0);
  List<OrderEntity> _allAvailableOrders = [];

  @override
  void initState() {
    super.initState();

    listViewBuilderScrollController = ScrollController();
    _allAvailableOrders = [];
    _allAvailableOrders.clear();
  }

  Future<void> _fetchPage(pageKey, {int pageSize = 20, String? searchItem, String? filter, String? sort}) async {
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
  Widget build(BuildContext context) => BlocListener<AllOrderBloc, AllOrderState>(
        bloc: context.read<AllOrderBloc>(),
        key: const Key('get-allorders-bloc-listener-widget'),
        listener: (context, allOrderState) {
          switch (allOrderState) {
            case GetAllOrderState():
              {
                try {
                  final isLastPage = allOrderState.orderEntities.length < pageSize;
                  if (isLastPage) {
                    _pagingController.appendLastPage(allOrderState.orderEntities.toList());
                  } else {
                    final nextPageKey = allOrderState.pageKey + allOrderState.orderEntities.length;
                    _pagingController.appendPage(allOrderState.orderEntities.toList(), nextPageKey);
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

class _AllOrderPagesView extends WidgetView<AllOrderPages, _AllOrderPagesController> {
  const _AllOrderPagesView(super.state);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CustomScrollView(
          controller: state.listViewBuilderScrollController,
          slivers: [
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
        AnimatedOpacity(
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
        ),
      ],
    );
  }
}
