part of 'package:homemakers_merchant/app/features/menu/index.dart';

class AllMenuPage extends StatefulWidget {
  const AllMenuPage({super.key});

  @override
  _AllMenuPageController createState() => _AllMenuPageController();
}

class _AllMenuPageController extends State<AllMenuPage> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  List<MenuEntity> listOfAllMenus = [];
  List<MenuEntity> listOfAllSelectedMenus = [];
  final TextEditingController searchTextEditingController = TextEditingController();
  WidgetState<MenuEntity> widgetState = const WidgetState<MenuEntity>.none();
  bool? haveSelectAllMenus = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    listOfAllMenus = [];
    listOfAllMenus.clear();
    listOfAllSelectedMenus = [];
    listOfAllSelectedMenus.clear();
    if (mounted) {
      context.read<MenuBloc>().add(GetAllMenu());
    }
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
    scrollController.dispose();
    innerScrollController.dispose();
    searchTextEditingController.dispose();
    listOfAllMenus = [];
    listOfAllMenus.clear();
    listOfAllSelectedMenus = [];
    listOfAllSelectedMenus.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<MenuBloc, MenuState>(
        key: const Key('all-menus-page-bloc-builder-widget'),
        bloc: context.watch<MenuBloc>(),
        builder: (context, state) {
          switch (state) {
            case GetAllMenuState():
              {
                listOfAllMenus = List<MenuEntity>.from(state.menuEntities.toList());
                widgetState = WidgetState<MenuEntity>.allData(
                  context: context,
                );
              }
            case _:
              appLog.d('Default case: all menu page');
          }
          return _AllMenuPageView(this);
        },
      );

  void onSelectionChanged(List<MenuEntity> listOfMenuEntities) {
    setState(() {
      listOfAllSelectedMenus = List<MenuEntity>.from(listOfMenuEntities.toList());
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
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
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
                    await Future.delayed(const Duration(milliseconds: 300), () {});
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
            textDirection: serviceLocator<LanguageController>().targetTextDirection,
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
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: double.infinity,
                    minHeight: media.size.height,
                  ),
                  padding: EdgeInsetsDirectional.only(top: topPadding, start: margins * 2.5, end: margins * 2.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
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
                              child: AppTextFieldWidget(
                                controller: state.searchTextEditingController,
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Search',
                                  hintText: 'Search menu and addons',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  isDense: true,
                                ),
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
                      const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                      CheckboxListTile(
                        value: state.haveSelectAllMenus,
                        onChanged: (value) {
                          state.selectAllMenus(isSelectAllMenus: value);
                        },
                        tristate: true,
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 0),
                        //dense: true,
                        title: IntrinsicHeight(
                          child: Row(
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            children: [
                              Text(
                                'Your Menus',
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
                                    '${state.listOfAllMenus.length}',
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  ),
                                ),
                              ),
                              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                              const Spacer(flex: 2),
                              Text(
                                'Select All',
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                      Expanded(
                        flex: 3,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return MenuCardWidget(
                              key: ValueKey(index),
                              menuEntity: state.listOfAllMenus[index],
                              currentIndex: index,
                              listOfAllMenuEntities: state.listOfAllMenus.toList(),
                              onSelectionChanged: (List<MenuEntity> listOfAllMenuEntities) {
                                state.onSelectionChanged(listOfAllMenuEntities.toList());
                              },
                              listOfAllSelectedMenuEntities: state.listOfAllSelectedMenus.toList(),
                            );
                          },
                          itemCount: state.listOfAllMenus.length,
                          separatorBuilder: (context, index) {
                            return const Divider(thickness: 0.25, color: Color.fromRGBO(127, 129, 132, 1));
                          },
                        ),
                      ),
                      const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                      Row(
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                final navigateToSaveMenuPage = await context.push(
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
                                context.read<MenuBloc>().add(GetAllMenu());
                                return;
                              },
                              child: Text(
                                'Add New Menu',
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
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
