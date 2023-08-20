part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuAllAddonsPage extends StatefulWidget {
  const MenuAllAddonsPage({super.key, this.selectItemUseCase = SelectItemUseCase.none});
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
  final PagingController<int, Addons> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    listViewBuilderScrollController = ScrollController();
    innerScrollController = ScrollController();
    _menuAvailableAddons = [];
    _selectedAddons = [];
    //initMenuAddons();
    context.read<MenuBloc>().add(GetAllAddons());
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    innerScrollController.dispose();
    listViewBuilderScrollController.dispose();
    _menuAvailableAddons = [];
    _selectedAddons = [];
    super.dispose();
  }

  void initMenuAddons() {
    //_menuAvailableAddons = List<Addons>.from(localMenuAddons.toList());
  }

  @override
  Widget build(BuildContext context) => BlocListener<MenuBloc, MenuState>(
        key: const Key('get-all-addons-bloclistener-widget'),
        bloc: context.watch<MenuBloc>(),
        listener: (context, menuState) {
          if (menuState is PopToMenuPageState) {
            if (context.canPop()) {
              Navigator.of(context).pop(menuState.addonsEntity.toList());
            }
          }
        },
        child: BlocBuilder<MenuBloc, MenuState>(
          key: const Key('get-all-addons-blocbuilder-widget'),
          bloc: context.watch<MenuBloc>(),
          builder: (context, addonsState) {
            switch (addonsState) {
              case GetAllAddonsState():
                {
                  _menuAvailableAddons = List<Addons>.from(addonsState.addonsEntities.toList());
                  widgetState = WidgetState<Addons>.allData(
                    context: context,
                  );
                }
              case GetEmptyAddonsState():
                {
                  print(addonsState.message);
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
                  _selectedAddons = List<Addons>.from(addonsState.selectedAddonsEntities.toList());
                }
              case _:
                print('default');
            }
            return _MenuAllAddonsPageView(this);
          },
        ),
      );
}

