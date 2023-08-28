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
    return Container();
  }
}
