part of 'package:homemakers_merchant/app/features/menu/index.dart';

class AllMenuPage extends StatefulWidget {
  const AllMenuPage({super.key, this.selectItemUseCase = SelectItemUseCase.none});

  final SelectItemUseCase selectItemUseCase;

  @override
  _AllMenuPageController createState() => _AllMenuPageController();
}

class _AllMenuPageController extends State<AllMenuPage> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  List<MenuEntity> listOfAllMenus = [];
  List<MenuEntity> listOfAllSelectedMenus = [];
  final TextEditingController searchTextEditingController =
  TextEditingController();
  WidgetState<MenuEntity> widgetState = const WidgetState<MenuEntity>.none();
  bool? haveSelectAllMenus = false;

  //Pagination
  int pageSize = 10;
  int pageKey = 0;
  String? searchText;
  String? sorting;
  String? filtering;
  late final PagingController<int, MenuEntity> _pagingController;

  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: 0);
    listOfAllMenus = [];
    listOfAllMenus.clear();
    listOfAllSelectedMenus = [];
    listOfAllSelectedMenus.clear();
    _refreshAddressList();
    widgetState = WidgetState<MenuEntity>.loading(context: context);
    scrollController = ScrollController();
    innerScrollController = ScrollController();

    super.initState();
    /*if (mounted) {
      widgetState = WidgetState<MenuEntity>.loading(
        context: context,
      );
      context.read<MenuBloc>().add(GetAllMenu());
      //serviceLocator<MenuRepository>().deleteMenu(menuID: 1).whenComplete(() => context.read<MenuBloc>().add(GetAllMenu()));
    }*/
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _pagingController.removeListener(() {});
    _pagingController.removePageRequestListener((pageKey) {});
    _pagingController.removeStatusListener((status) {});
    _pagingController.dispose();

    listOfAllMenus = [];
    listOfAllMenus.clear();
    listOfAllSelectedMenus = [];
    listOfAllSelectedMenus.clear();
    scrollController.dispose();
    innerScrollController.dispose();
    searchTextEditingController.dispose();
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
      context.read<MenuBloc>().add(
        GetAllMenuPagination(
          pageKey: pageKey,
          pageSize: pageSize,
          searchText: searchItem,
          filter: filtering ?? filter,
          sorting: sorting ?? sort,
        ),
      );
      appLog.i('Fetch Menu');
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

  @override
  Widget build(BuildContext context) =>
      BlocListener<MenuBloc, MenuState>(
        key: const Key('all-menus-page-bloc-listener-widget'),
        bloc: context.read<MenuBloc>(),
        listener: (context, menuListenerState){
          switch (menuListenerState) {
            case GetAllMenuPaginationState():
              {
                try {
                  final isLastPage =
                      menuListenerState.menuEntities.length < pageSize;
                  if (isLastPage) {
                    _pagingController.appendLastPage(
                        menuListenerState.menuEntities.toList());
                  } else {
                    final nextPageKey = menuListenerState.pageKey +
                        menuListenerState.menuEntities.length;
                    //final nextPageKey = addressState.pageKey + 1;
                    _pagingController.appendPage(
                        menuListenerState.menuEntities.toList(),
                        nextPageKey);
                  }
                  widgetState = WidgetState<MenuEntity>.allData(
                    context: context,
                    data: _pagingController.value.itemList ?? [],
                  );
                  listOfAllMenus = _pagingController.value.itemList ?? [];
                } catch (error) {
                  _pagingController.error = error;
                  widgetState = WidgetState<MenuEntity>.error(
                    context: context,
                    reason: _pagingController.error,
                  );
                }
              }
            case GetAllEmptyMenuPaginationState():
              {
                widgetState = WidgetState<MenuEntity>.empty(
                  context: context,
                  message: menuListenerState.message,
                );
              }
            case GetAllExceptionMenuPaginationState():
              {
                widgetState = WidgetState<MenuEntity>.error(
                  context: context,
                  reason: menuListenerState.message,
                );
              }
            case GetAllFailedMenuPaginationState():
              {
                widgetState = WidgetState<MenuEntity>.error(
                  context: context,
                  reason: menuListenerState.message,
                );
              }
            case _:
              appLog.d('Default case: all address page bloc listener');
          }
        },
        child: BlocBuilder<MenuBloc, MenuState>(
          key: const Key('all-menus-page-bloc-builder-widget'),
          bloc: context.read<MenuBloc>(),
          builder: (context, state) {
            switch (state) {
              case GetAllMenuState():
                {
                  listOfAllMenus =
                  List<MenuEntity>.from(state.menuEntities.toList());
                  widgetState = WidgetState<MenuEntity>.allData(
                    context: context,
                  );
                }
              case GetEmptyMenuState():
                {
                  listOfAllMenus =
                  List<MenuEntity>.from(state.menuEntities.toList());
                  widgetState = WidgetState<MenuEntity>.empty(
                    context: context,
                  );
                }
              case _:
                appLog.d('Default case: all menu page');
            }
            return _AllMenuPageView(this);
          },
        ),
      );

  void onSelectionChanged(List<MenuEntity> listOfMenuEntities) {
    setState(() {
      listOfAllSelectedMenus =
      List<MenuEntity>.from(listOfMenuEntities.toList());
    });
  }

  void selectAllMenus({bool? isSelectAllMenus = false}) {
    haveSelectAllMenus = isSelectAllMenus;
    if (isSelectAllMenus != null && isSelectAllMenus == true) {
      listOfAllSelectedMenus = List.from(listOfAllMenus.toList());
    } else {
      listOfAllSelectedMenus = [];
      listOfAllSelectedMenus.clear();
    }
    setState(() {});
  }
}

