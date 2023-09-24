part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuForm4Page extends StatefulWidget {
  const MenuForm4Page({
    super.key,
    this.haveNewMenu = true,
    this.menuEntity,
  });
  final bool haveNewMenu;
  final MenuEntity? menuEntity;

  @override
  State<MenuForm4Page> createState() => _MenuForm4PageState();
}

class _MenuForm4PageState extends State<MenuForm4Page>
    with AutomaticKeepAliveClientMixin<MenuForm4Page> {
  final ScrollController scrollController = ScrollController();
  List<MenuPortion> listOfMenuPortions = [];
  List<Addons> listOfAddons = [];
  CustomPortion? customPortion;
  bool hasCustomPortion = false;
  MenuEntity menuEntity = serviceLocator<MenuEntity>();

  @override
  void initState() {
    super.initState();
    listOfMenuPortions = [];
    initData();
  }

  void initData() {
    menuEntity = serviceLocator<MenuEntity>();
    if (serviceLocator<MenuEntity>().menuPortions.isNotEmpty) {
      listOfMenuPortions = List<MenuPortion>.from(
          serviceLocator<MenuEntity>().menuPortions.toList());
    }
    hasCustomPortion = menuEntity.hasCustomPortion;
    customPortion = menuEntity.customPortion;
    if (serviceLocator<MenuEntity>().addons.isNotEmpty) {
      listOfAddons =
          List<Addons>.from(serviceLocator<MenuEntity>().addons.toList());
    }
    setState(() {});
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  bool get wantKeepAlive => true;
  @override
  void dispose() {
    scrollController.dispose();
    //listOfMenuPortions = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: BlocBuilder<MenuBloc, MenuState>(
        key: const Key('menu-form4-page-bloc-builder-widget'),
        bloc: context.watch<MenuBloc>(),
        builder: (context, state) {
          if (state is PushMenuEntityDataState) {
            if (state.menuFormStage is MenuForm2Page ||
                state.menuFormStage is MenuForm4Page) {
              /*menuEntity = state.menuEntity;
              hasCustomPortion = menuEntity.hasCustomPortion;
              customPortion = menuEntity.customPortion;
              listOfMenuPortions = List<MenuPortion>.from(menuEntity.menuPortions.toList());*/
            }
          }
          if (state is PullMenuEntityDataState) {}
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            textDirection:
                serviceLocator<LanguageController>().targetTextDirection,
            children: [
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  children: [
                    Wrap(
                      textDirection: serviceLocator<LanguageController>()
                          .targetTextDirection,
                      children: [
                        Text(
                          'Menu price',
                          style: context.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                        ).translate(),
                      ],
                    ),
                    const AnimatedGap(2, duration: Duration(milliseconds: 500)),
                    Wrap(
                      textDirection: serviceLocator<LanguageController>()
                          .targetTextDirection,
                      children: [
                        Text(
                          'Set menu selling price for customer ',
                          style: context.labelMedium,
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                        ).translate(),
                      ],
                    ),
                    const AnimatedGap(12,
                        duration: Duration(milliseconds: 500)),
                    Flexible(
                      child: AnimatedCrossFade(
                        firstChild: SizedBox(
                          child: CustomScrollView(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            slivers: [
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return SetMenuPriceWidget(
                                      currentIndex: index,
                                      listOfMenuPortions: listOfMenuPortions,
                                      key: PageStorageKey(
                                          'set-menu-price-${listOfMenuPortions[index].title}_${index}'),
                                      menuPortion: listOfMenuPortions[index],
                                    );
                                  },
                                  childCount: listOfMenuPortions.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                        secondChild: const Offstage(),
                        crossFadeState:
                            (!hasCustomPortion && listOfMenuPortions.isNotEmpty)
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
                  customPortion: customPortion,
                  key: const Key('set-custom-price-widget'),
                ),
                secondChild: const Offstage(),
                crossFadeState: hasCustomPortion
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(
                  milliseconds: 500,
                ),
              ),
              AnimatedCrossFade(
                firstChild: const AnimatedGap(12,
                    duration: Duration(milliseconds: 500)),
                secondChild: const Offstage(),
                crossFadeState: hasCustomPortion
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(
                  milliseconds: 500,
                ),
              ),
              AnimatedCrossFade(
                firstChild: const Divider(),
                secondChild: const Offstage(),
                crossFadeState: hasCustomPortion
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(
                  milliseconds: 500,
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  children: [
                    Wrap(
                      textDirection: serviceLocator<LanguageController>()
                          .targetTextDirection,
                      children: [
                        Text(
                          'Extras price',
                          style: context.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                        ).translate(),
                      ],
                    ),
                    const AnimatedGap(2, duration: Duration(milliseconds: 500)),
                    Wrap(
                      textDirection: serviceLocator<LanguageController>()
                          .targetTextDirection,
                      children: [
                        Text(
                          'Set extras selling price for customer ',
                          style: context.labelMedium,
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                        ).translate(),
                      ],
                    ),
                    const AnimatedGap(12,
                        duration: Duration(milliseconds: 500)),
                    Flexible(
                      child: AnimatedCrossFade(
                        firstChild: SizedBox(
                          child: CustomScrollView(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            slivers: [
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return SetAddonsPriceWidget(
                                      currentIndex: index,
                                      listOfAddons: listOfAddons,
                                      key: PageStorageKey(
                                          'set-addons-price-${listOfAddons[index].title}_${index}'),
                                      addons: listOfAddons[index],
                                    );
                                  },
                                  childCount: listOfAddons.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                        secondChild: const Offstage(),
                        crossFadeState:
                            (!hasCustomPortion && listOfMenuPortions.isNotEmpty)
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
          );
        },
      ),
    );
  }
}
