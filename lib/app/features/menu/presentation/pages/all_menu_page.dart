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
  final TextEditingController searchTextEditingController = TextEditingController();
  WidgetState<MenuEntity> widgetState = const WidgetState<MenuEntity>.none();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    listOfAllMenus = [];
    listOfAllMenus.clear();
    context.read<MenuBloc>().add(GetAllMenu());
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
    listOfAllMenus.clear;
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
                      const AnimatedGap(12, duration: Duration(milliseconds: 500)),
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
                                  side: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
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
                      Expanded(
                        flex: 3,
                        child: CustomScrollView(
                          controller: state.innerScrollController,
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return MenuCardWidget(
                                    menuEntity: state.listOfAllMenus[index],
                                    currentIndex: index,
                                    listOfAllMenuEntity: state.listOfAllMenus.toList(),
                                  );
                                },
                                childCount: state.listOfAllMenus.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                      Row(
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                context.push(Routes.SAVE_MENU_PAGE);
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
