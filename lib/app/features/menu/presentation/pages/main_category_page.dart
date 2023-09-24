part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MainCategoryPage extends StatefulWidget {
  const MainCategoryPage({
    super.key,
  });

  @override
  _MainCategoryPageController createState() => _MainCategoryPageController();
}

class _MainCategoryPageController extends State<MainCategoryPage>
    with SingleTickerProviderStateMixin {
  Category? selectedCategory;
  Category? selectedSubCategory;
  List<Category> listOfCategories = [];
  List<Category> listOfSubCategories = [];
  List<Category> listOfSelectedSubCategories = [];
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  late final _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 1250),
      value: 0,
      vsync: this);
  late final _railAnimation = RailAnimation(parent: _controller);
  int selectedIndex = 0;
  int? subCategorySelectedIndex;
  List<NavigationRailDestination> navigationDestinations = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    selectedCategory = null;
    selectedSubCategory = null;
    selectedIndex = 0;
    listOfCategories = [];
    listOfCategories.clear();
    navigationDestinations = [];
    navigationDestinations.clear();
    listOfSubCategories = [];
    listOfSelectedSubCategories = [];
    listOfCategories.clear();
    listOfSelectedSubCategories.clear();

    listOfCategories = List<Category>.from(localListOfCategories.toList());
    initLoadCategoryList(listOfCategories.toList());
  }

  void initLoadCategoryList(List<Category> listOfCategories) {
    listOfCategories.asMap().forEach((key, category) {
      navigationDestinations.insert(
        key,
        NavigationRailDestination(
          icon: SvgPicture.asset(
            'assets/svg/category.svg',
            colorFilter:
                const ColorFilter.mode(Color(0xffe65100), BlendMode.srcIn),
            semanticsLabel: category.title,
            height: 24,
            width: 24,
          ),
          label: Center(
            child: Wrap(
              children: [
                Text(
                  category.title,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      );
    });
    listOfSubCategories =
        List<Category>.from(listOfCategories[0].subCategory.toList());
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    selectedIndex = 0;
    selectedCategory = null;
    selectedSubCategory = null;
    listOfCategories = [];
    listOfCategories.clear();
    navigationDestinations = [];
    navigationDestinations.clear();
    listOfSubCategories = [];
    listOfSelectedSubCategories = [];
    listOfCategories.clear();
    listOfSelectedSubCategories.clear();
    innerScrollController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void onSelected(int index) {
    selectedIndex = index;
    print('onSelected ${index}');
    selectedCategory = listOfCategories[selectedIndex];
    selectedCategory?.subCategory = List<Category>.from(
        localListOfCategories[selectedIndex].subCategory.toList());
    listOfSubCategories = List<Category>.from(
        localListOfCategories[selectedIndex].subCategory.toList());
    subCategorySelectedIndex = 0;
    selectedSubCategory = null;
    listOfSelectedSubCategories = [];
    print('listOfSubCategories ${listOfSubCategories.length}');
    setState(() {});
  }

  void selectedSubCategoryFunction(
      Category mainCategory, Category? subCategory) {
    selectedCategory = mainCategory;
    selectedSubCategory = subCategory;
    setState(() {});
  }

  void selectSubCategory(
      int? index, Category? mainCategory, Category? subCategory) {
    subCategorySelectedIndex = index;
    selectedCategory = mainCategory;
    selectedSubCategory = subCategory;
    //
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => _MainCategoryPageView(this);
}

class _MainCategoryPageView
    extends WidgetView<MainCategoryPage, _MainCategoryPageController> {
  const _MainCategoryPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding =
        margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
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
            title: const Text('All Category'),
            centerTitle: false,
            titleSpacing: 0,
            actions: [
              IconButton(
                onPressed: () async {
                  if (context.canPop()) {
                    await Future.delayed(
                        const Duration(milliseconds: 300), () {});
                    if (!state.mounted) {
                      return;
                    }
                    return context.pop(
                        [state.selectedCategory, state.selectedSubCategory]);
                    //(state.selectedCategory, state.selectedSubCategory));
                  }
                  return;
                },
                icon: const Icon(Icons.check),
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
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
              child: PageBody(
                controller: state.scrollController,
                constraints: BoxConstraints(
                    minWidth: 1000,
                    minHeight: media.size.height *
                        1.5 //media.size.height - (media.padding.top + kToolbarHeight + media.padding.bottom),
                    ),
                padding: EdgeInsetsDirectional.only(
                  top: topPadding,
                  //bottom: bottomPadding,
                  //start: margins * 2.5,
                  //end: margins * 2.5,
                ),
                child: SizedBox(
                  height: media.size.height * 1.5,
                  child: CustomScrollView(
                    controller: state.innerScrollController,
                    shrinkWrap: true,
                    slivers: [
                      SliverFillRemaining(
                        child: Row(
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                          children: [
                            Expanded(
                              child: LayoutBuilder(
                                builder: (context, constraint) {
                                  return SingleChildScrollView(
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                          minHeight: constraint.maxHeight),
                                      child: IntrinsicHeight(
                                        child: SizedBox(
                                          width: 60,
                                          child: NavigationRail(
                                            key: const Key(
                                                'category-navigationrail-widget'),
                                            labelType:
                                                NavigationRailLabelType.all,
                                            selectedIndex: state.selectedIndex,
                                            destinations: state
                                                .navigationDestinations
                                                .toList(),
                                            onDestinationSelected:
                                                state.onSelected,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const VerticalDivider(),
                            /*Expanded(
                              flex:2,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.listOfCategories[state.selectedIndex].subCategory.length,
                                itemBuilder: (context, index) {
                                  final Category subCategory=state.listOfCategories[state.selectedIndex].subCategory[index];
                                  return ChoiceChip(
                                    label: Text(subCategory.title),
                                    avatar: (state.subCategorySelectedIndex == index) ? Icon(Icons.check) : null,
                                    selected: state.subCategorySelectedIndex == index,
                                    onSelected: (bool selected) {
                                      state.selectSubCategory(selected ? index : null, state.listOfCategories[state.selectedIndex],selected ? subCategory : null);
                                    },
                                  );
                                },
                              ),
                            ),*/
                            Expanded(
                              flex: 2,
                              child: SubCategoryPage(
                                key: ValueKey(state
                                        .selectedCategory?.categoryId ??
                                    localListOfCategories[state.selectedIndex]
                                        .categoryId),
                                //key: ObjectKey(state.selectedCategory??localListOfCategories[state.selectedIndex]),
                                selectedCategory: state.selectedCategory ??
                                    localListOfCategories[state.selectedIndex],
                                parentSubCategories:
                                    state.listOfSubCategories.toList(),
                                onChangedCategory:
                                    state.selectedSubCategoryFunction,
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
