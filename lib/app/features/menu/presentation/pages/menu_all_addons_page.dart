part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuAllAddonsPage extends StatefulWidget {
  const MenuAllAddonsPage(
      {super.key, this.selectItemUseCase = SelectItemUseCase.none});

  final SelectItemUseCase selectItemUseCase;

  @override
  _MenuAllAddonsPageController createState() => _MenuAllAddonsPageController();
}

class _MenuAllAddonsPageController extends State<MenuAllAddonsPage> {
  late final ScrollController scrollController;
  List<Addons> _menuAvailableAddons = [];
  bool _hasCustomMenuPortionSize = false;
  List<Addons> _selectedAddons = [];
  List<StoreEntity> storeEntities = [];
  late final ScrollController listViewBuilderScrollController;
  late final ScrollController innerScrollController;
  ResultState<Addons> resultState = const ResultState<Addons>.empty();
  WidgetState<Addons> widgetState = const WidgetState<Addons>.none();

  // Pagination
  int pageSize = 10;
  int pageKey = 0;
  String? searchText;
  String? sorting;
  String? filtering;
  late final PagingController<int, Addons> _pagingController;
  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: 0);
    _menuAvailableAddons = [];
    _selectedAddons = [];
    _refreshAddressList();
    widgetState = WidgetState<Addons>.loading(context: context);
    scrollController = ScrollController();
    listViewBuilderScrollController = ScrollController();
    innerScrollController = ScrollController();
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
      context.read<MenuBloc>().add(
            GetAllAddonsPagination(
              pageKey: pageKey,
              pageSize: pageSize,
              searchText: searchText ?? searchItem,
              filter: filtering ?? filter,
              sorting: sorting ?? sort,
            ),
          );
      appLog.i('Fetch Addons');
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
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pagingController.removeListener(() {});
    _pagingController.removePageRequestListener((pageKey) {});
    _pagingController.removeStatusListener((status) {});
    _pagingController.dispose();
    scrollController.dispose();

    _menuAvailableAddons = [];
    _selectedAddons = [];
    innerScrollController.dispose();
    listViewBuilderScrollController.dispose();
    super.dispose();
  }

  void initMenuAddons() {
    //_menuAvailableAddons = List<Addons>.from(localMenuAddons.toList());
  }

  Future<void> _updateSearchTerm(String searchTerm) async {
    appLog.d('_updateSearchTerm ${searchTerm} ');
    searchText = searchTerm;
    if (_pagingController.value.itemList == null ||
        _pagingController.value.itemList.isEmptyOrNull) {
      appLog.d('state._pagingController.value.itemList null');
      await _fetchPage(
        0,
        searchItem: searchTerm,
      );
    } else {
      appLog.d('state._pagingController.value.itemList not null');
      _pagingController.refresh();
    }
    //_pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) => BlocListener<MenuBloc, MenuState>(
        key: const Key('get-all-addons-bloclistener-widget'),
        bloc: context.read<MenuBloc>(),
        listener: (context, menuState) {
          switch (menuState) {
            case PopToMenuPageState():
              {
                if (context.canPop()) {
                  Navigator.of(context).pop(menuState.addonsEntity.toList());
                }
              }
            case GetAllAddonsState():
              {}
            case GetAllAddonsPaginationState():
              {
                try {
                  final isLastPage = menuState.addonsEntities.length < pageSize;
                  if (isLastPage) {
                    _pagingController
                        .appendLastPage(menuState.addonsEntities.toList());
                  } else {
                    final nextPageKey =
                        menuState.pageKey + menuState.addonsEntities.length;
                    //final nextPageKey = addressState.pageKey + 1;
                    _pagingController.appendPage(
                        menuState.addonsEntities.toList(), nextPageKey);
                  }
                  widgetState = WidgetState<Addons>.allData(
                    context: context,
                    data: _pagingController.value.itemList ?? [],
                  );
                  _menuAvailableAddons = _pagingController.value.itemList ?? [];
                } catch (error) {
                  _pagingController.error = error;
                  widgetState = WidgetState<Addons>.error(
                    context: context,
                    reason: _pagingController.error,
                  );
                }
              }
            case GetAllEmptyAddonsPaginationState():
              {
                widgetState = WidgetState<Addons>.empty(
                  context: context,
                  message: menuState.message,
                );
              }
            case GetAllLoadingAddonsPaginationState():
              {
                widgetState = WidgetState<Addons>.loading(
                  context: context,
                  message: menuState.message,
                );
              }
            case GetAllProcessingAddonsPaginationState():
              {
                widgetState = WidgetState<Addons>.processing(
                  context: context,
                  message: menuState.message,
                );
              }
            case GetAllExceptionAddonsPaginationState():
              {
                widgetState = WidgetState<Addons>.error(
                  context: context,
                  reason: menuState.message,
                );
              }
            case GetAllFailedAddonsPaginationState():
              {
                widgetState = WidgetState<Addons>.error(
                  context: context,
                  reason: menuState.message,
                );
              }
            case _:
              appLog.d('Default case: all addons page bloc listener');
          }
          /*if (menuState is GetAllAddonsState) {
            //_menuAvailableAddons = List<Addons>.from(addonsState.addonsEntities.toList());
            try {
              final isLastPage =
                  menuState.addonsEntities.toList().length < pageSize;
              if (isLastPage) {
                _pagingController
                    .appendLastPage(menuState.addonsEntities.toList());
              } else {
                final nextPageKey = pageKey + 1;
                _pagingController.appendPage(
                    menuState.addonsEntities.toList(), nextPageKey);
              }
              widgetState = WidgetState<Addons>.allData(
                context: context,
                data: _pagingController.value.itemList ?? [],
              );
              _menuAvailableAddons = _pagingController.value.itemList ?? [];
            } catch (error) {
              _pagingController.error = error;
              widgetState = WidgetState<Addons>.error(
                context: context,
                reason: _pagingController.error,
              );
            }
          }*/
        },
        child: BlocBuilder<MenuBloc, MenuState>(
          key: const Key('get-all-addons-blocbuilder-widget'),
          bloc: context.read<MenuBloc>(),
          builder: (context, addonsState) {
            switch (addonsState) {
              case GetEmptyAddonsState():
                {
                  _menuAvailableAddons = [];
                  _menuAvailableAddons.clear();
                  widgetState = WidgetState<Addons>.empty(
                    context: context,
                    message: addonsState.message,
                  );
                }
              case AddonsLoadingState():
                {
                  widgetState = WidgetState<Addons>.loading(
                    context: context,
                    isLoading: addonsState.isLoading,
                    message: addonsState.message,
                  );
                }
              case SaveAddonsState():
                {
                  _menuAvailableAddons.add(addonsState.addonsEntity);
                  localMenuAddons.add(addonsState.addonsEntity);
                  widgetState = WidgetState<Addons>.allData(
                    context: context,
                  );
                }
              case SelectAddonsState():
                {
                  _selectedAddons = List<Addons>.from(
                      addonsState.selectedAddonsEntities.toList());
                }
              case AddonsExceptionState():
                {
                  _pagingController.error = addonsState.message;
                  widgetState = WidgetState<Addons>.error(
                    context: context,
                    reason: _pagingController.error,
                  );
                }
              case _:
                print('default');
            }
            return _MenuAllAddonsPageView(this);
          },
        ),
      );
}

