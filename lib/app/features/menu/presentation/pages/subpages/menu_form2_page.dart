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
  List<FocusNode> menuForm2FocusList = [];
  bool _haveAddonsWithCurrentMenu = false;
  List<Addons> _selectedAddons = [];
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
    menuForm2FocusList.asMap().forEach((key, value) => value.dispose());
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                focusNode: menuForm2FocusList[0],
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) => fieldFocusChange(context, menuForm2FocusList[0], menuForm2FocusList[1]),
                                keyboardType: TextInputType.numberWithOptions(),
                                decoration: InputDecoration(
                                  labelText: 'Size or Portion value',
                                  hintText: 'Enter size or portion value',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  isDense: true,
                                ),
                                validator: (value) {
                                  if (_hasCustomMenuPortionSize) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter size or portion value';
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
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                focusNode: menuForm2FocusList[1],
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) => fieldFocusChange(context, menuForm2FocusList[1], menuForm2FocusList[2]),
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
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                focusNode: menuForm2FocusList[2],
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.numberWithOptions(),
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
          ],
        ),
        const AnimatedGap(8, duration: Duration(milliseconds: 500)),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 500),
          crossFadeState: (_selectedAddons.isNotEmpty && selectedAddonsWidgets.isNotEmpty) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: Wrap(
            spacing: 6,
            runSpacing: 0,
            textDirection: serviceLocator<LanguageController>().targetTextDirection,
            children: selectedAddonsWidgets.toList(),
          ),
          secondChild: OutlinedButton(
            style: OutlinedButton.styleFrom(
              visualDensity: VisualDensity(vertical: -1, horizontal: 0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            child: Text('Select Adons').translate(),
            onPressed: () async {
              final List<Addons>? addons = await context.push<List<Addons>>(Routes.MENU_ADDONS_PAGE);
              debugPrint('List of addons ${addons}');
              if (addons != null && addons.isNotEmpty) {
                setState(() {
                  _selectedAddons = List<Addons>.from(addons.toList());
                  for (var item in _selectedAddons) {
                    selectedAddonsWidgets.add(
                      StatefulBuilder(
                        builder: (context,setState) {
                          return InputChip(
                            label: Text(
                              '${item.title} ${item.unit}',
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            ),
                            selected: _selectedAddons.contains(item),
                            showCheckmark: false,
                            onSelected: (selected) {
                              setState(() {
                                _selectedAddons.contains(item) ? _selectedAddons.remove(item) : _selectedAddons.add(item);
                              });
                            },
                            onDeleted: () {
                              setState(() {
                                _selectedAddons.remove(item);
                              });
                            },
                          );
                        },
                      ),
                    );
                  }
                });
              }
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _buildAddonsChoiceList(BuildContext context) {
    List<Widget> choices = [];

    for (var item in _selectedAddons) {
      choices.add(
        InputChip(
          label: Text(
            '${item.title} ${item.unit}',
            textDirection: serviceLocator<LanguageController>().targetTextDirection,
          ),
          selected: _selectedAddons.contains(item),
          onSelected: (selected) {
            setState(() {
              _selectedAddons.contains(item) ? _selectedAddons.remove(item) : _selectedAddons.add(item);
            });
          },
        ),
      );
    }

    return choices;
  }
}
