part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuComponentWidget extends StatefulWidget {
  const MenuComponentWidget({required this.menuEntity, this.height = 180, super.key});

  final MenuEntity menuEntity;
  final double height;

  @override
  State<MenuComponentWidget> createState() => _MenuComponentWidgetState();
}

class _MenuComponentWidgetState extends State<MenuComponentWidget> {
  WidgetState<Widget> widgetState = const WidgetState<Widget>.none();
  List<Addons> addonsEntities = [];
  List<MenuType> menuAvailableFoodTypes = [];
  List<MenuPreparationType> menuAvailableFoodPreparationType = [];
  List<MenuPortion> menuPortions = [];
  bool hasCustomPortion = false;
  List<CustomPortion> customPortions = [];
  String menuAvailableFromTime = '';
  String menuAvailableToTime = '';
  List<MenuAvailableDayAndTime> menuAvailableInDays = [];
  List<TimeOfPeriodWise> timeOfPeriodWise = [];
  List<Nutrients> nutrients = [];
  Timing? menuTiming;
  TasteType? tasteType;
  List<Ingredients> ingredients = [];
  CustomPortion? customPortion;
  String menuMinPreparationTime = '';
  String menuMaxPreparationTime = '';
  List<MenuComponent> menuComponents = [];
  List<Addons> listOfAddons = [];

  @override
  void initState() {
    super.initState();
    reset();
  }

  void reset() {
    customPortions = [];
    listOfAddons = [];
    menuComponents = [];
    ingredients = [];
    nutrients = [];
    timeOfPeriodWise = [];
    menuAvailableInDays = [];
    menuAvailableFromTime = '';
    menuAvailableToTime = '';
    customPortions = [];
    hasCustomPortion = false;
    addonsEntities = [];
    menuAvailableFoodTypes = [];
    menuAvailableFoodPreparationType = [];
    menuPortions = [];
    menuMinPreparationTime = '';
    menuMaxPreparationTime = '';
    // Initialize
    menuAvailableFoodTypes = List.from(widget.menuEntity.storeAvailableFoodTypes.toList());
    menuAvailableFoodPreparationType = List.from(widget.menuEntity.storeAvailableFoodPreparationType.toList());
    listOfAddons = List.from(widget.menuEntity.addons.toList());
    addonsEntities = List.from(widget.menuEntity.addons.toList());
    menuAvailableInDays = List.from(widget.menuEntity.menuAvailableInDays.toList());
    hasCustomPortion = widget.menuEntity.hasCustomPortion;
    customPortions = List.from(widget.menuEntity.customPortions.toList());
    menuAvailableInDays = List.from(widget.menuEntity.menuAvailableInDays.toList());
    menuPortions = List.from(widget.menuEntity.menuPortions.toList());
    menuMinPreparationTime = widget.menuEntity.menuMinPreparationTime;
    menuMaxPreparationTime = widget.menuEntity.menuMaxPreparationTime;
    menuAvailableFromTime = widget.menuEntity.menuAvailableFromTime;
    menuAvailableToTime = widget.menuEntity.menuAvailableToTime;
    timeOfPeriodWise = List.from(widget.menuEntity.timeOfPeriodWise.toList());
    ingredients = List.from(widget.menuEntity.ingredients.toList());
    nutrients = List.from(widget.menuEntity.nutrients.toList());
  }

  @override
  void dispose() {
    reset();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (mounted) {
      init(context);
    }
    super.didChangeDependencies();
  }

