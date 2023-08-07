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
  List<MenuType> storeAvailableFoodTypes = [];
  List<MenuPreparationType> storeAvailableFoodPreparationType = [];
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
    storeAvailableFoodTypes = [];
    storeAvailableFoodPreparationType = [];
    menuPortions = [];
    menuMinPreparationTime = '';
    menuMaxPreparationTime = '';
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
      child: Card(
        margin: const EdgeInsetsDirectional.only(bottom: 16, end: 8, top: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10),
        ),
        color: const Color.fromRGBO(242, 242, 242, 1),
        elevation: 0.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          //padding: EdgeInsetsDirectional.zero,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              key: ValueKey(index),
              margin: const EdgeInsetsDirectional.only(bottom: 16, end: 8, top: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(6),
              ),
              color: const Color.fromRGBO(242, 242, 242, 1),
              child: Padding(
                padding: EdgeInsetsDirectional.zero,
                child: Column(
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 24,
                      child: Center(child: menuComponents[index].icon),
                    ),
                    Text(
                      menuComponents[index].title,
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      style: context.titleMedium!.copyWith(),
                    ),
                    const AnimatedGap(4, duration: Duration(milliseconds: 200)),
                  ],
                ),
              ),
            );
          },
          itemCount: menuComponents.length,
        ),
      ),
    );
  }

  void loadWidgets(BuildContext context, int index) {
    widgetState = WidgetState<Widget>.allData(
      context: context,
      child: ConditionalSwitch.single<int>(
        context: context,
        valueBuilder: (BuildContext context) => index,
        caseBuilders: {
          0: (BuildContext context) => SizedBox(
                width: double.infinity,
                child: _menuFoodType(context),
              ),
          1: (BuildContext context) => SizedBox(
                width: double.infinity,
                child: _menuTasteLevel(context),
              ),
          2: (BuildContext context) => SizedBox(
                width: double.infinity,
                child: _menuPortions(context),
              ),
          3: (BuildContext context) => SizedBox(
                width: double.infinity,
                child: _menuAddons(context),
              ),
          4: (BuildContext context) => SizedBox(
                width: double.infinity,
                child: _menuAvailability(context),
              ),
          5: (BuildContext context) => SizedBox(
                width: double.infinity,
                child: _menuPreparationTime(context),
              ),
        },
        fallbackBuilder: (BuildContext context) => const Offstage(),
      ),
    );
  }

  Widget _menuFoodType(BuildContext context) {
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
