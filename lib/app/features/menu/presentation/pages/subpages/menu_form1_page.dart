part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuForm1Page extends StatefulWidget {
  const MenuForm1Page({super.key});

  @override
  State<MenuForm1Page> createState() => _MenuForm1PageState();
}

class _MenuForm1PageState extends State<MenuForm1Page> {
  late final ScrollController scrollController;
  final TextEditingController menuNameTextEditingController = TextEditingController();
  final TextEditingController menuDescriptionTextEditingController = TextEditingController();
  final TextEditingController menuCategoryTextEditingController = TextEditingController();
  Category? selectedCategory;

  List<Category> listOfCategories = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    listOfCategories = List<Category>.from(localListOfCategories.toList());
  }

  @override
  void dispose() {
    scrollController.dispose();
    listOfCategories = [];
    listOfCategories.clear();
    menuCategoryTextEditingController.dispose();
    menuNameTextEditingController.dispose();
    menuDescriptionTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        children: [
          AppTextFieldWidget(
            controller: menuCategoryTextEditingController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Food category',
              hintText: 'Select your food category',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              isDense: true,
              suffixIcon: IconButton(
                onPressed: () async {
                  final Category? category = await showConfirmationDialog<Category>(
                    context: context,
                    barrierDismissible: true,
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 700),
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return ResponsiveDialog(
                            context: context,
                            hideButtons: true,
                            maxLongSide: context.height / 2.25,
                            maxShortSide: context.width,
                            key: const Key('food-category-confirm-dialog'),
                            title: 'Food Category',
                            confirmText: 'Confirm',
                            cancelText: 'Cancel',
                            okPressed: () async {
                              debugPrint('Dialog confirmed');
                              Navigator.of(context).pop();
                            },
                            cancelPressed: () {
                              debugPrint('Dialog cancelled');
                              Navigator.of(context).pop();
                            },
                            child: ListView.builder(
                              padding: EdgeInsetsDirectional.zero,
                              itemCount: listOfCategories.length,
                              itemBuilder: (context, index) => _allFoodCategory(context, index, setState),
                              shrinkWrap: true,
                            ),
                          );
                        },
                      );
                    },
                  );
                  if (category != null) {
                    setState(() {
                      menuCategoryTextEditingController.text = category?.title ?? '';
                      selectedCategory = category;
                    });
                  }
                },
                icon: Icon(
                  Icons.arrow_drop_down,
                ),
              ),
            ),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter store name';
              }
              return null;
            },
          ),
          AnimatedGap(12, duration: Duration(milliseconds: 500)),
          AppTextFieldWidget(
            controller: menuNameTextEditingController,
            decoration: InputDecoration(
              labelText: 'Menu name',
              hintText: 'Enter your menu name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              isDense: true,
            ),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter store name';
              }
              return null;
            },
          ),
          AnimatedGap(12, duration: Duration(milliseconds: 500)),
          AppTextFieldWidget(
            controller: menuDescriptionTextEditingController,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Menu description',
              hintText: 'Enter your menu description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              isDense: true,
            ),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter store name';
              }
              return null;
            },
          ),
          //
        ],
      ),
    );
  }

  Widget _allFoodCategory(BuildContext context, int index, StateSetter innerSetState) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
            top: (index == 0) ? BorderSide(color: Theme.of(context).dividerColor) : BorderSide.none, bottom: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: ListTile(
        dense: true,
        minVerticalPadding: 0,
        minLeadingWidth: 0,
        horizontalTitleGap: 0,
        visualDensity: VisualDensity(vertical: -1, horizontal: 0),
        title: Text(
          '${listOfCategories[index].title}',
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
        ),
        onTap: () {
          innerSetState(() {});
          Navigator.of(context).pop(listOfCategories[index]);
          return;
        },
      ),
    );
  }
}
