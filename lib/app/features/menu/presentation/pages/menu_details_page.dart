part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuDetailsPage extends StatefulWidget {
  const MenuDetailsPage({
    super.key,
    required this.menuEntity,
    this.index = -1,
    this.menuEntities = const [],
  });

  final MenuEntity menuEntity;
  final int index;
  final List<MenuEntity> menuEntities;

  @override
  _MenuDetailsPageController createState() => _MenuDetailsPageController();
}

class _MenuDetailsPageController extends State<MenuDetailsPage> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  MenuEntity menuEntity = MenuEntity();
  CustomPortion? customPortion;
  bool hasCustomPortion = false;
  List<CustomPortion> customPortions = [];
  List<Addons> listOfAddons = [];

  @override
  void initState() {
    super.initState();
    menuEntity = widget.menuEntity;
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    customPortions = [];
    listOfAddons = [];
    customPortion = menuEntity.customPortion;
    hasCustomPortion = menuEntity.hasCustomPortion;
    customPortions = menuEntity.customPortions.toList();
    listOfAddons = menuEntity.addons.toList();
  }

  @override
  void dispose() {
    scrollController.dispose();
    innerScrollController.dispose();

    hasCustomPortion = false;
    customPortions = [];
    listOfAddons = [];
    super.dispose();
  }

  void editCurrentMenu() {}

  void addNewMenu() {}

  @override
  Widget build(BuildContext context) => BlocBuilder<MenuBloc, MenuState>(
        bloc: context.watch<MenuBloc>(),
        key: const Key('menu-details-page-bloc-builder-widget'),
        builder: (context, storeState) {
          return _StoreDetailsPageView(this);
        },
      );
}

class _StoreDetailsPageView extends WidgetView<MenuDetailsPage, _MenuDetailsPageController> {
  const _StoreDetailsPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = margins; //media.padding.bottom + margins;
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
              'Your menu',
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
            ),
            actions: const [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          body: SlideInLeft(
            key: const Key('menu-details-slideinleft-widget'),
            delay: const Duration(milliseconds: 500),
            from: context.width - 40,
            child: PageBody(
              controller: state.scrollController,
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: media.size.height,
              ),
              padding: EdgeInsetsDirectional.only(
                top: topPadding,
                start: margins * 2.5,
                end: margins * 2.5,
              ),
              child: CustomScrollView(
                controller: state.innerScrollController,
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Column(
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const AnimatedGap(8, duration: Duration(milliseconds: 100)),
                          // Top section
                          MenuDetailsNameImageWidget(
                            menuEntity: state.menuEntity,
                          ),
                          const AnimatedGap(8, duration: Duration(milliseconds: 100)),
                          const Divider(thickness: 0.75),
                          // Description section
                          WrapText(
                            'The Flutter framework has been optimized to make rerunning build methods fast, so that you can just rebuild anything that needs updating rather than having to individually change instances of widgets.',
                            breakWordCharacter: '-',
                            smartSizeMode: true,
                            asyncMode: true,
                            minFontSize: 13,
                            maxFontSize: 15,
                            textStyle: context.bodyMedium!.copyWith(),
                          ),
                          const AnimatedGap(8, duration: Duration(milliseconds: 100)),
                          const Divider(thickness: 0.75),
                          MenuComponentWidget(
                            menuEntity: state.menuEntity,
                          ),
                          const AnimatedGap(8, duration: Duration(milliseconds: 100)),
                          const Divider(thickness: 0.75),
                          Flexible(
                            child: MenuPriceInfoWidget(
                              menuEntity: state.menuEntity,
                              key: const Key('menu-details-portions-price-widget'),
                            ),
                          ),
                          const AnimatedGap(8, duration: Duration(milliseconds: 100)),
                          const Divider(thickness: 0.75),
                          ListTile(
                            dense: true,
                            title: Text(
                              'Extra Includes',
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              style: context.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                          const AnimatedGap(8, duration: Duration(milliseconds: 100)),
                          Flexible(
                            child: MenuPriceInfoWidget(
                              menuEntity: state.menuEntity,
                              hasAddons: true,
                              key: const Key('menu-details-addons-price-widget'),
                            ),
                          ),
                          const AnimatedGap(24, duration: Duration(milliseconds: 200)),
                          // Buttons

                          Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                    onPressed: state.editCurrentMenu,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      //minimumSize: Size(100, 40),
                                      side: const BorderSide(
                                        color: Color.fromRGBO(
                                          165,
                                          166,
                                          168,
                                          1.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'Edit',
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(127, 129, 132, 1.0),
                                      ),
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
                                    onPressed: state.addNewMenu,
                                    style: ElevatedButton.styleFrom(
                                        //minimumSize: Size(180, 40),
                                        //backgroundColor: const Color.fromRGBO(69, 201, 125, 1),
                                        ),
                                    child: Text(
                                      'Add New Menu',
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      //style: TextStyle(color:  Colors.white),
                                    ).translate(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
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
