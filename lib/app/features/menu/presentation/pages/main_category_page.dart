part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MainCategoryPage extends StatefulWidget {
  const MainCategoryPage({super.key});

  @override
  _MainCategoryPageController createState() => _MainCategoryPageController();
}

class _MainCategoryPageController extends State<MainCategoryPage> with SingleTickerProviderStateMixin {
  Category? selectedCategory;
  Category? selectedSubCategory;
  List<Category> listOfCategories = [];
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  late final _controller =
      AnimationController(duration: const Duration(milliseconds: 1000), reverseDuration: const Duration(milliseconds: 1250), value: 0, vsync: this);
  late final _railAnimation = RailAnimation(parent: _controller);
  int selectedIndex = 0;
  List<NavigationRailDestination> navigationDestinations = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    listOfCategories = [];
    listOfCategories.clear();
    navigationDestinations = [];
    navigationDestinations.clear();
    listOfCategories = List<Category>.from(localListOfCategories.toList());
    //initLoadCategoryList(context);
  }

  Future<void> initLoadCategoryList(BuildContext context) async {
    for (Category category in listOfCategories) {
      navigationDestinations.add(
        NavigationRailDestination(
          icon: SvgPicture.asset(
            'assets/svg/category.svg',
            colorFilter: ColorFilter.mode(context.colorScheme.primary, BlendMode.srcIn),
            semanticsLabel: category.title,
            height: 24,
            width: 24,
          ),
          label: Center(
            child: Wrap(
              children: [
                Text(
                  category.title,
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      );
    }
    //setState(() {});
  }

  @override
  void didChangeDependencies() {
    if (listOfCategories.isNotNullOrEmpty && navigationDestinations.isNullOrEmpty) {
      initLoadCategoryList(context);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    listOfCategories = [];
    listOfCategories.clear();
    innerScrollController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void onSelected(int index) {
    selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => _MainCategoryPageView(this);
}

class _MainCategoryPageView extends WidgetView<MainCategoryPage, _MainCategoryPageController> {
  const _MainCategoryPageView(super.state);

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
        child: DoubleTapToExit(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('All Category'),
              centerTitle: false,
              actions: [
                IconButton(
                  onPressed: () async {
                    final notification = await context.push(Routes.NOTIFICATIONS);
                    return;
                  },
                  icon: Badge(
                    alignment: AlignmentDirectional.topEnd,
                    //padding: EdgeInsets.all(4),
                    backgroundColor: context.colorScheme.secondary,
                    isLabelVisible: true,
                    largeSize: 16,
                    textStyle: const TextStyle(fontSize: 14),
                    textColor: Colors.yellow,
                    label: Text(
                      '10',
                      style: context.labelSmall!.copyWith(color: context.colorScheme.onPrimary),
                      //Color.fromRGBO(251, 219, 11, 1)
                    ),
                    child: Icon(Icons.notifications, color: context.colorScheme.primary),
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.only(end: 8),
                  child: LanguageSelectionWidget(),
                ),
              ],
            ),
            body: SlideInLeft(
              key: const Key('main-category-slideinleft-widget'),
              from: context.width / 2 - 60,
              duration: const Duration(milliseconds: 500),
              child: Directionality(
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                child: PageBody(
                  controller: state.scrollController,
                  constraints: BoxConstraints(
                      minWidth: 1000, minHeight: media.size.height * 1.5 //media.size.height - (media.padding.top + kToolbarHeight + media.padding.bottom),
                      ),
                  padding: EdgeInsetsDirectional.only(
                    top: topPadding,
                    //bottom: bottomPadding,
                    start: margins * 2.5,
                    end: margins * 2.5,
                  ),
                  child: SizedBox(
                    height: media.size.height * 1.5,
                    child: CustomScrollView(
                      controller: state.innerScrollController,
                      shrinkWrap: true,
                      slivers: [
                        SliverFillRemaining(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            children: [
                              Expanded(
                                child: LayoutBuilder(
                                  builder: (context, constraint) {
                                    return SingleChildScrollView(
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(minHeight: constraint.maxHeight),
                                        child: IntrinsicHeight(
                                          child: SizedBox(
                                            width: 80,
                                            child: NavigationRail(
                                              labelType: NavigationRailLabelType.all,
                                              selectedIndex: state.selectedIndex,
                                              destinations: state.navigationDestinations.toList(),
                                              onDestinationSelected: (int index) {
                                                return state.onSelected(index);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              VerticalDivider(),
                              Expanded(
                                flex: 2,
                                child: SubCategoryPage(
                                  key: ValueKey(state.selectedIndex),
                                  selectedCategory: state.listOfCategories[state.selectedIndex],
                                ),
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
      ),
    );
  }
}

class RailAnimation extends CurvedAnimation {
  RailAnimation({required super.parent})
      : super(
          curve: const Interval(0 / 5, 4 / 5),
          reverseCurve: const Interval(3 / 5, 1),
        );
}
