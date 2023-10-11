part of 'package:homemakers_merchant/app/features/menu/index.dart';

class ConfirmMenuPricePage extends StatefulWidget {
  const ConfirmMenuPricePage({
    required this.menuEntity, super.key,
    this.haveNewMenu = true,
    this.currentIndex = -1,
    this.selectionUseCase = SelectionUseCase.selectAndNext,
  });
  final bool haveNewMenu;
  final MenuEntity menuEntity;
  final int currentIndex;
  final SelectionUseCase selectionUseCase;

  @override
  _ConfirmMenuPricePageController createState() => _ConfirmMenuPricePageController();
}

class _ConfirmMenuPricePageController extends State<ConfirmMenuPricePage> {
  late final ScrollController scrollController;
  late final ScrollController _screenScrollController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late MenuEntity menuEntity;
  List<MenuPortion> listOfMenuPortions = [];
  List<Addons> listOfAddons = [];
  CustomPortion? customPortion;
  bool hasCustomPortion = false;

  double _basePriceOfItems=0.0;
  double _discountPriceOfItems=0.0;
  double _finalPriceOfItems=0.0;

  double get basePriceOfItems => _basePriceOfItems;
  set basePriceOfItems(double value) {
    _basePriceOfItems += value;
  }
  void setBasePriceOfItems(double value) {
    _basePriceOfItems += value;
  }
  double get discountPriceOfItems => _discountPriceOfItems;
  set discountPriceOfItems(double value) {
    _discountPriceOfItems += value;
  }
  void setDiscountPriceOfItems(double value) {
    _discountPriceOfItems += value;
  }

  double get finalPriceOfItems => _finalPriceOfItems;
  set finalPriceOfItems(double value) {
    _finalPriceOfItems = value;
  }

  @override
  void initState() {
    listOfMenuPortions = [];
    menuEntity=widget.menuEntity;

    super.initState();

    scrollController = ScrollController();
    _screenScrollController = ScrollController();
    loadMenuEntityData(menuEntity);
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    listOfMenuPortions = [];
    _screenScrollController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void loadMenuEntityData(MenuEntity cacheMenuEntity) {
    menuEntity = cacheMenuEntity;
    if (menuEntity.menuPortions.isNotEmpty) {
      listOfMenuPortions = List<MenuPortion>.from(menuEntity.menuPortions.toList());
    }
    hasCustomPortion = menuEntity.hasCustomPortion;
    customPortion = menuEntity.customPortion;
    if (menuEntity.addons.isNotEmpty) {
      listOfAddons = List<Addons>.from(menuEntity.addons.toList());
    }
    setState(() {});
  }

  void menuEntityChanged(MenuEntity cacheMenuEntity){
    menuEntity.copyWith(
      addons: cacheMenuEntity.addons.toList(),
      customPortion: cacheMenuEntity.customPortion,
      customPortions: cacheMenuEntity.customPortions,
      menuPortions: cacheMenuEntity.menuPortions.toList(),
    );
    setState(() { });
  }

  Future<void> onSaveAndNext() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      menuEntity.copyWith();
      appLog.d(menuEntity.toMap());
      context.read<MenuBloc>().add(
            PushMenuEntityData(
              menuEntity: menuEntity,
              menuFormStage: MenuFormStage.form2,
              menuEntityStatus: MenuEntityStatus.push,
            ),
          );
      return;
    }
    return;
  }

  @override
  Widget build(BuildContext context) => BlocListener<MenuBloc, MenuState>(
        bloc: context.read<MenuBloc>(),
        listener: (context, menuState) async {
          switch (menuState) {
            case NavigateToMenuImagePage():
              {
                final result = await context.push(Routes.UPLOAD_MENU_IMAGE_PAGE,extra: {
                  'menuEntity':menuState.menuEntity,
                  'haveNewMenu':widget.haveNewMenu,
                  'currentIndex':widget.currentIndex,
                  'selectionUseCase':widget.selectionUseCase,
                });
              }
          }
        },
        child: BlocBuilder<MenuBloc, MenuState>(
          bloc: context.read<MenuBloc>(),
          builder: (context, menuBuilderState) {
            switch (menuBuilderState) {
              case PushMenuEntityDataState():
                {
                  //menuEntity = menuBuilderState.menuEntity;
                  //loadMenuEntityData(menuEntity);
                }
            }
            return _ConfirmMenuPricePageView(this);
          },
        ),
      );


}

