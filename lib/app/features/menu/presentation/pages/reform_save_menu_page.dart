part of 'package:homemakers_merchant/app/features/menu/index.dart';

class ReFormSaveMenuPage extends StatefulWidget {
  const ReFormSaveMenuPage({
    super.key,
    this.haveNewMenu = true,
    this.menuEntity,
    this.currentIndex = -1,
    this.selectionUseCase = SelectionUseCase.selectAndNext,
  });

  final bool haveNewMenu;
  final MenuEntity? menuEntity;
  final int currentIndex;
  final SelectionUseCase selectionUseCase;

  @override
  _ReFormSaveMenuPageController createState() => _ReFormSaveMenuPageController();
}

class _ReFormSaveMenuPageController extends State<ReFormSaveMenuPage>
    with AutomaticKeepAliveClientMixin<ReFormSaveMenuPage>, WidgetsBindingObserver {
  late final ScrollController scrollController;
  late final ScrollController _screenScrollController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isKeyboardOpen = false;
  MenuStateStatus menuStateStatus = MenuStateStatus.none;
  List<FocusNode> focusList = [];
  bool _hasCustomMenuPortionSize = false;

  final TextEditingController menuNameTextEditingController = TextEditingController();
  final TextEditingController menuDescriptionTextEditingController = TextEditingController();
  final TextEditingController menuCategoryTextEditingController = TextEditingController();
  final TextEditingController menuSubCategoryTextEditingController = TextEditingController();

  final TextEditingController _menuPortionNameController = TextEditingController();
  final TextEditingController _menuPortionSizeController = TextEditingController();
  final TextEditingController _menuPortionMaximumServeController = TextEditingController();
  final TextEditingController _menuPortionUnitController = TextEditingController();

  final TextEditingController _menuOpeningTimeController = TextEditingController();
  final TextEditingController _menuClosingTimeController = TextEditingController();
  late final MaskTextInputFormatter maximumDeliveryTimeFormatter;
  final TextEditingController _menuMinPreparationTimeController = TextEditingController();
  final TextEditingController _menuMaxPreparationTimeController = TextEditingController();
  final TextEditingController _menuMinStockQuantityController = TextEditingController(text: '1');
  final TextEditingController _menuMaxStockQuantityController = TextEditingController();

  List<StoreAvailableFoodTypes> _menuAvailableFoodTypes = [];
  List<StoreAvailableFoodTypes> _selectedFoodTypes = [];
  List<StoreAvailableFoodTypes> _initialSelectedFoodTypes = [];

  List<StoreAvailableFoodPreparationType> _menuAvailableFoodCookingType = [];
  List<StoreAvailableFoodPreparationType> _selectedFoodPreparationType = [];
  List<StoreAvailableFoodPreparationType> _initialSelectedFoodPreparationType = [];
  List<MenuPreparationType> cacheMenuPreparationType = [];

  List<StoreWorkingDayAndTime> _menuAvailableDays = [];
  List<StoreWorkingDayAndTime> _selectedWorkingDays = [];
  List<StoreWorkingDayAndTime> _initialSelectedWorkingDays = [];
  List<StoreWorkingDayAndTime> _initSelectedWorkingDays = [];

  List<TasteType> _menuTasteType = [];
  List<TasteType> _initialSelectedTasteType = [];
  List<TasteType> _selectedTasteType = [];

  List<TasteLevel> _selectedTasteLevel = [];
  List<TasteLevel> _menuTasteLevel = [];
  List<TasteLevel> _initialSelectedTasteLevel = [];

  List<MenuPortion> _menuPortions = [];
  List<MenuPortion> _selectedMenuPortions = [];
  List<MenuPortion> _initialSelectedMenuPortions = [];

  bool _haveAddonsWithCurrentMenu = false;

  List<Addons> _selectedAddons = [];
  List<Addons> _initialSelectedAddons = [];
  List<Addons> _allAddons = [];
  List<Widget> selectedAddonsWidgets = [];

  Category? selectedCategory;
  Category? selectedSubCategory;
  List<Category> listOfCategories = [];

  /*List<StoreWorkingDayAndTime> _menuAvailableDays = [];
  List<StoreWorkingDayAndTime> _selectedWorkingDays = [];
  List<StoreWorkingDayAndTime> _initSelectedWorkingDays = [];*/

  //List<Timing> _menuAvailablePreparationTimings = [];
  List<String> _menuAvailablePreparationTimings = [];
  Timing? _menuPreparationTiming;
  Stock? _menuStock;
  List<FocusNode> menuForm3FocusList = [];
  late MenuEntity menuEntity;

  @override
  void initState() {
    menuEntity = MenuEntity();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    focusList = [
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
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
    scrollController = ScrollController();
    _screenScrollController = ScrollController();

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
    cacheMenuPreparationType = [];

    //Initial Data
    _initialSelectedFoodPreparationType = [];

    _menuAvailableDays = [];
    _selectedWorkingDays = [];
    _menuAvailablePreparationTimings = [];
    _initSelectedWorkingDays = [];
    maximumDeliveryTimeFormatter =
        MaskTextInputFormatter(mask: '##', filter: {'#': RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);
    initializeMenuWorkingDays();
    initializeMenuAvailableTimings();
    initializeMenuAvailableFoodCookingType();
    initializeMenuAvailableDays();
    initializeMenuAvailableFoodTypes();
    initializeMenuTasteType();
    initializeMenuTasteLevel();
    initMenuPortions();
    initData();
  }

  @override
  void dispose() {
    focusList.asMap().forEach((key, value) => value.dispose());
    menuNameTextEditingController.dispose();
    menuDescriptionTextEditingController.dispose();
    menuCategoryTextEditingController.dispose();
    menuSubCategoryTextEditingController.dispose();

    _menuPortionNameController.dispose();
    _menuPortionSizeController.dispose();
    _menuPortionMaximumServeController.dispose();
    _menuPortionUnitController.dispose();

    _menuOpeningTimeController.dispose();
    _menuClosingTimeController.dispose();
    //maximumDeliveryTimeFormatter.dispose();
    _menuMinPreparationTimeController.dispose();
    _menuMaxPreparationTimeController.dispose();
    _menuMinStockQuantityController.dispose();
    _menuMaxStockQuantityController.dispose();

    _menuAvailableFoodCookingType = [];
    _menuAvailableFoodTypes = [];
    _menuAvailableDays = [];
    _menuTasteType = [];
    _menuTasteLevel = [];
    _menuPortions = [];
    //
    _selectedFoodTypes = [];
    cacheMenuPreparationType = [];
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

    _menuAvailableDays = [];
    _selectedWorkingDays = [];
    _menuAvailablePreparationTimings = [];
    _initSelectedWorkingDays = [];

    WidgetsBinding.instance.removeObserver(this);
    _screenScrollController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isKeyboardOpen = MediaQuery
          .of(context)
          .viewInsets
          .bottom > 0;
    });
  }

  void _scrollListener() {
    if (_screenScrollController.offset >= _screenScrollController.position.maxScrollExtent &&
        !_screenScrollController.position.outOfRange) {
      //reach the top
    }
    if (_screenScrollController.offset <= _screenScrollController.position.minScrollExtent &&
        !_screenScrollController.position.outOfRange) {
      //reach the top
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void initData() {
    if (!widget.haveNewMenu && widget.menuEntity.isNotNull) {
      menuNameTextEditingController.text = widget.menuEntity?.menuName ?? '';
      menuDescriptionTextEditingController.text = widget.menuEntity?.menuDescription ?? '';
      menuCategoryTextEditingController.text = widget.menuEntity?.menuCategories.first.title ?? '';
      menuSubCategoryTextEditingController.text = widget.menuEntity?.menuCategories.first.subCategory.first.title ?? '';

      // Init data of Menu Preparation type
      _initialSelectedFoodPreparationType = List<StoreAvailableFoodPreparationType>.from(
        widget.menuEntity!.storeAvailableFoodPreparationType.toList(),
      );
      _selectedFoodPreparationType = List<StoreAvailableFoodPreparationType>.from(
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
      if (widget.menuEntity!.hasCustomPortion == true && widget.menuEntity!.customPortion.isNotNull) {
        _hasCustomMenuPortionSize = true;
        _menuPortionNameController.text = widget.menuEntity!.customPortion!.title ?? '';
        _menuPortionSizeController.text = widget.menuEntity!.customPortion!.quantity.toString() ?? '';
        _menuPortionMaximumServeController.text = widget.menuEntity!.customPortion!.maxServingPerson.toString() ?? '';
        _menuPortionUnitController.text = widget.menuEntity!.customPortion!.unit ?? '';
      }

      // Init data of selected addons
      _initialSelectedAddons = List<Addons>.from(widget.menuEntity!.addons);
      _selectedAddons = List<Addons>.from(widget.menuEntity!.addons);

      // Init data of days
      //var cacheMenuAvailableDayAndTime = List<MenuAvailableDayAndTime>.from(widget.menuEntity!.menuAvailableInDays.toList().map((e) => MenuAvailableDayAndTime.fromMap(e.toMap())).toList());
      _initSelectedWorkingDays = List<StoreWorkingDayAndTime>.from(widget.menuEntity!.menuAvailableInDays.toList());
      _selectedWorkingDays = List<StoreWorkingDayAndTime>.from(widget.menuEntity!.menuAvailableInDays.toList());

      // Init data of working time
      _menuOpeningTimeController.text = widget.menuEntity!.menuAvailableFromTime;
      _menuClosingTimeController.text = widget.menuEntity!.menuAvailableToTime;

      // Init data of menu preparation time
      _menuMaxPreparationTimeController.text = widget.menuEntity!.menuMaxPreparationTime;
      _menuMinPreparationTimeController.text = widget.menuEntity!.menuMinPreparationTime;

      // Init data of stocks
      _menuMinStockQuantityController.text = widget.menuEntity!.minStockAvailable.toString();
      _menuMaxStockQuantityController.text = widget.menuEntity!.maxStockAvailable.toString();
    }
  }

  void initializeMenuAvailableFoodCookingType() {
    _menuAvailableFoodCookingType =
    List<StoreAvailableFoodPreparationType>.from(localStoreAvailableFoodPreparationType.toList());
  }

  void initializeMenuAvailableFoodTypes() {
    _menuAvailableFoodTypes = List<StoreAvailableFoodTypes>.from(localStoreAvailableFoodTypes.toList());
  }

  void initializeMenuAvailableDays() {
    _menuAvailableDays = List<StoreWorkingDayAndTime>.from(localStoreWorkingDays.toList());
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

  void initializeMenuWorkingDays() {
    _menuAvailableDays = List<StoreWorkingDayAndTime>.from(localStoreWorkingDays.toList());
  }

  void initializeMenuAvailableTimings() {
    _menuAvailablePreparationTimings = List<String>.from(localTimings.toList());
  }

  void updateCategoryAndSubCategory(Category mainCategory, Category? subCategory) {
    menuCategoryTextEditingController.text = '';
    menuSubCategoryTextEditingController.text = '';
    menuCategoryTextEditingController.text = mainCategory.title ?? '';
    selectedCategory = mainCategory;
    if (subCategory != null) {
      selectedSubCategory = subCategory;
      menuSubCategoryTextEditingController.text = subCategory.title ?? '';
      selectedCategory = selectedCategory?.copyWith(subCategory: List<Category>.from([subCategory]));
      menuEntity.menuCategories = [selectedCategory!];
    }
    setState(() {});
  }

  void updateSelectedFoodPreparationType(List<StoreAvailableFoodPreparationType> selectedPreparationTypes) {
    _selectedFoodPreparationType = List<StoreAvailableFoodPreparationType>.from(selectedPreparationTypes);
    cacheMenuPreparationType = List<MenuPreparationType>.from(
        _selectedFoodPreparationType.map((e) => MenuPreparationType.fromMap(e.toMap())).toList());
    menuEntity.storeAvailableFoodPreparationType = cacheMenuPreparationType.toList();
    setState(() {});
  }

  void menuTasteTypeSelection(List<TasteType> selectedTasteTypes) {
    _selectedTasteType = List<TasteType>.from(selectedTasteTypes);
    final cacheTasteType = _selectedTasteType[0];
    menuEntity.tasteType = cacheTasteType;
    setState(() {});
  }

  void setMenuNameValue(String value) {
    menuEntity.menuName = menuNameTextEditingController.value.text.trim();
    setState(() {});
  }
  void setMenuDescriptionValue(String value) {
    menuEntity.menuDescription = menuDescriptionTextEditingController.value.text.trim();
    setState(() {});
  }

  void setMenuMaxStockValue() {
    menuEntity.maxStockAvailable = int.tryParse(_menuMaxStockQuantityController.value.text.trim()) ?? 0;
    setState(() {});
  }

  void setMenuMinStockValue() {
    menuEntity.minStockAvailable = int.tryParse(_menuMinStockQuantityController.value.text.trim()) ?? 0;
    setState(() {});
  }

  void menuMaxPreparationTimeSave() {
    menuEntity.menuMaxPreparationTime = _menuMaxPreparationTimeController.value.text.trim();
  }

  Future<void> menuMaxPreparationTimeSelection() async {
    final String? timing = await selectTiming(context);
    if (timing != null) {
      _menuMaxPreparationTimeController.text = timing ?? '';
      menuEntity.menuTiming = _menuPreparationTiming?.copyWith(
        maxPreparingTime: _menuMaxPreparationTimeController.value.text.trim(),
      );
      setState(() {});
    }
  }

  void menuMinPreparationTimeSave() {
    menuEntity.menuMinPreparationTime = _menuMinPreparationTimeController.value.text.trim();
    setState(() {});
  }

  Future<void> menuMinPreparationTimeSelection() async {
    final String? timing = await selectTiming(context);
    if (timing != null) {
      _menuMinPreparationTimeController.text = timing ?? '';
      menuEntity.menuTiming = _menuPreparationTiming?.copyWith(
        minPreparingTime: _menuMinPreparationTimeController.value.text.trim(),
      );
      setState(() {});
    }
  }

  void menuAvailableClosingTimeSelection() {
    menuEntity.menuAvailableToTime = _menuClosingTimeController.value.text.trim();
    setState(() {});
  }

  void menuAvailableOpeningTimeSelection() {
    menuEntity.menuAvailableFromTime = _menuOpeningTimeController.value.text.trim();
    setState(() {});
  }

  void menuAvailableDaysSelection(List<StoreWorkingDayAndTime> selectedWorkingDays,) {
    _selectedWorkingDays = List<StoreWorkingDayAndTime>.from(selectedWorkingDays);
    var cacheMenuAvailableDayAndTime = List<MenuAvailableDayAndTime>.from(
        _selectedWorkingDays.map((e) => MenuAvailableDayAndTime.fromMap(e.toMap())).toList());
    menuEntity.menuAvailableInDays = cacheMenuAvailableDayAndTime.toList();
    setState(() {});
  }

  Future<void> navigateToAddonsSelection() async {
    final List<Addons>? addons = await context.push<List<Addons>>(Routes.ALL_ADDONS_PAGE);
    if (addons != null && addons.isNotEmpty) {
      _selectedAddons = List<Addons>.from(addons.toList());
    }
    menuEntity.addons = _selectedAddons.toList();
    setState(() {});
  }

  void addonSelection(List<Addons> selectedAddons,) {
    _selectedAddons = List<Addons>.from(selectedAddons);
    menuEntity.addons = _selectedAddons.toList();
    setState(() {});
  }

  void setCustomPortionMaximumServe() {
    if (_hasCustomMenuPortionSize) {
      if (menuEntity.customPortion.isNull) {
        menuEntity.customPortion =
            CustomPortion(maxServingPerson: int.tryParse(_menuPortionMaximumServeController.value.text.trim()) ?? 0);
      } else {
        final data = menuEntity.customPortion
            ?.copyWith(maxServingPerson: int.tryParse(_menuPortionMaximumServeController.value.text.trim()) ?? 0);
        menuEntity.customPortion = data;
      }
      menuEntity.hasCustomPortion = true;
      setState(() {});
    }
  }

  void setCustomPortionUnit() {
    if (_hasCustomMenuPortionSize) {
      if (menuEntity.customPortion.isNull) {
        menuEntity.customPortion = CustomPortion(unit: _menuPortionUnitController.value.text.trim());
      } else {
        final data = menuEntity.customPortion?.copyWith(unit: _menuPortionUnitController.value.text.trim());
        menuEntity.customPortion = data;
      }
      menuEntity.hasCustomPortion = true;
      setState(() {});
    }
  }

  void setCustomPortionSize() {
    if (_hasCustomMenuPortionSize) {
      if (menuEntity.customPortion.isNull) {
        menuEntity.customPortion =
            CustomPortion(quantity: double.tryParse(_menuPortionSizeController.value.text.trim()) ?? 0.0);
      } else {
        final data = menuEntity.customPortion
            ?.copyWith(quantity: double.tryParse(_menuPortionSizeController.value.text.trim()) ?? 0.0);
        menuEntity.customPortion = data;
      }
      menuEntity.hasCustomPortion = true;
      setState(() {});
    }
  }

  void setCustomPortionName() {
    if (_hasCustomMenuPortionSize) {
      if (menuEntity.customPortion.isNull) {
        menuEntity.customPortion = CustomPortion(title: _menuPortionNameController.value.text.trim());
      } else {
        final data = menuEntity.customPortion?.copyWith(title: _menuPortionNameController.value.text.trim());
        menuEntity.customPortion = data;
      }
      menuEntity.hasCustomPortion = true;
      setState(() {});
    }
  }

  void setCustomMenuSelection(bool value) {
    _hasCustomMenuPortionSize = value;
    setState(() {});
  }

  void multiSelectionMenuPortion(List<MenuPortion> selectedMenuPortions,) {
    _selectedMenuPortions = List<MenuPortion>.from(selectedMenuPortions);
    if (!_hasCustomMenuPortionSize) {
      menuEntity.menuPortions = List<MenuPortion>.from(_selectedMenuPortions.toList());
      menuEntity.hasCustomPortion = false;
    }
    setState(() {});
  }

  void menuTasteLevelSelection(List<TasteLevel> selectedTasteLevel,) {
    _selectedTasteLevel = List<TasteLevel>.from(selectedTasteLevel);
    menuEntity.tasteType?.tasteLevel = List<TasteLevel>.from(_selectedTasteLevel.toList());
    setState(() {});
  }

  Future<String?> selectTiming(BuildContext context,) async {
    final String? timing = await showConfirmationDialog<String>(
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
              key: const Key('menu-preparation-time-confirm-dialog'),
              title: 'Time slots',
              child: ListView.builder(
                padding: EdgeInsetsDirectional.zero,
                itemCount: _menuAvailablePreparationTimings.length,
                itemBuilder: (context, index) => _menuPreparationWidget(context, index, setState),
                shrinkWrap: true,
              ),
            );
          },
        );
      },
    );
    return timing;
  }

  Widget _menuPreparationWidget(BuildContext context, int index, StateSetter innerSetState) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
            top: (index == 0) ? BorderSide(color: Theme
                .of(context)
                .dividerColor) : BorderSide.none,
            bottom: BorderSide(color: Theme
                .of(context)
                .dividerColor)),
      ),
      child: ListTile(
        dense: true,
        minVerticalPadding: 0,
        minLeadingWidth: 0,
        horizontalTitleGap: 0,
        visualDensity: const VisualDensity(vertical: -1),
        title: Text(
          _menuAvailablePreparationTimings[index],
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
        ),
        onTap: () {
          innerSetState(() {});
          Navigator.of(context).pop(_menuAvailablePreparationTimings[index]);
          return;
        },
      ),
    );
  }

  String? stockMinQuantityValidation(String? value) {
    String? validate = ValidatorGroup<String>([
      const RequiredValidator<String>(errorMessage: 'Enter minimum stock quantity'),
      if (_menuMaxStockQuantityController.value.text.isNotEmpty)
        CustomValidator<String>(
          validator: (value) {
            final maximumStockValue =
            int.parse(_menuMaxStockQuantityController.value.text.trim().replaceAll(RegExp(r'[^0-9]'), ''));
            final minimumStockValue =
            int.parse(_menuMinStockQuantityController.value.text.trim().replaceAll(RegExp(r'[^0-9]'), ''));
            if (minimumStockValue > maximumStockValue) {
              return 'Enter valid minimum quantity';
            }
            return null;
          },
        ),
    ]).validate(value);
    setState(() {});
    return validate;
  }

  String? stockMaxQuantityValidation(String? value) {
    String? validate = ValidatorGroup<String>([
      const RequiredValidator<String>(errorMessage: 'Enter maximum stock quantity'),
      if (_menuMinStockQuantityController.value.text.isNotEmpty)
        CustomValidator<String>(
          validator: (value) {
            final maximumStockValue =
            int.parse(_menuMaxStockQuantityController.value.text.trim().replaceAll(RegExp(r'[^0-9]'), ''));
            final minimumStockValue =
            int.parse(_menuMinStockQuantityController.value.text.trim().replaceAll(RegExp(r'[^0-9]'), ''));
            if (maximumStockValue < minimumStockValue) {
              return 'Enter valid maximum quantity';
            }
            return null;
          },
        ),
    ]).validate(value);
    setState(() {});
    return validate;
  }

  Future<void> onSaveAndNext() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (!widget.haveNewMenu && widget.menuEntity != null) {
        menuEntity.copyWith(
          menuId: widget.menuEntity!.menuId,
          hasCustomPortion: _hasCustomMenuPortionSize,
          maxStockAvailable: int.tryParse(_menuMaxStockQuantityController.value.text.trim()) ?? 0,
          menuAvailableFromTime: _menuOpeningTimeController.value.text.trim(),
          menuAvailableToTime: _menuClosingTimeController.value.text.trim(),
          menuDescription: menuDescriptionTextEditingController.value.text.trim(),
          menuMaxPreparationTime: _menuMaxPreparationTimeController.value.text.trim(),
          menuMinPreparationTime: _menuMinPreparationTimeController.value.text.trim(),
          menuName: menuNameTextEditingController.value.text.trim(),
          minStockAvailable: int.tryParse(_menuMinStockQuantityController.value.text.trim()) ?? 0,
          stock: Stock(
            maxStockQuantity: int.tryParse(_menuMaxStockQuantityController.value.text.trim()) ?? 0,
            minStockQuantity: int.tryParse(_menuMinStockQuantityController.value.text.trim()) ?? 0,
          ),
        );
      } else {
        menuEntity.copyWith(
          hasCustomPortion: _hasCustomMenuPortionSize,
          maxStockAvailable: int.tryParse(_menuMaxStockQuantityController.value.text.trim()) ?? 0,
          menuAvailableFromTime: _menuOpeningTimeController.value.text.trim(),
          menuAvailableToTime: _menuClosingTimeController.value.text.trim(),
          menuDescription: menuDescriptionTextEditingController.value.text.trim(),
          menuMaxPreparationTime: _menuMaxPreparationTimeController.value.text.trim(),
          menuMinPreparationTime: _menuMinPreparationTimeController.value.text.trim(),
          menuName: menuNameTextEditingController.value.text.trim(),
          minStockAvailable: int.tryParse(_menuMinStockQuantityController.value.text.trim()) ?? 0,
          stock: Stock(
            maxStockQuantity: int.tryParse(_menuMaxStockQuantityController.value.text.trim()) ?? 0,
            minStockQuantity: int.tryParse(_menuMinStockQuantityController.value.text.trim()) ?? 0,
          ),
        );
      }
      appLog.d(menuEntity.toMap());
      context.read<MenuBloc>().add(
        PushMenuEntityData(
          menuEntity: menuEntity,
          menuFormStage: MenuFormStage.form1,
          menuEntityStatus: MenuEntityStatus.push,
        ),
      );
      return;
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<MenuBloc, MenuState>(
      bloc: context.read<MenuBloc>(),
      listener: (context, menuState) async {
        switch (menuState) {
          case NavigateToMenuPricePage():
            {
              final result = await context.push(Routes.MENU_PRICE_PAGE,extra: {
                'menuEntity':menuState.menuEntity,
                'haveNewMenu':widget.haveNewMenu,
                'currentIndex':widget.currentIndex,
              'selectionUseCase':widget.selectionUseCase,
              },);
            }
        }
      },
      child: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, menuBuilderState) {
          switch(menuBuilderState){
            case PushMenuEntityDataState():{
              menuEntity = menuBuilderState.menuEntity;
            }
          }
          return _ReFormSaveMenuPageView(this);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ReFormSaveMenuPageView extends WidgetView<ReFormSaveMenuPage, _ReFormSaveMenuPageController> {
  const _ReFormSaveMenuPageView(super.state);

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
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Menu'),
            centerTitle: false,
            actions: const [
              Padding(
                padding: EdgeInsetsDirectional.only(end: 8),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          body: SlideInLeft(
            key: const Key('reform-save-menu-slideinleft-widget'),
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
                child: Form(
                  key: state.formKey,
                  child: CustomScrollView(
                    controller: state._screenScrollController,
                    shrinkWrap: true,
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const AnimatedGap(
                                  6,
                                  duration: Duration(milliseconds: 100),
                                ),
                                AppTextFieldWidget(
                                  key: const Key('reform-menuCategory-textfield-widget'),
                                  controller: state.menuCategoryTextEditingController,
                                  readOnly: true,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  focusNode: state.focusList[0],
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) =>
                                      fieldFocusChange(context, state.focusList[0], state.focusList[1]),
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
                                          Routes.MAIN_CATEGORY_PAGE,
                                        );
                                        if (result != null && result[0] != null && result[1] != null) {
                                          state.updateCategoryAndSubCategory(result[0]!, result[1]);
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
                                    final result = await context.push<List<Category?>>(Routes.MAIN_CATEGORY_PAGE);
                                    if (result != null && result[0] != null && result[1] != null) {
                                      state.updateCategoryAndSubCategory(result[0]!, result[1]);
                                    }
                                    return;
                                  },
                                ),
                                const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                AppTextFieldWidget(
                                  key: const Key('reform-menuSubCategory-textfield-widget'),
                                  controller: state.menuSubCategoryTextEditingController,
                                  readOnly: true,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
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
                                        final result = await context.push<List<Category?>>(Routes.MAIN_CATEGORY_PAGE);
                                        if (result != null && result[0] != null && result[1] != null) {
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
                                    final result = await context.push<List<Category?>>(Routes.MAIN_CATEGORY_PAGE);
                                    if (result != null && result[0] != null && result[1] != null) {
                                      //updateCategoryAndSubCategory(result[0]!, result[1]);
                                    }
                                    return;
                                  },
                                ),
                                const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                AppTextFieldWidget(
                                  key: const Key('reform-menu-name-textfield-widget'),
                                  controller: state.menuNameTextEditingController,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  focusNode: state.focusList[1],
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) =>
                                      fieldFocusChange(context, state.focusList[1], state.focusList[2]),
                                  keyboardType: TextInputType.name,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp('[a-z A-Z ]')),
                                    FilteringTextInputFormatter.deny('  ')
                                  ],
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
                                  onChanged: state.setMenuNameValue,
                                ),
                                const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                AppTextFieldWidget(
                                  key: const Key('reform-menu-description-textfield-widget'),
                                  controller: state.menuDescriptionTextEditingController,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  focusNode: state.focusList[2],
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  maxLines: 5,
                                  inputFormatters: [
                                    //FilteringTextInputFormatter.allow(RegExp('[a-z A-Z ]')),
                                    FilteringTextInputFormatter.deny('  ')
                                  ],
                                  readOnly: false,
                                  decoration: InputDecoration(
                                    labelText: 'Menu description',
                                    hintText: 'Enter either the description or about the ingredients of the menu.',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    isDense: true,
                                    enabled: true,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter menu description';
                                    }
                                    return null;
                                  },
                                  onChanged: state.setMenuDescriptionValue,
                                ),
                                const Divider(thickness: 0.8),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  children: [
                                    Wrap(
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Text(
                                          'Food preparation method',
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
                                          'Choose the cooking methods of your menu',
                                          style: context.labelMedium,
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate(),
                                      ],
                                    ),
                                  ],
                                ),
                                const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                MultiSelectAvailableFoodPreparationTypesFormField(
                                  key: const Key('reform-menu-multiSelectAvailableFoodPreparationTypes-formfield'),
                                  onSelectionChanged: state.updateSelectedFoodPreparationType,
                                  availableFoodPreparationTypesList: state._menuAvailableFoodCookingType.toList(),
                                  validator: (value) {
                                    if (value == null || value.length == 0) {
                                      return 'Select one or more food preparation type';
                                    } else {
                                      return null;
                                    }
                                  },
                                  isSingleSelect: true,
                                  maxSelection: 1,
                                  initialSelectedFoodPreparationTypesList: state._initialSelectedFoodPreparationType,
                                ),
                                const Divider(),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  children: [
                                    Wrap(
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Text(
                                          'Taste type',
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
                                          'Select the food taste type of your menu',
                                          style: context.labelMedium,
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate(),
                                      ],
                                    ),
                                  ],
                                ),
                                const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                MultiSelectTasteTypeFormField(
                                  key: const Key('reform-menu-multiSelectTasteType-formfield'),
                                  onSelectionChanged: state.menuTasteTypeSelection,
                                  availableTasteTypeList: state._menuTasteType.toList(),
                                  validator: (value) {
                                    if (value == null || value.length == 0) {
                                      return 'Select one or more taste type';
                                    } else {
                                      return null;
                                    }
                                  },
                                  initialSelectedTasteTypeList: state._initialSelectedTasteType,
                                  maxSelection: 1,
                                  isSingleSelect: true,
                                  onMaxSelected: (List<TasteType> selectedTasteTypes) {
                                    state._selectedTasteType = List<TasteType>.from(selectedTasteTypes);
                                    //setState(() {});
                                  },
                                ),
                                const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  children: [
                                    Wrap(
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Text(
                                          'Taste level',
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
                                          'Select the taste level of your menu',
                                          style: context.labelMedium,
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate(),
                                      ],
                                    ),
                                  ],
                                ),
                                const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                MultiSelectTasteLevelFormField(
                                  key: const Key('reform-menu-multiSelectAvailableTasteLevel-formfield'),
                                  onSelectionChanged: state.menuTasteLevelSelection,
                                  availableTasteLevelList: state._menuTasteLevel.toList(),
                                  validator: (value) {
                                    if (value == null || value.length == 0) {
                                      return 'Select one or more taste level';
                                    } else {
                                      return null;
                                    }
                                  },
                                  maxSelection: 1,
                                  isSingleSelect: true,
                                  initialSelectedTasteLevelList: state._initialSelectedTasteLevel,
                                ),
                                const Divider(),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  children: [
                                    Wrap(
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Text(
                                          'Portion size of menu',
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
                                          'Select the menu serving size or quantity availability',
                                          style: context.labelMedium,
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate(),
                                      ],
                                    ),
                                  ],
                                ),
                                const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                MultiSelectMenuPortionFormField(
                                  key: const Key('reform-menu-multiSelectAvailableMenuPortions-formfield'),
                                  onSelectionChanged: state.multiSelectionMenuPortion,
                                  availableMenuPortionList: state._menuPortions.toList(),
                                  validator: (value) {
                                    if (!state._hasCustomMenuPortionSize) {
                                      if (value == null || value.isEmpty) {
                                        return 'Select one or more portions';
                                      } else {
                                        return null;
                                      }
                                    }
                                    return null;
                                  },
                                  initialSelectedMenuPortionList: state._initialSelectedMenuPortions,
                                ),
                                Card(
                                  key: const Key('reform-custom-portion-widget'),
                                  margin: const EdgeInsetsDirectional.only(start: 0, end: 0, top: 4, bottom: 4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusDirectional.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    children: [
                                      SwitchListTile(
                                        onChanged: state.setCustomMenuSelection,
                                        value: state._hasCustomMenuPortionSize,
                                        title: Text(
                                          'Select your own portion size',
                                          style: context.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate(),
                                        isThreeLine: false,
                                        dense: true,
                                        controlAffinity: ListTileControlAffinity.leading,
                                        visualDensity: const VisualDensity(horizontal: -4, vertical: 0),
                                      ),
                                      AnimatedCrossFade(
                                        firstChild: const SizedBox.shrink(),
                                        secondChild: Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(8, 2, 8, 12),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                            children: [
                                              const AnimatedGap(8, duration: Duration(milliseconds: 500)),
                                              IntrinsicHeight(
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  textDirection:
                                                  serviceLocator<LanguageController>().targetTextDirection,
                                                  children: [
                                                    Expanded(
                                                      child: AppTextFieldWidget(
                                                        controller: state._menuPortionNameController,
                                                        textDirection:
                                                        serviceLocator<LanguageController>().targetTextDirection,
                                                        focusNode: state.focusList[3],
                                                        onFieldSubmitted: (_) =>
                                                            fieldFocusChange(
                                                                context, state.focusList[3], state.focusList[4]),
                                                        textInputAction: TextInputAction.next,
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          labelText: 'Your Portion name',
                                                          hintText: 'Enter your portion name',
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                          ),
                                                          isDense: true,
                                                        ),
                                                        validator: (value) {
                                                          if (state._hasCustomMenuPortionSize) {
                                                            if (value == null || value.isEmpty) {
                                                              return 'Please enter your portion name';
                                                            } else {
                                                              return null;
                                                            }
                                                          }
                                                          return null;
                                                        },
                                                        onSaved: (newValue) {
                                                          return state.setCustomPortionName();
                                                        },
                                                      ),
                                                    ),
                                                    //
                                                  ],
                                                ),
                                              ),
                                              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                              IntrinsicHeight(
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  textDirection:
                                                  serviceLocator<LanguageController>().targetTextDirection,
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: AppTextFieldWidget(
                                                        controller: state._menuPortionSizeController,
                                                        textDirection:
                                                        serviceLocator<LanguageController>().targetTextDirection,
                                                        focusNode: state.focusList[4],
                                                        textInputAction: TextInputAction.next,
                                                        onFieldSubmitted: (_) =>
                                                            fieldFocusChange(
                                                                context, state.focusList[4], state.focusList[5]),
                                                        keyboardType: const TextInputType.numberWithOptions(),
                                                        decoration: InputDecoration(
                                                          labelText: 'Portion value',
                                                          hintText: 'Enter portion value',
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                          ),
                                                          isDense: true,
                                                        ),
                                                        validator: (value) {
                                                          if (state._hasCustomMenuPortionSize) {
                                                            if (value == null || value.isEmpty) {
                                                              return 'Please enter portion value';
                                                            } else {
                                                              return null;
                                                            }
                                                          }
                                                          return null;
                                                        },
                                                        onSaved: (newValue) {
                                                          state.setCustomPortionSize();
                                                        },
                                                      ),
                                                    ),
                                                    const AnimatedGap(18, duration: Duration(milliseconds: 500)),
                                                    Expanded(
                                                      child: AppTextFieldWidget(
                                                        controller: state._menuPortionUnitController,
                                                        textDirection:
                                                        serviceLocator<LanguageController>().targetTextDirection,
                                                        focusNode: state.focusList[5],
                                                        textInputAction: TextInputAction.next,
                                                        onFieldSubmitted: (_) =>
                                                            fieldFocusChange(
                                                                context, state.focusList[5], state.focusList[6]),
                                                        keyboardType: TextInputType.text,
                                                        textCapitalization: TextCapitalization.words,
                                                        decoration: InputDecoration(
                                                          labelText: 'Unit',
                                                          hintText: 'Enter unit of menu',
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                          ),
                                                          isDense: true,
                                                        ),
                                                        validator: (value) {
                                                          if (state._hasCustomMenuPortionSize) {
                                                            if (value == null || value.isEmpty) {
                                                              return 'Please enter unit of menu';
                                                            } else {
                                                              return null;
                                                            }
                                                          }
                                                          return null;
                                                        },
                                                        onSaved: (newValue) {
                                                          state.setCustomPortionUnit();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                              IntrinsicHeight(
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  textDirection:
                                                  serviceLocator<LanguageController>().targetTextDirection,
                                                  children: [
                                                    Expanded(
                                                      child: AppTextFieldWidget(
                                                        controller: state._menuPortionMaximumServeController,
                                                        textDirection:
                                                        serviceLocator<LanguageController>().targetTextDirection,
                                                        focusNode: state.focusList[6],
                                                        textInputAction: TextInputAction.done,
                                                        keyboardType: const TextInputType.numberWithOptions(),
                                                        decoration: InputDecoration(
                                                          labelText: 'Maximum Serving Persons',
                                                          hintText: 'Enter maximum serving persons',
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                          ),
                                                          isDense: true,
                                                        ),
                                                        validator: (value) {
                                                          if (state._hasCustomMenuPortionSize) {
                                                            if (value == null || value.isEmpty) {
                                                              return 'Please enter maximum serving persons';
                                                            } else {
                                                              return null;
                                                            }
                                                          }
                                                          return null;
                                                        },
                                                        onSaved: (newValue) {
                                                          state.setCustomPortionMaximumServe();
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
                                        crossFadeState: (state._hasCustomMenuPortionSize == true)
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
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  children: [
                                    Wrap(
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Text(
                                          'Extras',
                                          style: context.titleLarge!.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate(),
                                      ],
                                    ),
                                    const AnimatedGap(2, duration: Duration(milliseconds: 500)),
                                    Wrap(
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Text(
                                          'Add customization options add to your menu item',
                                          style: context.labelMedium,
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate(),
                                      ],
                                    ),
                                    const AnimatedGap(8, duration: Duration(milliseconds: 500)),
                                    AnimatedCrossFade(
                                      duration: const Duration(milliseconds: 500),
                                      crossFadeState: (state._selectedAddons.isNotEmpty)
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      firstChild: MultiSelectAddonsFormField(
                                        key: const Key('reform-menu-multiSelectAvailableMenuAddons-formfield'),
                                        onSelectionChanged: state.addonSelection,
                                        availableAddonsList: state._selectedAddons.toList(),
                                        initialSelectedAddonsList: state._initialSelectedAddons,
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
                                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      ).translate(),
                                      onPressed: state.navigateToAddonsSelection,
                                    )
                                  ],
                                ),
                                const Divider(thickness: 0.8),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  children: [
                                    Wrap(
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Text(
                                          'Menu availability',
                                          style: context.titleLarge!.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate(),
                                      ],
                                    ),
                                    const AnimatedGap(2, duration: Duration(milliseconds: 500)),
                                    Wrap(
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Text(
                                          'Select menu availability day(s) and time',
                                          style: context.labelMedium,
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate(),
                                      ],
                                    ),
                                  ],
                                ),
                                const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                Text(
                                  'Select days',
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  style: context.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ).translate(),
                                const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                MultiSelectAvailableWorkingDaysFormField(
                                  key: const Key('reform-menu-working-days-widget'),
                                  onSelectionChanged: state.menuAvailableDaysSelection,
                                  availableWorkingDaysList: state._menuAvailableDays.toList(),
                                  validator: (value) {
                                    return ValidatorGroup<List<StoreWorkingDayAndTime>>([
                                      const RequiredValidator<List<StoreWorkingDayAndTime>>(
                                          errorMessage: 'Select valid time'),
                                      CustomValidator<List<StoreWorkingDayAndTime>>(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Select one or more days';
                                          }
                                          return null;
                                        },
                                      ),
                                    ]).validate(value);
                                  },
                                  initialSelectedAvailableWorkingDaysList: [],
                                ),
                                const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                Wrap(
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  children: [
                                    Text(
                                      'Select menu availability in time',
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      style: context.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ).translate(),
                                  ],
                                ),
                                const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  children: [
                                    Expanded(
                                      child: DateTimeFieldPlatform(
                                        key: const Key('reform-menu-available-from-time-widget'),
                                        mode: DateMode.time,
                                        maximumDate: DateTime.now().add(const Duration(hours: 2)),
                                        minimumDate: DateTime.now().subtract(const Duration(hours: 2)),
                                        controller: state._menuOpeningTimeController,
                                        decoration: InputDecoration(
                                          labelText: 'From',
                                          hintText: 'Select from time',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          suffixIcon: const Icon(
                                            Icons.arrow_drop_down,
                                          ),
                                          isDense: true,
                                          contentPadding:
                                          const EdgeInsetsDirectional.symmetric(vertical: 8, horizontal: 12),
                                        ),
                                        validator: (value) {
                                          return ValidatorGroup<String>([
                                            const RequiredValidator<String>(errorMessage: 'Select valid time'),
                                            CustomValidator<String>(
                                              validator: (value) {
                                                if (compareOpenAndCloseTime(
                                                    openingTime: state._menuOpeningTimeController.value.text.trim(),
                                                    closingTime:
                                                    state._menuClosingTimeController.value.text.trim())) {
                                                  return 'Select valid time';
                                                }
                                                return null;
                                              },
                                            ),
                                          ]).validate(value);
                                        },
                                        onSaved: (newValue) {
                                          state.menuAvailableOpeningTimeSelection();
                                        },
                                      ),
                                    ),
                                    const AnimatedGap(16, duration: Duration(milliseconds: 500)),
                                    Expanded(
                                      child: DateTimeFieldPlatform(
                                        key: const Key('menu-available-to-time-widget'),
                                        mode: DateMode.time,
                                        maximumDate: DateTime.now().add(const Duration(hours: 2)),
                                        minimumDate: DateTime.now().subtract(const Duration(hours: 2)),
                                        controller: state._menuClosingTimeController,
                                        decoration: InputDecoration(
                                          labelText: 'To',
                                          hintText: 'Select to time',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          suffixIcon: const Icon(
                                            Icons.arrow_drop_down,
                                          ),
                                          isDense: true,
                                          contentPadding:
                                          const EdgeInsetsDirectional.symmetric(vertical: 8, horizontal: 12),
                                        ),
                                        validator: (value) {
                                          return ValidatorGroup<String>([
                                            const RequiredValidator<String>(errorMessage: 'Select valid time'),
                                            CustomValidator<String>(
                                              validator: (value) {
                                                if (compareOpenAndCloseTime(
                                                    openingTime: state._menuOpeningTimeController.value.text.trim(),
                                                    closingTime:
                                                    state._menuClosingTimeController.value.text.trim())) {
                                                  return 'Select valid time';
                                                }
                                                return null;
                                              },
                                            ),
                                          ]).validate(value);
                                        },
                                        onSaved: (newValue) {
                                          state.menuAvailableClosingTimeSelection();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Column(
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Wrap(
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Text(
                                          'Menu preparation time',
                                          style: context.titleLarge!.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate(),
                                      ],
                                    ),
                                    const AnimatedGap(2, duration: Duration(milliseconds: 500)),
                                    Wrap(
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Text(
                                          'Select menu preparation or cooking time',
                                          style: context.labelMedium,
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate(),
                                      ],
                                    ),
                                  ],
                                ),
                                const AnimatedGap(8, duration: Duration(milliseconds: 500)),
                                MenuPreparationTimeWidget(
                                  key: const Key('reform-menu-preparation-minimum-time'),
                                  title: 'Minimum time',
                                  controller: state._menuMinPreparationTimeController,
                                  suffixIcon: IconButton(
                                    onPressed: state.menuMinPreparationTimeSelection,
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                    ),
                                  ),
                                  validator: (value) {
                                    return ValidatorGroup<String>([
                                      const RequiredValidator<String>(
                                          errorMessage: 'Select minimum preparation time'),
                                      CustomValidator<String>(
                                        validator: (value) {
                                          //final intInStr = RegExp(r'\d+');
                                          final maximumTime = int.parse(state
                                              ._menuMaxPreparationTimeController.value.text
                                              .trim()
                                              .replaceAll(RegExp(r'[^0-9]'), ''));
                                          final minimumTime = int.parse(state
                                              ._menuMinPreparationTimeController.value.text
                                              .trim()
                                              .replaceAll(RegExp(r'[^0-9]'), ''));
                                          if (minimumTime > maximumTime) {
                                            return 'Select valid minimum preparation time';
                                          }
                                          return null;
                                        },
                                      ),
                                    ]).validate(value);
                                  },
                                  onSaved: (newValue) {
                                    state.menuMinPreparationTimeSave();
                                  },
                                ),
                                const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                MenuPreparationTimeWidget(
                                  key: const Key('reform-menu-preparation-maximum-time'),
                                  title: 'Maximum time',
                                  controller: state._menuMaxPreparationTimeController,
                                  suffixIcon: IconButton(
                                    onPressed: state.menuMaxPreparationTimeSelection,
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                    ),
                                  ),
                                  validator: (value) {
                                    return ValidatorGroup<String>([
                                      const RequiredValidator<String>(
                                          errorMessage: 'Select maximum preparation time'),
                                      CustomValidator<String>(
                                        validator: (value) {
                                          final maximumTime = int.parse(state
                                              ._menuMaxPreparationTimeController.value.text
                                              .trim()
                                              .replaceAll(RegExp(r'[^0-9]'), ''));
                                          final minimumTime = int.parse(state
                                              ._menuMinPreparationTimeController.value.text
                                              .trim()
                                              .replaceAll(RegExp(r'[^0-9]'), ''));
                                          if (maximumTime < minimumTime) {
                                            return 'Select valid maximum preparation time';
                                          }
                                          return null;
                                        },
                                      ),
                                    ]).validate(value);
                                  },
                                  onSaved: (newValue) {
                                    state.menuMaxPreparationTimeSave();
                                  },
                                ),
                                const Divider(),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  children: [
                                    Text(
                                      'Stocks',
                                      style: context.titleLarge!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    ).translate(),
                                    const AnimatedGap(2, duration: Duration(milliseconds: 500)),
                                    Text(
                                      'Select menu minimum and maximum stock',
                                      style: context.labelMedium,
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    ).translate(),
                                  ],
                                ),
                                const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                AppTextFieldWidget(
                                  key: const Key('reform-menu-min-stock-widget'),
                                  controller: state._menuMinStockQuantityController,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  focusNode: state.focusList[7],
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) =>
                                      fieldFocusChange(context, state.focusList[7], state.focusList[8]),
                                  keyboardType: const TextInputType.numberWithOptions(),
                                  decoration: InputDecoration(
                                    labelText: 'Minimum Quantity',
                                    hintText: 'Enter minimum stock quantity',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    isDense: true,
                                  ),
                                  validator: state.stockMinQuantityValidation,
                                  onSaved: (newValue) {
                                    state.setMenuMinStockValue();
                                  },
                                ),
                                const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                AppTextFieldWidget(
                                  key: const Key('reform-menu-max-stock-widget'),
                                  controller: state._menuMaxStockQuantityController,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  focusNode: state.focusList[8],
                                  textInputAction: TextInputAction.done,
                                  keyboardType: const TextInputType.numberWithOptions(),
                                  decoration: InputDecoration(
                                    labelText: 'Maximum Quantity',
                                    hintText: 'Enter maximum stock quantity',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    isDense: true,
                                  ),
                                  validator: state.stockMaxQuantityValidation,
                                  onSaved: (newValue) {
                                    state.setMenuMaxStockValue();
                                  },
                                ),
                                const Divider(thickness: 0.8),
                              ],
                            )
                          ],
                        ),
                      ),
                      SliverFillRemaining(
                        fillOverscroll: true,
                        hasScrollBody: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          children: [
                            const Spacer(),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: ElevatedButton(
                                    onPressed: state.onSaveAndNext,
                                    style: ElevatedButton.styleFrom(
                                      //minimumSize: Size(180, 40),
                                      disabledBackgroundColor: const Color.fromRGBO(255, 219, 208, 1),
                                      disabledForegroundColor: Colors.white,
                                    ),
                                    child: Text(
                                      'Save & Next',
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    ).translate(),
                                  ),
                                ),
                              ],
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
