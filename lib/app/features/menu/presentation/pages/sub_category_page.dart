part of 'package:homemakers_merchant/app/features/menu/index.dart';

class SubCategoryPage extends StatefulWidget {
  const SubCategoryPage({required this.selectedCategory, super.key});

  final Category selectedCategory;

  @override
  _SubCategoryPageController createState() => _SubCategoryPageController();
}

class _SubCategoryPageController extends State<SubCategoryPage> {
  late final ScrollController innerScrollController;
  List<Category> listOfSubCategories = [];
  static const _pageSize = 20;
  final PagingController<int, Category> _pagingController = PagingController(firstPageKey: 0);
  int? selectedSubCategoryValue = 0;

  @override
  void initState() {
    super.initState();
    innerScrollController = ScrollController();
    listOfSubCategories = [];
    listOfSubCategories.clear();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    //initLoadCategoryList(context);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      listOfSubCategories = List<Category>.from(widget.selectedCategory.subCategory.toList());
      final isLastPage = listOfSubCategories.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(listOfSubCategories);
      } else {
        final nextPageKey = pageKey + listOfSubCategories.length;
        _pagingController.appendPage(listOfSubCategories, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void selectSubCategory(int? index) {
    selectedSubCategoryValue = index;
    setState(() {});
  }

  @override
  void dispose() {
    listOfSubCategories = [];
    listOfSubCategories.clear();
    _pagingController.dispose();
    innerScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _SubCategoryPageView(this);
}

class _SubCategoryPageView extends WidgetView<SubCategoryPage, _SubCategoryPageController> {
  const _SubCategoryPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins;
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: SizedBox(
        child: PagedListView<int, Category>(
          pagingController: state._pagingController,
          builderDelegate: PagedChildBuilderDelegate<Category>(
            itemBuilder: (context, item, index) => Wrap(
              spacing: 5.0,
              children: [
                ChoiceChip(
                  label: Text('${item.title}'),
                  selected: state.selectedSubCategoryValue == index,
                  onSelected: (bool selected) {
                    state.selectSubCategory(selected ? index : null);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