class _ConfirmMenuPricePageView extends WidgetView<ConfirmMenuPricePage, _ConfirmMenuPricePageController> {
  const _ConfirmMenuPricePageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
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
            title: const Text('Menu'),
            centerTitle: false,
            actions: const [
              Padding(
                padding: EdgeInsetsDirectional.only(end: 8),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          body: SlideInLeft(
            key: const Key('reform-save-menu-slideinleft-widget'),
            from: context.width / 2 - 60,
            duration: const Duration(milliseconds: 500),
            child: Directionality(
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
              child: PageBody(
                controller: state.scrollController,
                constraints: BoxConstraints(
                  minWidth: 1000,
                  minHeight: media.size.height - (media.padding.top + kToolbarHeight + media.padding.bottom),
                ),
                padding: EdgeInsetsDirectional.only(
                  top: topPadding,
                  //bottom: bottomPadding,
                  start: margins * 2.5,
                  end: margins * 2.5,
                ),
                child: Form(
                  key: state.formKey,
                  child: CustomScrollView(
                    controller: state._screenScrollController,
                    shrinkWrap: true,
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              children: [
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    children: [
                                      Wrap(
                                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        children: [
                                          Text(
                                            'Menu price',
                                            style: context.titleLarge!.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          ).translate(),
                                        ],
                                      ),
                                      const AnimatedGap(2, duration: Duration(milliseconds: 500)),
                                      Wrap(
                                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        children: [
                                          Text(
                                            'Set menu selling price for customer ',
                                            style: context.labelMedium,
                                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          ).translate(),
                                        ],
                                      ),
                                      const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                      Flexible(
                                        child: AnimatedCrossFade(
                                          firstChild: SizedBox(
                                            child: Column(
                                              children: state.listOfMenuPortions.mapIndex((item, index) {
                                                return SetMenuPriceWidget(
                                                  currentIndex: index,
                                                  listOfMenuPortions: state.listOfMenuPortions,
                                                  key: ValueKey(index),
                                                  menuPortion: item,
                                                  basePriceValueChanged: state.setBasePriceOfItems,
                                                  discountPriceValueChanged: state.setDiscountPriceOfItems,
                                                  menuEntity: state.menuEntity,
                                                  hasGlobalMenuEntity: false,
                                                  menuEntityChanged: state.menuEntityChanged,
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          secondChild: const Offstage(),
                                          crossFadeState:
                                              (!state.hasCustomPortion && state.listOfMenuPortions.isNotEmpty)
                                                  ? CrossFadeState.showFirst
                                                  : CrossFadeState.showSecond,
                                          duration: const Duration(milliseconds: 500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                AnimatedCrossFade(
                                  firstChild: SetMenuPriceWidget(
                                    hasCustomPortion: true,
                                    customPortion: state.customPortion,
                                    key: const Key('set-custom-price-widget'),
                                    menuEntity: state.menuEntity,
                                    basePriceValueChanged: state.setBasePriceOfItems,
                                    discountPriceValueChanged: state.setDiscountPriceOfItems,
                                    hasGlobalMenuEntity: false,
                                    menuEntityChanged: state.menuEntityChanged,
                                  ),
                                  secondChild: const Offstage(),
                                  crossFadeState:
                                      state.hasCustomPortion ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                  duration: const Duration(
                                    milliseconds: 500,
                                  ),
                                ),
                                AnimatedCrossFade(
                                  firstChild: const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                  secondChild: const Offstage(),
                                  crossFadeState:
                                      state.hasCustomPortion ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                  duration: const Duration(
                                    milliseconds: 500,
                                  ),
                                ),
                                AnimatedCrossFade(
                                  firstChild: const Divider(),
                                  secondChild: const Offstage(),
                                  crossFadeState:
                                      state.hasCustomPortion ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                  duration: const Duration(
                                    milliseconds: 500,
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    children: [
                                      Wrap(
                                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        children: [
                                          Text(
                                            'Extras price',
                                            style: context.titleLarge!.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          ).translate(),
                                        ],
                                      ),
                                      const AnimatedGap(2, duration: Duration(milliseconds: 500)),
                                      Wrap(
                                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        children: [
                                          Text(
                                            'Set extras selling price for customer ',
                                            style: context.labelMedium,
                                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          ).translate(),
                                        ],
                                      ),
                                      const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                      Flexible(
                                        child: AnimatedCrossFade(
                                          firstChild: SizedBox(
                                            child: Column(
                                              children: state.listOfAddons.mapIndex((item, index) {
                                                return SetAddonsPriceWidget(
                                                  currentIndex: index,
                                                  listOfAddons: state.listOfAddons,
                                                  key: ValueKey(index),
                                                  addons: item,
                                                  basePriceValueChanged: state.setBasePriceOfItems,
                                                  discountPriceValueChanged: state.setDiscountPriceOfItems,
                                                  menuEntity: state.menuEntity,
                                                  hasGlobalMenuEntity: false,
                                                  menuEntityChanged: state.menuEntityChanged,
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          secondChild: const Offstage(),
                                          crossFadeState:
                                              (state.listOfAddons.isNotEmpty)
                                                  ? CrossFadeState.showFirst
                                                  : CrossFadeState.showSecond,
                                          duration: const Duration(milliseconds: 500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SliverFillRemaining(
                        fillOverscroll: true,
                        hasScrollBody: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          children: [
                            const Spacer(),
                            Directionality(
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                    child: RichText(
                      text: TextSpan(
                        style: context.bodyMedium!.copyWith(),
                        children: <TextSpan>[
                           TextSpan(
                            text: 'Selling price ',
                            style: context.labelMedium!.copyWith(),
                          ),
                          TextSpan(
                            text: 'SAR ${state.basePriceOfItems-state.discountPriceOfItems}',
                            style: context.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                            const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: ElevatedButton(
                                    onPressed: state.onSaveAndNext,
                                    style: ElevatedButton.styleFrom(
                                      //minimumSize: Size(180, 40),
                                      disabledBackgroundColor: const Color.fromRGBO(255, 219, 208, 1),
                                      disabledForegroundColor: Colors.white,
                                    ),
                                    child: Text(
                                      'Save & Next',
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    ).translate(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
