part of 'package:homemakers_merchant/app/features/menu/index.dart';

class SaveAddonsPage extends StatefulWidget {
  const SaveAddonsPage({
    super.key,
    this.haveNewAddons = true,
    this.haveOwnAddons = true,
    this.addons,
    this.currentIndex = -1,
    this.pageKey = 1,
    this.pageSize = 10,
    this.searchItem,
  });

  final bool haveNewAddons;
  final bool haveOwnAddons;
  final Addons? addons;
  final int currentIndex;
  final int pageKey;
  final int pageSize;
  final String? searchItem;

  @override
  _SaveAddonsPageController createState() => _SaveAddonsPageController();
}

class _SaveAddonsPageController extends State<SaveAddonsPage> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  late final ScrollController listViewBuilderScrollController;

  static final GlobalKey<FormState> saveAddonsFormKey =
      GlobalKey<FormState>(debugLabel: 'save_addons-formkey');
  List<FocusNode> focusList = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];
  final TextEditingController addonsNameTextEditingController =
      TextEditingController();
  final TextEditingController addonsDescriptionTextEditingController =
      TextEditingController();
  final TextEditingController addonsPriceTextEditingController =
      TextEditingController();
  final TextEditingController addonsQuantityTextEditingController =
      TextEditingController();
  final TextEditingController addonsUnitTextEditingController =
      TextEditingController();
  List<MenuPortion> _menuPortions = [];
  List<MenuPortion> _selectedMenuPortions = [];
  String currency = 'SAR';
  String unit = '';
  String addonsImagePath = '';

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    listViewBuilderScrollController = ScrollController();
    _menuPortions = [];
    _selectedMenuPortions = [];
    initMenuPortions();
    initAddonsData(widget.addons);
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    addonsPriceTextEditingController.dispose();
    addonsNameTextEditingController.dispose();
    addonsDescriptionTextEditingController.dispose();
    addonsQuantityTextEditingController.dispose();
    addonsUnitTextEditingController.dispose();
    _menuPortions = [];
    _selectedMenuPortions = [];
    focusList.asMap().forEach((key, value) => value.dispose());
    listViewBuilderScrollController.dispose();
    innerScrollController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void initMenuPortions() {
    _menuPortions = List<MenuPortion>.from(localMenuPortions.toList());
  }

  void initAddonsData(Addons? addons) {
    if (addons.isNotNull) {
      addonsPriceTextEditingController.text =
          (addons?.finalPrice ?? 0.0).toString();
      addonsNameTextEditingController.text = addons?.title ?? '';
      addonsDescriptionTextEditingController.text = addons?.description ?? '';
      addonsQuantityTextEditingController.text =
          (addons?.quantity ?? 0.0).toString();
      addonsUnitTextEditingController.text = addons?.unit ?? '';
    }
  }

  void onSelectionChangedPortion(List<MenuPortion> selectedMenuPortions) {
    context.read<MenuBloc>().add(
          SelectAddonsMaxPortion(
            selectedMenuPortions: selectedMenuPortions.toList(),
          ),
        );
    return;
  }

  void onMaxSelectedPortion(List<MenuPortion> selectedMenuPortions) {
    context.read<MenuBloc>().add(
          SelectAddonsMaxPortion(
            selectedMenuPortions: selectedMenuPortions.toList(),
          ),
        );
    return;
  }

  void _nextButtonOnPressed() {
    return;
  }

  void updateAddonsProfileImage(String addonsImage) {
    addonsImagePath = addonsImage;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => BlocListener<MenuBloc, MenuState>(
        key: const Key('save-addons-bloclistener-widget'),
        bloc: context.watch<MenuBloc>(),
        listener: (context, state) {
          if (state is NavigateToAddonsMenuState) {
            context.pushReplacement(
              Routes.NEW_ADDONS_GREETING_PAGE,
              extra: state.addonsEntity,
            );
          }
        },
        child: BlocBuilder<MenuBloc, MenuState>(
          key: const Key('save-addons-blocbuilder-widget'),
          bloc: context.watch<MenuBloc>(),
          builder: (context, addonsState) {
            switch (addonsState) {
              case SelectAddonsMaxPortionState():
                {
                  _selectedMenuPortions = List<MenuPortion>.from(
                      addonsState.selectedMenuPortions.toList());
                  addonsQuantityTextEditingController.text = addonsState
                      .selectedMenuPortions.first.quantity
                      .toString();
                  addonsPriceTextEditingController.text = addonsState
                      .selectedMenuPortions.first.finalPrice
                      .toString();
                  addonsUnitTextEditingController.text =
                      addonsState.selectedMenuPortions.first.unit.toString();
                  currency = addonsState.selectedMenuPortions.first.currency
                      .toString();
                  unit = addonsState.selectedMenuPortions.first.unit.toString();
                }
              case _:
                debugPrint('default');
            }
            return _SaveAddonsPageView(this);
          },
        ),
      );
}

