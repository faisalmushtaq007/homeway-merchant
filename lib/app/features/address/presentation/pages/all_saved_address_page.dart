part of 'package:homemakers_merchant/app/features/address/index.dart';

class AllSavedAddressPage extends StatefulWidget {
  const AllSavedAddressPage({
    super.key,
    this.selectItemUseCase = SelectItemUseCase.none,
  });

  final SelectItemUseCase selectItemUseCase;

  @override
  _AllSavedAddressPageController createState() =>
      _AllSavedAddressPageController();
}

class _AllSavedAddressPageController extends State<AllSavedAddressPage> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;

  WidgetState<AddressModel> widgetState =
      const WidgetState<AddressModel>.none();
  int pageSize = 10;
  int pageKey = 0;
  String? searchText;
  String? sorting;
  String? filtering;
  late final PagingController<int, AddressModel> _pagingController;
  List<AddressModel> addressEntities = [];

  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: 0);
    addressEntities = [];
    addressEntities.clear();
    //_pagingController.refresh();
    _refreshAddressList();
    widgetState = WidgetState<AddressModel>.loading(context: context);
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    //context.read<AddressBloc>().add(const GetAllAddress());
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
      context.read<AddressBloc>().add(
            GetAllAddressPagination(
              pageKey: pageKey,
              pageSize: pageSize,
              searchText: searchText ?? searchItem,
              filter: filtering ?? filter,
              sorting: sorting ?? sort,
            ),
          );
      appLog.i('Fetch Address');
      return;
    } catch (error) {
      _pagingController.error = error;
      debugPrint(error.toString());
    }
  }

  @override
  void dispose() {
    _pagingController.removeListener(() {});
    _pagingController.removePageRequestListener((pageKey) {});
    _pagingController.removeStatusListener((status) {});
    _pagingController.dispose();

    addressEntities = [];
    addressEntities.clear();
    scrollController.dispose();
    innerScrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _refreshAddressList() {
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
    if (_pagingController.value.itemList == null ||
        _pagingController.value.itemList.isEmptyOrNull) {
      await _fetchPage(
        0,
        searchItem: searchTerm,
      );
    } else {
      _pagingController.refresh();
    }
  }

  @override
  Widget build(BuildContext context) => BlocListener<AddressBloc, AddressState>(
        key: const Key('all-address-bloc-listener'),
        bloc: context.read<AddressBloc>(),
        //listenWhen: (previous, current) => previous != current,
        listener: (context, addressListenerState) {
          switch (addressListenerState) {
            case GetAllAddressPaginationState():
              {
                try {
                  final isLastPage =
                      addressListenerState.addressEntities.length < pageSize;
                  if (isLastPage) {
                    _pagingController.appendLastPage(
                        addressListenerState.addressEntities.toList());
                  } else {
                    final nextPageKey = addressListenerState.pageKey +
                        addressListenerState.addressEntities.length;
                    //final nextPageKey = addressState.pageKey + 1;
                    _pagingController.appendPage(
                        addressListenerState.addressEntities.toList(),
                        nextPageKey);
                  }
                  widgetState = WidgetState<AddressModel>.allData(
                    context: context,
                    data: _pagingController.value.itemList ?? [],
                  );
                  addressEntities = _pagingController.value.itemList ?? [];
                } catch (error) {
                  _pagingController.error = error;
                  widgetState = WidgetState<AddressModel>.error(
                    context: context,
                    reason: _pagingController.error,
                  );
                }
              }
            case GetAllEmptyAddressPaginationState():
              {
                widgetState = WidgetState<AddressModel>.empty(
                  context: context,
                  message: addressListenerState.message,
                );
              }
            case GetAllLoadingAddressPaginationState():
              {
                widgetState = WidgetState<AddressModel>.loading(
                  context: context,
                  message: addressListenerState.message,
                );
              }
            case GetAllProcessingAddressPaginationState():
              {
                widgetState = WidgetState<AddressModel>.processing(
                  context: context,
                  message: addressListenerState.message,
                );
              }
            case GetAllExceptionAddressPaginationState():
              {
                widgetState = WidgetState<AddressModel>.error(
                  context: context,
                  reason: addressListenerState.message,
                );
              }
            case GetAllFailedAddressPaginationState():
              {
                widgetState = WidgetState<AddressModel>.error(
                  context: context,
                  reason: addressListenerState.message,
                );
              }
            case _:
              appLog.d('Default case: all address page bloc listener');
          }
        },
        child: BlocBuilder<AddressBloc, AddressState>(
          key: const Key('all-address-bloc-builder'),
          bloc: context.read<AddressBloc>(),
          builder: (context, addressState) {
            print(addressState.runtimeType);
            switch (addressState) {
              case AddressExceptionState():
                {
                  widgetState = WidgetState<AddressModel>.error(
                    context: context,
                    reason: addressState.message,
                  );
                }
              case AddressFailedState():
                {
                  widgetState = WidgetState<AddressModel>.error(
                    context: context,
                    reason: addressState.message,
                  );
                }
              case AddressEmptyState():
                {
                  widgetState = WidgetState<AddressModel>.empty(
                    context: context,
                  );
                  addressEntities = [];
                }
              case GetAllAddressState():
                {
                  widgetState = WidgetState<AddressModel>.allData(
                    context: context,
                    data: _pagingController.value.itemList ?? [],
                  );
                  addressEntities = addressState.addressEntities.toList();
                }
              case _:
                appLog.d('Default case: all address page bloc builder');
            }
            return _AllSavedAddressPageView(this);
          },
        ),
      );
}