class _AllMenuPageView extends WidgetView<AllMenuPage, _AllMenuPageController> {
  const _AllMenuPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding =
        margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
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
            title: const Text('All Menus'),
            actions: const [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          floatingActionButton: AnimatedOpacity(
            opacity: state.listOfAllSelectedMenus.isEmpty ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 70),
              child: FloatingActionButton(
                backgroundColor: const Color.fromRGBO(69, 201, 125, 1.0),
                onPressed: () async {
                  if (state.listOfAllSelectedMenus.isEmpty) {
                    return;
                  } else {
                    final result = await context.push(
                      Routes.BIND_MENU_WITH_STORE_PAGE,
                      extra: {
                        'allMenu': state.listOfAllMenus.toList(),
                        'selectedMenus': state.listOfAllSelectedMenus.toList(),
                      },
                    );
                    await Future.delayed(
                        const Duration(milliseconds: 300), () {});
                    if (!state.mounted) {
                      return;
                    }
                    context.read<MenuBloc>().add(GetAllMenu());
                  }
                },
                child: const Icon(
                  Icons.store,
                ),
              ),
            ),
          ),
          body: Directionality(
            textDirection:
            serviceLocator<LanguageController>().targetTextDirection,
            child: SlideInLeft(
              key: const Key('get-all-menus-slideinleft-widget'),
              delay: const Duration(milliseconds: 500),
              from: context.width - 40,
              child: PageBody(
                controller: state.scrollController,
                constraints: BoxConstraints(
                  minWidth: double.infinity,
                  minHeight: media.size.height,
                ),
                child: SingleChildScrollView(
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            children: [
                              const AnimatedGap(6,
                                  duration: Duration(milliseconds: 500)),
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                                  children: [
                                    Expanded(
                                      child: AppTextFieldWidget(
                                        controller:
                                        state.searchTextEditingController,
                                        textDirection:
                                        serviceLocator<LanguageController>()
                                            .targetTextDirection,
                                        textInputAction: TextInputAction.done,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          labelText: 'Search',
                                          hintText: 'Search menu and addons',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    const AnimatedGap(12,
                                        duration: Duration(milliseconds: 500)),
                                    SizedBox(
                                      height: 52,
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
                              const AnimatedGap(12,
                                  duration: Duration(milliseconds: 500)),
                              CheckboxListTile(
                                value: state.haveSelectAllMenus,
                                onChanged: (value) {
                                  state.selectAllMenus(isSelectAllMenus: value);
                                },
                                tristate: true,
                                visualDensity: const VisualDensity(
                                    horizontal: -4, vertical: -4),
                                contentPadding:
                                const EdgeInsetsDirectional.symmetric(
                                    horizontal: 0),
                                //dense: true,
                                title: IntrinsicHeight(
                                  child: Row(
                                    textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                                    children: [
                                      Text(
                                        'Your Menus',
                                        textDirection:
                                        serviceLocator<LanguageController>()
                                            .targetTextDirection,
                                      ),
                                      const AnimatedGap(3,
                                          duration:
                                          Duration(milliseconds: 500)),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadiusDirectional.circular(
                                              20),
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(
                                              start: 12.0,
                                              end: 12,
                                              top: 4,
                                              bottom: 4),
                                          child: Text(
                                            '${state.listOfAllMenus.length}',
                                            textDirection: serviceLocator<
                                                LanguageController>()
                                                .targetTextDirection,
                                          ),
                                        ),
                                      ),
                                      const AnimatedGap(12,
                                          duration:
                                          Duration(milliseconds: 500)),
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
                            ],
                          ),
                          secondChild: const Offstage(),
                          duration: const Duration(milliseconds: 500),
                          crossFadeState: (state.listOfAllMenus.isNotEmpty)
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                        ),
                        Expanded(
                          child: state.widgetState.maybeWhen(
                            empty: (context, child, message, data) =>
                                Center(
                                  key: const Key('get-all-menu-empty-widget'),
                                  child: Text(
                                    'No menu available or added by you',
                                    style: context.labelLarge,
                                    textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                                  ).translate(),
                                ),
                            loading: (context, child, message, isLoading) {
                              return const Center(
                                key: Key('get-all-menu-center-widget'),
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
                                  PagedSliverList<int, MenuEntity>(
                                    key: const Key(
                                        'address-list-pagedSliverList-widget'),
                                    pagingController: state._pagingController,
                                    builderDelegate:
                                    PagedChildBuilderDelegate<
                                        MenuEntity>(
                                      animateTransitions: true,
                                      itemBuilder: (context, item, index) =>
                                          MenuCardWidget(
                                            key: ValueKey(index),
                                            menuEntity: item,
                                            currentIndex: index,
                                            listOfAllMenuEntities:
                                            state.listOfAllMenus.toList(),
                                            onSelectionChanged: (List<MenuEntity>
                                            listOfAllMenuEntities) {
                                              state.onSelectionChanged(
                                                  listOfAllMenuEntities.toList());
                                            },
                                            listOfAllSelectedMenuEntities:
                                            state.listOfAllSelectedMenus.toList(),
                                          ),
                                    ),
                                  ),
                                ],
                              );
                              return ListView.separated(
                                itemBuilder: (context, index) {
                                  return MenuCardWidget(
                                    key: ValueKey(index),
                                    menuEntity: state.listOfAllMenus[index],
                                    currentIndex: index,
                                    listOfAllMenuEntities:
                                    state.listOfAllMenus.toList(),
                                    onSelectionChanged: (List<MenuEntity>
                                    listOfAllMenuEntities) {
                                      state.onSelectionChanged(
                                          listOfAllMenuEntities.toList());
                                    },
                                    listOfAllSelectedMenuEntities:
                                    state.listOfAllSelectedMenus.toList(),
                                  );
                                },
                                itemCount: state.listOfAllMenus.length,
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                      thickness: 0.25,
                                      color: Color.fromRGBO(127, 129, 132, 1));
                                },
                              );
                            },
                            none: () {
                              return Center(
                                child: Text(
                                  'No menu available or added by you',
                                  style: context.labelLarge,
                                  textDirection:
                                  serviceLocator<LanguageController>()
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
                                onPressed: () async {
                                  final navigateToSaveMenuPage =
                                  await context.push(
                                    Routes.SAVE_MENU_PAGE,
                                    extra: {
                                      'menuEntity': null,
                                      'haveNewMenu': true,
                                      'currentIndex': -1,
                                    },
                                  );
                                  if (!state.mounted) {
                                    return;
                                  }
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
                                  //context.read<MenuBloc>().add(GetAllMenu());
                                  //return;
                                },
                                child: Text(
                                  'Add New Menu',
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
      ),
    );
  }
}
