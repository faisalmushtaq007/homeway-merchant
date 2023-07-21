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
  List<FocusNode> menuForm1FocusList = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    listOfCategories = List<Category>.from(localListOfCategories.toList());
    menuForm1FocusList = [
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
    ];
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
    listOfCategories = [];
    listOfCategories.clear();
    menuCategoryTextEditingController.dispose();
    menuNameTextEditingController.dispose();
    menuDescriptionTextEditingController.dispose();
    menuForm1FocusList.asMap().forEach((key, value) => value.dispose());
    super.dispose();
  }

  Future<void> selectMenuCategory(BuildContext context) async {
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
              title: 'Menu Category',
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
        serviceLocator<MenuEntity>().menuCategories = [
          Category(
            title: menuCategoryTextEditingController.value.text.trim(),
          )
        ];
        context.read<MenuBloc>().add(
              PushMenuEntityData(
                menuEntity: serviceLocator<MenuEntity>(),
                menuFormStage: MenuFormStage.form1,
                menuEntityStatus: MenuEntityStatus.push,
              ),
            );
      });
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: BlocBuilder<MenuBloc, MenuState>(
        key: const Key('menu-form1-page-bloc-builder-widget'),
        bloc: context.watch<MenuBloc>(),
        builder: (context, state) {
          if (state is PushMenuEntityDataState && state.menuFormStage is MenuForm1Page) {}
          if (state is PullMenuEntityDataState && state.menuFormStage is MenuForm1Page) {}
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            textDirection: serviceLocator<LanguageController>().targetTextDirection,
            children: [
              AppTextFieldWidget(
                controller: menuCategoryTextEditingController,
                readOnly: true,
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                focusNode: menuForm1FocusList[0],
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => fieldFocusChange(context, menuForm1FocusList[0], menuForm1FocusList[1]),
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
                      await selectMenuCategory(context);
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
                  await selectMenuCategory(context);
                  return;
                },
                onChanged: (value) {
                  serviceLocator<MenuEntity>().menuCategories = [
                    Category(
                      title: value,
                    )
                  ];
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form1,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
                },
                onSaved: (newValue) {
                  serviceLocator<MenuEntity>().menuCategories = [
                    Category(
                      title: menuCategoryTextEditingController.value.text.trim(),
                    )
                  ];
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form1,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
                },
                onEditingComplete: () {
                  serviceLocator<MenuEntity>().menuCategories = [
                    Category(
                      title: menuCategoryTextEditingController.value.text.trim(),
                    )
                  ];
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form1,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
                },
              ),
              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
              AppTextFieldWidget(
                controller: menuNameTextEditingController,
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                focusNode: menuForm1FocusList[1],
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => fieldFocusChange(context, menuForm1FocusList[1], menuForm1FocusList[2]),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Menu name',
                  hintText: 'Enter your menu name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  isDense: true,
                ),
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
                  serviceLocator<MenuEntity>().menuName = menuNameTextEditingController.value.text.trim();
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
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
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
                onEditingComplete: () {
                  serviceLocator<MenuEntity>().menuDescription = menuDescriptionTextEditingController.value.text.trim();
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
                  hintText: 'Enter either the description or about the ingredients of the menu.',
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
                  final cacheMenuEntity = serviceLocator<MenuEntity>().copyWith(
                    menuDescription: menuDescriptionTextEditingController.value.text.trim(),
                  );
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: cacheMenuEntity,
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
        visualDensity: const VisualDensity(vertical: -1, horizontal: 0),
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
