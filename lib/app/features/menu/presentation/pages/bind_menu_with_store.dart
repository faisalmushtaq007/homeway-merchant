part of 'package:homemakers_merchant/app/features/menu/index.dart';

class BindMenuWithStore extends StatefulWidget {
  const BindMenuWithStore({
    super.key,
    this.listOfAllMenus = const [],
    this.listOfAllSelectedMenus = const [],
    this.selectItemUseCase = SelectItemUseCase.none,
  });

  final List<MenuEntity> listOfAllMenus;
  final List<MenuEntity> listOfAllSelectedMenus;
  final SelectItemUseCase selectItemUseCase;

  @override
  _BindMenuWithStoreController createState() => _BindMenuWithStoreController();
}

class _BindMenuWithStoreController extends State<BindMenuWithStore> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  List<MenuEntity> listOfAllMenus = [];
  List<MenuEntity> listOfAllSelectedMenus = [];
  List<StoreEntity> listOfAllStores = [];
  List<StoreEntity> listOfAllSelectedStores = [];
  final TextEditingController searchTextEditingController =
  TextEditingController();
  WidgetState<StoreEntity> widgetState = const WidgetState<StoreEntity>.none();
  bool? haveSelectAllStores = false;

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
    listOfAllMenus = [];
    listOfAllMenus.clear();
    listOfAllSelectedMenus = [];
    listOfAllSelectedMenus.clear();
    listOfAllStores = [];
    listOfAllStores.clear();
    listOfAllSelectedStores = [];
    listOfAllSelectedStores.clear();
    _refreshAddressList();
    widgetState = WidgetState<StoreEntity>.loading(context: context);

    scrollController = ScrollController();
    innerScrollController = ScrollController();
    super.initState();
    initLoadSelectedMenu();
    //context.read<MenuBloc>().add(FetchAllStores());
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void initLoadSelectedMenu() {
    listOfAllMenus = List<MenuEntity>.from(widget.listOfAllMenus.toList());
    listOfAllSelectedMenus =
    List<MenuEntity>.from(widget.listOfAllSelectedMenus.toList());
    setState(() {});
  }

  @override
  void dispose() {
    _pagingController.removeListener(() {});
    _pagingController.removePageRequestListener((pageKey) {});
    _pagingController.removeStatusListener((status) {});
    _pagingController.dispose();

    searchTextEditingController.dispose();
    listOfAllMenus = [];
    listOfAllMenus.clear();
    listOfAllSelectedMenus = [];
    listOfAllSelectedMenus.clear();
    listOfAllStores = [];
    listOfAllStores.clear();
    listOfAllSelectedStores = [];
    listOfAllSelectedStores.clear();

    innerScrollController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void onSelectionChanged(List<StoreEntity> listOfStoreEntities) {
    setState(() {
      listOfAllSelectedStores =
      List<StoreEntity>.from(listOfStoreEntities.toList());
    });
  }

  void selectAllStores({bool? isSelectAllStores = false}) {
    haveSelectAllStores = isSelectAllStores;
    if (isSelectAllStores != null && isSelectAllStores == true) {
      listOfAllSelectedStores = List.from(listOfAllStores.toList());
    } else {
      listOfAllSelectedStores = [];
      listOfAllSelectedStores.clear();
    }
    setState(() {});
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
          searchText: searchText ?? searchItem,
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
  Widget build(BuildContext context) =>
      BlocListener<StoreBloc, StoreState>(
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
                    listOfAllStores  = _pagingController.value.itemList ?? [];
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
        child: BlocListener<MenuBloc, MenuState>(
          key: const Key('bind-menu-with-store-page-bloc-listener-widget'),
          bloc: context.watch<MenuBloc>(),
          listener: (context, state) {
            switch (state) {
              case BindMenuWithStoresState():
                {
                  switch (state.bindMenuToStoreStage) {
                    case BindMenuToStoreStage.attached:
                      {
                        listOfAllSelectedStores = [];
                        listOfAllSelectedStores.clear();
                        context.pushReplacement(
                          Routes.BIND_MENU_WITH_STORE_GREETING_PAGE,
                          extra: {
                            'allMenu': state.menuEntities.toList(),
                            'allStore': state.storeEntities.toList(),
                          },
                        );
                      }
                    case _:
                      {}
                  }
                  return;
                }
              case UnBindMenuWithStoresState():
                {
                  switch (state.bindMenuToStoreStage) {
                    case BindMenuToStoreStage.remove:
                      {
                        listOfAllSelectedStores = [];
                        listOfAllSelectedStores.clear();
                        context.pushReplacement(
                          Routes.BIND_MENU_WITH_STORE_GREETING_PAGE,
                          extra: {
                            'allMenu': state.menuEntities.toList(),
                            'allStore': state.storeEntities.toList(),
                            'message': '',
                            'isRemoved': true,
                          },
                        );
                      }
                    case _:
                      {}
                  }
                  return;
                }
              case _:
                appLog.d('Default case: all bloc listener bind menu page');
            }
          },
          child: BlocBuilder<MenuBloc, MenuState>(
            key: const Key('bind-menu-with-store-page-bloc-builder-widget'),
            bloc: context.watch<MenuBloc>(),
            builder: (context, state) {
              switch (state) {
                case FetchAllStoresState():
                  {
                    listOfAllStores =
                    List<StoreEntity>.from(state.storeEntities.toList());
                    widgetState = WidgetState<StoreEntity>.allData(
                      context: context,
                    );
                  }
                case _:
                  appLog.d('Default case: all bloc builder bind menu page');
              }
              return _BindMenuWithStoreView(this);
            },
          ),
        ),
      );
}

class _BindMenuWithStoreView extends WidgetView<BindMenuWithStore, _BindMenuWithStoreController> {
  const _BindMenuWithStoreView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding =
        margins; //media.padding.top + kWitholbarHeight + margins; //margins * 1.5;
    final double bottomPadding = media.padding.bottom + margins;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
        noAppBar: true,
      ),
      child: Directionality(
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('All Stores'),
            actions: const [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          floatingActionButton: AnimatedOpacity(
            opacity: (state.listOfAllSelectedMenus.isEmpty &&
                state.listOfAllSelectedStores.isEmpty)
                ? 0.0
                : 1.0,
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 70),
              child: FloatingActionButton(
                backgroundColor: const Color.fromRGBO(69, 201, 125, 1.0),
                onPressed: () async {
                  if (state.listOfAllSelectedMenus.isEmpty &&
                      state.listOfAllSelectedStores.isEmpty) {
                    return;
                  } else {
                    context.go(
                      Routes.BIND_MENU_WITH_STORE_GREETING_PAGE,
                      extra: {
                        'allMenu': state.listOfAllSelectedMenus.toList(),
                        'allStore': state.listOfAllSelectedStores.toList(),
                      },
                    );
                  }
                },
                child: const Icon(
                  Icons.check,
                ),
              ),
            ),
          ),
          body: Directionality(
            textDirection:
            serviceLocator<LanguageController>().targetTextDirection,
            child: SlideInLeft(
              key: const Key('bind-menu-with-store-slideinleft-widget'),
              delay: const Duration(milliseconds: 500),
              from: context.width - 40,
              child: PageBody(
                controller: state.scrollController,
                constraints: BoxConstraints(
                  minWidth: double.infinity,
                  minHeight: media.size.height,
                ),
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: double.infinity,
                    minHeight: media.size.height,
                  ),
                  padding: EdgeInsetsDirectional.only(
                      top: topPadding,
                      start: margins * 2.5,
                      end: margins * 2.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    children: [
                      const AnimatedGap(6,
                          duration: Duration(milliseconds: 500)),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                          children: [
                            Expanded(child:  AppSearchInputSliverWidget(
                              key: const Key('bind-all-store-search-field-widget'),
                              onChanged: state._updateSearchTerm,
                              height: 48,
                              hintText: 'Search Store',
                            ),),
                            /*Expanded(
                              child: AppTextFieldWidget(
                                controller: state.searchTextEditingController,
                                textDirection:
                                serviceLocator<LanguageController>()
                                    .targetTextDirection,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Search',
                                  hintText: 'Search store',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  isDense: true,
                                ),
                              ),
                            ),*/
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
                            )
                          ],
                        ),
                      ),
                      const AnimatedGap(12,
                          duration: Duration(milliseconds: 500)),
                      CheckboxListTile(
                        value: state.haveSelectAllStores,
                        onChanged: (value) {
                          state.selectAllStores(isSelectAllStores: value);
                        },
                        tristate: true,
                        visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                        contentPadding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 0),
                        //dense: true,
                        title: IntrinsicHeight(
                          child: Row(
                            children: [
                              Text(
                                'Your Stores',
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
                                    '${state._pagingController.value.itemList?.length??0}',
                                    textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                                  ),
                                ),
                              ),
                              const AnimatedGap(12,
                                  duration: Duration(milliseconds: 500)),
                              const Spacer(flex: 2),
                              Text(
                                'Select All',
                                textDirection:
                                serviceLocator<LanguageController>()
                                    .targetTextDirection,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const AnimatedGap(12,
                          duration: Duration(milliseconds: 500)),
                      Text(
                        'Select Store',
                        style: context.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                      ),
                      const AnimatedGap(12,
                          duration: Duration(milliseconds: 500)),
                      Text(
                        'For your Menu',
                        style: context.labelMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.colorScheme.primary,
                        ),
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                      ),
                      const AnimatedGap(12,
                          duration: Duration(milliseconds: 500)),
                      Expanded(
                        flex: 3,
                        child: state.widgetState.maybeWhen(
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
                              controller: state.innerScrollController,
                              slivers: [
                                PagedSliverList<int, StoreEntity>(
                                  key: const Key(
                                      'store-list-pagedSliverList-widget'),
                                  pagingController: state._pagingController,
                                  builderDelegate:
                                  PagedChildBuilderDelegate<
                                      StoreEntity>(
                                    animateTransitions: true,
                                    itemBuilder: (context, item, index) =>
                                        StoreCardWidget(
                                          key: ValueKey(index),
                                          currentIndex: index,
                                          listOfAllMenuEntities:
                                          state.listOfAllMenus.toList(),
                                          onSelectionChanged:
                                              (List<StoreEntity> listOfAllStoreEntities) {
                                            state.onSelectionChanged(
                                                listOfAllStoreEntities.toList());
                                          },
                                          listOfAllSelectedMenuEntities:
                                          state.listOfAllSelectedMenus.toList(),
                                          listOfAllSelectedStoreEntities:
                                          state.listOfAllSelectedStores.toList(),
                                          listOfAllStoreEntities:
                                          state.listOfAllStores.toList(),
                                          storeEntity: state.listOfAllStores[index],
                                          refreshStoreList: () {
                                            return state._updateSearchTerm(state.searchText??'');
                                          },
                                        )
                                  ),
                                ),
                              ],
                            );

                          },
                          none: () {
                            return Center(
                              child: Text(
                                'No store available or added by you',
                                style: context.labelLarge,
                                textDirection: serviceLocator<
                                    LanguageController>()
                                    .targetTextDirection,
                              ).translate(),
                            );
                          },
                          orElse: () {
                            return const SizedBox();
                          },
                        ),
                      ),

                      const AnimatedGap(12,
                          duration: Duration(milliseconds: 500)),
                      Row(
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<MenuBloc>().add(
                                  UnBindMenuWithStores(
                                    menuEntities:
                                    state.listOfAllMenus.toList(),
                                    listOfSelectedMenuEntities: state
                                        .listOfAllSelectedMenus
                                        .toList(),
                                    listOfSelectedStoreEntities: state
                                        .listOfAllSelectedStores
                                        .toList(),
                                    storeEntities:
                                    state.listOfAllStores.toList(),
                                  ),
                                );
                                return;
                              },
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color.fromRGBO(165, 166, 168, 1),
                                ),
                                backgroundColor: Colors.white,
                              ),
                              child: Text(
                                'Remove',
                                style: const TextStyle(
                                    color: Color.fromRGBO(42, 45, 50, 1)),
                                textDirection:
                                serviceLocator<LanguageController>()
                                    .targetTextDirection,
                              ).translate(),
                            ),
                          ),
                          const AnimatedGap(
                            24,
                            duration: Duration(milliseconds: 100),
                          ),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: () {
                                //context.push(Routes.SAVE_MENU_PAGE);
                                context.read<MenuBloc>().add(
                                  BindMenuWithStores(
                                    menuEntities:
                                    state.listOfAllMenus.toList(),
                                    listOfSelectedMenuEntities: state
                                        .listOfAllSelectedMenus
                                        .toList(),
                                    listOfSelectedStoreEntities: state
                                        .listOfAllSelectedStores
                                        .toList(),
                                    storeEntities:
                                    state.listOfAllStores.toList(),
                                  ),
                                );
                                return;
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color.fromRGBO(69, 201, 125, 1),
                              ),
                              child: Text(
                                'Save',
                                textDirection:
                                serviceLocator<LanguageController>()
                                    .targetTextDirection,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
