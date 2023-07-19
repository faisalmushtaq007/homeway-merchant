part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuForm4Page extends StatefulWidget {
  const MenuForm4Page({super.key});

  @override
  State<MenuForm4Page> createState() => _MenuForm4PageState();
}

class _MenuForm4PageState extends State<MenuForm4Page> {
  final ScrollController scrollController = ScrollController();
  List<MenuPortion> listOfMenuPortions = [];
  CustomPortion? customPortion;
  bool hasCustomPortion = false;
  MenuEntity menuEntity = serviceLocator<MenuEntity>();
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    menuEntity = serviceLocator<MenuEntity>();
    hasCustomPortion = menuEntity.hasCustomPortion;
    customPortion = menuEntity.customPortion;
    listOfMenuPortions = List<MenuPortion>.from(menuEntity.menuPortions.toList());
    debugPrint('menuPortions ${menuEntity.menuPortions.length}');
    menuEntity.menuPortions.asMap().forEach((key, value) {
      debugPrint('Value ${value}');
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    listOfMenuPortions = [];
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    menuEntity = serviceLocator<MenuEntity>();
    hasCustomPortion = menuEntity.hasCustomPortion;
    customPortion = menuEntity.customPortion;
    listOfMenuPortions = List<MenuPortion>.from(menuEntity.menuPortions.toList());
    debugPrint('didChangeDependencies menuPortions ${menuEntity.menuPortions.length}');
    menuEntity.menuPortions.asMap().forEach((key, value) {
      debugPrint('didChangeDependencies Value ${value}');
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: PageStorage(
        bucket: pageStorageBucket,
        key: const Key('menu-form4-PageStorage-widget'),
        child: Column(
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
                                    key: PageStorageKey('set-menu-price-${listOfMenuPortions[index].title}_${index}'),
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
                      crossFadeState: (!hasCustomPortion && listOfMenuPortions.isNotEmpty) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
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
                key: const Key('set-custom-price-wdget'),
              ),
              secondChild: const Offstage(),
              crossFadeState: hasCustomPortion ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(
                milliseconds: 500,
              ),
            ),
            AnimatedCrossFade(
              firstChild: const AnimatedGap(12, duration: Duration(milliseconds: 500)),
              secondChild: const Offstage(),
              crossFadeState: hasCustomPortion ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(
                milliseconds: 500,
              ),
            ),
            AnimatedCrossFade(
              firstChild: const Divider(),
              secondChild: const Offstage(),
              crossFadeState: hasCustomPortion ? CrossFadeState.showFirst : CrossFadeState.showSecond,
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
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            const AnimatedGap(12, duration: Duration(milliseconds: 500)),
          ],
        ),
      ),
    );
  }
}
