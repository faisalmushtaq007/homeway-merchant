part of 'package:homemakers_merchant/app/features/address/index.dart';

class AllSavedAddressPage extends StatefulWidget {
  const AllSavedAddressPage({
    super.key,
    this.selectItemUseCase = SelectItemUseCase.none,
  });
  final SelectItemUseCase selectItemUseCase;

  @override
  _AllSavedAddressPageController createState() => _AllSavedAddressPageController();
}

class _AllSavedAddressPageController extends State<AllSavedAddressPage> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  List<AddressModel> addressEntities = [];
  WidgetState<AddressModel> widgetState = WidgetState<AddressModel>.none();
  int pageSize = 10;
  int pageKey = 0;
  String? searchText;
  String? sorting;
  String? filtering;
  final PagingController<int, AddressModel> _addressPagingController = PagingController(firstPageKey: 0);
  final addressFormPageFormKey = GlobalKey<FormState>();
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    addressEntities = [];
    addressEntities.clear();
    //context.read<PermissionBloc>().add(RequestLocationPermissionEvent());
    //widgetState = WidgetState<AddressModel>.loading(context: context);
    _addressPagingController.nextPageKey = 0;
    _addressPagingController.addPageRequestListener((pageKey) {
      this.pageKey = pageKey;
      _fetchAllAddressFunction(pageKey);
    });

    _addressPagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching a all orders.',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => _addressPagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
    //_fetchAllAddressFunction(pageKey);

    //
    context.read<AddressBloc>().add(GetAllAddress());
  }

  void _fetchAllAddressFunction(int pageKey, {int pageSize = 10, String? searchItem, String? filter, String? sort}) {
    appLog.i('Fetch ');
    context.read<AddressBloc>().add(GetAllAddressPaginationEvent(
          pageKey: pageKey,
          pageSize: pageSize,
          searchText: searchItem,
          filter: filtering ?? filter,
          sorting: sorting ?? sort,
        ));
    //return;
  }

  @override
  void dispose() {
    _addressPagingController.dispose();
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

  void _refreshAddressList(){
    _addressPagingController.nextPageKey = 0;
    _fetchAllAddressFunction(0);
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
                  final isLastPage = addressListenerState.addressEntities.length < pageSize;
                  if (isLastPage) {
                    _addressPagingController.appendLastPage(addressListenerState.addressEntities.toList());
                  } else {
                    final nextPageKey = addressListenerState.pageKey + addressListenerState.addressEntities.length;
                    //final nextPageKey = addressListenerState.pageKey + 1;
                    _addressPagingController.appendPage(addressListenerState.addressEntities.toList(), nextPageKey);
                  }
                  widgetState = WidgetState<AddressModel>.allData(
                    context: context,
                    data: _addressPagingController.value.itemList ?? [],
                  );
                  addressEntities = _addressPagingController.value.itemList ?? [];
                } catch (error) {
                  _addressPagingController.error = error;
                  widgetState = WidgetState<AddressModel>.error(
                    context: context,
                    reason: _addressPagingController.error,
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
            case AddressExceptionState():
              {
                widgetState = WidgetState<AddressModel>.error(
                  context: context,
                  reason: addressListenerState.message,
                );
              }
            case AddressFailedState():
              {
                widgetState = WidgetState<AddressModel>.error(
                  context: context,
                  reason: addressListenerState.message,
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
                  data: _addressPagingController.value.itemList ?? [],
                );
                addressEntities = addressListenerState.addressEntities.toList();
              }
            case _:
              appLog.d('Default case: all address page bloc listener');
          }
        },
        child: _AllSavedAddressPageView(this),
      );
}

class _AllSavedAddressPageView extends WidgetView<AllSavedAddressPage, _AllSavedAddressPageController> {
  const _AllSavedAddressPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
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
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
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
                        maxHeight: media.size.height - (media.padding.top + kToolbarHeight + media.padding.bottom),
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
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        children: [
                          AnimatedCrossFade(
                            firstChild: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              children: [
                                const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                IntrinsicHeight(
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
                                            /*setState(() {
                                                        state._results = sherlock.search(input: input);
                                                      });*/
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
                                const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                ListTile(
                                  dense: true,
                                  title: IntrinsicHeight(
                                    child: Row(
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Text(
                                          'Your Address',
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
                                              '${state.addressEntities.length}',
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
                                ),
                                const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                              ],
                            ),
                            secondChild: const Offstage(),
                            duration: const Duration(milliseconds: 500),
                            crossFadeState: (state.addressEntities.isNotEmpty) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                          ),
                          Expanded(
                            child: state.widgetState.maybeWhen(
                              empty: (context, child, message, data) => Center(
                                key: const Key('get-all-address-empty-widget'),
                                child: Text(
                                  'No address available or added by you',
                                  style: context.labelLarge,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
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
                                /*return CustomScrollView(
                                  slivers: [
                                    PagedSliverList<int, AddressModel>(
                                      pagingController: state._addressPagingController,
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
                                );*/
                                return ListView.separated(
                                  itemBuilder: (context, index) {
                                    return AddressCardWidget(
                                      key: ValueKey(index),
                                      addressEntity: state.addressEntities[index],
                                      listOfAllAddressEntities: state.addressEntities.toList(),
                                      currentIndex: index,
                                    );
                                  },
                                  shrinkWrap: true,
                                  itemCount: state.addressEntities.length,
                                  separatorBuilder: (context, index) {
                                    return const Divider(thickness: 0.25, color: Color.fromRGBO(127, 129, 132, 1));
                                  },
                                );
                              },
                              none: () {
                                return Center(
                                  child: Text(
                                    'No address available or added by you',
                                    style: context.labelLarge,
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
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
                                    final navigateToSaveStorePage = await context.push(
                                      Routes.PICKUP_LOCATION_FROM_MAP_PAGE,
                                      extra: {
                                        'addressEntity': null,
                                        'addressEntities': state.addressEntities.toList(),
                                        'haveNewAddress': true,
                                        'currentIndex': -1,
                                      },
                                    );
                                    //context.read<AddressBloc>().add(GetAllAddress());
                                   state._refreshAddressList();
                                    return;
                                  },
                                  child: Text(
                                    'Add New Address',
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
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
