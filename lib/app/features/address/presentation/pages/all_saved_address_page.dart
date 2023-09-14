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
  int pageSize = 5;
  int pageKey = 0;
  String? searchText;
  String? sorting;
  String? filtering;
  late final PagingController<int, AddressModel> _pagingController;
  List<AddressModel> addressEntities = [];

  @override
  void initState() {
    _pagingController =
        PagingController(firstPageKey: 0);
    addressEntities = [];
    addressEntities.clear();
    //_pagingController.refresh();
    _refreshAddressList();
    widgetState = WidgetState<AddressModel>.loading(context: context);
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    //context.read<AddressBloc>().add(const GetAllAddress());
  }

  Future<void> _fetchPage(int pageKey,
      {int pageSize = 5, String? searchItem, String? filter, String? sort}) async{
    /*if (pageKey == 0) {
      _pagingController.itemList = [];
    }*/
    int sectionNumber = pageKey ~/ pageSize;
    print('Loading section $sectionNumber');
    try {
      context.read<AddressBloc>().add(
                 GetAllAddressPagination(
                  pageKey: pageKey,
                  pageSize: pageSize,
                  searchText: searchItem,
                  filter: filtering ?? filter,
                  sorting: sorting ?? sort,
                ),
              );
      appLog.i('Fetch Address');
      return;
    } catch (error) {
      _pagingController.error = error;
      print(error);
    }
  }

  @override
  void dispose() {
    _pagingController.removeListener(() { });
    _pagingController.removePageRequestListener((pageKey) { });
    _pagingController.removeStatusListener((status) { });
    _pagingController.dispose();
    scrollController.dispose();
    innerScrollController.dispose();
    addressEntities = [];
    addressEntities.clear();
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
    _pagingController.addPageRequestListener((pageKey)  {
      this.pageKey = pageKey;
      appLog.d('Page key addPageRequestListener ${pageKey}');
      _fetchPage(pageKey);
    });
    _pagingController.addListener(() {
      appLog.d('Page key addListener ${pageKey}');
      //_fetchPage(0);
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
  Widget build(BuildContext context) => BlocListener<AddressBloc, AddressState>(
        key: const Key('all-address-bloc-listener'),
        bloc: context.read<AddressBloc>(),
        //listenWhen: (previous, current) => previous != current,
        listener: (context, addressListenerState) {
          switch(addressListenerState){
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
                  addressEntities =
                      _pagingController.value.itemList ?? [];
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
                                /*IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    children: [
                                      Expanded(
                                        child: SherlockSearchBar(
                                          //isFullScreen: true,
                                          sherlock: Sherlock(elements: state.addressEntities.map((e) => e.toMap()).toList()),
                                          sherlockCompletion: SherlockCompletion(where: 'by', elements: state.addressEntities.map((e) => e.toMap()).toList()),
                                          sherlockCompletionMinResults: 1,
                                          onSearch: (input, sherlock) {
                                            */ /*setState(() {
                                                        state._results = sherlock.search(input: input);
                                                      });*/ /*
                                          },
                                          completionsBuilder: (context, completions) => SherlockCompletionsBuilder(
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
                                                  const Icon(Icons.close)
                                                ],
                                              ),
                                            ),
                                          ),
                                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16.0),
                                          constraints: const BoxConstraints(minWidth: 360.0, maxWidth: 800.0, minHeight: 48.0),
                                          viewConstraints: const BoxConstraints(minWidth: 360.0, minHeight: 240.0),
                                          viewShape: RoundedRectangleBorder(
                                            borderRadius: BorderRadiusDirectional.circular(12),
                                          ),
                                          isFullScreen: false,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadiusDirectional.circular(12),
                                          ),
                                          elevation: 1,
                                        ),
                                      ),
                                      const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                      SizedBox(
                                        height: 52,
                                        child: OutlinedButton(
                                          onPressed: () {},
                                          style: OutlinedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadiusDirectional.circular(10),
                                            ),
                                            side: const BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
                                            backgroundColor: Colors.white,
                                          ),
                                          child: Icon(
                                            Icons.filter_list,
                                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                            color: context.primaryColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const AnimatedGap(6, duration: Duration(milliseconds: 500)),*/
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
                                              '${state.addressEntities.length}',
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
                              empty: (context, child, message, data) => Center(
                                key: const Key('get-all-address-empty-widget'),
                                child: Text(
                                  'No address available or added by you',
                                  style: context.labelLarge,
                                  textDirection:
                                      serviceLocator<LanguageController>()
                                          .targetTextDirection,
                                ).translate(),
                              ),
                              loading: (context, child, message, isLoading) {
                                return const Center(
                                  key: Key('get-all-address-center-widget'),
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
                                    PagedSliverList<int, AddressModel>(
                                      key: const Key('address-list-pagedSliverList-widget'),
                                      pagingController: state._pagingController,
                                      builderDelegate: PagedChildBuilderDelegate<AddressModel>(
                                        animateTransitions: true,
                                        itemBuilder: (context, item, index) => AddressCardWidget(
                                          key: ValueKey(index),
                                          addressEntity: state.addressEntities[index],
                                          listOfAllAddressEntities: state.addressEntities.toList(),
                                          currentIndex: index,
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
                                return Center(
                                  child: Text(
                                    'No address available or added by you',
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
                                    //state._refreshAddressList();
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
