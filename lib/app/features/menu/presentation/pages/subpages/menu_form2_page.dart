part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuForm2Page extends StatefulWidget {
  const MenuForm2Page({super.key});

  @override
  State<MenuForm2Page> createState() => _MenuForm2PageState();
}

class _MenuForm2PageState extends State<MenuForm2Page> {
  late final ScrollController scrollController;

  List<StoreAvailableFoodTypes> _menuAvailableFoodTypes = [];
  List<StoreAvailableFoodPreparationType> _menuAvailableFoodCookingType = [];
  List<StoreWorkingDayAndTime> _menuAvailableDays = [];
  List<TasteType> _menuTasteType = [];
  List<TasteLevel> _menuTasteLevel = [];
  List<MenuPortion> _menuPortions = [];
  bool _hasCustomMenuPortionSize = false;
  final TextEditingController _menuPortionNameController = TextEditingController();
  final TextEditingController _menuPortionSizeController = TextEditingController();
  final TextEditingController _menuPortionUnitController = TextEditingController();

  List<StoreAvailableFoodTypes> _selectedFoodTypes = [];
  List<StoreAvailableFoodPreparationType> _selectedFoodPreparationType = [];
  List<StoreWorkingDayAndTime> _selectedWorkingDays = [];
  List<TasteType> _selectedTasteType = [];
  List<TasteLevel> _selectedTasteLevel = [];
  List<MenuPortion> _selectedMenuPortions = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
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
    initializeMenuAvailableFoodCookingType();
    initializeMenuAvailableDays();
    initializeMenuAvailableFoodTypes();
    initializeMenuTasteType();
    initializeMenuTasteLevel();
    initMenuPortions();
  }

  @override
  void dispose() {
    scrollController.dispose();
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
    super.dispose();
  }

  void initializeMenuAvailableFoodCookingType() {
    _menuAvailableFoodCookingType = List<StoreAvailableFoodPreparationType>.from(localStoreAvailableFoodPreparationType.toList());
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

  @override
  Widget build(BuildContext context) {
    return DynMouseScroll(
      builder: (context, controller, physics) {
        return ListView(
          controller: scrollController,
          //shrinkWrap: true,
          physics: physics,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Food types',
                  style: context.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
                const AnimatedGap(4, duration: Duration(milliseconds: 500)),
                Text(
                  'Select the food group of your menu in which its belongs',
                  style: context.labelMedium,
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
              ],
            ),
            const AnimatedGap(6, duration: Duration(milliseconds: 500)),
            MultiSelectAvailableFoodTypeFormField(
              key: const Key('store-menu-multiSelectAvailableFoodType-formfield'),
              onSelectionChanged: (List<StoreAvailableFoodTypes> selectedFoodTypes) {
                _selectedFoodTypes = List<StoreAvailableFoodTypes>.from(selectedFoodTypes);
                setState(() {});
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
              onSaved: (newValue) {},
            ),
            const AnimatedGap(12, duration: Duration(milliseconds: 500)),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Food preparation method',
                  style: context.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
                const AnimatedGap(4, duration: Duration(milliseconds: 500)),
                Text(
                  'Choose the cooking methods of your menu',
                  style: context.labelMedium,
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
              ],
            ),
            const AnimatedGap(6, duration: Duration(milliseconds: 500)),
            MultiSelectAvailableFoodPreparationTypesFormField(
              key: const Key('store-menu-multiSelectAvailableFoodPreparationTypes-formfield'),
              onSelectionChanged: (List<StoreAvailableFoodPreparationType> selectedPreparationTypes) {
                _selectedFoodPreparationType = List<StoreAvailableFoodPreparationType>.from(selectedPreparationTypes);
                setState(() {});
              },
              availableFoodPreparationTypesList: _menuAvailableFoodCookingType.toList(),
              validator: (value) {
                if (value == null || value.length == 0) {
                  return 'Select one or more food preparation type';
                } else {
                  return null;
                }
              },
              initialSelectedFoodPreparationTypesList: [],
              onSaved: (newValue) {},
            ),
            Divider(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Taste type',
                  style: context.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
                const AnimatedGap(4, duration: Duration(milliseconds: 500)),
                Text(
                  'Select the food taste type of your menu',
                  style: context.labelMedium,
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
              ],
            ),
            const AnimatedGap(6, duration: Duration(milliseconds: 500)),
            MultiSelectTasteTypeFormField(
              key: const Key('store-menu-multiSelectTasteType-formfield'),
              onSelectionChanged: (List<TasteType> selectedTasteTypes) {
                _selectedTasteType = List<TasteType>.from(selectedTasteTypes);
                setState(() {});
              },
              availableTasteTypeList: _menuTasteType.toList(),
              validator: (value) {
                if (value == null || value.length == 0) {
                  return 'Select one or more taste type';
                } else {
                  return null;
                }
              },
              initialSelectedTasteTypeList: [],
              onSaved: (newValue) {},
            ),
            const AnimatedGap(12, duration: Duration(milliseconds: 500)),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Taste level',
                  style: context.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
                const AnimatedGap(4, duration: Duration(milliseconds: 500)),
                Text(
                  'Select the taste level of your menu',
                  style: context.labelMedium,
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
              ],
            ),
            const AnimatedGap(6, duration: Duration(milliseconds: 500)),
            MultiSelectTasteLevelFormField(
              key: const Key('store-menu-multiSelectAvailableTasteLevel-formfield'),
              onSelectionChanged: (List<TasteLevel> selectedTasteLevel) {
                _selectedTasteLevel = List<TasteLevel>.from(selectedTasteLevel);
                setState(() {});
              },
              availableTasteLevelList: _menuTasteLevel.toList(),
              validator: (value) {
                if (value == null || value.length == 0) {
                  return 'Select one or more taste level';
                } else {
                  return null;
                }
              },
              initialSelectedTasteLevelList: [],
              onSaved: (newValue) {},
            ),
            Divider(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Portion size of menu',
                  style: context.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
                const AnimatedGap(4, duration: Duration(milliseconds: 500)),
                Text(
                  'Select the menu serving size or quantity availability',
                  style: context.labelMedium,
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
              ],
            ),
            const AnimatedGap(6, duration: Duration(milliseconds: 500)),
            MultiSelectMenuPortionFormField(
              key: const Key('store-menu-multiSelectAvailableMenuPortions-formfield'),
              onSelectionChanged: (List<MenuPortion> selectedMenuPortions) {
                _selectedMenuPortions = List<MenuPortion>.from(selectedMenuPortions);
                setState(() {});
              },
              availableMenuPortionList: _menuPortions.toList(),
              /* validator: (value) {
            if (value == null || value.length == 0) {
              return 'Select one or more taste level';
            } else {
              return null;
            }
          },*/
              initialSelectedMenuPortionList: [],
              onSaved: (newValue) {},
            ),
            Card(
              margin: EdgeInsetsDirectional.only(start: 0, end: 0, top: 4, bottom: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SwitchListTile(
                    onChanged: (value) {
                      setState(() {
                        _hasCustomMenuPortionSize = value;
                        _selectedMenuPortions.clear();
                        _selectedMenuPortions = [];
                      });
                    },
                    value: _hasCustomMenuPortionSize,
                    title: Text(
                      'Select your own portion size',
                      style: context.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                    ).translate(),
                    isThreeLine: false,
                    dense: true,
                    controlAffinity: ListTileControlAffinity.leading,
                    visualDensity: VisualDensity(horizontal: -4, vertical: 0),
                  ),
                  AnimatedCrossFade(
                    firstChild: SizedBox.shrink(),
                    secondChild: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 2, 8, 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const AnimatedGap(8, duration: Duration(milliseconds: 500)),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: StoreTextFieldWidget(
                                    controller: _menuPortionNameController,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: 'Size or Quantity name',
                                      hintText: 'Enter size or quantity name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      isDense: true,
                                    ),
                                    validator: (value) {
                                      if (_hasCustomMenuPortionSize) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter size or quantity name';
                                        } else {
                                          return null;
                                        }
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const AnimatedGap(18, duration: Duration(milliseconds: 500)),
                                Expanded(
                                  child: StoreTextFieldWidget(
                                    controller: _menuPortionUnitController,
                                    textInputAction: TextInputAction.next,
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
                                      if (_hasCustomMenuPortionSize) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter unit of menu';
                                        } else {
                                          return null;
                                        }
                                      }
                                      return null;
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
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              children: [
                                Expanded(
                                  child: StoreTextFieldWidget(
                                    controller: _menuPortionSizeController,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: 'Maximum Serving Persons',
                                      hintText: 'Enter maximum serving persons',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
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
                                  ),
                                ),
                                //
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    crossFadeState: (_hasCustomMenuPortionSize == true) ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 500),
                  ),
                ],
              ),
            ),
            const AnimatedGap(12, duration: Duration(milliseconds: 500)),
          ],
        );
      },
    );
  }
}
