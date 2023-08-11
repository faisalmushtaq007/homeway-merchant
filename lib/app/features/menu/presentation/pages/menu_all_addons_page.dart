part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuAllAddonsPage extends StatefulWidget {
  const MenuAllAddonsPage({super.key});

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
  ResultState<Addons> resultState = const ResultState<Addons>.empty();
  WidgetState<Addons> widgetState = const WidgetState<Addons>.none();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    listViewBuilderScrollController = ScrollController();
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
              padding: EdgeInsetsDirectional.only(bottom: 70),
              child: FloatingActionButton(
                child: Icon(
                  Icons.check,
                ),
                backgroundColor: Color.fromRGBO(69, 201, 125, 1.0),
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
                minWidth: double.infinity,
                minHeight: media.size.height,
              ),
              padding: EdgeInsetsDirectional.only(
                top: margins,
                bottom: bottomPadding,
                start: margins * 2.5,
                end: margins * 2.5,
              ),
              child: BlocBuilder<PermissionBloc, PermissionState>(
                bloc: context.read<PermissionBloc>(),
                buildWhen: (previous, current) => previous != current,
                builder: (context, permissionState) {
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
                                  key: Key('get-all-addons-empty-widget'),
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
                                  return SizedBox();
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
