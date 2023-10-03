part of 'package:homemakers_merchant/app/features/store/index.dart';

class AllStoresPage extends StatefulWidget {
  const AllStoresPage({
    super.key,
    this.selectItemUseCase = SelectItemUseCase.none,
  });

  final SelectItemUseCase selectItemUseCase;

  @override
  State<AllStoresPage> createState() => _AllStoresPageState();
}

class _AllStoresPageState extends State<AllStoresPage> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  List<StoreEntity> storeEntities = [];
  late final ScrollController listViewBuilderScrollController;
  ResultState<StoreEntity> resultState = const ResultState.empty();
  WidgetState<StoreEntity> widgetState = const WidgetState<StoreEntity>.none();
  final TextEditingController searchTextEditingController =
  TextEditingController();
  // Pagination
  int pageSize = 10;
  int pageKey = 0;
  String? searchText;
  String? sorting;
  String? filtering;
  late final PagingController<int, StoreEntity> _pagingController;

  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: 0);
    storeEntities = [];
    storeEntities.clear();
    _refreshAddressList();
    widgetState = WidgetState<StoreEntity>.loading(context: context);

    scrollController = ScrollController();
    innerScrollController = ScrollController();
    listViewBuilderScrollController = ScrollController();

    //context.read<StoreBloc>().add(GetAllStore());
    super.initState();
    initStoreList();
  }

  void initStoreList() {}

  @override
  void dispose() {
    _pagingController.removeListener(() {});
    _pagingController.removePageRequestListener((pageKey) {});
    _pagingController.removeStatusListener((status) {});
    _pagingController.dispose();
    storeEntities = [];
    storeEntities.clear();
    scrollController.dispose();
    innerScrollController.dispose();
    listViewBuilderScrollController.dispose();
    super.dispose();
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
      context.read<StoreBloc>().add(
        GetAllStoresPagination(
          pageKey: pageKey,
          pageSize: pageSize,
          searchText: searchText??searchItem,
          filter: filtering ?? filter,
          sorting: sorting ?? sort,
        ),
      );
      appLog.i('Fetch Store');
      return;
    } catch (error) {
      _pagingController.error = error;
      debugPrint(error.toString());
    }
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
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding =
        margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
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
              'All Stores',
              textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
            ),
            actions: const [
              NotificationIconWidget(),
              LanguageSelectionWidget(),
            ],
          ),
          body: SlideInLeft(
            key: const Key('get-all-store-slideinleft-widget'),
            delay: const Duration(milliseconds: 500),
            from: context.width - 40,
            child: PageBody(
              controller: scrollController,
              constraints: BoxConstraints(
                minWidth: 1000,
                minHeight: media.size.height,
              ),
              padding: EdgeInsetsDirectional.only(
                top: margins,
                //bottom: bottomPadding,
                start: margins * 2.5,
                end: margins * 2.5,
              ),
              child: BlocListener<StoreBloc, StoreState>(
                bloc: context.read<StoreBloc>(),
                listener: (context, storeListenerState) {
                  switch (storeListenerState) {
                    case GetAllStorePaginationState():
                      {
                        try {
                          final isLastPage =
                              storeListenerState.storeEntities.length < pageSize;
                          if (isLastPage) {
                            _pagingController.appendLastPage(
                                storeListenerState.storeEntities.toList());
                          } else {
                            final nextPageKey = storeListenerState.pageKey +
                                storeListenerState.storeEntities.length;
                            //final nextPageKey = addressState.pageKey + 1;
                            _pagingController.appendPage(
                                storeListenerState.storeEntities.toList(),
                                nextPageKey);
                          }
                          widgetState = WidgetState<StoreEntity>.allData(
                            context: context,
                            data: _pagingController.value.itemList ?? [],
                          );
                          storeEntities = _pagingController.value.itemList ?? [];
                        } catch (error) {
                          _pagingController.error = error;
                          widgetState = WidgetState<StoreEntity>.error(
                            context: context,
                            reason: _pagingController.error,
                          );
                        }
                      }
                    case GetAllEmptyStorePaginationState():
                      {
                        widgetState = WidgetState<StoreEntity>.empty(
                          context: context,
                          message: storeListenerState.message,
                        );
                      }
                    case GetAllExceptionStorePaginationState():
                      {
                        widgetState = WidgetState<StoreEntity>.error(
                          context: context,
                          reason: storeListenerState.message,
                        );
                      }
                    case GetAllFailedStorePaginationState():
                      {
                        widgetState = WidgetState<StoreEntity>.error(
                          context: context,
                          reason: storeListenerState.message,
                        );
                      }
                    case GetAllLoadingStorePaginationState():
                      {
                        widgetState = WidgetState<StoreEntity>.loading(
                          context: context,
                          message: storeListenerState.message,
                        );
                      }
                    case GetAllProcessingStorePaginationState():
                      {
                        widgetState = WidgetState<StoreEntity>.processing(
                          context: context,
                          message: storeListenerState.message,
                        );
                      }
                    case _:
                      appLog.d('Default case: all stores page bloc listener');
                  }
                },
                child: BlocBuilder<PermissionBloc, PermissionState>(
                  bloc: context.read<PermissionBloc>(),
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) {
                    return Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minWidth: double.infinity,
                        minHeight: media.size.height,
                      ),
                      child: Stack(
                        children: [
                          BlocBuilder<StoreBloc, StoreState>(
                            key: const Key('get-all-store-blocbuilder-widget'),
                            bloc: context.read<StoreBloc>(),
                            builder: (context, state) {
                              switch (state) {
                                case GetAllStoreState():
                                  {
                                    storeEntities = List<StoreEntity>.from(
                                        state.storeEntities.toList());
                                    widgetState =
                                    WidgetState<StoreEntity>.allData(
                                      context: context,
                                    );
                                  }
                              //case GetEmptyStoreState(:final error):
                                case GetEmptyStoreState():
                                  {
                                    storeEntities = [];
                                    storeEntities.clear();
                                    widgetState = WidgetState<StoreEntity>.empty(
                                      context: context,
                                      message: state.message,
                                    );
                                  }
                                case StoreLoadingState():
                                  {
                                    widgetState =
                                    WidgetState<StoreEntity>.loading(
                                      context: context,
                                      isLoading: state.isLoading,
                                      message: state.message,
                                    );
                                  }
                                case SaveStoreState():
                                  {
                                    storeEntities.add(state.storeEntity);
                                    widgetState =
                                    WidgetState<StoreEntity>.allData(
                                      context: context,
                                    );
                                  }
                                case _:
                                  appLog.d('Default case: all store page');
                              }
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: storeEntities.isEmpty
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                textDirection:
                                serviceLocator<LanguageController>()
                                    .targetTextDirection,
                                children: [
                                  AnimatedCrossFade(
                                    firstChild: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                      textDirection:
                                      serviceLocator<LanguageController>()
                                          .targetTextDirection,
                                      children: [
                                        const AnimatedGap(6,
                                            duration:
                                            Duration(milliseconds: 500)),
                                        IntrinsicHeight(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            textDirection: serviceLocator<
                                                LanguageController>()
                                                .targetTextDirection,
                                            children: [
                                              Expanded(child:  AppSearchInputSliverWidget(
                                                key: const Key('all-store-search-field-widget'),
                                                onChanged: _updateSearchTerm,
                                                height: 48,
                                                hintText: 'Search Store',

                                              ),),
                                              /*Expanded(
                                                child: AppTextFieldWidget(
                                                  controller:
                                                  searchTextEditingController,
                                                  textDirection: serviceLocator<
                                                      LanguageController>()
                                                      .targetTextDirection,
                                                  textInputAction:
                                                  TextInputAction.done,
                                                  keyboardType:
                                                  TextInputType.text,
                                                  decoration: InputDecoration(
                                                    labelText: 'Search',
                                                    hintText: 'Search store',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                    ),
                                                    isDense: true,
                                                  ),
                                                ),
                                              ),*/
                                              const AnimatedGap(12,
                                                  duration: Duration(
                                                      milliseconds: 500)),
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
                                            duration:
                                            Duration(milliseconds: 500)),
                                        ListTile(
                                          dense: true,
                                          title: IntrinsicHeight(
                                            child: Row(
                                              textDirection: serviceLocator<
                                                  LanguageController>()
                                                  .targetTextDirection,
                                              children: [
                                                Text(
                                                  'Your Stores',
                                                  style: context.labelLarge!
                                                      .copyWith(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 18),
                                                  textDirection: serviceLocator<
                                                      LanguageController>()
                                                      .targetTextDirection,
                                                ),
                                                const AnimatedGap(3,
                                                    duration: Duration(
                                                        milliseconds: 500)),
                                                Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadiusDirectional
                                                        .circular(20),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional
                                                        .only(
                                                        start: 12.0,
                                                        end: 12,
                                                        top: 4,
                                                        bottom: 4),
                                                    child: Text(
                                                      '${_pagingController.value.itemList?.length??0}',
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
                                            duration:
                                            Duration(milliseconds: 500)),
                                      ],
                                    ),
                                    secondChild: const Offstage(),
                                    duration: const Duration(milliseconds: 500),
                                    crossFadeState: (_pagingController.value.itemList.isNotNullOrEmpty)
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: widgetState.maybeWhen(
                                      empty: (context, child, message, data) =>
                                          Center(
                                            key: const Key(
                                                'get-all-store-empty-widget'),
                                            child: Text(
                                              'No store available or added by you',
                                              style: context.labelLarge,
                                              textDirection:
                                              serviceLocator<LanguageController>()
                                                  .targetTextDirection,
                                            ).translate(),
                                          ),
                                      loading:
                                          (context, child, message, isLoading) {
                                        return const Center(
                                          key: Key('get-all-store-center-widget'),
                                          child: SizedBox(
                                            width: 48,
                                            height: 48,
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      },
                                      allData: (context, child, message, data) {
                                        return CustomScrollView(
                                          controller: innerScrollController,
                                          slivers: [
                                            PagedSliverList<int, StoreEntity>(
                                              key: const Key(
                                                  'store-list-pagedSliverList-widget'),
                                              pagingController: _pagingController,
                                              builderDelegate:
                                              PagedChildBuilderDelegate<
                                                  StoreEntity>(
                                                animateTransitions: true,
                                                itemBuilder: (context, item, index) =>
                                                    StoreCard(
                                                      key: ValueKey(index),
                                                      storeEntity: storeEntities[index],
                                                      listOfAllStoreEntities:
                                                      storeEntities.toList(),
                                                      currentIndex: index,
                                                      refreshStoreList: () {
                                                        return _updateSearchTerm(searchText??'');
                                                      },
                                                    ),
                                              ),
                                            ),
                                          ],
                                        );

                                      },
                                      none: () {
                                        return const NoItemAvailableWidget(
                                          key: Key('get-all-store-none-widget'),
                                          textMessage: 'No store available or added by you',
                                        );
                                      },
                                      orElse: () {
                                        return const NoItemAvailableWidget(
                                          key: Key('get-all-store-else-widget'),
                                          textMessage: 'No store available or added by you',
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
                                              Routes.SAVE_STORE_PAGE,
                                              extra: {
                                                'storeEntity': null,
                                                'haveNewStore': true,
                                                'currentIndex': -1,
                                              },
                                            );
                                            if (!mounted) {
                                              return;
                                            }
                                            if (!mounted) {
                                              return;
                                            }
                                            //context.read<AddressBloc>().add(const GetAllAddress());
                                            if (_pagingController.value
                                                .itemList ==
                                                null ||
                                                _pagingController.value.itemList
                                                    .isEmptyOrNull) {
                                              appLog.d(
                                                  'state._pagingController.value.itemList null');
                                              await _fetchPage(0);
                                            } else {
                                              appLog.d(
                                                  'state._pagingController.value.itemList not null');
                                              _pagingController.refresh();
                                            }
                                            return;
                                          },
                                          child: Text(
                                            'Add Store',
                                            textDirection: serviceLocator<
                                                LanguageController>()
                                                .targetTextDirection,
                                          ).translate(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
