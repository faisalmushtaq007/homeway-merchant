part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuForm1Page extends StatefulWidget {
  const MenuForm1Page({
    super.key,
    this.haveNewMenu = true,
    this.menuEntity,
  });

  final bool haveNewMenu;
  final MenuEntity? menuEntity;

  @override
  State<MenuForm1Page> createState() => _MenuForm1PageState();
}

class _MenuForm1PageState extends State<MenuForm1Page>
    with AutomaticKeepAliveClientMixin<MenuForm1Page> {
  late final ScrollController scrollController;
  final TextEditingController menuNameTextEditingController =
      TextEditingController();
  final TextEditingController menuDescriptionTextEditingController =
      TextEditingController();
  final TextEditingController menuCategoryTextEditingController =
      TextEditingController();
  final TextEditingController menuSubCategoryTextEditingController =
      TextEditingController();
  Category? selectedCategory;
  Category? selectedSubCategory;
  List<Category> listOfCategories = [];
  List<FocusNode> menuForm1FocusList = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    listOfCategories = [];
    listOfCategories.clear();
    //listOfCategories = List<Category>.from(localListOfCategories.toList());
    menuForm1FocusList = [
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
    ];
    initData();
  }

  void initData() {
    if (!widget.haveNewMenu && widget.menuEntity.isNotNull) {
      menuNameTextEditingController.text = widget.menuEntity?.menuName ?? '';
      menuDescriptionTextEditingController.text =
          widget.menuEntity?.menuDescription ?? '';
      menuCategoryTextEditingController.text =
          widget.menuEntity?.menuCategories.first.title ?? '';
      menuSubCategoryTextEditingController.text =
          widget.menuEntity?.menuCategories.first.subCategory.first.title ?? '';
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    /*listOfCategories = [];
    listOfCategories.clear();
    menuCategoryTextEditingController.dispose();
    menuNameTextEditingController.dispose();
    menuDescriptionTextEditingController.dispose();
    menuForm1FocusList.asMap().forEach((key, value) => value.dispose());*/
    super.dispose();
  }

  void updateCategoryAndSubCategory(
      Category mainCategory, Category? subCategory) {
    menuCategoryTextEditingController.text = '';
    menuSubCategoryTextEditingController.text = '';
    menuCategoryTextEditingController.text = mainCategory.title ?? '';
    selectedCategory = mainCategory;
    if (subCategory != null) {
      selectedSubCategory = subCategory;
      menuSubCategoryTextEditingController.text = subCategory.title ?? '';
      final copyCategory=selectedCategory?.copyWith(subCategory: List<Category>.from([subCategory]));
      serviceLocator<MenuEntity>().menuCategories = [copyCategory!];
    }
    context.read<MenuBloc>().add(
      PushMenuEntityData(
        menuEntity: serviceLocator<MenuEntity>(),
        menuFormStage: MenuFormStage.form1,
        menuEntityStatus: MenuEntityStatus.push,
      ),
    );
    return;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: BlocBuilder<MenuBloc, MenuState>(
        key: const Key('menu-form1-page-bloc-builder-widget'),
        bloc: context.watch<MenuBloc>(),
        builder: (context, state) {
          if (state is PushMenuEntityDataState &&
              state.menuFormStage is MenuForm1Page) {}
          if (state is PullMenuEntityDataState &&
              state.menuFormStage is MenuForm1Page) {}
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            textDirection:
                serviceLocator<LanguageController>().targetTextDirection,
            children: [
              AppTextFieldWidget(
                key: const Key('menuCategory-textfield-widget'),
                controller: menuCategoryTextEditingController,
                readOnly: true,
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                focusNode: menuForm1FocusList[0],
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => fieldFocusChange(
                    context, menuForm1FocusList[0], menuForm1FocusList[1]),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Menu category',
                  hintText: 'Select your menu category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  isDense: true,
                  suffixIcon: IconButton(
                    onPressed: () async {
                      //await selectMenuCategory(context);
                      final result = await context.push<List<Category?>>(
                          Routes.MAIN_CATEGORY_PAGE,);
                      if (result != null && result[0]!=null && result[1]!=null) {
                        updateCategoryAndSubCategory(result[0]!, result[1]);
                      }
                      return;
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select menu category';
                  }
                  return null;
                },
                onTap: () async {
                  //await selectMenuCategory(context);
                  final result = await context
                      .push<List<Category?>>(Routes.MAIN_CATEGORY_PAGE);
                  if (result != null && result[0]!=null && result[1]!=null) {
                    updateCategoryAndSubCategory(result[0]!, result[1]);
                  }
                  return;
                },
              ),
              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
              AppTextFieldWidget(
                key: const Key('menuSubCategory-textfield-widget'),
                controller: menuSubCategoryTextEditingController,
                readOnly: true,
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Menu sub-category',
                  hintText: 'Select your menu sub-category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  isDense: true,
                  suffixIcon: IconButton(
                    onPressed: () async {
                      //await selectMenuCategory(context);
                      final result = await context
                          .push<List<Category?>>(Routes.MAIN_CATEGORY_PAGE);
                      if (result != null && result[0]!=null && result[1]!=null) {
                        //updateCategoryAndSubCategory(result[0]!, result[1]);
                      }
                      return;
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select menu sub category';
                  }
                  return null;
                },
                onTap: () async {
                  //await selectMenuCategory(context);
                  final result = await context
                      .push<List<Category?>>(Routes.MAIN_CATEGORY_PAGE);
                  if (result != null && result[0]!=null && result[1]!=null) {
                    //updateCategoryAndSubCategory(result[0]!, result[1]);
                  }
                  return;
                },
              ),
              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
              AppTextFieldWidget(
                controller: menuNameTextEditingController,
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                focusNode: menuForm1FocusList[1],
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => fieldFocusChange(
                    context, menuForm1FocusList[1], menuForm1FocusList[2]),
                keyboardType: TextInputType.name,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-z A-Z ]')),FilteringTextInputFormatter.deny('  ')],
                decoration: InputDecoration(
                  labelText: 'Menu name',
                  hintText: 'Enter your menu name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  isDense: true,
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter menu name';
                  }
                  return null;
                },
                onChanged: (value) {
                  serviceLocator<MenuEntity>().menuName = value;
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form1,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
                },
                onSaved: (newValue) {
                  serviceLocator<MenuEntity>().menuName =
                      menuNameTextEditingController.value.text.trim();
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form2,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
                },
              ),
              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
              AppTextFieldWidget(
                controller: menuDescriptionTextEditingController,
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                focusNode: menuForm1FocusList[2],
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  serviceLocator<MenuEntity>().menuDescription = value;
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form1,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
                },
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Menu description',
                  hintText:
                      'Enter either the description or about the ingredients of the menu.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  isDense: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter menu description';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  serviceLocator<MenuEntity>().menuDescription =
                      menuDescriptionTextEditingController.value.text.trim();
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form1,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
                },
              ),
              //
            ],
          );
        },
      ),
    );
  }

  Widget _allFoodCategory(
      BuildContext context, int index, StateSetter innerSetState) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
            top: (index == 0)
                ? BorderSide(color: Theme.of(context).dividerColor)
                : BorderSide.none,
            bottom: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: ListTile(
        dense: true,
        minVerticalPadding: 0,
        minLeadingWidth: 0,
        horizontalTitleGap: 0,
        visualDensity: const VisualDensity(vertical: -1, horizontal: 0),
        title: Text(
          '${listOfCategories[index].title}',
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
        ),
        onTap: () {
          innerSetState(() {});
          Navigator.of(context).pop(listOfCategories[index]);
          return;
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
