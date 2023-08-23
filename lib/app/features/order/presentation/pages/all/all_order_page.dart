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
  int pageKey = 1;
  String? searchText;
  String? sorting;
  String? filtering;
  final PagingController<int, OrderEntity> _pagingController = PagingController(firstPageKey: 1);
  List<OrderEntity> _allAvailableOrders = [];

  @override
  void initState() {
    super.initState();

    listViewBuilderScrollController = ScrollController();
    _allAvailableOrders = [];
    _allAvailableOrders.clear();
    _pagingController.addPageRequestListener((pageKey) {
      this.pageKey = pageKey;
    });
    _fetchPage(pageKey);
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

  Future<void> _fetchPage(pageKey, {int pageSize = 10, String? searchItem, String? filter, String? sort}) async {
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
  Widget build(BuildContext context) => BlocListener<AllOrderBloc, AllOrderState>(
        bloc: context.read<AllOrderBloc>(),
        key: const Key('get-allorders-bloc-listener-widget'),
        listener: (context, allOrderState) {
          switch (allOrderState) {
            case GetAllOrderState():
              {
                try {
                  final isLastPage = allOrderState.orderEntities.toList().length < pageSize;
                  if (isLastPage) {
                    _pagingController.appendLastPage(allOrderState.orderEntities.toList());
                  } else {
                    final nextPageKey = pageKey + 1;
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
    return CustomScrollView(
      controller: state.listViewBuilderScrollController,
      slivers: [
        PagedSliverList(
          pagingController: state._pagingController,
          builderDelegate: PagedChildBuilderDelegate<OrderEntity>(
              animateTransitions: true,
              itemBuilder: (context, orderResult, index) {
                return Card(
                  child: ListTile(
                    title: Text('${orderResult.store.menu[0].menuName}'),
                    subtitle: Text('${orderResult.store.storeName}'),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