class _MenuAllAddonsPageView
    extends WidgetView<MenuAllAddonsPage, _MenuAllAddonsPageController> {
  const _MenuAllAddonsPageView(super.state);

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
              'All Addons',
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
            ),
            actions: const [
              NotificationIconWidget(),
              LanguageSelectionWidget(),
            ],
          ),
          floatingActionButton: AnimatedOpacity(
            opacity: state._selectedAddons.isEmpty ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 70),
              child: FloatingActionButton(
                child: const Icon(
                  Icons.check,
                ),
                backgroundColor: const Color.fromRGBO(69, 201, 125, 1.0),
                onPressed: () {
                  context.read<MenuBloc>().add(
                        PopToMenuPage(
                            addonsEntity: state._selectedAddons.toList()),
                      );
                },
              ),
            ),
          ),
          body: SlideInLeft(
            key: const Key('menu-all-addons-slideinleft-widget'),
            delay: const Duration(milliseconds: 500),
            from: context.width - 40,
            child: PageBody(
              controller: state.scrollController,
              constraints: BoxConstraints(
                minWidth: 1000,
                minHeight: media.size.height,
                //minHeight: media.size.height,
              ),
              padding: EdgeInsetsDirectional.only(
                top: margins,
                //bottom: bottomPadding,
                start: margins * 2.5,
                end: margins * 2.5,
              ),
              child: BlocBuilder<PermissionBloc, PermissionState>(
                bloc: context.read<PermissionBloc>(),
                buildWhen: (previous, current) => previous != current,
                builder: (context, permissionState) {
                  return SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: media.size.height -
                            (media.padding.top +
                                kToolbarHeight +
                                media.padding.bottom +
                                margins),
                        //minHeight: media.size.height,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    textDirection:
                                        serviceLocator<LanguageController>()
                                            .targetTextDirection,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: AppSearchInputSliverWidget(
                                          key: const Key(
                                              'addons-search-field-widget'),
                                          onChanged: state._updateSearchTerm,
                                          height: 48,
                                          hintText: 'Search Addons',
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
                                      ),
                                    ],
                                  ),
                                ),
                                const AnimatedGap(6,
                                    duration: Duration(milliseconds: 500)),
                                ListTile(
                                  dense: true,
                                  title: IntrinsicHeight(
                                    child: Row(
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      children: [
                                        Text(
                                          'Your Addons',
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
                                  visualDensity: const VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  horizontalTitleGap: 0,
                                  minLeadingWidth: 0,
                                  contentPadding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: 2),
                                ),
                                const AnimatedGap(6,
                                    duration: Duration(milliseconds: 500)),
                              ],
                            ),
                            secondChild: const Offstage(),
                            duration: const Duration(milliseconds: 500),
                            crossFadeState: (state._pagingController.value
                                    .itemList.isNotNullOrEmpty)
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                          ),
                          Expanded(
                            child: state.widgetState.maybeWhen(
                              empty: (context, child, message, data) =>
                                  const NoItemAvailableWidget(
                                key: Key('addons-empty-widget'),
                                textMessage:
                                    'No addons available or added by you',
                              ),
                              loading: (context, child, message, isLoading) {
                                return const DataLoadingWidget(
                                  key: Key('addons-loading-widget'),
                                );
                              },
                              processing: (context, child, message, isLoading) {
                                return const DataLoadingWidget(
                                  key: Key('addons-processing-widget'),
                                );
                              },
                              allData: (context, child, message, data) {
                                return CustomScrollView(
                                  controller: state.innerScrollController,
                                  slivers: [
                                    PagedSliverList<int, Addons>(
                                      pagingController: state._pagingController,
                                      builderDelegate:
                                          PagedChildBuilderDelegate<Addons>(
                                              animateTransitions: true,
                                              itemBuilder: (context,
                                                  notificationResult, index) {
                                                return AddonsCard(
                                                  key: ValueKey(index),
                                                  addonsEntity:
                                                      notificationResult,
                                                  onChangedAddons: (value) {
                                                    //state._selectedAddons = List<StoreAvailableFoodPreparationType>.from(value);
                                                    context
                                                        .read<MenuBloc>()
                                                        .add(
                                                          SelectAddons(
                                                            index: index,
                                                            addonsID:
                                                                notificationResult
                                                                    .addonsID,
                                                            addonsEntity:
                                                                notificationResult,
                                                            addonsEntities: state
                                                                ._menuAvailableAddons
                                                                .toList(),
                                                            selectedAddonsEntities:
                                                                state
                                                                    ._selectedAddons
                                                                    .toList(),
                                                          ),
                                                        );
                                                  },
                                                  selectedAllAddons: state
                                                      ._selectedAddons
                                                      .toList(),
                                                );
                                              }),
                                    ),
                                  ],
                                );
                              },
                              none: () {
                                return const NoItemAvailableWidget(
                                  key: Key('addons-none-widget'),
                                  textMessage:
                                      'No addons available or added by you',
                                );
                              },
                              orElse: () {
                                return const NoItemAvailableWidget(
                                  key: Key('addons-else-widget'),
                                  textMessage:
                                      'No addons available or added by you',
                                );
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final navigateToSaveAddonsPage =
                                        await context.push(
                                      Routes.SAVE_ADDONS_PAGE,
                                      extra: {
                                        'addons': null,
                                        'haveNewAddons': true,
                                        'haveOwnAddons': true,
                                        'currentIndex': -1,
                                        'pageKey': state.pageKey,
                                        'pageSize': state.pageSize,
                                        'searchItem': state.searchText,
                                      },
                                    );
                                    if (!state.mounted) {
                                      return;
                                    }
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
                                    //await state._fetchPage(state.pageKey,pageSize:state.pageSize,searchItem: state.searchText, );
                                    //return;
                                  },
                                  child: Text(
                                    'Add Addons',
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
