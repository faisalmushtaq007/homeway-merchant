part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuForm3Page extends StatefulWidget {
  const MenuForm3Page({super.key,this.haveNewMenu = true,
    this.menuEntity,});
  final bool haveNewMenu;
  final MenuEntity? menuEntity;

  @override
  State<MenuForm3Page> createState() => _MenuForm3PageState();
}

class _MenuForm3PageState extends State<MenuForm3Page> with AutomaticKeepAliveClientMixin<MenuForm3Page> {
  late final ScrollController scrollController;

  List<StoreWorkingDayAndTime> _menuAvailableDays = [];
  List<StoreWorkingDayAndTime> _selectedWorkingDays = [];
  final TextEditingController _menuOpeningTimeController = TextEditingController();
  final TextEditingController _menuClosingTimeController = TextEditingController();
  late final MaskTextInputFormatter maximumDeliveryTimeFormatter;
  final TextEditingController _menuMinPreparationTimeController = TextEditingController();
  final TextEditingController _menuMaxPreparationTimeController = TextEditingController();
  final TextEditingController _menuMinStockQuantityController = TextEditingController(text: '1');
  final TextEditingController _menuMaxStockQuantityController = TextEditingController();

  //List<Timing> _menuAvailablePreparationTimings = [];
  List<String> _menuAvailablePreparationTimings = [];
  Timing? _menuPreparationTiming;
  Stock? _menuStock;
  List<FocusNode> menuForm3FocusList = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    menuForm3FocusList = [
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
    _menuAvailableDays = [];
    _selectedWorkingDays = [];
    _menuAvailablePreparationTimings = [];
    maximumDeliveryTimeFormatter = MaskTextInputFormatter(mask: '##', filter: {'#': RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);
    initializeMenuWorkingDays();
    initializeMenuAvailableTimings();
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
    /*_menuOpeningTimeController.dispose();
    _menuClosingTimeController.dispose();
    _menuMinPreparationTimeController.dispose();
    _menuMaxPreparationTimeController.dispose();
    _menuMinStockQuantityController.dispose();
    _menuMaxStockQuantityController.dispose();
    menuForm3FocusList.asMap().forEach((key, value) => value.dispose());
    _menuAvailablePreparationTimings = [];
    _menuAvailableDays = [];
    _selectedWorkingDays = [];*/
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  void initializeMenuWorkingDays() {
    _menuAvailableDays = List<StoreWorkingDayAndTime>.from(localStoreWorkingDays.toList());
  }

  void initializeMenuAvailableTimings() {
    _menuAvailablePreparationTimings = List<String>.from(localTimings.toList());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: BlocBuilder<MenuBloc, MenuState>(
        key: const Key('menu-form3-page-bloc-builder-widget'),
        bloc: context.watch<MenuBloc>(),
        builder: (context, state) {
          if (state is PushMenuEntityDataState && state.menuFormStage is MenuForm3Page) {}
          if (state is PullMenuEntityDataState && state.menuFormStage is MenuForm3Page) {}
          return Column(
            //controller: scrollController,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            textDirection: serviceLocator<LanguageController>().targetTextDirection,
            children: [
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
                onSelectionChanged: (List<StoreWorkingDayAndTime> selectedWorkingDays) {
                  _selectedWorkingDays = List<StoreWorkingDayAndTime>.from(selectedWorkingDays);
                  appLog.d('Winner ${_selectedWorkingDays.length}');
                  var cacheMenuAvailableDayAndTime =
                      List<MenuAvailableDayAndTime>.from(_selectedWorkingDays.map((e) => MenuAvailableDayAndTime.fromMap(e.toMap())).toList());
                  serviceLocator<MenuEntity>().menuAvailableInDays = cacheMenuAvailableDayAndTime.toList();
                  setState(() {});
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form3,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
                },
                availableWorkingDaysList: _menuAvailableDays.toList(),
                validator: (value) {
                  return ValidatorGroup<List<StoreWorkingDayAndTime>>([
                    const RequiredValidator<List<StoreWorkingDayAndTime>>(errorMessage: 'Select valid time'),
                    CustomValidator<List<StoreWorkingDayAndTime>>(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select one or more days';
                        }
                        return null;
                      },
                    ),
                  ]).validate(value);
                  if (value == null || value.length == 0) {
                    return 'Select one or more days';
                  } else {
                    return null;
                  }
                },
                initialSelectedAvailableWorkingDaysList: [],
                onSaved: (newValue) {
                  var cacheMenuAvailableDayAndTime =
                      List<MenuAvailableDayAndTime>.from(_selectedWorkingDays.map((e) => MenuAvailableDayAndTime.fromMap(e.toMap())).toList());
                  serviceLocator<MenuEntity>().menuAvailableInDays = cacheMenuAvailableDayAndTime.toList();
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form3,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
                },
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
                      key: const Key('menu-available-from-time-widget'),
                      mode: DateMode.time,
                      maximumDate: DateTime.now().add(const Duration(hours: 2)),
                      minimumDate: DateTime.now().subtract(const Duration(hours: 2)),
                      controller: _menuOpeningTimeController,
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
                        contentPadding: const EdgeInsetsDirectional.symmetric(vertical: 8, horizontal: 12),
                      ),
                      validator: (value) {
                        return ValidatorGroup<String>([
                          const RequiredValidator<String>(errorMessage: 'Select valid time'),
                          CustomValidator<String>(
                            validator: (value) {
                              if (compareOpenAndCloseTime(
                                  openingTime: _menuOpeningTimeController.value.text.trim(), closingTime: _menuClosingTimeController.value.text.trim())) {
                                return 'Select valid time';
                              }
                              return null;
                            },
                          ),
                        ]).validate(value);
                      },
                      onSaved: (newValue) {
                        serviceLocator<MenuEntity>().menuAvailableFromTime = _menuOpeningTimeController.value.text.trim();
                        context.read<MenuBloc>().add(
                              PushMenuEntityData(
                                menuEntity: serviceLocator<MenuEntity>(),
                                menuFormStage: MenuFormStage.form3,
                                menuEntityStatus: MenuEntityStatus.push,
                              ),
                            );
                      },
                      onEditingComplete: () {},
                      onFieldSubmitted: (value) {},
                      onChanged: (value) {
                        serviceLocator<MenuEntity>().menuAvailableFromTime = value;
                        context.read<MenuBloc>().add(
                              PushMenuEntityData(
                                menuEntity: serviceLocator<MenuEntity>(),
                                menuFormStage: MenuFormStage.form3,
                                menuEntityStatus: MenuEntityStatus.push,
                              ),
                            );
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
                      controller: _menuClosingTimeController,
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
                        contentPadding: const EdgeInsetsDirectional.symmetric(vertical: 8, horizontal: 12),
                      ),
                      validator: (value) {
                        return ValidatorGroup<String>([
                          const RequiredValidator<String>(errorMessage: 'Select valid time'),
                          CustomValidator<String>(
                            validator: (value) {
                              if (compareOpenAndCloseTime(
                                  openingTime: _menuOpeningTimeController.value.text.trim(), closingTime: _menuClosingTimeController.value.text.trim())) {
                                return 'Select valid time';
                              }
                              return null;
                            },
                          ),
                        ]).validate(value);
                      },
                      onSaved: (newValue) {
                        serviceLocator<MenuEntity>().menuAvailableToTime = _menuClosingTimeController.value.text.trim();
                        context.read<MenuBloc>().add(
                              PushMenuEntityData(
                                menuEntity: serviceLocator<MenuEntity>(),
                                menuFormStage: MenuFormStage.form3,
                                menuEntityStatus: MenuEntityStatus.push,
                              ),
                            );
                      },
                      onEditingComplete: () {},
                      onFieldSubmitted: (value) {},
                      onChanged: (value) {
                        serviceLocator<MenuEntity>().menuAvailableToTime = value;
                        context.read<MenuBloc>().add(
                              PushMenuEntityData(
                                menuEntity: serviceLocator<MenuEntity>(),
                                menuFormStage: MenuFormStage.form3,
                                menuEntityStatus: MenuEntityStatus.push,
                              ),
                            );
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
                key: const Key('menu-preparation-minimum-time'),
                title: 'Minimum time',
                controller: _menuMinPreparationTimeController,
                suffixIcon: IconButton(
                  onPressed: () async {
                    final String? timing = await selectTiming(context);
                    if (timing != null) {
                      setState(() {
                        _menuMinPreparationTimeController.text = timing ?? '';
                        final cacheMenuTiming = _menuPreparationTiming?.copyWith(
                          minPreparingTime: _menuMinPreparationTimeController.value.text.trim(),
                        );
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down,
                  ),
                ),
                validator: (value) {
                  return ValidatorGroup<String>([
                    const RequiredValidator<String>(errorMessage: 'Select minimum preparation time'),
                    CustomValidator<String>(
                      validator: (value) {
                        //final intInStr = RegExp(r'\d+');
                        final maximumTime = int.parse(_menuMaxPreparationTimeController.value.text.trim().replaceAll(RegExp(r'[^0-9]'), ''));
                        final minimumTime = int.parse(_menuMinPreparationTimeController.value.text.trim().replaceAll(RegExp(r'[^0-9]'), ''));
                        if (minimumTime > maximumTime) {
                          return 'Select valid minimum preparation time';
                        }
                        return null;
                      },
                    ),
                  ]).validate(value);
                },
                onChanged: (value) {
                  serviceLocator<MenuEntity>().menuMinPreparationTime = value;
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form3,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
                },
                onSaved: (newValue) {
                  serviceLocator<MenuEntity>().menuMinPreparationTime = _menuMinPreparationTimeController.value.text.trim();
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form3,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
                },
              ),
              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
              MenuPreparationTimeWidget(
                key: const Key('menu-preparation-maximum-time'),
                title: 'Maximum time',
                controller: _menuMaxPreparationTimeController,
                suffixIcon: IconButton(
                  onPressed: () async {
                    final String? timing = await selectTiming(context);
                    if (timing != null) {
                      setState(() {
                        _menuMaxPreparationTimeController.text = timing ?? '';
                        final cacheMenuTiming = _menuPreparationTiming?.copyWith(
                          minPreparingTime: _menuMaxPreparationTimeController.value.text.trim(),
                        );
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down,
                  ),
                ),
                validator: (value) {
                  return ValidatorGroup<String>([
                    const RequiredValidator<String>(errorMessage: 'Select maximum preparation time'),
                    CustomValidator<String>(
                      validator: (value) {
                        final maximumTime = int.parse(_menuMaxPreparationTimeController.value.text.trim().replaceAll(RegExp(r'[^0-9]'), ''));
                        final minimumTime = int.parse(_menuMinPreparationTimeController.value.text.trim().replaceAll(RegExp(r'[^0-9]'), ''));
                        if (maximumTime < minimumTime) {
                          return 'Select valid maximum preparation time';
                        }
                        return null;
                      },
                    ),
                  ]).validate(value);
                },
                onChanged: (value) {
                  serviceLocator<MenuEntity>().menuMaxPreparationTime = value;
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form3,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
                },
                onSaved: (newValue) {
                  serviceLocator<MenuEntity>().menuMaxPreparationTime = _menuMaxPreparationTimeController.value.text.trim();
                  context.read<MenuBloc>().add(
                        PushMenuEntityData(
                          menuEntity: serviceLocator<MenuEntity>(),
                          menuFormStage: MenuFormStage.form3,
                          menuEntityStatus: MenuEntityStatus.push,
                        ),
                      );
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
              Directionality(
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                child: AppTextFieldWidget(
                  controller: _menuMinStockQuantityController,
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  focusNode: menuForm3FocusList[0],
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => fieldFocusChange(context, menuForm3FocusList[0], menuForm3FocusList[1]),
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    labelText: 'Minimum Quantity',
                    hintText: 'Enter minimum stock quantity',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    isDense: true,
                  ),
                  validator: (value) {
                    return ValidatorGroup<String>([
                      const RequiredValidator<String>(errorMessage: 'Enter minimum stock quantity'),
                      CustomValidator<String>(
                        validator: (value) {
                          final maximumStockValue = int.parse(_menuMaxStockQuantityController.value.text.trim().replaceAll(RegExp(r'[^0-9]'), ''));
                          final minimumStockValue = int.parse(_menuMinStockQuantityController.value.text.trim().replaceAll(RegExp(r'[^0-9]'), ''));
                          if (minimumStockValue > maximumStockValue) {
                            return 'Enter valid minimum quantity';
                          }
                          return null;
                        },
                      ),
                    ]).validate(value);
                  },
                  onChanged: (value) {
                    serviceLocator<MenuEntity>().minStockAvailable = int.tryParse(value) ?? 0;
                    context.read<MenuBloc>().add(
                          PushMenuEntityData(
                            menuEntity: serviceLocator<MenuEntity>(),
                            menuFormStage: MenuFormStage.form3,
                            menuEntityStatus: MenuEntityStatus.push,
                          ),
                        );
                  },
                  onSaved: (newValue) {
                    serviceLocator<MenuEntity>().minStockAvailable = int.tryParse(_menuMinStockQuantityController.value.text.trim()) ?? 0;
                    context.read<MenuBloc>().add(
                          PushMenuEntityData(
                            menuEntity: serviceLocator<MenuEntity>(),
                            menuFormStage: MenuFormStage.form3,
                            menuEntityStatus: MenuEntityStatus.push,
                          ),
                        );
                  },
                ),
              ),
              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
              Directionality(
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                child: AppTextFieldWidget(
                  controller: _menuMaxStockQuantityController,
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  focusNode: menuForm3FocusList[1],
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
                  validator: (value) {
                    return ValidatorGroup<String>([
                      const RequiredValidator<String>(errorMessage: 'Enter maximum stock quantity'),
                      CustomValidator<String>(
                        validator: (value) {
                          final maximumStockValue = int.parse(_menuMaxStockQuantityController.value.text.trim().replaceAll(RegExp(r'[^0-9]'), ''));
                          final minimumStockValue = int.parse(_menuMinStockQuantityController.value.text.trim().replaceAll(RegExp(r'[^0-9]'), ''));
                          if (maximumStockValue < minimumStockValue) {
                            return 'Enter valid maximum quantity';
                          }
                          return null;
                        },
                      ),
                    ]).validate(value);
                  },
                  onChanged: (value) {
                    serviceLocator<MenuEntity>().maxStockAvailable = int.tryParse(value) ?? 0;
                    context.read<MenuBloc>().add(
                          PushMenuEntityData(
                            menuEntity: serviceLocator<MenuEntity>(),
                            menuFormStage: MenuFormStage.form3,
                            menuEntityStatus: MenuEntityStatus.push,
                          ),
                        );
                  },
                  onSaved: (newValue) {
                    serviceLocator<MenuEntity>().maxStockAvailable = int.tryParse(_menuMaxStockQuantityController.value.text.trim()) ?? 0;
                    context.read<MenuBloc>().add(
                          PushMenuEntityData(
                            menuEntity: serviceLocator<MenuEntity>(),
                            menuFormStage: MenuFormStage.form3,
                            menuEntityStatus: MenuEntityStatus.push,
                          ),
                        );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<String?> selectTiming(
    BuildContext context,
  ) async {
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
            top: (index == 0) ? BorderSide(color: Theme.of(context).dividerColor) : BorderSide.none, bottom: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: ListTile(
        dense: true,
        minVerticalPadding: 0,
        minLeadingWidth: 0,
        horizontalTitleGap: 0,
        visualDensity: const VisualDensity(vertical: -1, horizontal: 0),
        title: Text(
          '${_menuAvailablePreparationTimings[index]}',
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
}