class _MenuAllAddonsPageView extends WidgetView<MenuAllAddonsPage, _MenuAllAddonsPageController> {
  const _MenuAllAddonsPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
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
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
            ),
            actions: const [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
                child: LanguageSelectionWidget(),
              ),
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
                        PopToMenuPage(addonsEntity: state._selectedAddons.toList()),
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
                        maxHeight: media.size.height - (media.padding.top + kToolbarHeight + media.padding.bottom + margins),
                        //minHeight: media.size.height,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SherlockSearchBar(
                                          //isFullScreen: true,
                                          sherlock: Sherlock(elements: state._menuAvailableAddons.map((e) => e.toMap()).toList()),
                                          sherlockCompletion:
                                              SherlockCompletion(where: 'by', elements: state._menuAvailableAddons.map((e) => e.toMap()).toList()),
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
                                        height: 48,
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
                                          'Your Addons',
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
                                              '${state._menuAvailableAddons.length}',
                                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                  horizontalTitleGap: 0,
                                  minLeadingWidth: 0,
                                  contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 2),
                                ),
                                const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                              ],
                            ),
                            secondChild: const Offstage(),
                            duration: const Duration(milliseconds: 500),
                            crossFadeState: (state._menuAvailableAddons.isNotEmpty) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                          ),
                          Expanded(
                            child: CustomScrollView(
                              controller: state.innerScrollController,
                              slivers: [
                                state.widgetState.maybeWhen(
                                  empty: (context, child, message, data) => SliverToBoxAdapter(
                                    child: Center(
                                      key: const Key('get-all-addons-empty-widget'),
                                      child: Text(
                                        'No addons available or added by you',
                                        style: context.labelLarge,
                                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      ).translate(),
                                    ),
                                  ),
                                  loading: (context, child, message, isLoading) {
                                    return SliverToBoxAdapter(
                                      child: const Center(
                                        key: Key('get-all-addons-center-widget'),
                                        child: SizedBox(
                                          width: 48,
                                          height: 48,
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    );
                                  },
                                  allData: (context, child, message, data) {
                                    return PagedSliverList<int, Addons>(
                                      pagingController: state._pagingController,
                                      builderDelegate: PagedChildBuilderDelegate<Addons>(
                                          animateTransitions: true,
                                          itemBuilder: (context, notificationResult, index) => AddonsCard(
                                                key: ValueKey(index),
                                                addonsEntity: state._menuAvailableAddons[index],
                                                onChangedAddons: (value) {
                                                  //state._selectedAddons = List<StoreAvailableFoodPreparationType>.from(value);
                                                  context.read<MenuBloc>().add(
                                                        SelectAddons(
                                                          index: index,
                                                          addonsID: state._menuAvailableAddons[index].addonsID,
                                                          addonsEntity: state._menuAvailableAddons[index],
                                                          addonsEntities: state._menuAvailableAddons.toList(),
                                                          selectedAddonsEntities: state._selectedAddons.toList(),
                                                        ),
                                                      );
                                                },
                                                selectedAllAddons: state._selectedAddons.toList(),
                                              )),
                                    );
                                  },
                                  none: () {
                                    return SliverToBoxAdapter(
                                      child: Center(
                                        child: Text(
                                          'No addons available or added by you',
                                          style: context.labelLarge,
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate(),
                                      ),
                                    );
                                  },
                                  orElse: () {
                                    return SliverToBoxAdapter(child: const SizedBox());
                                  },
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final navigateToSaveAddonsPage = await context.push(
                                      Routes.SAVE_ADDONS_PAGE,
                                      extra: {
                                        'addons': null,
                                        'haveNewAddons': true,
                                        'haveOwnAddons': true,
                                        'currentIndex': -1,
                                      },
                                    );
                                    if (!state.mounted) {
                                      return;
                                    }
                                    context.read<MenuBloc>().add(GetAllAddons());
                                    return;
                                  },
                                  child: Text(
                                    'Add Addons',
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
                  return Container(
                    constraints: BoxConstraints(
                      minWidth: double.infinity,
                      minHeight: media.size.height,
                    ),
                    child: Stack(
                      children: [
                        ScrollableColumn(
                          controller: state.scrollController,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: state._menuAvailableAddons.isEmpty ? MainAxisAlignment.center : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          flexible: true,
                          physics: const ClampingScrollPhysics(),
                          children: [
                            Flexible(
                              flex: 1,
                              child: state.widgetState.maybeWhen(
                                empty: (context, child, message, data) => Center(
                                  key: const Key('get-all-addons-empty-widget'),
                                  child: Text(
                                    'No addons available or added',
                                    style: context.labelLarge,
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  ).translate(),
                                ),
                                loading: (context, child, message, isLoading) {
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
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    key: const Key('get-all-addons-listviewbuilder-widget'),
                                    controller: state.listViewBuilderScrollController,
                                    itemCount: state._menuAvailableAddons.length,
                                    itemBuilder: (context, index) {
                                      return AddonsCard(
                                        key: ValueKey(index),
                                        addonsEntity: state._menuAvailableAddons[index],
                                        onChangedAddons: (value) {
                                          //state._selectedAddons = List<StoreAvailableFoodPreparationType>.from(value);
                                          context.read<MenuBloc>().add(
                                                SelectAddons(
                                                  index: index,
                                                  addonsID: state._menuAvailableAddons[index].addonsID,
                                                  addonsEntity: state._menuAvailableAddons[index],
                                                  addonsEntities: state._menuAvailableAddons.toList(),
                                                  selectedAddonsEntities: state._selectedAddons.toList(),
                                                ),
                                              );
                                        },
                                        selectedAllAddons: state._selectedAddons.toList(),
                                      );
                                    },
                                  );
                                },
                                none: () {
                                  return Center(
                                    child: Text(
                                      'No addons available or added',
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
                          ],
                        ),
                        PositionedDirectional(
                          bottom: 0,
                          start: 0,
                          end: 0,
                          child: ElevatedButton(
                            onPressed: () async {
                              final navigateToSaveAddonsPage = await context.push(
                                Routes.SAVE_ADDONS_PAGE,
                                extra: {
                                  'addons': null,
                                  'haveNewAddons': true,
                                  'haveOwnAddons': true,
                                  'currentIndex': -1,
                                },
                              );
                              if (!state.mounted) {
                                return;
                              }
                              context.read<MenuBloc>().add(GetAllAddons());
                              return;
                            },
                            child: Text(
                              'Add Addons',
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            ).translate(),
                          ),
                        )
                      ],
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
