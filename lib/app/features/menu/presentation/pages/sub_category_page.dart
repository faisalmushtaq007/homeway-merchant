part of 'package:homemakers_merchant/app/features/menu/index.dart';

class SubCategoryPage extends StatefulWidget {
  const SubCategoryPage({required this.selectedCategory, required this.onChangedCategory, this.parentSubCategories=const[],super.key});

  final Category selectedCategory;
  final ValueChangedCategoryAndSubCategory<Category, Category> onChangedCategory;
  final List<Category> parentSubCategories;

  @override
  _SubCategoryPageController createState() => _SubCategoryPageController();
}

class _SubCategoryPageController extends State<SubCategoryPage> {
  late final ScrollController innerScrollController;
  List<Category> listOfSubCategories = [];
  static const _pageSize = 20;
  final PagingController<int, Category> _pagingController = PagingController(firstPageKey: 0);
  int? selectedSubCategoryIndex;

  @override
  void initState() {
    super.initState();
    innerScrollController = ScrollController();
    listOfSubCategories = [];
    listOfSubCategories.clear();
    _pagingController.addPageRequestListener(_fetchPage);

    //initLoadCategoryList(context);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      listOfSubCategories = List<Category>.from(widget.parentSubCategories.toList());
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

  void selectSubCategory(int? index, Category? selectedCategory) {
    selectedSubCategoryIndex = index;
    //
    setState(() {});
    widget.onChangedCategory(widget.selectedCategory, selectedCategory);
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
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
              children: [
                ChoiceChip(
                  key: ValueKey(item.categoryId),
                  label: Text(item.title,textDirection: serviceLocator<LanguageController>().targetTextDirection,),
                  avatar: (state.selectedSubCategoryIndex == index) ? Icon(Icons.check,textDirection: serviceLocator<LanguageController>().targetTextDirection,) : null,
                  selected: state.selectedSubCategoryIndex == index,
                  onSelected: (bool selected) {
                    state.selectSubCategory(selected ? index : null, selected ? item : null);
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
