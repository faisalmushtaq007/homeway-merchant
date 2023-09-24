part of 'package:homemakers_merchant/app/features/store/index.dart';

class BindDriverWithStore extends StatefulWidget {
  const BindDriverWithStore({
    super.key,
    this.listOfAllStoreOwnDeliveryPartners = const [],
    this.listOfAllSelectedStoreOwnDeliveryPartners = const [],
    this.selectItemUseCase = SelectItemUseCase.none,
  });

  final List<StoreOwnDeliveryPartnersInfo> listOfAllStoreOwnDeliveryPartners;
  final List<StoreOwnDeliveryPartnersInfo>
      listOfAllSelectedStoreOwnDeliveryPartners;
  final SelectItemUseCase selectItemUseCase;

  @override
  _BindDriverWithStoreController createState() =>
      _BindDriverWithStoreController();
}

class _BindDriverWithStoreController extends State<BindDriverWithStore> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  List<StoreOwnDeliveryPartnersInfo> listOfAllStoreOwnDeliveryPartners = [];
  List<StoreOwnDeliveryPartnersInfo> listOfAllSelectedStoreOwnDeliveryPartners =
      [];
  List<StoreEntity> listOfAllStores = [];
  List<StoreEntity> listOfAllSelectedStores = [];
  final TextEditingController searchTextEditingController =
      TextEditingController();
  WidgetState<StoreEntity> widgetState = const WidgetState<StoreEntity>.none();
  bool? haveSelectAllStores = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    listOfAllStoreOwnDeliveryPartners = [];
    listOfAllStoreOwnDeliveryPartners.clear();
    listOfAllSelectedStoreOwnDeliveryPartners = [];
    listOfAllSelectedStoreOwnDeliveryPartners.clear();
    listOfAllStores = [];
    listOfAllStores.clear();
    listOfAllSelectedStores = [];
    listOfAllSelectedStores.clear();
    initLoadSelectedDrivers();
    context.read<StoreBloc>().add(GetAllStore());
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void initLoadSelectedDrivers() {
    listOfAllStoreOwnDeliveryPartners = List<StoreOwnDeliveryPartnersInfo>.from(
        widget.listOfAllStoreOwnDeliveryPartners.toList());
    listOfAllSelectedStoreOwnDeliveryPartners =
        List<StoreOwnDeliveryPartnersInfo>.from(
            widget.listOfAllSelectedStoreOwnDeliveryPartners.toList());
    setState(() {});
  }

  @override
  void dispose() {
    scrollController.dispose();
    innerScrollController.dispose();
    searchTextEditingController.dispose();
    listOfAllStoreOwnDeliveryPartners = [];
    listOfAllStoreOwnDeliveryPartners.clear();
    listOfAllSelectedStoreOwnDeliveryPartners = [];
    listOfAllSelectedStoreOwnDeliveryPartners.clear();
    listOfAllStores = [];
    listOfAllStores.clear();
    listOfAllSelectedStores = [];
    listOfAllSelectedStores.clear();
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

  @override
  Widget build(BuildContext context) => BlocListener<StoreBloc, StoreState>(
        key: const Key('bind-driver-with-store-page-bloc-listener-widget'),
        bloc: context.watch<StoreBloc>(),
        listener: (context, state) {
          switch (state) {
            case BindDriverWithStoresState():
              {
                if (state.bindDriverToStoreStage ==
                    BindingStage.bindingDriverWithStore) {
                  listOfAllSelectedStores = [];
                  listOfAllSelectedStores.clear();
                  context.pushReplacement(
                    Routes.BIND_DRIVER_WITH_STORE_GREETING_PAGE,
                    extra: {
                      'allDriver':
                          state.listOfSelectedStoreOwnDeliveryPartners.toList(),
                      'allStore': state.listOfSelectedStoreEntities.toList(),
                    },
                  );
                }
                return;
              }
            case UnBindDriverWithStoresState():
              {
                if (state.bindDriverToStoreStage ==
                    BindingStage.unbindingDriverWithStore) {
                  listOfAllSelectedStores = [];
                  listOfAllSelectedStores.clear();
                  context.pushReplacement(
                    Routes.BIND_DRIVER_WITH_STORE_GREETING_PAGE,
                    extra: {
                      'allDriver':
                          state.listOfSelectedStoreOwnDeliveryPartners.toList(),
                      'allStore': state.listOfSelectedStoreEntities.toList(),
                      'message': '',
                      'isRemoved': true,
                    },
                  );
                }
                return;
              }
            case _:
              appLog.d('Default case: all bloc listener bind menu page');
          }
        },
        child: BlocBuilder<StoreBloc, StoreState>(
          key: const Key('bind-driver-with-store-page-bloc-builder-widget'),
          bloc: context.watch<StoreBloc>(),
          builder: (context, state) {
            switch (state) {
              case GetAllStoreState():
                {
                  listOfAllStores =
                      List<StoreEntity>.from(state.storeEntities.toList());
                  widgetState = WidgetState<StoreEntity>.allData(
                    context: context,
                  );
                }
              case GetEmptyStoreState():
                {
                  listOfAllStores = [];
                  listOfAllStores.clear();
                  widgetState = WidgetState<StoreEntity>.empty(
                    context: context,
                    message: state.message,
                  );
                }
              case StoreLoadingState():
                {
                  widgetState = WidgetState<StoreEntity>.loading(
                    context: context,
                    isLoading: state.isLoading,
                    message: state.message,
                  );
                }
              case _:
                appLog.d('Default case: all bloc builder bind driver page');
            }
            return _BindDriverWithStoreView(this);
          },
        ),
      );
}