class _SaveAddonsPageView
    extends WidgetView<SaveAddonsPage, _SaveAddonsPageController> {
  const _SaveAddonsPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding =
        margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = media.padding.bottom + margins;
    final double width = media.size.width;
    final ThemeData theme = Theme.of(context);
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: FlexColorScheme.themedSystemNavigationBar(
          context,
          useDivider: false,
          opacity: 0.60,
          noAppBar: true,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text(
              'Addons',
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
            ),
            actions: const [
              NotificationIconWidget(),
              LanguageSelectionWidget(),
            ],
          ),
          body: SlideInLeft(
            key: const Key('save-addons-slideinleft-widget'),
            delay: const Duration(milliseconds: 500),
            from: context.width - 40,
            child: PageBody(
              controller: state.scrollController,
              constraints: BoxConstraints(
                minWidth: 1000,
                minHeight: media.size.height,
              ),
              child: CustomScrollView(
                controller: state.innerScrollController,
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const AnimatedGap(50,
                            duration: Duration(milliseconds: 500)),
                        AnimatedContainer(
                          height: context.height * 0.7,
                          margin: EdgeInsetsDirectional.only(
                            start: margins * 1.5,
                            end: margins * 1.5,
                          ),
                          padding: EdgeInsetsDirectional.only(
                            start: margins * 2.25,
                            end: margins * 2.25,
                            top: margins * 2.25,
                            //bottom: margins,
                          ),
                          duration: const Duration(
                            milliseconds: 500,
                          ),
                          decoration: BoxDecoration(
                            color: context.colorScheme.background,
                            borderRadius: BorderRadiusDirectional.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 3),
                                blurRadius: 12,
                                color: Color.fromRGBO(
                                  0,
                                  0,
                                  0,
                                  0.16,
                                ),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AbsorbPointer(
                                child: GestureDetector(
                                  child: SizedBox(
                                    height: 26,
                                    child: Stack(
                                      alignment: AlignmentDirectional.topCenter,
                                      clipBehavior: Clip.none,
                                      children: [
                                        AnimatedPositioned(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          top: -54,
                                          child: DisplayImage(
                                            imagePath: state.addonsImagePath,
                                            onPressed: () async {
                                              final result =
                                                  await UploadImageUtils()
                                                      .selectImagePicker(
                                                          context);
                                              if (result.imagePath.isNotEmpty) {
                                                state.updateAddonsProfileImage(
                                                    result.imagePath);
                                              } else {}
                                            },
                                            hasIconImage:
                                                state.addonsImagePath.isEmpty
                                                    ? true
                                                    : false,
                                            hasEditButton: false,
                                            hasCustomIcon:
                                                state.addonsImagePath.isEmpty
                                                    ? true
                                                    : false,
                                            customIcon: Icon(Icons.camera_alt),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    final result = await UploadImageUtils()
                                        .selectImagePicker(context);
                                    if (result.imagePath.isNotEmpty) {
                                      state.updateAddonsProfileImage(
                                          result.imagePath);
                                    } else {}
                                  },
                                ),
                                absorbing: false,
                              ),
                              /*Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  AnimatedSwitcher(
                                    duration: const Duration(
                                      milliseconds: 500,
                                    ),
                                    child: Text(
                                      '${((!widget.haveNewAddons || widget.haveOwnAddons != true) && widget.addons?.title != null) ? widget.addons?.title : 'Add New Addons'}',
                                      style: context.titleLarge!.copyWith(
                                        color: context.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ).translate(),
                                  ),
                                ],
                              ),*/
                              //const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                              Expanded(
                                flex: 3,
                                child: Form(
                                  key: _SaveAddonsPageController
                                      .saveAddonsFormKey,
                                  child: ListView(
                                    controller:
                                        state.listViewBuilderScrollController,
                                    physics: const ClampingScrollPhysics(),
                                    //shrinkWrap: true,
                                    children: [
                                      const AnimatedGap(12,
                                          duration:
                                              Duration(milliseconds: 500)),
                                      AppTextFieldWidget(
                                        controller: state
                                            .addonsNameTextEditingController,
                                        textDirection:
                                            serviceLocator<LanguageController>()
                                                .targetTextDirection,
                                        focusNode: state.focusList[0],
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (_) =>
                                            fieldFocusChange(
                                                context,
                                                state.focusList[0],
                                                state.focusList[1]),
                                        keyboardType: TextInputType.name,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[a-z A-Z ]')),
                                          FilteringTextInputFormatter.deny('  ')
                                        ],
                                        decoration: InputDecoration(
                                          labelText: 'Addons name',
                                          hintText: 'Enter addons name',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          isDense: true,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter addons name';
                                          }
                                          return null;
                                        },
                                      ),
                                      const AnimatedGap(12,
                                          duration:
                                              Duration(milliseconds: 500)),
                                      AppTextFieldWidget(
                                        controller: state
                                            .addonsDescriptionTextEditingController,
                                        textDirection:
                                            serviceLocator<LanguageController>()
                                                .targetTextDirection,
                                        focusNode: state.focusList[1],
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (_) =>
                                            fieldFocusChange(
                                                context,
                                                state.focusList[1],
                                                state.focusList[2]),
                                        keyboardType: TextInputType.text,
                                        maxLines: 3,
                                        decoration: InputDecoration(
                                          labelText: 'Addons Description',
                                          hintText: 'Enter addons description',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                      const AnimatedGap(12,
                                          duration:
                                              Duration(milliseconds: 500)),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            'Portion the size of addons',
                                            style: context.titleLarge!.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                            textDirection: serviceLocator<
                                                    LanguageController>()
                                                .targetTextDirection,
                                          ).translate(),
                                          const AnimatedGap(4,
                                              duration:
                                                  Duration(milliseconds: 500)),
                                          Text(
                                            'Select the addons serving size or quantity availability',
                                            style: context.labelMedium,
                                            textDirection: serviceLocator<
                                                    LanguageController>()
                                                .targetTextDirection,
                                          ).translate(),
                                        ],
                                      ),
                                      const AnimatedGap(6,
                                          duration:
                                              Duration(milliseconds: 500)),
                                      MultiSelectMenuPortionFormField(
                                        key: const Key(
                                            'menu-addons-multiSelectAvailableMenuPortions-formfield'),
                                        onSelectionChanged:
                                            state.onSelectionChangedPortion,
                                        availableMenuPortionList:
                                            state._menuPortions.toList(),
                                        initialSelectedMenuPortionList: [],
                                        onSaved: (newValue) {},
                                        isSingleSelect: true,
                                      ),
                                      const AnimatedGap(12,
                                          duration:
                                              Duration(milliseconds: 500)),
                                      IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: AppTextFieldWidget(
                                                controller: state
                                                    .addonsQuantityTextEditingController,
                                                textDirection: serviceLocator<
                                                        LanguageController>()
                                                    .targetTextDirection,
                                                focusNode: state.focusList[2],
                                                textInputAction:
                                                    TextInputAction.next,
                                                onFieldSubmitted: (_) =>
                                                    fieldFocusChange(
                                                        context,
                                                        state.focusList[2],
                                                        state.focusList[3]),
                                                keyboardType:
                                                    const TextInputType
                                                        .numberWithOptions(
                                                  decimal: true,
                                                ),
                                                decoration: InputDecoration(
                                                  labelText: 'Quantity',
                                                  hintText:
                                                      'Enter addons quantity',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  isDense: true,
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Enter addons quantity';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            const AnimatedGap(24,
                                                duration: Duration(
                                                    milliseconds: 500)),
                                            Expanded(
                                              child: AppTextFieldWidget(
                                                controller: state
                                                    .addonsUnitTextEditingController,
                                                textDirection: serviceLocator<
                                                        LanguageController>()
                                                    .targetTextDirection,
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                focusNode: state.focusList[3],
                                                textInputAction:
                                                    TextInputAction.next,
                                                onFieldSubmitted: (_) =>
                                                    fieldFocusChange(
                                                        context,
                                                        state.focusList[3],
                                                        state.focusList[4]),
                                                keyboardType:
                                                    TextInputType.name,
                                                decoration: InputDecoration(
                                                  labelText: 'Units',
                                                  hintText:
                                                      'Enter addons units',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  isDense: true,
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Enter addons units';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const AnimatedGap(12,
                                          duration:
                                              Duration(milliseconds: 500)),
                                      AppTextFieldWidget(
                                        controller: state
                                            .addonsPriceTextEditingController,
                                        textDirection:
                                            serviceLocator<LanguageController>()
                                                .targetTextDirection,
                                        focusNode: state.focusList[4],
                                        textInputAction: TextInputAction.done,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(
                                          decimal: true,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Addons Price',
                                          hintText: 'Enter addons price',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          isDense: true,
                                          suffixText: state.currency,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter addons price';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const AnimatedGap(6,
                                  duration: Duration(milliseconds: 500)),
                            ],
                          ),
                        ),
                        const AnimatedGap(12,
                            duration: Duration(milliseconds: 500)),
                        Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: margins * 1.5),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_SaveAddonsPageController
                                  .saveAddonsFormKey.currentState!
                                  .validate()) {
                                _SaveAddonsPageController
                                    .saveAddonsFormKey.currentState!
                                    .save();
                                Addons addonsEntity;
                                if (widget.haveOwnAddons &&
                                    !widget.haveNewAddons &&
                                    widget.addons != null) {
                                  addonsEntity = widget.addons!.copyWith(
                                    title: state.addonsNameTextEditingController
                                        .value.text
                                        .trim(),
                                    description: state
                                        .addonsDescriptionTextEditingController
                                        .value
                                        .text
                                        .trim(),
                                    quantity: double.parse(state
                                        .addonsQuantityTextEditingController
                                        .value
                                        .text
                                        .trim()),
                                    defaultPrice: 0.0,
                                    finalPrice: double.parse(state
                                        .addonsPriceTextEditingController
                                        .value
                                        .text
                                        .trim()),
                                    discountedPrice: 0.0,
                                    unit: state.addonsUnitTextEditingController
                                        .value.text
                                        .trim(),
                                    currency: state.currency,
                                    addonsImage: MenuImage(
                                      assetPath: state.addonsImagePath,
                                    ),
                                    hasOwnAddons:
                                        state.addonsImagePath.isNotEmpty
                                            ? true
                                            : false,
                                  );
                                  context.read<MenuBloc>().add(
                                        SaveAddons(
                                          addonsEntity: addonsEntity,
                                        ),
                                      );
                                } else if (widget.haveOwnAddons &&
                                    widget.haveNewAddons) {
                                  addonsEntity = Addons(
                                    title: state.addonsNameTextEditingController
                                        .value.text
                                        .trim(),
                                    description: state
                                        .addonsDescriptionTextEditingController
                                        .value
                                        .text
                                        .trim(),
                                    quantity: double.parse(state
                                        .addonsQuantityTextEditingController
                                        .value
                                        .text
                                        .trim()),
                                    finalPrice: double.parse(state
                                        .addonsPriceTextEditingController
                                        .value
                                        .text
                                        .trim()),
                                    unit: state.addonsUnitTextEditingController
                                        .value.text
                                        .trim(),
                                    currency: state.currency,
                                    addonsImage: MenuImage(
                                      assetPath: state.addonsImagePath,
                                    ),
                                    hasOwnAddons:
                                        state.addonsImagePath.isNotEmpty
                                            ? true
                                            : false,
                                  );
                                  context.read<MenuBloc>().add(
                                        SaveAddons(
                                          addonsEntity: addonsEntity,
                                        ),
                                      );
                                } else {
                                  // Invalid case
                                }
                              }
                              return;
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(69, 201, 125, 1),
                            ),
                            child: Text(
                              'Save Addons',
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                            ).translate(),
                          ),
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
    );
  }
}