  void init(BuildContext context) {
    menuComponents.insert(
      0,
      MenuComponent<MenuType, MenuPreparationType>(
        title: 'Menu Type',
        icon: Icon(
          Icons.restaurant_menu,
          color: context.colorScheme.primary,
          size: 20,
        ),
        data: [],
        secondaryData: [],
      ),
    );
    menuComponents.insert(
      1,
      MenuComponent<TasteType, TasteLevel>(
        title: 'Taste Type',
        icon: FaIcon(
          FontAwesomeIcons.pepperHot,
          color: context.colorScheme.primary,
          size: 20,
        ),
        data: [],
        secondaryData: [],
      ),
    );
    menuComponents.insert(
      2,
      MenuComponent<TasteType, TasteLevel>(
        title: 'Portion of Dish',
        icon: FaIcon(
          FontAwesomeIcons.pepperHot,
          color: context.colorScheme.primary,
          size: 20,
        ),
        data: [],
        secondaryData: [],
      ),
    );
    menuComponents.insert(
      3,
      MenuComponent<TasteType, TasteLevel>(
        title: 'Extra Includes',
        icon: FaIcon(
          FontAwesomeIcons.pepperHot,
          color: context.colorScheme.primary,
          size: 20,
        ),
        data: [],
        secondaryData: [],
      ),
    );
    menuComponents.insert(
      4,
      MenuComponent<TasteType, TasteLevel>(
        title: 'Menu Availability',
        icon: FaIcon(
          FontAwesomeIcons.pepperHot,
          color: context.colorScheme.primary,
          size: 20,
        ),
        data: [],
        secondaryData: [],
      ),
    );
    menuComponents.insert(
      5,
      MenuComponent<TasteType, TasteLevel>(
        title: 'Preparation Time',
        icon: FaIcon(
          FontAwesomeIcons.pepperHot,
          color: context.colorScheme.primary,
          size: 20,
        ),
        data: [],
        secondaryData: [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: Container(
        width: context.width,
        height: context.width / 2,
        padding: EdgeInsetsDirectional.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsetsDirectional.zero,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: context.width / 2.25,
                    child: Card(
                      key: ValueKey(index),
                      margin: const EdgeInsetsDirectional.only(bottom: 0, end: 8, top: 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(6),
                      ),
                      elevation: 0,
                      color: const Color.fromRGBO(242, 242, 242, 1),
                      child: Padding(
                        padding: EdgeInsetsDirectional.zero,
                        child: Column(
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const AnimatedGap(6, duration: Duration(milliseconds: 200)),
                            Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 24,
                                child: Center(child: menuComponents[index].icon),
                              ),
                            ),
                            const AnimatedGap(
                              4,
                              duration: Duration(
                                milliseconds: 300,
                              ),
                            ),
                            Center(
                              child: Text(
                                menuComponents[index].title,
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                style: context.labelMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const AnimatedGap(4, duration: Duration(milliseconds: 200)),
                            Flexible(
                              child: loadWidgets(context, index).maybeWhen(
                                orElse: () {
                                  return const Offstage();
                                },
                                allData: (context, child, message, data) {
                                  return child ?? const Offstage();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: menuComponents.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  WidgetState<Widget> loadWidgets(BuildContext context, int index) {
    widgetState = WidgetState<Widget>.allData(
      context: context,
      child: ConditionalSwitch.single<int>(
        context: context,
        valueBuilder: (BuildContext context) => index,
        caseBuilders: {
          0: (BuildContext context) => SizedBox(
                width: double.maxFinite,
                child: _menuFoodType(context),
              ),
          1: (BuildContext context) => SizedBox(
                width: double.maxFinite,
                child: _menuTasteLevel(context),
              ),
          2: (BuildContext context) => SizedBox(
                width: double.maxFinite,
                child: _menuPortions(context),
              ),
          3: (BuildContext context) => SizedBox(
                width: double.maxFinite,
                child: _menuAddons(context),
              ),
          4: (BuildContext context) => SizedBox(
                width: double.maxFinite,
                child: _menuAvailability(context),
              ),
          5: (BuildContext context) => SizedBox(
                width: double.maxFinite,
                child: _menuPreparationTime(context),
              ),
        },
        fallbackBuilder: (BuildContext context) => const Offstage(),
      ),
    );
    return widgetState;
  }

  Widget _menuFoodType(BuildContext context) {
    List<String> menuTypes = [];
    menuAvailableFoodTypes.asMap().forEach((key, value) {
      menuTypes.add(value.title);
    });
    menuAvailableFoodPreparationType.asMap().forEach((key, value) {
      menuTypes.add(value.title);
    });
    return LayoutBuilder(
      builder: (context, constraints) {
        return ScrollableColumn();
      },
    );
    return const Offstage();
  }

  Widget _menuTasteLevel(BuildContext context) {
    return const Offstage();
  }

  Widget _menuPortions(BuildContext context) {
    return const Offstage();
  }

  Widget _menuAddons(BuildContext context) {
    return const Offstage();
  }

  Widget _menuAvailability(BuildContext context) {
    return const Offstage();
  }

  Widget _menuPreparationTime(BuildContext context) {
    return const Offstage();
  }
}

class MenuComponent<T, R> {
  MenuComponent({
    required this.title,
    required this.icon,
    this.data = const [],
    this.secondaryData = const [],
  });

  String title;
  Widget icon;
  List<T> data;
  List<R> secondaryData;
}