class _BindDriverWithStoreView
    extends WidgetView<BindDriverWithStore, _BindDriverWithStoreController> {
  const _BindDriverWithStoreView(super.state);

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
          /*floatingActionButton: AnimatedOpacity(
            opacity: (state.listOfAllSelectedStoreOwnDeliveryPartners.isEmpty && state.listOfAllSelectedStores.isEmpty) ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 70),
              child: FloatingActionButton(
                backgroundColor: const Color.fromRGBO(69, 201, 125, 1.0),
                onPressed: () async {
                  if (state.listOfAllSelectedStoreOwnDeliveryPartners.isEmpty && state.listOfAllSelectedStores.isEmpty) {
                    return;
                  } else {
                    context.go(
                      Routes.BIND_DRIVER_WITH_STORE_GREETING_PAGE,
                      extra: {
                        'allDriver': state.listOfAllSelectedStoreOwnDeliveryPartners.toList(),
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
          ),*/
          body: Directionality(
            textDirection:
                serviceLocator<LanguageController>().targetTextDirection,
            child: SlideInLeft(
              key: const Key('bind-driver-with-store-slideinleft-widget'),
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
                                        hintText: 'Search driver',
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
                                              BorderRadiusDirectional.circular(
                                                  10),
                                        ),
                                        side: const BorderSide(
                                            color: Color.fromRGBO(
                                                238, 238, 238, 1)),
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
                              value: state.haveSelectAllStores,
                              onChanged: (value) {
                                state.selectAllStores(isSelectAllStores: value);
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
                                      'Your Stores',
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                    ),
                                    const AnimatedGap(3,
                                        duration: Duration(milliseconds: 100)),
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
                                          '${state.listOfAllStores.length}',
                                          textDirection: serviceLocator<
                                                  LanguageController>()
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
                            const AnimatedGap(12,
                                duration: Duration(milliseconds: 100)),
                            Text(
                              'Select Store',
                              style: context.titleMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                            ),
                            const AnimatedGap(12,
                                duration: Duration(milliseconds: 100)),
                            Text(
                              'For your Driver',
                              style: context.labelMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: context.colorScheme.primary,
                              ),
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                            ),
                          ],
                        ),
                        secondChild: const Offstage(),
                        duration: const Duration(milliseconds: 500),
                        crossFadeState: (state.listOfAllStores.isNotEmpty)
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                      ),
                      const AnimatedGap(12,
                          duration: Duration(milliseconds: 300)),
                      Expanded(
                        flex: 2,
                        child: state.widgetState.maybeWhen(
                          empty: (context, child, message, data) => Center(
                            key: const Key(
                                'get-all-bind-drivers-with-store-empty-widget'),
                            child: Text(
                              'No store available or added by you',
                              style: context.labelLarge,
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                            ).translate(),
                          ),
                          loading: (context, child, message, isLoading) {
                            return const Center(
                              key: Key(
                                  'get-all-bind-drivers-with-store-center-widget'),
                              child: SizedBox(
                                width: 48,
                                height: 48,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                          allData: (context, child, message, data) {
                            return ListView.separated(
                              itemBuilder: (context, index) {
                                return BindStoreCardWidget(
                                  key: ValueKey(index),
                                  currentIndex: index,
                                  onSelectionChanged: (List<StoreEntity>
                                      listOfAllStoreEntities) {
                                    state.onSelectionChanged(
                                        listOfAllStoreEntities.toList());
                                  },
                                  listOfAllSelectedStoreEntities:
                                      state.listOfAllSelectedStores.toList(),
                                  listOfAllStoreEntities:
                                      state.listOfAllStores.toList(),
                                  storeEntity: state.listOfAllStores[index],
                                );
                              },
                              itemCount: state.listOfAllStores.length,
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
                                'No stores available or added by you',
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
                              onPressed: () {
                                //context.push(Routes.SAVE_MENU_PAGE);
                                context.read<StoreBloc>().add(
                                      UnBindDriverWithStores(
                                        listOfStoreOwnDeliveryPartners: state
                                            .listOfAllStoreOwnDeliveryPartners
                                            .toList(),
                                        listOfSelectedStoreOwnDeliveryPartners:
                                            state
                                                .listOfAllSelectedStoreOwnDeliveryPartners
                                                .toList(),
                                        listOfSelectedStoreEntities: state
                                            .listOfAllSelectedStores
                                            .toList(),
                                        storeEntities:
                                            state.listOfAllStores.toList(),
                                        bindDriverToStoreStage: BindingStage
                                            .unbindingDriverWithStore,
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
                                context.read<StoreBloc>().add(
                                      BindDriverWithStores(
                                        listOfStoreOwnDeliveryPartners: state
                                            .listOfAllStoreOwnDeliveryPartners
                                            .toList(),
                                        listOfSelectedStoreOwnDeliveryPartners:
                                            state
                                                .listOfAllSelectedStoreOwnDeliveryPartners
                                                .toList(),
                                        listOfSelectedStoreEntities: state
                                            .listOfAllSelectedStores
                                            .toList(),
                                        storeEntities:
                                            state.listOfAllStores.toList(),
                                        bindDriverToStoreStage:
                                            BindingStage.bindingDriverWithStore,
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
        ),
      ),
    );
  }
}
