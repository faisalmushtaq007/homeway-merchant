part of 'package:homemakers_merchant/app/features/store/index.dart';

class SaveStorePage extends StatefulWidget {
  const SaveStorePage({
    super.key,
    this.haveNewStore = true,
    this.currentIndex = -1,
    this.storeEntity,
  });

  final bool haveNewStore;
  final int currentIndex;
  final StoreEntity? storeEntity;

  @override
  _SaveStorePageState createState() => _SaveStorePageState();
}

class _SaveStorePageState extends State<SaveStorePage> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  static final storFormKey = GlobalKey<FormState>();
  List<File>? file_images = [];
  List<XFile> cross_file_images = [];
  TextEditingController _storeAddressController = TextEditingController();
  TextEditingController _storeNameController = TextEditingController();
  TextEditingController _storeMaxDeliveryTimeController =
      TextEditingController();

  double _maximumDeliveryRadiusValue = 6;
  List<StoreAvailableFoodTypes> _storeAvailableFoodTypes = [];
  List<StoreAvailableFoodPreparationType> _storeAvailableFoodPreparationType =
      [];

  TextEditingController _storeOpeningTimeController = TextEditingController();
  TextEditingController _storeClosingTimeController = TextEditingController();

  List<StoreAvailableFoodTypes> _selectedFoodTypes = [];
  List<StoreAvailableFoodPreparationType> _selectedFoodPreparationType = [];

  List<StoreAcceptedPaymentModes> _storeAcceptedPaymentModes = [];
  List<StoreAcceptedPaymentModes> _selectedAcceptedPaymentModes = [];
  List<StoreAcceptedPaymentModes> _initialSelectedStoreAcceptedPaymentModes =
      [];

  List<StoreWorkingDayAndTime> _storeWorkingDays = [];
  List<StoreWorkingDayAndTime> _selectedWorkingDays = [];
  List<StoreWorkingDayAndTime> _initialSelectedWorkingDays = [];

  bool _hasStoreOwnDeliveryService = false;
  TextEditingController _storeOwnerDriverNameController =
      TextEditingController();
  TextEditingController _storeOwnerDriverPhoneNumberController =
      TextEditingController();
  TextEditingController _storeOwnerDriverLicenseController =
      TextEditingController();
  List<StoreOwnDeliveryPartnersInfo> _selectedStoreOwnDrivers = [];
  List<StoreOwnDeliveryPartnersInfo> _initialSelectedStoreOwnDrivers = [];

  Category? selectedCategory;
  Category? selectedSubCategory;
  List<Category> listOfCategories = [];
  final TextEditingController menuCategoryTextEditingController =
      TextEditingController();
  final TextEditingController menuSubCategoryTextEditingController =
      TextEditingController();

  // Store phone number
  String? phoneValidation;
  Widget? suffixIcon;
  String userEnteredPhoneNumber = '';
  PhoneNumber? phoneNumber;
  final isoCodeNameMap = IsoCode.values.asNameMap();
  IsoCode defaultCountry = IsoCode.SA;
  late PhoneNumber initialPhoneNumberValue;
  late PhoneController phoneNumberController;
  PhoneNumberVerification phoneNumberVerification =
      PhoneNumberVerification.none;
  ValueNotifier<PhoneNumberVerification> valueNotifierPhoneNumberVerification =
      ValueNotifier<PhoneNumberVerification>(
    PhoneNumberVerification.none,
  );
  TextEditingController _storePhoneNumberController = TextEditingController();

  final deliveryTimeMuskeyFormatter = MuskeyFormatter(
    masks: ['### min'],
    wildcards: {
      '#': RegExp('[0-9]'),
      '@': RegExp('[s|S]'),
      '%': RegExp('[a|A]')
    },
    charTransforms: {
      '@': (s) => s.toUpperCase(),
      '%': (s) => s.toUpperCase(),
    },
    allowAutofill: true,
    overflow: OverflowBehavior.forbidden(),
  );
  late final MaskTextInputFormatter maximumDeliveryTimeFormatter;
  AddressModel? addressModel;

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
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  List<BannerModel> listBanners = [];
  final radiusTooTipKey = GlobalKey<State<Tooltip>>();
  AppUserEntity? appUserEntity;

  @override
  void initState() {
    super.initState();
    addressModel = null;
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    file_images = [];
    cross_file_images = [];
    //
    _storeAcceptedPaymentModes = [];
    _storeAvailableFoodPreparationType = [];
    _storeAvailableFoodTypes = [];
    _storeWorkingDays = [];
    //
    _selectedFoodTypes = [];
    _selectedFoodPreparationType = [];
    _selectedAcceptedPaymentModes = [];
    _initialSelectedStoreAcceptedPaymentModes = [];
    _initialSelectedWorkingDays = [];
    _initialSelectedStoreOwnDrivers = [];
    _selectedWorkingDays = [];
    listBanners = [];
    listBanners.clear();
    _selectedStoreOwnDrivers = [];
    _selectedStoreOwnDrivers.clear();
    listOfCategories = [];
    listOfCategories.clear();
    listOfCategories = List<Category>.from(localListOfCategories.toList());
    defaultCountry = IsoCode.values.byName('SA');

    initializeStoreAcceptedPaymentModes();
    initializeStoreAvailableFoodPreparationType();
    initializeStoreWorkingDays();
    initializeStoreAvailableFoodTypes();
    initializeStoreAvailableDrivers();
    maximumDeliveryTimeFormatter = MaskTextInputFormatter(
        mask: "##",
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    if (!mounted) {
      return;
    }

    if (!widget.haveNewStore &&
        widget.currentIndex != -1 &&
        widget.storeEntity != null) {
      initialPhoneNumberValue = PhoneNumber(
        isoCode: IsoCode.values.asNameMap().values.byName('SA'),
        nsn: '',
      );
      phoneNumberController = PhoneController(
        initialPhoneNumberValue,
      );
      phoneNumberController.value = initialPhoneNumberValue;
      context.read<StoreBloc>().add(
            GetStore(
              index: widget.currentIndex,
              storeID: widget.storeEntity?.storeID.toString() ?? '',
              storeEntity: widget.storeEntity,
            ),
          );
    } else {
      initData().whenComplete(
        () {
          if (widget.haveNewStore) {
            initialPhoneNumberValue = PhoneNumber(
              isoCode: IsoCode.values.asNameMap().values.byName('SA'),
              nsn: '',
            );
            phoneNumberController = PhoneController(
              initialPhoneNumberValue,
            );
            phoneNumberController.value = initialPhoneNumberValue;
            userEnteredPhoneNumber =
                appUserEntity?.phoneNumberWithoutDialCode ??
                    appUserEntity?.phoneNumber ??
                    '';
            initialPhoneNumberValue = PhoneNumber(
              isoCode: IsoCode.values.byName(appUserEntity?.isoCode ?? 'SA'),
              nsn: appUserEntity?.phoneNumberWithoutDialCode ?? '',
            );
            phoneNumberController.value = PhoneNumber(
              isoCode: IsoCode.values.byName(appUserEntity?.isoCode ?? 'SA'),
              nsn: appUserEntity?.phoneNumberWithoutDialCode ?? '',
            );
            defaultCountry =
                IsoCode.values.byName(appUserEntity?.isoCode ?? 'SA');
            _storeAddressController.text = appUserEntity?.businessProfile
                    ?.businessAddress?.address?.displayAddressName ??
                '';
            addressModel = appUserEntity?.businessProfile?.businessAddress;
          }
          setState(() {});
        },
      );
    }
  }

  Future<void> initData() async {
    final cacheUserEntity = serviceLocator<AppUserEntity>();
    AppUserEntity input = AppUserEntity(
      hasCurrentUser: true,
      isoCode: !cacheUserEntity.isoCode.isEmptyOrNull
          ? cacheUserEntity.isoCode
          : cacheUserEntity.businessProfile?.isoCode ?? '',
      country_dial_code: !cacheUserEntity.country_dial_code.isEmptyOrNull
          ? cacheUserEntity.country_dial_code
          : cacheUserEntity.businessProfile?.countryDialCode ?? '',
      phoneNumber: !cacheUserEntity.phoneNumber.isEmptyOrNull
          ? cacheUserEntity.phoneNumber
          : cacheUserEntity.businessProfile?.businessPhoneNumber ?? '',
      uid: cacheUserEntity.userID.toString(),
      access_token: cacheUserEntity.access_token ?? '',
      phoneNumberWithoutDialCode: !cacheUserEntity
              .phoneNumberWithoutDialCode.isEmptyOrNull
          ? cacheUserEntity.phoneNumberWithoutDialCode
          : cacheUserEntity.businessProfile?.phoneNumberWithoutDialCode ?? '',
    );
    final getCurrentUserResult =
        await serviceLocator<GetAllAppUserPaginationUseCase>()(
      pageSize: 10,
      pageKey: 0,
      entity: input,
    );
    await getCurrentUserResult.when(
      remote: (data, meta) {
        if (data.isNotNullOrEmpty) {
          appUserEntity = data!.last;
          serviceLocator<AppUserEntity>().updateEntity(data.last);
          setState(() {});
          appLog.d('Remote User Info ${data.last.toMap()}');
        }
      },
      localDb: (data, meta) {
        if (data.isNotNullOrEmpty) {
          appUserEntity = data!.last;
          serviceLocator<AppUserEntity>().updateEntity(data.last);
          setState(() {});
          appLog.d('Local User Info ${data.last.toMap()}');
        }
      },
      error: (dataSourceFailure, reason, error, networkException, stackTrace,
          exception, extra) {
        appLog.d('Error $reason');
      },
    );
  }

  @override
  void dispose() {
    addressModel = null;
    _storeAddressController.dispose();
    _storeNameController.dispose();
    _storePhoneNumberController.dispose();
    _storeMaxDeliveryTimeController.dispose();
    menuCategoryTextEditingController.dispose();
    menuSubCategoryTextEditingController.dispose();
    if (_storeOpeningTimeController == null) {
      _storeOpeningTimeController.dispose();
    } else {
      _storeOpeningTimeController.dispose();
    }
    _storeClosingTimeController.dispose();
    _storeOwnerDriverNameController.dispose();
    _storeOwnerDriverLicenseController.dispose();
    _storeOwnerDriverPhoneNumberController.dispose();
    _selectedFoodTypes = [];
    _selectedFoodPreparationType = [];
    _selectedAcceptedPaymentModes = [];
    _selectedWorkingDays = [];
    _storeAcceptedPaymentModes = [];
    _initialSelectedStoreAcceptedPaymentModes = [];
    _initialSelectedWorkingDays = [];
    _initialSelectedStoreOwnDrivers = [];
    _storeAvailableFoodPreparationType = [];
    _storeAvailableFoodTypes = [];
    _storeWorkingDays = [];
    file_images = [];
    cross_file_images = [];
    _selectedStoreOwnDrivers = [];
    _selectedStoreOwnDrivers.clear();
    listOfCategories = [];
    listOfCategories.clear();
    focusList.asMap().forEach((key, value) => value.dispose());
    scrollController.dispose();
    innerScrollController.dispose();
    super.dispose();
  }

  void initializeStoreAcceptedPaymentModes() {
    _storeAcceptedPaymentModes = [
      /*StoreAcceptedPaymentModes(
        title: 'Cash',
        id: 0,
        //icon: const Icon(Icons.payments),
      ),*/
      StoreAcceptedPaymentModes(
        title: 'Card',
        id: 1,
        //icon: const Icon(Icons.payment),
      ),
      StoreAcceptedPaymentModes(
        title: 'Online',
        id: 2,
        //icon: const Icon(Icons.devices),
      ),
      /*StoreAcceptedPaymentModes(
        title: 'Wallet',
        id: 3,
        //icon: const Icon(Icons.account_balance_wallet),
      ),*/
    ];
  }

  void initializeStoreAvailableFoodPreparationType() {
    _storeAvailableFoodPreparationType =
        List<StoreAvailableFoodPreparationType>.from(
            localStoreAvailableFoodPreparationType.toList());
  }

  void initializeStoreAvailableFoodTypes() {
    _storeAvailableFoodTypes = List<StoreAvailableFoodTypes>.from(
        localStoreAvailableFoodTypes.toList());
  }

  void initializeStoreWorkingDays() {
    _storeWorkingDays =
        List<StoreWorkingDayAndTime>.from(localStoreWorkingDays.toList());
  }

  initializeStoreAvailableDrivers() {}

  void onPhoneNumberChanged(
    PhoneNumber? phoneNumbers,
  ) {
    phoneNumber = phoneNumbers;
    userEnteredPhoneNumber =
        '+${phoneNumbers?.countryCode} ${phoneNumbers?.getFormattedNsn().trim()}';
    String countryDialCode = '+${phoneNumbers?.countryCode ?? '+966'}';
    String country = phoneNumbers?.isoCode.name ?? 'SA';
    _storePhoneNumberController.text = userEnteredPhoneNumber;
    //setState(() {});
  }

  void phoneNumberValidationChanged(
    String? value,
    PhoneNumber? phoneNumbers,
    PhoneController phoneNumberControllers,
  ) {
    phoneValidation = value;
    phoneNumber = phoneNumbers;
    phoneNumberController = phoneNumberControllers;
    if (phoneValidation != null && phoneValidation!.isNotEmpty) {
      phoneNumberVerification = PhoneNumberVerification.invalid;
      valueNotifierPhoneNumberVerification.value =
          PhoneNumberVerification.invalid;
    } else {
      if (phoneValidation == null &&
          phoneNumberControllers.value != null &&
          phoneNumberControllers.value!.getFormattedNsn().trim().isNotEmpty) {
        phoneNumberVerification = PhoneNumberVerification.valid;
        valueNotifierPhoneNumberVerification.value =
            PhoneNumberVerification.valid;
      } else {
        phoneNumberVerification = PhoneNumberVerification.none;
        valueNotifierPhoneNumberVerification.value =
            PhoneNumberVerification.none;
      }
    }
    //setState(() {});
  }

  void onPhoneNumberSaved(PhoneNumber? value) {}

  String? phoneNumberValidator(PhoneNumber? phoneNumber) {
    //
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

  void updateCategoryAndSubCategory(
      Category mainCategory, Category? subCategory) {
    setState(() {
      menuCategoryTextEditingController.text = '';
      menuSubCategoryTextEditingController.text = '';
      menuCategoryTextEditingController.text = mainCategory.title ?? '';
      selectedCategory = mainCategory;
      if (subCategory != null) {
        selectedSubCategory = subCategory;
        menuSubCategoryTextEditingController.text = subCategory?.title ?? '';
        final copyCategory = selectedCategory?.copyWith(
            subCategory: List<Category>.from([subCategory]));
        selectedCategory = copyCategory;
      }
    });
    return;
  }

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
            automaticallyImplyLeading: true,
            title: Text(
              'Store',
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
            ),
            actions: const [
              NotificationIconWidget(),
              LanguageSelectionWidget(),
            ],
          ),
          body: BlocListener<StoreBloc, StoreState>(
            bloc: context.read<StoreBloc>(),
            listenWhen: (previous, current) => previous != current,
            key: const Key('save_store-page-bloc-listener-widget'),
            listener: (context, state) {
              if (state is SaveStoreState) {
                context.go(
                  Routes.NEW_STORE_GREETING_PAGE,
                  extra: state.storeEntity,
                );
                return;
              } else if (state is GetStoreState) {
                final cacheStore = state.storeEntity;

                if (cacheStore.isNotNull) {
                  _storeNameController.text = cacheStore!.storeName ?? '';
                  userEnteredPhoneNumber =
                      cacheStore.phoneNumberWithoutDialCode ??
                          cacheStore.storePhoneNumber ??
                          '';
                  initialPhoneNumberValue = PhoneNumber(
                    isoCode: IsoCode.values.byName(cacheStore.isoCode ?? 'SA'),
                    nsn: userEnteredPhoneNumber,
                  );
                  phoneNumberController = PhoneController(
                    initialPhoneNumberValue,
                  );
                  phoneNumberController.value = initialPhoneNumberValue;
                  defaultCountry =
                      IsoCode.values.byName(cacheStore.isoCode ?? 'SA');
                  _storeAddressController.text =
                      cacheStore.storeAddress?.address?.displayAddressName ??
                          '';
                  addressModel = cacheStore.storeAddress;
                  updateCategoryAndSubCategory(cacheStore.storeCategories.last,
                      cacheStore.storeCategories.last.subCategory.last);
                  listBanners = [];
                  listBanners.insert(
                    0,
                    BannerModel(
                      imagePath: cacheStore.storeImagePath,
                      id: cacheStore.storeImageMetaData['id'],
                      boxFit: BoxFit.contain,
                      metaData: cacheStore.storeImageMetaData,
                    ),
                  );
                  _initialSelectedStoreOwnDrivers = [];
                  _initialSelectedStoreAcceptedPaymentModes = [];
                  _initialSelectedWorkingDays = [];
                  if (cacheStore
                      .storeOwnDeliveryPartnersInfo.isNotNullOrEmpty) {
                    _hasStoreOwnDeliveryService = true;
                    _initialSelectedStoreOwnDrivers =
                        List<StoreOwnDeliveryPartnersInfo>.from(
                            cacheStore.storeOwnDeliveryPartnersInfo);
                  }
                  if (cacheStore.storeWorkingDays.isNotNullOrEmpty) {
                    _initialSelectedWorkingDays =
                        List<StoreWorkingDayAndTime>.from(
                            cacheStore.storeWorkingDays);
                    _storeOpeningTimeController.text =
                        cacheStore.storeOpeningTime ?? '';
                    _storeClosingTimeController.text =
                        cacheStore.storeClosingTime ?? '';
                  }
                  if (cacheStore.storeAcceptedPaymentModes.isNotNullOrEmpty) {
                    _initialSelectedStoreAcceptedPaymentModes =
                        List<StoreAcceptedPaymentModes>.from(
                            cacheStore.storeAcceptedPaymentModes);
                  }
                  _storeMaxDeliveryTimeController.text =
                      cacheStore.storeMaximumFoodDeliveryTime.toString();
                  _maximumDeliveryRadiusValue =
                      cacheStore.storeMaximumFoodDeliveryRadius.toDouble();
                }
              }
            },
            child: PageBody(
              controller: scrollController,
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: media.size.height,
              ),
              padding: EdgeInsetsDirectional.only(
                //top: margins,
                //bottom: margins,
                start: margins * 2.5,
                end: margins * 2.5,
              ),
              child: BlocBuilder<PermissionBloc, PermissionState>(
                bloc: context.read<PermissionBloc>(),
                buildWhen: (previous, current) => previous != current,
                builder: (context, permissionState) {
                  return Container(
                    constraints: BoxConstraints(
                      minWidth: double.infinity,
                      minHeight: media.size.height,
                    ),
                    child: Form(
                      key: storFormKey,
                      child: CustomScrollView(
                        controller: innerScrollController,
                        physics: const ClampingScrollPhysics(),
                        slivers: [
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  textDirection:
                                      serviceLocator<LanguageController>()
                                          .targetTextDirection,
                                  children: [
                                    const AnimatedGap(6,
                                        duration: Duration(milliseconds: 500)),
                                    /*Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: Text(
                                      'Enter store details',
                                      style: context.titleLarge,
                                    ),
                                  ),
                                  const AnimatedGap(12, duration: Duration(milliseconds: 500)),*/
                                    if (listBanners.isNotEmpty)
                                      Stack(
                                        children: [
                                          BannerCarousel(
                                            banners: listBanners.toList(),
                                            customizedIndicators:
                                                const IndicatorModel.animation(
                                                    width: 20,
                                                    height: 5,
                                                    spaceBetween: 2,
                                                    widthAnimation: 50),
                                            height: 150,
                                            activeColor: Colors.amberAccent,
                                            disableColor: Colors.white,
                                            animation: true,
                                            margin: EdgeInsetsDirectional.zero,
                                            borderRadius: 10,
                                            showIndicator: false,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              return await uploadStoreImage(
                                                  context);
                                            },
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white70,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      spreadRadius: 2,
                                                      offset:
                                                          const Offset(0, 2),
                                                      blurRadius: 2,
                                                    )
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.all(
                                                          6),
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: context
                                                        .colorScheme.primary,
                                                    size: 18,
                                                    textDirection: serviceLocator<
                                                            LanguageController>()
                                                        .targetTextDirection,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    else
                                      GestureDetector(
                                        onTap: () async {
                                          return await uploadStoreImage(
                                              context);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(10),
                                            border: const BorderDirectional(
                                              start: BorderSide(width: 0.5),
                                              end: BorderSide(width: 0.5),
                                              top: BorderSide(width: 0.5),
                                              bottom: BorderSide(width: 0.5),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.camera_alt,
                                                size: 40,
                                              ),
                                              const SizedBox(height: 15),
                                              Text(
                                                'Upload store cover photo',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey.shade400,
                                                ),
                                              ).translate(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    const AnimatedGap(12,
                                        duration: Duration(milliseconds: 500)),
                                    Wrap(
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      children: [
                                        Text(
                                          'Make sure your store image is clear and visible with jpg or png format',
                                          style: context.labelMedium!.copyWith(
                                            color: const Color.fromRGBO(
                                                127, 129, 132, 1),
                                          ),
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                          maxLines: 2,
                                          softWrap: true,
                                        ).translate(),
                                      ],
                                    ),
                                    const AnimatedGap(12,
                                        duration: Duration(milliseconds: 500)),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      children: [
                                        Expanded(
                                          child: StoreTextFieldWidget(
                                            controller: _storeNameController,
                                            keyboardType: TextInputType.name,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp('[a-z A-Z ]')),
                                              FilteringTextInputFormatter.deny(
                                                  '  ')
                                            ],
                                            decoration: InputDecoration(
                                              labelText: 'Store name',
                                              hintText: 'Enter your store name',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              isDense: true,
                                            ),
                                            //focusNode: focusList[0],
                                            textInputAction:
                                                TextInputAction.next,
                                            //onFieldSubmitted: (_) => fieldFocusChange(context, focusList[0], focusList[1]),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Enter store name';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const AnimatedGap(12,
                                        duration: Duration(milliseconds: 500)),
                                    AppTextFieldWidget(
                                      controller:
                                          menuCategoryTextEditingController,
                                      readOnly: true,
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      //focusNode: focusList[1],
                                      textInputAction: TextInputAction.next,
                                      //onFieldSubmitted: (_) => fieldFocusChange(context, focusList[1], focusList[2]),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: 'Store category',
                                        hintText: 'Select your store category',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        isDense: true,
                                        suffixIcon: IconButton(
                                          onPressed: () async {
                                            final result = await context
                                                .push<List<Category?>>(
                                              Routes.MAIN_CATEGORY_PAGE,
                                            );
                                            if (result != null &&
                                                result[0] != null &&
                                                result[1] != null) {
                                              updateCategoryAndSubCategory(
                                                  result[0]!, result[1]);
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Select store category';
                                        }
                                        return null;
                                      },
                                      onTap: () async {
                                        final result =
                                            await context.push<List<Category?>>(
                                          Routes.MAIN_CATEGORY_PAGE,
                                        );
                                        if (result != null &&
                                            result[0] != null &&
                                            result[1] != null) {
                                          updateCategoryAndSubCategory(
                                              result[0]!, result[1]);
                                        }
                                      },
                                    ),
                                    const AnimatedGap(12,
                                        duration: Duration(milliseconds: 500)),
                                    AppTextFieldWidget(
                                      controller:
                                          menuSubCategoryTextEditingController,
                                      readOnly: true,
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: 'Store sub-category',
                                        hintText:
                                            'Select your store sub-category',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        isDense: true,
                                        suffixIcon: IconButton(
                                          onPressed: () async {
                                            final result = await context
                                                .push<List<Category?>>(
                                              Routes.MAIN_CATEGORY_PAGE,
                                            );
                                            if (result != null &&
                                                result[0] != null &&
                                                result[1] != null) {
                                              updateCategoryAndSubCategory(
                                                  result[0]!, result[1]);
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Select store sub category';
                                        }
                                        return null;
                                      },
                                      onTap: () async {
                                        final result =
                                            await context.push<List<Category?>>(
                                          Routes.MAIN_CATEGORY_PAGE,
                                        );
                                        if (result != null &&
                                            result[0] != null &&
                                            result[1] != null) {
                                          updateCategoryAndSubCategory(
                                              result[0]!, result[1]);
                                        }
                                      },
                                    ),
                                    const AnimatedGap(12,
                                        duration: Duration(milliseconds: 500)),
                                    Directionality(
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      child: PhoneNumberFieldWidget(
                                        key: const Key(
                                            'save-store-phone-number-widget'),
                                        isCountryChipPersistent: false,
                                        outlineBorder: true,
                                        shouldFormat: true,
                                        useRtl: false,
                                        withLabel: true,
                                        decoration: InputDecoration(
                                          labelText: 'Store contact number',
                                          //hintText: 'Enter driver number',
                                          alignLabelWithHint: true,
                                          errorText: phoneValidation,
                                          /*suffixIcon: PhoneNumberValidateWidget(
                                                phoneNumberVerification: value,
                                              ),*/
                                          isDense: true,
                                        ),
                                        isAllowEmpty: false,
                                        autofocus: false,
                                        style: context.bodyLarge,
                                        showFlagInInput: false,
                                        countryCodeStyle: context.bodyLarge,
                                        initialPhoneNumberValue:
                                            initialPhoneNumberValue,
                                        //validator: state.phoneNumberValidator,
                                        //suffixIcon: PhoneNumberValidateWidget(phoneNumberVerification: value),
                                        onPhoneNumberChanged:
                                            onPhoneNumberChanged,
                                        phoneNumberValidator:
                                            phoneNumberValidator,
                                        onPhoneNumberSaved: onPhoneNumberSaved,
                                        phoneNumberValidationChanged:
                                            phoneNumberValidationChanged,
                                        haveStateManagement: false,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(),
                                        textInputAction: TextInputAction.done,
                                      ),
                                    ),
                                    const AnimatedGap(12,
                                        duration: Duration(milliseconds: 500)),
                                    MultiStreamBuilder(
                                      key: const Key(
                                        'store-address-textFormField-key',
                                      ),
                                      buildWhen: (previousDataList,
                                              latestDataList) =>
                                          previousDataList != latestDataList,
                                      streams: [
                                        Stream.fromFuture(
                                          AppTranslator.instance
                                              .translate('Store address'),
                                        ),
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate(
                                              'Please enter an address'),
                                        ),
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate(
                                            _storeAddressController.value.text
                                                .trim(),
                                          ),
                                        ),
                                      ],
                                      initialStreamValue: const [
                                        'Store address',
                                        'Please enter an address',
                                        ''
                                      ],
                                      builder: (context, snapshot) {
                                        return Directionality(
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                          child: TextFormField(
                                            controller: _storeAddressController,
                                            textDirection: serviceLocator<
                                                    LanguageController>()
                                                .targetTextDirection,
                                            maxLines: 3,
                                            readOnly: true,
                                            //focusNode: focusList[2],
                                            textInputAction:
                                                TextInputAction.next,
                                            //onFieldSubmitted: (_) => fieldFocusChange(context, focusList[2], focusList[3]),
                                            onTap: () async {
                                              final result = await context
                                                  .push<(String, AddressModel)>(
                                                Routes.ALL_SAVED_ADDRESS_LIST,
                                                extra: {
                                                  'selectItemUseCase':
                                                      SelectItemUseCase
                                                          .onlySelect,
                                                },
                                              );
                                              if (result != null) {
                                                _storeAddressController.text =
                                                    result.$1;
                                                addressModel = result.$2;
                                                setState(() {});
                                              }
                                            },
                                            decoration: InputDecoration(
                                              labelText: snapshot[0],
                                              isDense: true,
                                              suffixIcon: Container(
                                                width:
                                                    kMinInteractiveDimension *
                                                        1.05,
                                                constraints:
                                                    const BoxConstraints(
                                                  minWidth:
                                                      kMinInteractiveDimension *
                                                          1.05,
                                                  minHeight:
                                                      kMinInteractiveDimension *
                                                          2,
                                                ),
                                                decoration: const BoxDecoration(
                                                  border: BorderDirectional(
                                                    start: BorderSide(
                                                      width: 1,
                                                      color: Color.fromRGBO(
                                                        201,
                                                        201,
                                                        203,
                                                        1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () async {
                                                        final result =
                                                            await context.push<
                                                                (
                                                                  String,
                                                                  AddressModel
                                                                )>(
                                                          Routes
                                                              .ALL_SAVED_ADDRESS_LIST,
                                                          extra: {
                                                            'selectItemUseCase':
                                                                SelectItemUseCase
                                                                    .onlySelect,
                                                          },
                                                        );
                                                        if (result != null) {
                                                          _storeAddressController
                                                              .text = result.$1;
                                                          addressModel =
                                                              result.$2;
                                                          setState(() {});
                                                        }
                                                      },
                                                      icon: const Icon(
                                                        Icons.my_location,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return '${snapshot[1]}';
                                              }
                                              return null;
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    const Divider(),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          'Service availability',
                                          style: context.titleLarge!.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                        ).translate(),
                                        const AnimatedGap(2,
                                            duration:
                                                Duration(milliseconds: 500)),
                                        Text(
                                          'Select store availability day(s) and time',
                                          style: context.labelMedium,
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                        ).translate(),
                                      ],
                                    ),
                                    const AnimatedGap(12,
                                        duration: Duration(milliseconds: 500)),
                                    Text(
                                      'Select days',
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      style: context.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ).translate(),
                                    const AnimatedGap(6,
                                        duration: Duration(milliseconds: 500)),
                                    MultiSelectAvailableWorkingDaysFormField(
                                      onSelectionChanged:
                                          (List<StoreWorkingDayAndTime>
                                              selectedWorkingDays) {
                                        _selectedWorkingDays =
                                            List<StoreWorkingDayAndTime>.from(
                                                selectedWorkingDays);
                                        setState(() {});
                                      },
                                      availableWorkingDaysList:
                                          _storeWorkingDays.toList(),
                                      validator: (value) {
                                        if (value == null ||
                                            value.length == 0) {
                                          return 'Select one or more days';
                                        } else {
                                          return null;
                                        }
                                      },
                                      initialSelectedAvailableWorkingDaysList:
                                          _initialSelectedWorkingDays.toList(),
                                      onSaved: (newValue) {},
                                    ),
                                    const AnimatedGap(12,
                                        duration: Duration(milliseconds: 500)),
                                    Text(
                                      'Select time',
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      style: context.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ).translate(),
                                    const AnimatedGap(6,
                                        duration: Duration(milliseconds: 500)),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: DateTimeFieldPlatform(
                                            key: const Key(
                                                'Store-OpeningTime-widget'),
                                            mode: DateMode.time,
                                            maximumDate: DateTime.now()
                                                .add(const Duration(hours: 2)),
                                            minimumDate: DateTime.now()
                                                .subtract(
                                                    const Duration(hours: 2)),
                                            controller:
                                                _storeOpeningTimeController,
                                            decoration: InputDecoration(
                                              labelText: 'Open time',
                                              hintText: 'Select open time',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              suffixIcon: const Icon(
                                                Icons.arrow_drop_down,
                                              ),
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsetsDirectional
                                                      .symmetric(
                                                      vertical: 8,
                                                      horizontal: 12),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Select open time';
                                              } else if (compareOpenAndCloseTime(
                                                  openingTime:
                                                      _storeOpeningTimeController
                                                          .value.text
                                                          .trim(),
                                                  closingTime:
                                                      _storeClosingTimeController
                                                          .value.text
                                                          .trim())) {
                                                return 'Select valid open time';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        const AnimatedGap(16,
                                            duration:
                                                Duration(milliseconds: 500)),
                                        Expanded(
                                          child: DateTimeFieldPlatform(
                                            key: const Key(
                                                'Store-ClosingTime-widget'),
                                            mode: DateMode.time,
                                            maximumDate: DateTime.now()
                                                .add(const Duration(hours: 2)),
                                            minimumDate: DateTime.now()
                                                .subtract(
                                                    const Duration(hours: 2)),
                                            controller:
                                                _storeClosingTimeController,
                                            decoration: InputDecoration(
                                              labelText: 'Close time',
                                              hintText: 'Select close time',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              suffixIcon: const Icon(
                                                Icons.arrow_drop_down,
                                              ),
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsetsDirectional
                                                      .symmetric(
                                                      vertical: 8,
                                                      horizontal: 12),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Select close time';
                                              } else if (compareOpenAndCloseTime(
                                                  openingTime:
                                                      _storeOpeningTimeController
                                                          .value.text
                                                          .trim(),
                                                  closingTime:
                                                      _storeClosingTimeController
                                                          .value.text
                                                          .trim())) {
                                                return 'Select valid close time';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    /*Text(
                                    'Food types',
                                    style: context.titleLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  ).translate(),
                                  const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                  MultiSelectAvailableFoodTypeFormField(
                                    onSelectionChanged: (List<StoreAvailableFoodTypes> selectedFoodTypes) {
                                      _selectedFoodTypes = List<StoreAvailableFoodTypes>.from(selectedFoodTypes);
                                      setState(() {});
                                    },
                                    availableFoodTypesList: _storeAvailableFoodTypes.toList(),
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
                                  Text(
                                    'Food preparation method',
                                    style: context.titleLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  ).translate(),
                                  const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                  MultiSelectAvailableFoodPreparationTypesFormField(
                                    onSelectionChanged: (List<StoreAvailableFoodPreparationType> selectedPreparationTypes) {
                                      _selectedFoodPreparationType = List<StoreAvailableFoodPreparationType>.from(selectedPreparationTypes);
                                      setState(() {});
                                    },
                                    availableFoodPreparationTypesList: _storeAvailableFoodPreparationType.toList(),
                                    validator: (value) {
                                      if (value == null || value.length == 0) {
                                        return 'Select one or more food preparation method';
                                      } else {
                                        return null;
                                      }
                                    },
                                    initialSelectedFoodPreparationTypesList: [],
                                    onSaved: (newValue) {},
                                  ),
                                  const Divider(),*/
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Wrap(
                                          children: [
                                            Text(
                                              'Delivery options',
                                              style:
                                                  context.titleLarge!.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20,
                                              ),
                                              textDirection: serviceLocator<
                                                      LanguageController>()
                                                  .targetTextDirection,
                                            ).translate(),
                                          ],
                                        ),
                                        const AnimatedGap(6,
                                            duration:
                                                Duration(milliseconds: 500)),
                                        Wrap(
                                          children: [
                                            Text(
                                              'Do you have your own delivery service',
                                              style:
                                                  context.bodySmall!.copyWith(),
                                              textDirection: serviceLocator<
                                                      LanguageController>()
                                                  .targetTextDirection,
                                            ).translate(),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const AnimatedGap(4,
                                        duration: Duration(milliseconds: 500)),
                                    Card(
                                      margin: const EdgeInsetsDirectional.only(
                                          start: 0, end: 0, top: 4, bottom: 4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                10),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          SwitchListTile(
                                            onChanged: (value) {
                                              setState(() {
                                                _hasStoreOwnDeliveryService =
                                                    value;
                                              });
                                            },
                                            value: _hasStoreOwnDeliveryService,
                                            title: Wrap(
                                              children: [
                                                Text(
                                                  'I have my own delivery service',
                                                  style: context.bodyMedium!
                                                      .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  maxLines: 2,
                                                  textDirection: serviceLocator<
                                                          LanguageController>()
                                                      .targetTextDirection,
                                                ).translate(),
                                              ],
                                            ),
                                            isThreeLine: false,
                                            dense: true,
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            visualDensity: const VisualDensity(
                                                horizontal: -4, vertical: 0),
                                          ),
                                          AnimatedCrossFade(
                                            firstChild: const SizedBox.shrink(),
                                            secondChild: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .symmetric(
                                                          horizontal:
                                                              margins * 2.5),
                                                  child:
                                                      StoreOwnDriverFormField(
                                                    key: const Key(
                                                        'store-own-driver-formfield'),
                                                    onSelectionChanged: (List<
                                                            StoreOwnDeliveryPartnersInfo>
                                                        selectedStoreOwnDrivers) {
                                                      _selectedStoreOwnDrivers =
                                                          List<StoreOwnDeliveryPartnersInfo>.from(
                                                              selectedStoreOwnDrivers);
                                                      setState(() {});
                                                    },
                                                    availableDriverList:
                                                        _selectedStoreOwnDrivers
                                                            .toList(),
                                                    initialSelectedAvailableDriverList:
                                                        _initialSelectedStoreOwnDrivers
                                                            .toList(),
                                                  ),
                                                ),
                                                const AnimatedGap(4,
                                                    duration: Duration(
                                                        milliseconds: 500)),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .symmetric(
                                                          horizontal:
                                                              margins * 2.5),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child:
                                                            ElevatedButton.icon(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            //visualDensity: VisualDensity(vertical: -1, horizontal: 0),
                                                            shape:
                                                                const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    10),
                                                              ),
                                                            ),
                                                            backgroundColor:
                                                                const Color
                                                                    .fromRGBO(
                                                                    238,
                                                                    238,
                                                                    238,
                                                                    1),
                                                          ),
                                                          icon: const Icon(
                                                            Icons.add,
                                                            color:
                                                                Color.fromRGBO(
                                                                    42,
                                                                    45,
                                                                    48,
                                                                    1),
                                                          ),
                                                          label: Text(
                                                            'Add Driver',
                                                            style:
                                                                const TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      42,
                                                                      45,
                                                                      50,
                                                                      1),
                                                            ),
                                                            textDirection:
                                                                serviceLocator<
                                                                        LanguageController>()
                                                                    .targetTextDirection,
                                                          ).translate(),
                                                          onPressed: () async {
                                                            final List<
                                                                    StoreOwnDeliveryPartnersInfo>?
                                                                returnSelectedDriver =
                                                                await context.push<
                                                                    List<
                                                                        StoreOwnDeliveryPartnersInfo>>(
                                                              Routes
                                                                  .ALL_DRIVER_PAGE,
                                                              extra: {
                                                                'selectItemUseCase':
                                                                    SelectItemUseCase
                                                                        .selectAndReturn,
                                                              },
                                                            );
                                                            if (returnSelectedDriver
                                                                .isNotNullOrEmpty) {
                                                              setState(() {
                                                                _selectedStoreOwnDrivers = List<
                                                                        StoreOwnDeliveryPartnersInfo>.from(
                                                                    returnSelectedDriver!
                                                                        .toList());
                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const AnimatedGap(8,
                                                    duration: Duration(
                                                        milliseconds: 500)),
                                              ],
                                            ),
                                            crossFadeState:
                                                (_hasStoreOwnDeliveryService ==
                                                        true)
                                                    ? CrossFadeState.showSecond
                                                    : CrossFadeState.showFirst,
                                            duration: const Duration(
                                                milliseconds: 500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const AnimatedGap(16,
                                        duration: Duration(milliseconds: 500)),
                                    Wrap(
                                      children: [
                                        Text(
                                          'Maximum preparation time',
                                          style: context.titleLarge!.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                        ).translate(),
                                      ],
                                    ),
                                    const AnimatedGap(6,
                                        duration: Duration(milliseconds: 500)),
                                    Wrap(
                                      children: [
                                        Text(
                                          'How much maximum time does you take to preparation your order, whenever the order will place at this store?',
                                          style: context.bodySmall!.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                        ).translate(),
                                      ],
                                    ),
                                    const AnimatedGap(12,
                                        duration: Duration(milliseconds: 500)),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      children: [
                                        Expanded(
                                          child: StoreTextFieldWidget(
                                            controller:
                                                _storeMaxDeliveryTimeController,
                                            textDirection: serviceLocator<
                                                    LanguageController>()
                                                .targetTextDirection,
                                            //focusNode: focusList[7],
                                            textInputAction:
                                                TextInputAction.done,
                                            //onFieldSubmitted: (_) => fieldFocusChange(context, focusList[7], focusList[8]),
                                            decoration: InputDecoration(
                                              hintText: '00',
                                              isDense: true,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              suffixText: 'min',
                                            ),
                                            inputFormatters: [
                                              //FilteringTextInputFormatter.digitsOnly,
                                              maximumDeliveryTimeFormatter,
                                            ],
                                            onChanged: (value) {},
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  maximumDeliveryTimeFormatter
                                                      .getUnmaskedText()
                                                      .isEmpty) {
                                                return 'Please enter delivery time';
                                              } else {
                                                return null;
                                              }
                                              /*if (value == null || value.isEmpty || deliveryTimeMuskeyFormatter.info.clean.isEmpty) {
                                      return 'Please enter delivery time';
                                    } else if (!deliveryTimeMuskeyFormatter.info.isValid) {
                                      return 'Please enter delivery time';
                                    }*/
                                            },
                                          ),
                                        ),
                                        /*Expanded(
                                flex: 3,
                                child: SizedBox(),
                              ),*/
                                      ],
                                    ),
                                    const AnimatedGap(16,
                                        duration: Duration(milliseconds: 500)),
                                    Wrap(
                                      spacing: 2,
                                      children: [
                                        Text(
                                          'Maximum delivery radius',
                                          style: context.titleLarge!.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                        ).translate(),
                                        Tooltip(
                                          triggerMode: TooltipTriggerMode.tap,
                                          onTriggered: () {
                                            final dynamic tooltip =
                                                radiusTooTipKey.currentState;
                                            tooltip?.ensureTooltipVisible();
                                          },
                                          key: radiusTooTipKey,
                                          message:
                                              'It is area where customers within the range will be able to discover and order from this store.',
                                          child: Icon(
                                            Icons.info,
                                            size: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const AnimatedGap(6,
                                        duration: Duration(milliseconds: 500)),
                                    Wrap(
                                      children: [
                                        Text(
                                          'How much maximum distance does you take to deliver your order, whenever the order will place at this store?',
                                          style: context.bodySmall!.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                        ).translate(),
                                      ],
                                    ),
                                    const AnimatedGap(6,
                                        duration: Duration(milliseconds: 500)),
                                    SliderTheme(
                                      data: SliderThemeData(
                                        // here
                                        overlayShape:
                                            SliderComponentShape.noOverlay,
                                        showValueIndicator:
                                            ShowValueIndicator.always,
                                        valueIndicatorColor:
                                            const Color.fromRGBO(
                                                251, 219, 11, 1),
                                      ),
                                      child: Slider(
                                        min: 1,
                                        divisions: 19,
                                        max: 20,
                                        value: _maximumDeliveryRadiusValue,
                                        label: _maximumDeliveryRadiusValue
                                            .round()
                                            .toString(),
                                        onChanged: (double value) {
                                          setState(() {
                                            _maximumDeliveryRadiusValue = value;
                                          });
                                        },
                                      ),
                                    ),
                                    const AnimatedGap(6,
                                        duration: Duration(milliseconds: 500)),
                                    Wrap(
                                      children: [
                                        Text(
                                          '$_maximumDeliveryRadiusValue KM',
                                          style: context.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                        ).translate(),
                                      ],
                                    ),
                                    const AnimatedGap(6,
                                        duration: Duration(milliseconds: 500)),
                                    const Divider(),
                                    Text(
                                      'Accepted payment mode',
                                      style: context.titleLarge!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                    ).translate(),
                                    const AnimatedGap(6,
                                        duration: Duration(milliseconds: 500)),
                                    MultiSelectAvailablePaymentModeFormField(
                                      onSelectionChanged:
                                          (List<StoreAcceptedPaymentModes>
                                              selectedPaymentModes) {
                                        _selectedAcceptedPaymentModes = List<
                                                StoreAcceptedPaymentModes>.from(
                                            selectedPaymentModes);
                                        setState(() {});
                                      },
                                      availablePaymentModesList:
                                          _storeAcceptedPaymentModes.toList(),
                                      validator: (value) {
                                        if (value == null ||
                                            value.length == 0) {
                                          return 'Select one or more payment mode';
                                        } else {
                                          return null;
                                        }
                                      },
                                      initialSelectedAvailablePaymentModesList:
                                          _initialSelectedStoreAcceptedPaymentModes
                                              .toList(),
                                      onSaved: (newValue) {},
                                    ),
                                    const AnimatedGap(30,
                                        duration: Duration(milliseconds: 500)),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (storFormKey.currentState!
                                            .validate()) {
                                          storFormKey.currentState!.save();

                                          final storeInfo = StoreEntity(
                                            storeName:
                                                _storeNameController.value.text,
                                            storePhoneNumber:
                                                userEnteredPhoneNumber,
                                            countryDialCode:
                                                initialPhoneNumberValue
                                                    .countryCode,
                                            isoCode: initialPhoneNumberValue
                                                .isoCode.name,
                                            /* storeAddress: AddressModel(
                                            address: AddressBean(
                                              displayAddressName: _storeAddressController.value.text,
                                            ),
                                          ),*/
                                            storeAddress: addressModel,
                                            storeImagePath:
                                                (listBanners.isNotNullOrEmpty)
                                                    ? listBanners[0].imagePath
                                                    : '',
                                            storeImageMetaData:
                                                (listBanners.isNotNullOrEmpty)
                                                    ? listBanners[0].metaData
                                                    : <String, dynamic>{},
                                            storeMaximumFoodDeliveryTime:
                                                int.parse(
                                                    _storeMaxDeliveryTimeController
                                                        .value.text),
                                            storeMaximumFoodDeliveryRadius:
                                                _maximumDeliveryRadiusValue
                                                    .toInt(),
                                            storeOpeningTime:
                                                _storeOpeningTimeController
                                                    .value.text
                                                    .trim(),
                                            storeClosingTime:
                                                _storeClosingTimeController
                                                    .value.text
                                                    .trim(),
                                            hasStoreOwnDeliveryPartners:
                                                _hasStoreOwnDeliveryService,
                                            storeAcceptedPaymentModes:
                                                _selectedAcceptedPaymentModes
                                                    .toList(),
                                            storeAvailableFoodPreparationType:
                                                _selectedFoodPreparationType
                                                    .toList(),
                                            storeAvailableFoodTypes:
                                                _selectedFoodTypes.toList(),
                                            storeOwnDeliveryPartnersInfo:
                                                (_hasStoreOwnDeliveryService)
                                                    ? [
                                                        StoreOwnDeliveryPartnersInfo(
                                                          driverMobileNumber:
                                                              _storeOwnerDriverPhoneNumberController
                                                                  .value.text,
                                                          driverName:
                                                              _storeOwnerDriverNameController
                                                                  .value.text,
                                                          drivingLicenseNumber:
                                                              _storeOwnerDriverLicenseController
                                                                  .value.text,
                                                        ),
                                                      ]
                                                    : [],
                                            storeWorkingDays:
                                                _selectedWorkingDays.toList(),
                                            hasNewStore: widget.haveNewStore,
                                            storeCategories:
                                                selectedCategory != null
                                                    ? [selectedCategory!]
                                                    : [],
                                            phoneNumberWithoutDialCode:
                                                initialPhoneNumberValue.nsn,
                                          );
                                          StoreEntity storeEntity;
                                          if (!widget.haveNewStore &&
                                              widget.storeEntity != null &&
                                              widget.currentIndex != -1) {
                                            storeEntity = storeInfo.copyWith(
                                              storeID:
                                                  widget.storeEntity?.storeID,
                                            );
                                          } else {
                                            storeEntity = storeInfo.copyWith(
                                                //storeID: ((DateTime.now().millisecondsSinceEpoch - DateTime.now().millisecond) / 100).toInt(),
                                                );
                                          }
                                          if (!mounted) {
                                            return;
                                          }
                                          context
                                              .read<StoreBloc>()
                                              .add(SaveStore(
                                                storeEntity: storeEntity,
                                                hasNewStore:
                                                    widget.haveNewStore,
                                              ));
                                          return;
                                        }
                                        return;
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            69, 201, 125, 1),
                                      ),
                                      child: Text(
                                        'Save Store',
                                        textDirection:
                                            serviceLocator<LanguageController>()
                                                .targetTextDirection,
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
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uploadStoreImage(BuildContext context) async {
    {
      // Navigate to document picker page
      final List<dynamic>? result = await context.push<List<dynamic>>(
        Routes.UPLOAD_DOCUMENT_PAGE,
        extra: jsonEncode(
          {
            'documentType': DocumentType.other.name,
          },
        ),
      );
      // Check is Result exists or not
      if (result != null && result.isNotEmpty) {
        // Extarct and store the value
        String filePath = result[0] as String;
        XFile? xCroppedDocumentFile = result[1] as XFile;
        File? croppedDocumentFile = result[2] as File;
        XFile? xFile = result[5] as XFile;
        File? file = result[6] as File;
        String? assetNetworkUrl = result[7] as String?;
        final int timeStamp = DateTime.now().millisecondsSinceEpoch;
        var tempName = 'homeway_store_image_$timeStamp';
        var fileNameWithExtension = path.basenameWithoutExtension(
            xCroppedDocumentFile?.path ??
                croppedDocumentFile?.path ??
                tempName);
        String fileExtension = path.extension(
            xCroppedDocumentFile?.path ?? croppedDocumentFile?.path ?? '.png');
        String croppedFilePath = (xCroppedDocumentFile.path.isEmpty)
            ? xCroppedDocumentFile.path
            : croppedDocumentFile.path;
        final fileReadAsBytes = await file.readAsBytes();
        final xFileReadAsBytes = await xFile.readAsBytes();
        final fileReadAsString = base64Encode(fileReadAsBytes);
        final xFileReadAsString = base64Encode(xFileReadAsBytes);
        final String mimeType =
            xCroppedDocumentFile.mimeType ?? xFile.mimeType ?? 'image/png';
        var decodedImage =
            await decodeImageFromList(xFileReadAsBytes ?? fileReadAsBytes);
        double height = decodedImage.height.toDouble();
        double width = decodedImage.width.toDouble();
        var metaData = {
          'id': const Uuid().v4(),
          'filePath': filePath,
          'croppedFilePath': croppedFilePath,
          'fileExtension': fileExtension,
          'fileNameWithExtension': fileNameWithExtension,
          //'file': file,
          //'xFile': xFile,
          'assetNetworkUrl': assetNetworkUrl,
          'fileReadAsBytes': fileReadAsBytes,
          'xFileReadAsBytes': xFileReadAsBytes,
          'fileReadAsString': fileReadAsString,
          'xFileReadAsString': xFileReadAsString,
          //'mimeType':'image',
          'height': height,
          'width': width,
          'mimeType': mimeType,
          'documentType': DocumentType.other.name,
          'blob': (xFileReadAsBytes.isNotNullOrEmpty)
              ? Blob(xFileReadAsBytes)
              : Blob(fileReadAsBytes),
          'base64': (xFileReadAsString.isNotEmpty)
              ? xFileReadAsString
              : fileReadAsString,
        };
        listBanners.insert(
            0,
            BannerModel(
              imagePath: croppedFilePath,
              id: const Uuid().v4(),
              boxFit: BoxFit.contain,
              metaData: metaData,
            ));
        final CaptureImageEntity captureImageEntity =
            CaptureImageEntity.fromMap(metaData);
        setState(() {});
      }
    }
  }
}