class _AllSavedAddressPageView
    extends WidgetView<AllSavedAddressPage, _AllSavedAddressPageController> {
  const _AllSavedAddressPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding =
        margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = media.padding.bottom + margins;
    final double width = media.size.width;
    final ThemeData theme = Theme.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
        noAppBar: true,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Address'),
          actions: const [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
              child: LanguageSelectionWidget(),
            ),
          ],
        ),
        body: Directionality(
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
          child: SlideInLeft(
            key: const Key('all-saved-address-page-slideleft-widget'),
            delay: const Duration(milliseconds: 500),
            child: PageBody(
              controller: state.scrollController,
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: media.size.height,
              ),
              child: BlocBuilder<PermissionBloc, PermissionState>(
                bloc: context.read<PermissionBloc>(),
                buildWhen: (previous, current) => previous != current,
                builder: (context, permissionState) {
                  return SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                        minWidth: double.infinity,
                        maxHeight: media.size.height -
                            (media.padding.top +
                                kToolbarHeight +
                                media.padding.bottom),
                      ),
                      padding: EdgeInsetsDirectional.only(
                        top: topPadding,
                        start: margins * 2.5,
                        end: margins * 2.5,
                        //bottom: bottomPadding,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                        children: [
                          AnimatedCrossFade(
                            firstChild: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                              children: [
                                const AnimatedGap(6,
                                    duration: Duration(milliseconds: 500)),
                                //
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    textDirection:
                                        serviceLocator<LanguageController>()
                                            .targetTextDirection,
                                    children: [
                                      Expanded(
                                        child: AppSearchInputSliverWidget(
                                          key: const Key(
                                              'all-address-search-field-widget'),
                                          onChanged: state._updateSearchTerm,
                                          height: 48,
                                          hintText: 'Search Address',
                                        ),
                                      ),
                                      const AnimatedGap(12,
                                          duration:
                                              Duration(milliseconds: 500)),
                                      SizedBox(
                                        height: 46,
                                        child: OutlinedButton(
                                          onPressed: () {},
                                          style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadiusDirectional
                                                      .circular(10),
                                            ),
                                            side: const BorderSide(
                                                color: Color.fromRGBO(
                                                    238, 238, 238, 1)),
                                            backgroundColor: Colors.white,
                                          ),
                                          child: Icon(
                                            Icons.filter_list,
                                            textDirection: serviceLocator<
                                                    LanguageController>()
                                                .targetTextDirection,
                                            color: context.primaryColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const AnimatedGap(6,
                                    duration: Duration(milliseconds: 500)),
                                //
                                ListTile(
                                  dense: true,
                                  title: IntrinsicHeight(
                                    child: Row(
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      children: [
                                        Text(
                                          'Your Address',
                                          style: context.labelLarge!.copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                        ),
                                        const AnimatedGap(3,
                                            duration:
                                                Duration(milliseconds: 500)),
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(
                                                start: 12.0,
                                                end: 12,
                                                top: 4,
                                                bottom: 4),
                                            child: Text(
                                              '${state._pagingController.value.itemList?.length ?? 0}',
                                              textDirection: serviceLocator<
                                                      LanguageController>()
                                                  .targetTextDirection,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  horizontalTitleGap: 0,
                                  minLeadingWidth: 0,
                                  contentPadding:
                                      EdgeInsetsDirectional.symmetric(
                                          horizontal: 2),
                                ),
                                const AnimatedGap(6,
                                    duration: Duration(milliseconds: 500)),
                              ],
                            ),
                            secondChild: const Offstage(),
                            duration: const Duration(milliseconds: 500),
                            crossFadeState: (state.addressEntities.isNotEmpty)
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                          ),
                          Expanded(
                            child: state.widgetState.maybeWhen(
                              empty: (context, child, message, data) =>
                                  const NoItemAvailableWidget(
                                key: Key('all-address-empty-widget'),
                                textMessage:
                                    'No address available or added by you',
                              ),
                              loading: (context, child, message, isLoading) =>
                                  const DataLoadingWidget(
                                key: Key('all-menu-loading-widget'),
                              ),
                              processing:
                                  (context, child, message, isLoading) =>
                                      const DataLoadingWidget(
                                key: Key('all-menu-processing-widget'),
                              ),
                              allData: (context, child, message, data) {
                                return CustomScrollView(
                                  controller: state.innerScrollController,
                                  slivers: [
                                    PagedSliverList<int, AddressModel>(
                                      key: const Key(
                                          'address-list-pagedSliverList-widget'),
                                      pagingController: state._pagingController,
                                      builderDelegate:
                                          PagedChildBuilderDelegate<
                                              AddressModel>(
                                        animateTransitions: true,
                                        itemBuilder: (context, item, index) =>
                                            AddressCardWidget(
                                          key: ValueKey(index),
                                          addressEntity:
                                              state.addressEntities[index],
                                          listOfAllAddressEntities:
                                              state.addressEntities.toList(),
                                          currentIndex: index,
                                          selectItemUseCase:
                                              widget.selectItemUseCase,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                                return ListView.separated(
                                  itemBuilder: (context, index) {
                                    return AddressCardWidget(
                                      key: ValueKey(index),
                                      addressEntity:
                                          state.addressEntities[index],
                                      listOfAllAddressEntities:
                                          state.addressEntities.toList(),
                                      currentIndex: index,
                                    );
                                  },
                                  shrinkWrap: true,
                                  itemCount: state.addressEntities.length,
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                        thickness: 0.25,
                                        color:
                                            Color.fromRGBO(127, 129, 132, 1));
                                  },
                                );
                              },
                              none: () {
                                return const NoItemAvailableWidget(
                                  key: Key('all-address-none-widget'),
                                  textMessage:
                                      'No address available or added by you',
                                );
                              },
                              orElse: () {
                                return const NoItemAvailableWidget(
                                  key: Key('all-menu-else-widget'),
                                  textMessage:
                                      'No address available or added by you',
                                );
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final navigateToSaveStorePage =
                                        await context.push(
                                      Routes.PICKUP_LOCATION_FROM_MAP_PAGE,
                                      extra: {
                                        'addressEntity': null,
                                        'addressEntities':
                                            state.addressEntities.toList(),
                                        'haveNewAddress': true,
                                        'currentIndex': -1,
                                      },
                                    );
                                    if (!state.mounted) {
                                      return;
                                    }
                                    //context.read<AddressBloc>().add(const GetAllAddress());
                                    if (state._pagingController.value
                                                .itemList ==
                                            null ||
                                        state._pagingController.value.itemList
                                            .isEmptyOrNull) {
                                      appLog.d(
                                          'state._pagingController.value.itemList null');
                                      await state._fetchPage(0);
                                    } else {
                                      appLog.d(
                                          'state._pagingController.value.itemList not null');
                                      state._pagingController.refresh();
                                    }
                                    return;
                                  },
                                  child: Text(
                                    'Add New Address',
                                    textDirection:
                                        serviceLocator<LanguageController>()
                                            .targetTextDirection,
                                  ).translate(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
