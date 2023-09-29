part of 'package:homemakers_merchant/app/features/store/index.dart';

class StoreOwnerAllDrivers extends StatefulWidget {
  const StoreOwnerAllDrivers({
    super.key,
    this.selectItemUseCase = SelectItemUseCase.none,
  });

  final SelectItemUseCase selectItemUseCase;

  @override
  _StoreOwnerAllDriversController createState() =>
      _StoreOwnerAllDriversController();
}

class _StoreOwnerAllDriversController extends State<StoreOwnerAllDrivers> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  List<StoreOwnDeliveryPartnersInfo> listOfAllDrivers = [];
  List<StoreOwnDeliveryPartnersInfo> listOfAllSelectedDrivers = [];
  final TextEditingController searchTextEditingController =
      TextEditingController();
  WidgetState<StoreOwnDeliveryPartnersInfo> widgetState =
      const WidgetState<StoreOwnDeliveryPartnersInfo>.none();
  bool? haveSelectAllMenus = false;
  // Pagination
  int pageSize = 10;
  int pageKey = 0;
  String? searchText;
  String? sorting;
  String? filtering;
  late final PagingController<int, StoreOwnDeliveryPartnersInfo> _pagingController;

  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: 0);
    listOfAllDrivers = [];
    listOfAllDrivers.clear();
    listOfAllSelectedDrivers = [];
    listOfAllSelectedDrivers.clear();
    _refreshAddressList();
    widgetState = WidgetState<StoreOwnDeliveryPartnersInfo>.loading(context: context);
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    super.initState();
    //context.read<StoreBloc>().add(GetAllDriver());
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
        GetAllDriversPagination(
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
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
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
    searchTextEditingController.dispose();
    listOfAllDrivers = [];
    listOfAllDrivers.clear();
    listOfAllSelectedDrivers = [];
    listOfAllSelectedDrivers.clear();
    innerScrollController.dispose();
    scrollController.dispose();
    
    super.dispose();
  }

  void onSelectionChanged(
      List<StoreOwnDeliveryPartnersInfo> listOfMenuEntities) {
    setState(() {
      listOfAllSelectedDrivers =
          List<StoreOwnDeliveryPartnersInfo>.from(listOfMenuEntities.toList());
    });
  }

  void selectAllDrivers({bool? isSelectAllDrivers = false}) {
    haveSelectAllMenus = isSelectAllDrivers;
    if (isSelectAllDrivers != null && isSelectAllDrivers == true) {
      listOfAllSelectedDrivers = List.from(listOfAllDrivers.toList());
    } else {
      listOfAllSelectedDrivers = [];
      listOfAllSelectedDrivers.clear();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => BlocListener<StoreBloc, StoreState>(
        key: const Key('all-driver-page-bloc-builder-widget'),
        bloc: context.read<StoreBloc>(),
        listener: (context, storeState) async {
          switch (storeState) {
            case SelectDriversForStoresState():
              {
                final result = await context.push(
                  Routes.BIND_DRIVER_WITH_STORE_PAGE,
                  extra: {
                    'selectItemUseCase': SelectItemUseCase.bindingWithOther,
                    'allDriver': listOfAllDrivers.toList(),
                    'selectedDriver': listOfAllSelectedDrivers.toList(),
                  },
                );
                await Future.delayed(const Duration(milliseconds: 300), () {});
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
              }
            case ReturnToStorePageState():
              {
                if (context.canPop()) {
                  context
                      .pop(storeState.listOfStoreOwnDeliveryPartners.toList());
                }
              }
            case GetAllDriversPaginationState():
              {
                try {
                  final isLastPage =
                      storeState.driverEntities.length < pageSize;
                  if (isLastPage) {
                    _pagingController.appendLastPage(
                        storeState.driverEntities.toList());
                  } else {
                    final nextPageKey = storeState.pageKey +
                        storeState.driverEntities.length;
                    //final nextPageKey = addressState.pageKey + 1;
                    _pagingController.appendPage(
                        storeState.driverEntities.toList(),
                        nextPageKey);
                  }
                  widgetState = WidgetState<StoreOwnDeliveryPartnersInfo>.allData(
                    context: context,
                    data: _pagingController.value.itemList ?? [],
                  );
                  listOfAllDrivers = _pagingController.value.itemList ?? [];
                } catch (error) {
                  _pagingController.error = error;
                  widgetState = WidgetState<StoreOwnDeliveryPartnersInfo>.error(
                    context: context,
                    reason: _pagingController.error,
                  );
                }
              }
            case GetAllEmptyDriversPaginationState():
              {
                widgetState = WidgetState<StoreOwnDeliveryPartnersInfo>.empty(
                  context: context,
                  message: storeState.message,
                );
              }
            case GetAllExceptionDriversPaginationState():
              {
                widgetState = WidgetState<StoreOwnDeliveryPartnersInfo>.error(
                  context: context,
                  reason: storeState.message,
                );
              }
            case GetAllFailedDriversPaginationState():
              {
                widgetState = WidgetState<StoreOwnDeliveryPartnersInfo>.error(
                  context: context,
                  reason: storeState.message,
                );
              }
            case GetAllLoadingDriversPaginationState():
              {
                widgetState = WidgetState<StoreOwnDeliveryPartnersInfo>.loading(
                  context: context,
                  message: storeState.message,
                );
              }
            case GetAllProcessingDriversPaginationState():
              {
                widgetState = WidgetState<StoreOwnDeliveryPartnersInfo>.processing(
                  context: context,
                  message: storeState.message,
                );
              }
            case _:
              appLog.d('Default case: BlocListener all driver page');
          }
        },
        child: BlocBuilder<StoreBloc, StoreState>(
          key: const Key('all-driver-page-bloc-builder-widget'),
          bloc: context.watch<StoreBloc>(),
          builder: (context, state) {
            switch (state) {
              case GetAllDriverState():
                {
                  listOfAllDrivers = List<StoreOwnDeliveryPartnersInfo>.from(
                      state.storeOwnDeliveryPartnerEntities.toList());
                  widgetState =
                      WidgetState<StoreOwnDeliveryPartnersInfo>.allData(
                    context: context,
                  );
                }
              case DriverEmptyState():
                {
                  if (state.driverStateStage == DriverStateStage.getAllDriver) {
                    listOfAllDrivers = [];
                    listOfAllDrivers.clear();
                    widgetState =
                        WidgetState<StoreOwnDeliveryPartnersInfo>.empty(
                      context: context,
                      message: state.message,
                    );
                  }
                }
              case DriverLoadingState():
                {
                  if (state.driverStateStage == DriverStateStage.getAllDriver) {
                    widgetState =
                        WidgetState<StoreOwnDeliveryPartnersInfo>.loading(
                      context: context,
                      isLoading: state.isLoading,
                      message: state.message,
                    );
                  }
                }
              case DriverExceptionState():
                {
                  if (state.driverStateStage == DriverStateStage.getAllDriver) {
                    widgetState =
                        WidgetState<StoreOwnDeliveryPartnersInfo>.error(
                            context: context,
                            stackTrace: state.stackTrace,
                            reason: state.message,
                            error: state.exception);
                  }
                }
              case _:
                appLog.d('Default case: BlocBuilder all driver page');
            }
            return _StoreOwnerAllDriversView(this);
          },
        ),
      );
}

class _StoreOwnerAllDriversView
    extends WidgetView<StoreOwnerAllDrivers, _StoreOwnerAllDriversController> {
  const _StoreOwnerAllDriversView(super.state);

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
              'All Drivers',
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
            ),
            actions: const [
              NotificationIconWidget(),
              LanguageSelectionWidget(),
            ],
          ),
          floatingActionButton: AnimatedOpacity(
            opacity: state.listOfAllSelectedDrivers.isEmpty ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 70),
              child: FloatingActionButton(
                backgroundColor: const Color.fromRGBO(69, 201, 125, 1.0),
                onPressed: () async {
                  if (state.listOfAllSelectedDrivers.isEmpty) {
                    return;
                  } else {
                    switch (widget.selectItemUseCase) {
                      /*case SelectItemUseCase.bindingWithOther:
                        {
                          context.read<StoreBloc>().add(
                                BindDriverWithStores(
                                  listOfStoreOwnDeliveryPartners: state.listOfAllSelectedDrivers.toList(),
                                ),
                              );
                          return;
                        }*/
                      case SelectItemUseCase.selectAndReturn:
                        {
                          context.read<StoreBloc>().add(
                                ReturnToStorePage(
                                  listOfStoreOwnDeliveryPartners:
                                      state.listOfAllSelectedDrivers.toList(),
                                ),
                              );
                          return;
                        }
                      case _:
                        {
                          context.read<StoreBloc>().add(
                                SelectDriversForStores(
                                  listOfStoreOwnDeliveryPartners:
                                      state.listOfAllDrivers.toList(),
                                  listOfSelectedStoreOwnDeliveryPartners:
                                      state.listOfAllSelectedDrivers.toList(),
                                  selectItemUseCase: widget.selectItemUseCase,
                                ),
                              );
                          return;
                        }
                        ;
                    }
                  }
                },
                child: switch (widget.selectItemUseCase) {
                  /*SelectItemUseCase.bindingWithOther => const Icon(
                      Icons.store,
                    ),*/
                  SelectItemUseCase.selectAndReturn => const Icon(
                      Icons.check,
                    ),
                  _ => const Icon(
                      Icons.store,
                    ),
                },
              ),
            ),
          ),
          body: SlideInLeft(
            key: const Key('get-all-drivers-slideinleft-widget'),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: state.listOfAllDrivers.isEmpty
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
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
                            duration: Duration(milliseconds: 100)),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            children: [
                              Expanded(child:  AppSearchInputSliverWidget(
                                key: const Key('all-drivers-search-field-widget'),
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
                                    hintText: 'Search driver',
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
                                        color:
                                            Color.fromRGBO(238, 238, 238, 1)),
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
                        const AnimatedGap(6,
                            duration: Duration(milliseconds: 100)),
                        CheckboxListTile(
                          value: state.haveSelectAllMenus,
                          onChanged: (value) {
                            state.selectAllDrivers(isSelectAllDrivers: value);
                          },
                          tristate: true,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          contentPadding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 0),
                          //dense: true,
                          title: IntrinsicHeight(
                            child: Row(
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                              children: [
                                Text(
                                  'Your Drivers',
                                  textDirection:
                                      serviceLocator<LanguageController>()
                                          .targetTextDirection,
                                ),
                                const AnimatedGap(3,
                                    duration: Duration(milliseconds: 100)),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 12.0,
                                        end: 12,
                                        top: 4,
                                        bottom: 4),
                                    child: Text(
                                      '${state._pagingController.value.itemList?.length??0}',
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                    ),
                                  ),
                                ),
                                const AnimatedGap(12,
                                    duration: Duration(milliseconds: 100)),
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
                        /*ListTile(
                          dense: true,
                          title: IntrinsicHeight(
                            child: Row(
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              children: [
                                Text(
                                  'Your Drivers',
                                  style: context.labelLarge!.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                ),
                                const AnimatedGap(3, duration: Duration(milliseconds: 500)),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusDirectional.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(start: 12.0, end: 12, top: 4, bottom: 4),
                                    child: Text(
                                      '${state.listOfAllDrivers.length}',
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                          horizontalTitleGap: 0,
                          minLeadingWidth: 0,
                          contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 2),
                        ),*/
                        const AnimatedGap(6,
                            duration: Duration(milliseconds: 100)),
                      ],
                    ),
                    secondChild: const Offstage(),
                    duration: const Duration(milliseconds: 500),
                    crossFadeState: (state.listOfAllDrivers.isNotEmpty)
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                  ),
                  Expanded(
                    flex: 2,
                    child: state.widgetState.maybeWhen(
                      empty: (context, child, message, data) =>const NoItemAvailableWidget(
                        key: Key('all-driver-empty-widget'),
                        textMessage: 'No driver available or added by you',
                      ),
                      loading:
                          (context, child, message, isLoading) {
                        return const DataLoadingWidget(
                          key: Key('all-driver-loading-widget'),
                        );
                      },
                      processing:
                          (context, child, message, isLoading) {
                        return const DataLoadingWidget(
                          key: Key('all-driver-processing-widget'),
                        );
                      },
                      none: () {
                        return const NoItemAvailableWidget(
                          key: Key('all-driver-none-widget'),
                          textMessage: 'No driver available or added by you',
                        );
                      },
                      orElse: () {
                        return const NoItemAvailableWidget(
                          key: Key('all-driver-else-widget'),
                          textMessage: 'No driver available or added by you',
                        );
                      },

                      allData: (context, child, message, data) {
                        return CustomScrollView(
                          controller: state.innerScrollController,
                          slivers: [
                            PagedSliverList<int, StoreOwnDeliveryPartnersInfo>(
                              key: const Key(
                                  'driver-list-pagedSliverList-widget'),
                              pagingController: state._pagingController,
                              builderDelegate:
                              PagedChildBuilderDelegate<
                                  StoreOwnDeliveryPartnersInfo>(
                                animateTransitions: true,
                                itemBuilder: (context, item, index) =>
                                    DriverCard(
                                      key: ValueKey(index),
                                      storeOwnDeliveryPartnerEntity: item,
                                      listOfAllStoreOwnDeliveryPartnerEntities:
                                      state.listOfAllDrivers.toList(),
                                      currentIndex: index,
                                      onSelectionChanged: (List<
                                          StoreOwnDeliveryPartnersInfo>
                                      listOfAllStoreOwnDeliveryPartnerEntities) {
                                        state.onSelectionChanged(
                                            listOfAllStoreOwnDeliveryPartnerEntities
                                                .toList());
                                      },
                                      listOfAllSelectedStoreOwnDeliveryPartnerEntities:
                                      state.listOfAllSelectedDrivers.toList(),
                                    ),
                              ),
                            ),
                          ],
                        );
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            return DriverCard(
                              key: ValueKey(index),
                              storeOwnDeliveryPartnerEntity:
                                  state.listOfAllDrivers[index],
                              listOfAllStoreOwnDeliveryPartnerEntities:
                                  state.listOfAllDrivers.toList(),
                              currentIndex: index,
                              onSelectionChanged: (List<
                                      StoreOwnDeliveryPartnersInfo>
                                  listOfAllStoreOwnDeliveryPartnerEntities) {
                                state.onSelectionChanged(
                                    listOfAllStoreOwnDeliveryPartnerEntities
                                        .toList());
                              },
                              listOfAllSelectedStoreOwnDeliveryPartnerEntities:
                                  state.listOfAllSelectedDrivers.toList(),
                            );
                          },
                          itemCount: state.listOfAllDrivers.length,
                          separatorBuilder: (context, index) {
                            return const Divider(
                                thickness: 0.25,
                                color: Color.fromRGBO(127, 129, 132, 1));
                          },
                        );
                      },

                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            context.push(
                              Routes.SAVE_DRIVER_PAGE,
                              extra: {
                                'storeOwnDeliveryPartnersInfo': null,
                                'haveNewDriver': true,
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
                            'Add New Driver',
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                          ).translate(),
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
    );
  }
}
