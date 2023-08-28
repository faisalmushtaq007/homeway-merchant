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

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    listOfCategories = [];
    listOfCategories.clear();
    initLoadCategoryList();
  }

  Future<void> initLoadCategoryList() async {
    listOfCategories = List<Category>.from(localListOfCategories.toList());
    setState(() {});
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
    setState(() {
      selectedIndex = index;
    });
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
                    minWidth: 1000,
                    minHeight: media.size.height - (media.padding.top + kToolbarHeight + media.padding.bottom),
                  ),
                  padding: EdgeInsetsDirectional.only(
                    top: topPadding,
                    //bottom: bottomPadding,
                    start: margins * 2.5,
                    end: margins * 2.5,
                  ),
                  child: CustomScrollView(
                    controller: state.innerScrollController,
                    slivers: [
                      SliverFillRemaining(
                        child: ListDetailTransition(
                          animation: state._railAnimation,
                          one: CategoryListView(
                            allCategories: state.listOfCategories.toList(),
                            selectedIndex: state.selectedIndex,
                            onSelected: (index) {
                              state.onSelected(index);
                            },
                          ),
                          two: SubCategoryListView(
                            data: state.listOfCategories[state.selectedIndex].subCategory.toList(),
                          ),
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
