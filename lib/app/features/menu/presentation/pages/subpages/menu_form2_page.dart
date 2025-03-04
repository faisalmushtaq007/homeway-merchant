part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuForm2Page extends StatefulWidget {
  const MenuForm2Page({
    super.key,
    this.haveNewMenu = true,
    this.menuEntity,
  });

  final bool haveNewMenu;
  final MenuEntity? menuEntity;

  @override
  State<MenuForm2Page> createState() => _MenuForm2PageState();
}

class _MenuForm2PageState extends State<MenuForm2Page>
    with AutomaticKeepAliveClientMixin<MenuForm2Page> {
  late final ScrollController scrollController;

  List<StoreAvailableFoodTypes> _menuAvailableFoodTypes = [];
  List<StoreAvailableFoodTypes> _selectedFoodTypes = [];
  List<StoreAvailableFoodTypes> _initialSelectedFoodTypes = [];

  List<StoreAvailableFoodPreparationType> _menuAvailableFoodCookingType = [];
  List<StoreAvailableFoodPreparationType> _selectedFoodPreparationType = [];
  List<StoreAvailableFoodPreparationType> _initialSelectedFoodPreparationType =
      [];

  List<TasteType> _menuTasteType = [];
  List<TasteType> _initialSelectedTasteType = [];
  List<TasteType> _selectedTasteType = [];

  List<TasteLevel> _selectedTasteLevel = [];
  List<TasteLevel> _menuTasteLevel = [];
  List<TasteLevel> _initialSelectedTasteLevel = [];

  List<MenuPortion> _menuPortions = [];
  List<MenuPortion> _selectedMenuPortions = [];
  List<MenuPortion> _initialSelectedMenuPortions = [];

  bool _hasCustomMenuPortionSize = false;
  final TextEditingController _menuPortionNameController =
      TextEditingController();
  final TextEditingController _menuPortionSizeController =
      TextEditingController();
  final TextEditingController _menuPortionMaximumServeController =
      TextEditingController();
  final TextEditingController _menuPortionUnitController =
      TextEditingController();

  List<StoreWorkingDayAndTime> _menuAvailableDays = [];
  List<StoreWorkingDayAndTime> _selectedWorkingDays = [];
  List<StoreWorkingDayAndTime> _initialSelectedWorkingDays = [];

  List<FocusNode> menuForm2FocusList = [];
  bool _haveAddonsWithCurrentMenu = false;

  List<Addons> _selectedAddons = [];
  List<Addons> _initialSelectedAddons = [];
  List<Addons> _allAddons = [];
  List<Widget> selectedAddonsWidgets = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    menuForm2FocusList = [
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
    ];
    _menuAvailableFoodCookingType = [];
    _menuAvailableFoodTypes = [];
    _menuAvailableDays = [];
    _menuTasteType = [];
    _menuTasteLevel = [];
    _menuPortions = [];
    //
    _selectedFoodTypes = [];
    _selectedFoodPreparationType = [];
    _selectedWorkingDays = [];
    _selectedTasteType = [];
    _selectedTasteLevel = [];
    _selectedMenuPortions = [];
    _selectedAddons = [];
    _allAddons = [];
    selectedAddonsWidgets = [];
    _selectedAddons.clear();
    _allAddons.clear();
    selectedAddonsWidgets.clear();

    //Initial Data
    _initialSelectedFoodPreparationType = [];
    initializeMenuAvailableFoodCookingType();
    initializeMenuAvailableDays();
    initializeMenuAvailableFoodTypes();
    initializeMenuTasteType();
    initializeMenuTasteLevel();
    initMenuPortions();
    initData();
  }

  void initData() {
    if (!widget.haveNewMenu && widget.menuEntity.isNotNull) {
      // Init data of Menu Preparation type
      _initialSelectedFoodPreparationType =
          List<StoreAvailableFoodPreparationType>.from(
        widget.menuEntity!.storeAvailableFoodPreparationType.toList(),
      );
      _selectedFoodPreparationType =
          List<StoreAvailableFoodPreparationType>.from(
        widget.menuEntity!.storeAvailableFoodPreparationType.toList(),
      );

      // Init data of Menu Taste type and its level
      if (widget.menuEntity!.tasteType.isNotNull) {
        // Menu Taste type
        _initialSelectedTasteType = List<TasteType>.from(
          [widget.menuEntity!.tasteType!.title ?? ''],
        );
        // Menu Taste level
        _initialSelectedTasteLevel = List<TasteLevel>.from(
          widget.menuEntity!.tasteType!.tasteLevel.toList(),
        );
        _initialSelectedTasteType = List<TasteType>.from(
          [widget.menuEntity!.tasteType!.title ?? ''],
        );
        _initialSelectedTasteLevel = List<TasteLevel>.from(
          widget.menuEntity!.tasteType!.tasteLevel.toList(),
        );
      }

      // Init data of Menu portion
      _initialSelectedMenuPortions = List<MenuPortion>.from(
        widget.menuEntity!.menuPortions.toList(),
      );
      _selectedMenuPortions = List<MenuPortion>.from(
        widget.menuEntity!.menuPortions.toList(),
      );

      // Init date of Custom Portion
      if (widget.menuEntity!.hasCustomPortion == true &&
          widget.menuEntity!.customPortion.isNotNull) {
        _hasCustomMenuPortionSize = true;
        _menuPortionNameController.text =
            widget.menuEntity!.customPortion!.title ?? '';
        _menuPortionSizeController.text =
            widget.menuEntity!.customPortion!.quantity.toString() ?? '';
        _menuPortionMaximumServeController.text =
            widget.menuEntity!.customPortion!.maxServingPerson.toString() ?? '';
        _menuPortionUnitController.text =
            widget.menuEntity!.customPortion!.unit ?? '';
      }

      // Init data of selected addons
      _initialSelectedAddons = List<Addons>.from(widget.menuEntity!.addons);
      _selectedAddons = List<Addons>.from(widget.menuEntity!.addons);
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
/*
    _menuAvailableFoodCookingType = [];
    _menuAvailableFoodTypes = [];
    _menuAvailableDays = [];
    _menuTasteType = [];
    _menuTasteLevel = [];
    _menuPortions = [];
    //
    _selectedFoodTypes = [];
    _selectedFoodPreparationType = [];
    _selectedWorkingDays = [];
    _selectedTasteType = [];
    _selectedTasteLevel = [];
    _selectedMenuPortions = [];
    _menuPortionNameController.dispose();
    _menuPortionValueController.dispose();
    _menuPortionSizeController.dispose();
    _menuPortionUnitController.dispose();
    menuForm2FocusList.asMap().forEach((key, value) => value.dispose());
    menuForm2FocusList = [];
    menuForm2FocusList.clear();
    _selectedAddons = [];
    _allAddons = [];
    selectedAddonsWidgets = [];
    _selectedAddons.clear();
    _allAddons.clear();
    selectedAddonsWidgets.clear();*/
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  void initializeMenuAvailableFoodCookingType() {
    _menuAvailableFoodCookingType =
        List<StoreAvailableFoodPreparationType>.from(
            localStoreAvailableFoodPreparationType.toList());
  }

  void initializeMenuAvailableFoodTypes() {
    _menuAvailableFoodTypes = List<StoreAvailableFoodTypes>.from(
        localStoreAvailableFoodTypes.toList());
  }

  void initializeMenuAvailableDays() {
    _menuAvailableDays =
        List<StoreWorkingDayAndTime>.from(localStoreWorkingDays.toList());
  }

  void initializeMenuTasteType() {
    _menuTasteType = List<TasteType>.from(localTasteType.toList());
  }

  void initializeMenuTasteLevel() {
    _menuTasteLevel = List<TasteLevel>.from(localTasteLevel.toList());
  }

  void initMenuPortions() {
    _menuPortions = List<MenuPortion>.from(localMenuPortions.toList());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: BlocBuilder<MenuBloc, MenuState>(
        key: const Key('menu-form2-page-bloc-builder-widget'),
        bloc: context.watch<MenuBloc>(),
        builder: (context, state) {
          if (state is PushMenuEntityDataState &&
              state.menuFormStage is MenuForm2Page) {}
          if (state is PullMenuEntityDataState &&
              state.menuFormStage is MenuForm2Page) {}
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            textDirection:
                serviceLocator<LanguageController>().targetTextDirection,
            children: [
              /*Column(
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                    children: [
                      Text(
                        'Food types',
                        style: context.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      ).translate(),
                    ],
                  ),
                  const AnimatedGap(4, duration: Duration(milliseconds: 500)),
                  Wrap(
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                    children: [
                      Text(
                        'Select the food group of your menu in which its belongs',
                        style: context.labelMedium,
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      ).translate(),
                    ],
                  ),
                ],
              ),
              const AnimatedGap(6, duration: Duration(milliseconds: 500)),
              MultiSelectAvailableFoodTypeFormField(
                key: const Key('store-menu-multiSelectAvailableFoodType-formfield'),
                onSelectionChanged: (List<StoreAvailableFoodTypes> selectedFoodTypes) {
                  _selectedFoodTypes = List<StoreAvailableFoodTypes>.from(selectedFoodTypes);
                  setState(() {});
                  var cacheMenuType = List<MenuType>.from(_selectedFoodTypes.map((e) => MenuType.fromMap(e.toMap())).toList());
                  serviceLocator<MenuEntity>().storeAvailableFoodTypes = cacheMenuType.toList();
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form2,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
                },
                availableFoodTypesList: _menuAvailableFoodTypes.toList(),
                validator: (value) {
                  if (value == null || value.length == 0) {
                    return 'Select one or more food type';
                  } else {
                    return null;
                  }
                },
                initialSelectedAvailableFoodTypesList: [],
                onSaved: (newValue) {
                  var cacheMenuType = List<MenuType>.from(_selectedFoodTypes.map((e) => MenuType.fromMap(e.toMap())).toList());
                  serviceLocator<MenuEntity>().storeAvailableFoodTypes = cacheMenuType.toList();
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form2,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
                },
              ),
              const AnimatedGap(12, duration: Duration(milliseconds: 500)),*/
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  Wrap(
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    children: [
                      Text(
                        'Food preparation method',
                        style: context.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                      ).translate(),
                    ],
                  ),
                  const AnimatedGap(4, duration: Duration(milliseconds: 500)),
                  Wrap(
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    children: [
                      Text(
                        'Choose the cooking methods of your menu',
                        style: context.labelMedium,
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                      ).translate(),
                    ],
                  ),
                ],
              ),
              const AnimatedGap(6, duration: Duration(milliseconds: 500)),
              MultiSelectAvailableFoodPreparationTypesFormField(
                key: const Key(
                    'store-menu-multiSelectAvailableFoodPreparationTypes-formfield'),
                onSelectionChanged: (List<StoreAvailableFoodPreparationType>
                    selectedPreparationTypes) {
                  _selectedFoodPreparationType =
                      List<StoreAvailableFoodPreparationType>.from(
                          selectedPreparationTypes);
                  setState(() {});
                  final cacheMenuPreparationType =
                      List<MenuPreparationType>.from(
                          _selectedFoodPreparationType
                              .map(
                                  (e) => MenuPreparationType.fromMap(e.toMap()))
                              .toList());
                  serviceLocator<MenuEntity>()
                          .storeAvailableFoodPreparationType =
                      cacheMenuPreparationType.toList();
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form2,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
                },
                availableFoodPreparationTypesList:
                    _menuAvailableFoodCookingType.toList(),
                validator: (value) {
                  if (value == null || value.length == 0) {
                    return 'Select one or more food preparation type';
                  } else {
                    return null;
                  }
                },
                isSingleSelect: true,
                maxSelection: 1,
                initialSelectedFoodPreparationTypesList:
                    _initialSelectedFoodPreparationType,
                onSaved: (newValue) {
                  final cacheMenuPreparationType =
                      List<MenuPreparationType>.from(
                          _selectedFoodPreparationType
                              .map(
                                  (e) => MenuPreparationType.fromMap(e.toMap()))
                              .toList());
                  serviceLocator<MenuEntity>()
                          .storeAvailableFoodPreparationType =
                      cacheMenuPreparationType.toList();
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form2,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
                },
              ),
              const Divider(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  Wrap(
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    children: [
                      Text(
                        'Taste type',
                        style: context.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                      ).translate(),
                    ],
                  ),
                  const AnimatedGap(4, duration: Duration(milliseconds: 500)),
                  Wrap(
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    children: [
                      Text(
                        'Select the food taste type of your menu',
                        style: context.labelMedium,
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                      ).translate(),
                    ],
                  ),
                ],
              ),
              const AnimatedGap(6, duration: Duration(milliseconds: 500)),
              MultiSelectTasteTypeFormField(
                key: const Key('store-menu-multiSelectTasteType-formfield'),
                onSelectionChanged: (List<TasteType> selectedTasteTypes) {
                  _selectedTasteType = List<TasteType>.from(selectedTasteTypes);
                  setState(() {});
                  final cacheTasteType = _selectedTasteType[0];
                  serviceLocator<MenuEntity>().tasteType = cacheTasteType;
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form2,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
                },
                availableTasteTypeList: _menuTasteType.toList(),
                validator: (value) {
                  if (value == null || value.length == 0) {
                    return 'Select one or more taste type';
                  } else {
                    return null;
                  }
                },
                initialSelectedTasteTypeList: _initialSelectedTasteType,
                maxSelection: 1,
                isSingleSelect: true,
                onMaxSelected: (List<TasteType> selectedTasteTypes) {
                  _selectedTasteType = List<TasteType>.from(selectedTasteTypes);
                  setState(() {});
                },
                onSaved: (newValue) {
                  final cacheTasteType = _selectedTasteType[0];
                  serviceLocator<MenuEntity>().tasteType = cacheTasteType;
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
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  Wrap(
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    children: [
                      Text(
                        'Taste level',
                        style: context.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                      ).translate(),
                    ],
                  ),
                  const AnimatedGap(4, duration: Duration(milliseconds: 500)),
                  Wrap(
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    children: [
                      Text(
                        'Select the taste level of your menu',
                        style: context.labelMedium,
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                      ).translate(),
                    ],
                  ),
                ],
              ),
              const AnimatedGap(6, duration: Duration(milliseconds: 500)),
              MultiSelectTasteLevelFormField(
                key: const Key(
                    'store-menu-multiSelectAvailableTasteLevel-formfield'),
                onSelectionChanged: (List<TasteLevel> selectedTasteLevel) {
                  _selectedTasteLevel =
                      List<TasteLevel>.from(selectedTasteLevel);
                  setState(() {});
                  serviceLocator<MenuEntity>().tasteType?.tasteLevel =
                      List<TasteLevel>.from(_selectedTasteLevel.toList());
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form2,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
                },
                availableTasteLevelList: _menuTasteLevel.toList(),
                validator: (value) {
                  if (value == null || value.length == 0) {
                    return 'Select one or more taste level';
                  } else {
                    return null;
                  }
                },
                maxSelection: 1,
                isSingleSelect: true,
                initialSelectedTasteLevelList: _initialSelectedTasteLevel,
                onSaved: (newValue) {
                  serviceLocator<MenuEntity>().tasteType?.tasteLevel =
                      List<TasteLevel>.from(_selectedTasteLevel.toList());
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form2,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
                },
              ),
              const Divider(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  Wrap(
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    children: [
                      Text(
                        'Portion size of menu',
                        style: context.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                      ).translate(),
                    ],
                  ),
                  const AnimatedGap(4, duration: Duration(milliseconds: 500)),
                  Wrap(
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    children: [
                      Text(
                        'Select the menu serving size or quantity availability',
                        style: context.labelMedium,
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                      ).translate(),
                    ],
                  ),
                ],
              ),
              const AnimatedGap(6, duration: Duration(milliseconds: 500)),
              MultiSelectMenuPortionFormField(
                key: const Key(
                    'store-menu-multiSelectAvailableMenuPortions-formfield'),
                onSelectionChanged: (List<MenuPortion> selectedMenuPortions) {
                  _selectedMenuPortions =
                      List<MenuPortion>.from(selectedMenuPortions);
                  if (!_hasCustomMenuPortionSize) {
                    serviceLocator<MenuEntity>().menuPortions =
                        List<MenuPortion>.from(_selectedMenuPortions.toList());
                    serviceLocator<MenuEntity>().hasCustomPortion = false;
                    context.read<MenuBloc>().add(
                          PushMenuEntityData(
                            menuEntity: serviceLocator<MenuEntity>(),
                            menuFormStage: MenuFormStage.form2,
                            menuEntityStatus: MenuEntityStatus.push,
                          ),
                        );
                  }
                  setState(() {});
                },
                availableMenuPortionList: _menuPortions.toList(),
                validator: (value) {
                  if (!_hasCustomMenuPortionSize) {
                    if (value == null || value.isEmpty) {
                      return 'Select one or more portions';
                    } else {
                      return null;
                    }
                  }
                  return null;
                },
                initialSelectedMenuPortionList: _initialSelectedMenuPortions,
                onSaved: (newValue) {
                  if (!_hasCustomMenuPortionSize) {
                    serviceLocator<MenuEntity>().menuPortions =
                        List<MenuPortion>.from(_selectedMenuPortions.toList());
                    serviceLocator<MenuEntity>().hasCustomPortion = false;
                    context.read<MenuBloc>().add(
                          PushMenuEntityData(
                            menuEntity: serviceLocator<MenuEntity>(),
                            menuFormStage: MenuFormStage.form2,
                            menuEntityStatus: MenuEntityStatus.push,
                          ),
                        );
                  } else {
                    _selectedMenuPortions.clear();
                    _selectedMenuPortions = [];
                    serviceLocator<MenuEntity>().menuPortions =
                        List<MenuPortion>.from(_selectedMenuPortions.toList());
                    serviceLocator<MenuEntity>().hasCustomPortion = true;
                    context.read<MenuBloc>().add(
                          PushMenuEntityData(
                            menuEntity: serviceLocator<MenuEntity>(),
                            menuFormStage: MenuFormStage.form2,
                            menuEntityStatus: MenuEntityStatus.push,
                          ),
                        );
                  }
                },
              ),
              Card(
                margin: const EdgeInsetsDirectional.only(
                    start: 0, end: 0, top: 4, bottom: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  children: [
                    SwitchListTile(
                      onChanged: (value) {
                        setState(() {
                          _hasCustomMenuPortionSize = value;
                        });
                      },
                      value: _hasCustomMenuPortionSize,
                      title: Text(
                        'Select your own portion size',
                        style: context.titleMedium!
                            .copyWith(fontWeight: FontWeight.w500),
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                      ).translate(),
                      isThreeLine: false,
                      dense: true,
                      controlAffinity: ListTileControlAffinity.leading,
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: 0),
                    ),
                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 2, 8, 12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                          children: [
                            const AnimatedGap(8,
                                duration: Duration(milliseconds: 500)),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                                children: [
                                  Expanded(
                                    child: StoreTextFieldWidget(
                                      controller: _menuPortionNameController,
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      focusNode: menuForm2FocusList[0],
                                      onFieldSubmitted: (_) => fieldFocusChange(
                                          context,
                                          menuForm2FocusList[0],
                                          menuForm2FocusList[1]),
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: 'Your Portion name',
                                        hintText: 'Enter your portion name',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        isDense: true,
                                      ),
                                      validator: (value) {
                                        if (_hasCustomMenuPortionSize) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your portion name';
                                          } else {
                                            return null;
                                          }
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        if (_hasCustomMenuPortionSize) {
                                          if (serviceLocator<MenuEntity>()
                                              .customPortion
                                              .isNull) {
                                            serviceLocator<MenuEntity>()
                                                    .customPortion =
                                                CustomPortion(title: value);
                                          } else {
                                            final data =
                                                serviceLocator<MenuEntity>()
                                                    .customPortion
                                                    ?.copyWith(title: value);
                                            serviceLocator<MenuEntity>()
                                                .customPortion = data;
                                          }
                                          serviceLocator<MenuEntity>()
                                              .hasCustomPortion = true;
                                          context.read<MenuBloc>().add(
                                                PushMenuEntityData(
                                                  menuEntity: serviceLocator<
                                                      MenuEntity>(),
                                                  menuFormStage:
                                                      MenuFormStage.form2,
                                                  menuEntityStatus:
                                                      MenuEntityStatus.push,
                                                ),
                                              );
                                        }
                                      },
                                      onSaved: (newValue) {
                                        if (_hasCustomMenuPortionSize) {
                                          if (serviceLocator<MenuEntity>()
                                              .customPortion
                                              .isNull) {
                                            serviceLocator<MenuEntity>()
                                                    .customPortion =
                                                CustomPortion(
                                                    title:
                                                        _menuPortionNameController
                                                            .value.text
                                                            .trim());
                                          } else {
                                            final data = serviceLocator<
                                                    MenuEntity>()
                                                .customPortion
                                                ?.copyWith(
                                                    title:
                                                        _menuPortionNameController
                                                            .value.text
                                                            .trim());
                                            serviceLocator<MenuEntity>()
                                                .customPortion = data;
                                          }
                                          serviceLocator<MenuEntity>()
                                              .hasCustomPortion = true;
                                          context.read<MenuBloc>().add(
                                                PushMenuEntityData(
                                                  menuEntity: serviceLocator<
                                                      MenuEntity>(),
                                                  menuFormStage:
                                                      MenuFormStage.form2,
                                                  menuEntityStatus:
                                                      MenuEntityStatus.push,
                                                ),
                                              );
                                        }
                                      },
                                    ),
                                  ),
                                  //
                                ],
                              ),
                            ),
                            const AnimatedGap(12,
                                duration: Duration(milliseconds: 500)),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: StoreTextFieldWidget(
                                      controller: _menuPortionSizeController,
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      focusNode: menuForm2FocusList[1],
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) => fieldFocusChange(
                                          context,
                                          menuForm2FocusList[1],
                                          menuForm2FocusList[2]),
                                      keyboardType: const TextInputType
                                          .numberWithOptions(),
                                      decoration: InputDecoration(
                                        labelText: 'Portion value',
                                        hintText: 'Enter portion value',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        isDense: true,
                                      ),
                                      validator: (value) {
                                        if (_hasCustomMenuPortionSize) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter portion value';
                                          } else {
                                            return null;
                                          }
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        if (_hasCustomMenuPortionSize) {
                                          if (serviceLocator<MenuEntity>()
                                              .customPortion
                                              .isNull) {
                                            serviceLocator<MenuEntity>()
                                                    .customPortion =
                                                CustomPortion(
                                                    quantity: double.tryParse(
                                                            value) ??
                                                        0.0);
                                          } else {
                                            final data =
                                                serviceLocator<MenuEntity>()
                                                    .customPortion
                                                    ?.copyWith(
                                                        quantity:
                                                            double.tryParse(
                                                                    value) ??
                                                                0.0);
                                            serviceLocator<MenuEntity>()
                                                .customPortion = data;
                                          }
                                          serviceLocator<MenuEntity>()
                                              .hasCustomPortion = true;
                                          context.read<MenuBloc>().add(
                                                PushMenuEntityData(
                                                  menuEntity: serviceLocator<
                                                      MenuEntity>(),
                                                  menuFormStage:
                                                      MenuFormStage.form2,
                                                  menuEntityStatus:
                                                      MenuEntityStatus.push,
                                                ),
                                              );
                                        }
                                      },
                                      onSaved: (newValue) {
                                        if (_hasCustomMenuPortionSize) {
                                          if (serviceLocator<MenuEntity>()
                                              .customPortion
                                              .isNull) {
                                            serviceLocator<MenuEntity>()
                                                    .customPortion =
                                                CustomPortion(
                                                    quantity: double.tryParse(
                                                            _menuPortionSizeController
                                                                .value.text
                                                                .trim()) ??
                                                        0.0);
                                          } else {
                                            final data = serviceLocator<
                                                    MenuEntity>()
                                                .customPortion
                                                ?.copyWith(
                                                    quantity: double.tryParse(
                                                            _menuPortionSizeController
                                                                .value.text
                                                                .trim()) ??
                                                        0.0);
                                            serviceLocator<MenuEntity>()
                                                .customPortion = data;
                                          }
                                          serviceLocator<MenuEntity>()
                                              .hasCustomPortion = true;
                                          context.read<MenuBloc>().add(
                                                PushMenuEntityData(
                                                  menuEntity: serviceLocator<
                                                      MenuEntity>(),
                                                  menuFormStage:
                                                      MenuFormStage.form2,
                                                  menuEntityStatus:
                                                      MenuEntityStatus.push,
                                                ),
                                              );
                                        }
                                      },
                                    ),
                                  ),
                                  const AnimatedGap(18,
                                      duration: Duration(milliseconds: 500)),
                                  Expanded(
                                    child: StoreTextFieldWidget(
                                      controller: _menuPortionUnitController,
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      focusNode: menuForm2FocusList[2],
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) => fieldFocusChange(
                                          context,
                                          menuForm2FocusList[2],
                                          menuForm2FocusList[3]),
                                      keyboardType: TextInputType.text,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      decoration: InputDecoration(
                                        labelText: 'Unit',
                                        hintText: 'Enter unit of menu',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        isDense: true,
                                      ),
                                      validator: (value) {
                                        if (_hasCustomMenuPortionSize) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter unit of menu';
                                          } else {
                                            return null;
                                          }
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        if (_hasCustomMenuPortionSize) {
                                          if (serviceLocator<MenuEntity>()
                                              .customPortion
                                              .isNull) {
                                            serviceLocator<MenuEntity>()
                                                    .customPortion =
                                                CustomPortion(unit: value);
                                          } else {
                                            final data =
                                                serviceLocator<MenuEntity>()
                                                    .customPortion
                                                    ?.copyWith(unit: value);
                                            serviceLocator<MenuEntity>()
                                                .customPortion = data;
                                          }
                                          serviceLocator<MenuEntity>()
                                              .hasCustomPortion = true;
                                          context.read<MenuBloc>().add(
                                                PushMenuEntityData(
                                                  menuEntity: serviceLocator<
                                                      MenuEntity>(),
                                                  menuFormStage:
                                                      MenuFormStage.form2,
                                                  menuEntityStatus:
                                                      MenuEntityStatus.push,
                                                ),
                                              );
                                        }
                                      },
                                      onSaved: (newValue) {
                                        if (_hasCustomMenuPortionSize) {
                                          if (serviceLocator<MenuEntity>()
                                              .customPortion
                                              .isNull) {
                                            serviceLocator<MenuEntity>()
                                                    .customPortion =
                                                CustomPortion(
                                                    unit:
                                                        _menuPortionUnitController
                                                            .value.text
                                                            .trim());
                                          } else {
                                            final data = serviceLocator<
                                                    MenuEntity>()
                                                .customPortion
                                                ?.copyWith(
                                                    unit:
                                                        _menuPortionUnitController
                                                            .value.text
                                                            .trim());
                                            serviceLocator<MenuEntity>()
                                                .customPortion = data;
                                          }
                                          serviceLocator<MenuEntity>()
                                              .hasCustomPortion = true;
                                          context.read<MenuBloc>().add(
                                                PushMenuEntityData(
                                                  menuEntity: serviceLocator<
                                                      MenuEntity>(),
                                                  menuFormStage:
                                                      MenuFormStage.form2,
                                                  menuEntityStatus:
                                                      MenuEntityStatus.push,
                                                ),
                                              );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const AnimatedGap(12,
                                duration: Duration(milliseconds: 500)),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                                children: [
                                  Expanded(
                                    child: StoreTextFieldWidget(
                                      controller:
                                          _menuPortionMaximumServeController,
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      focusNode: menuForm2FocusList[3],
                                      textInputAction: TextInputAction.done,
                                      keyboardType: const TextInputType
                                          .numberWithOptions(),
                                      decoration: InputDecoration(
                                        labelText: 'Maximum Serving Persons',
                                        hintText:
                                            'Enter maximum serving persons',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        isDense: true,
                                      ),
                                      validator: (value) {
                                        if (_hasCustomMenuPortionSize) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter maximum serving persons';
                                          } else {
                                            return null;
                                          }
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        if (_hasCustomMenuPortionSize) {
                                          if (serviceLocator<MenuEntity>()
                                              .customPortion
                                              .isNull) {
                                            serviceLocator<MenuEntity>()
                                                    .customPortion =
                                                CustomPortion(
                                                    maxServingPerson:
                                                        int.tryParse(value) ??
                                                            0);
                                          } else {
                                            final data =
                                                serviceLocator<MenuEntity>()
                                                    .customPortion
                                                    ?.copyWith(
                                                        maxServingPerson:
                                                            int.tryParse(
                                                                    value) ??
                                                                0);
                                            serviceLocator<MenuEntity>()
                                                .customPortion = data;
                                          }

                                          serviceLocator<MenuEntity>()
                                              .hasCustomPortion = true;
                                          context.read<MenuBloc>().add(
                                                PushMenuEntityData(
                                                  menuEntity: serviceLocator<
                                                      MenuEntity>(),
                                                  menuFormStage:
                                                      MenuFormStage.form2,
                                                  menuEntityStatus:
                                                      MenuEntityStatus.push,
                                                ),
                                              );
                                        }
                                      },
                                      onSaved: (newValue) {
                                        if (_hasCustomMenuPortionSize) {
                                          if (serviceLocator<MenuEntity>()
                                              .customPortion
                                              .isNull) {
                                            serviceLocator<MenuEntity>()
                                                    .customPortion =
                                                CustomPortion(
                                                    maxServingPerson: int.tryParse(
                                                            _menuPortionMaximumServeController
                                                                .value.text
                                                                .trim()) ??
                                                        0);
                                          } else {
                                            final data = serviceLocator<
                                                    MenuEntity>()
                                                .customPortion
                                                ?.copyWith(
                                                    maxServingPerson: int.tryParse(
                                                            _menuPortionMaximumServeController
                                                                .value.text
                                                                .trim()) ??
                                                        0);
                                            serviceLocator<MenuEntity>()
                                                .customPortion = data;
                                          }
                                          serviceLocator<MenuEntity>()
                                              .hasCustomPortion = true;
                                          context.read<MenuBloc>().add(
                                                PushMenuEntityData(
                                                  menuEntity: serviceLocator<
                                                      MenuEntity>(),
                                                  menuFormStage:
                                                      MenuFormStage.form2,
                                                  menuEntityStatus:
                                                      MenuEntityStatus.push,
                                                ),
                                              );
                                        }
                                      },
                                    ),
                                  ),
                                  //
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      crossFadeState: (_hasCustomMenuPortionSize == true)
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 500),
                    ),
                  ],
                ),
              ),
              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  Wrap(
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    children: [
                      Text(
                        'Extras',
                        style: context.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                      ).translate(),
                    ],
                  ),
                  const AnimatedGap(2, duration: Duration(milliseconds: 500)),
                  Wrap(
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    children: [
                      Text(
                        'Add customization options add to your menu item',
                        style: context.labelMedium,
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                      ).translate(),
                    ],
                  ),
                  const AnimatedGap(8, duration: Duration(milliseconds: 500)),
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 500),
                    crossFadeState: (_selectedAddons.isNotEmpty)
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: MultiSelectAddonsFormField(
                      key: const Key(
                          'store-menu-multiSelectAvailableMenuAddons-formfield'),
                      onSelectionChanged: (List<Addons> selectedAddons) {
                        _selectedAddons = List<Addons>.from(selectedAddons);
                        setState(() {});
                        serviceLocator<MenuEntity>().addons =
                            _selectedAddons.toList();
                        context.read<MenuBloc>().add(
                              PushMenuEntityData(
                                menuEntity: serviceLocator<MenuEntity>(),
                                menuFormStage: MenuFormStage.form2,
                                menuEntityStatus: MenuEntityStatus.push,
                              ),
                            );
                      },
                      availableAddonsList: _selectedAddons.toList(),
                      /*validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Select one or more portions';
                    } else {
                      return null;
                    }
                  },*/
                      initialSelectedAddonsList: _initialSelectedAddons,
                      onSaved: (newValue) {
                        serviceLocator<MenuEntity>().addons =
                            _selectedAddons.toList();
                        context.read<MenuBloc>().add(
                              PushMenuEntityData(
                                menuEntity: serviceLocator<MenuEntity>(),
                                menuFormStage: MenuFormStage.form2,
                                menuEntityStatus: MenuEntityStatus.push,
                              ),
                            );
                      },
                    ),
                    secondChild: const Offstage(),
                  ),
                  const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      //visualDensity: VisualDensity(vertical: -1, horizontal: 0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      backgroundColor: const Color.fromRGBO(238, 238, 238, 1.0),
                    ),
                    icon: const Icon(
                      Icons.add,
                      color: Color.fromRGBO(42, 45, 48, 1.0),
                    ),
                    label: Text(
                      'Add Addons Menu',
                      style: const TextStyle(
                        color: Color.fromRGBO(42, 45, 50, 1.0),
                      ),
                      textDirection: serviceLocator<LanguageController>()
                          .targetTextDirection,
                    ).translate(),
                    onPressed: () async {
                      final List<Addons>? addons = await context
                          .push<List<Addons>>(Routes.ALL_ADDONS_PAGE);
                      if (addons != null && addons.isNotEmpty) {
                        setState(() {
                          _selectedAddons = List<Addons>.from(addons.toList());
                        });
                      }
                    },
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildAddonsChoiceList(BuildContext context) {
    final List<Widget> choices = [];

    for (var item in _selectedAddons) {
      choices.add(
        InputChip(
          label: Text(
            '${item.title} ${item.unit}',
            textDirection:
                serviceLocator<LanguageController>().targetTextDirection,
          ),
          selected: _selectedAddons.contains(item),
          onSelected: (selected) {
            setState(() {
              _selectedAddons.contains(item)
                  ? _selectedAddons.remove(item)
                  : _selectedAddons.add(item);
            });
          },
        ),
      );
    }

    return choices;
  }
}
