part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MainCategoryPage extends StatefulWidget {
  const MainCategoryPage({super.key});
  @override
  _MainCategoryPageController createState() => _MainCategoryPageController();
}

class _MainCategoryPageController extends State<MainCategoryPage> {
  Category? selectedCategory;
  Category? selectedSubCategory;
  List<Category> listOfCategories = [];
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    listOfCategories = [];
    listOfCategories.clear();
  }

  Future<void> initLoadCategoryList() async {}

  @override
  void dispose() {
    listOfCategories = [];
    listOfCategories.clear();
    innerScrollController.dispose();
    scrollController.dispose();
    super.dispose();
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          mainAxisSize: MainAxisSize.min,
                          children: [],
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
