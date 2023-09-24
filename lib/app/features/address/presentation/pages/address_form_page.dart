part of 'package:homemakers_merchant/app/features/address/index.dart';

class AddressFormPage extends StatefulWidget {
  const AddressFormPage({
    super.key,
    this.addressModel,
    this.currentIndex = -1,
    this.hasNewAddress = true,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.locationData,
    this.allAddress = const [],
    this.hasViewAddress = false,
  });

  final AddressModel? addressModel;
  final int currentIndex;
  final bool hasNewAddress;
  final double latitude;
  final double longitude;
  final GBData? locationData;
  final List<AddressModel> allAddress;
  final bool hasViewAddress;

  @override
  _AddressFormPageController createState() => _AddressFormPageController();
}

class _AddressFormPageController extends State<AddressFormPage> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  final addressFormPageFormKey = GlobalKey<FormState>();

  // Phone Form Field
  String? phoneValidation;
  String userEnteredPhoneNumber = '';
  PhoneNumberVerification phoneNumberVerification =
      PhoneNumberVerification.none;
  final isoCodeNameMap = IsoCode.values.asNameMap();
  IsoCode defaultCountry = IsoCode.SA;
  PhoneNumber initialPhoneNumberValue = PhoneNumber(
    isoCode: IsoCode.values.asNameMap().values.byName('SA'),
    nsn: '',
  );
  PhoneController controller = PhoneController(
    PhoneNumber(
      isoCode: IsoCode.values.asNameMap().values.byName('SA'),
      nsn: '',
    ),
  );
  int businessProfileID = -1;
  ValueNotifier<PhoneNumberVerification> valueNotifierPhoneNumberVerification =
      ValueNotifier<PhoneNumberVerification>(
    PhoneNumberVerification.none,
  );
  bool mobileOnly = true;

  // TextEditing controllers
  final firstAddressTextFieldController = TextEditingController();
  final secondAddressTextFieldController = TextEditingController();
  final landmarkTextFieldController = TextEditingController();
  final buildingTextFieldController = TextEditingController();
  final areaTextFieldController = TextEditingController();
  final cityTextFieldController = TextEditingController();
  final stateTextFieldController = TextEditingController(text: '');
  final countryTextFieldController = TextEditingController(text: '');
  final zipCodeTextFieldController = TextEditingController();
  final fullNameTextFieldController = TextEditingController();
  final mobileNumberTextFieldController = TextEditingController();
  final mapAddressTextFieldController = TextEditingController();
  final districtAddressTextFieldController = TextEditingController();

  // Others
  bool checkBoxValue = false;
  List<bool> isToggleButtonSelected = [false, false, false, false, false];
  List<String> valueOfToggleButtonSelected = [
    'Home',
    'Office',
    'Friend',
    'Business',
    'Other'
  ];
  late final GBData locationAddressData;
  AddressModel? addressModel;
  int indexOfSaveAddress = -1;
  String? valueOfSavedAddress;
  String? addressTypeValidation;
  double latitude = 0;
  double longitude = 0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    initialPhoneNumberValue = PhoneNumber(
      isoCode: isoCodeNameMap.values.byName('SA'),
      nsn: '',
    );
    controller = PhoneController(initialPhoneNumberValue);
    controller.value = initialPhoneNumberValue;
    context.read<PermissionBloc>().add(const RequestLocationPermissionEvent());
    initializeEditableData();
  }

  void initializeEditableData() {
    latitude = widget.latitude;
    longitude = widget.longitude;
    if (widget.locationData.isNotNull) {
      locationAddressData = widget.locationData!;
    }
    if (widget.addressModel.isNotNull) {
      addressModel = widget.addressModel;
    }
    setAddressEntityData(addressModel,
        locationAddressData: locationAddressData);
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        super.setState(fn);
      });
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    innerScrollController.dispose();
    // Controller
    firstAddressTextFieldController.dispose();
    secondAddressTextFieldController.dispose();
    landmarkTextFieldController.dispose();
    buildingTextFieldController.dispose();
    areaTextFieldController.dispose();
    cityTextFieldController.dispose();
    stateTextFieldController.dispose();
    countryTextFieldController.dispose();
    zipCodeTextFieldController.dispose();
    fullNameTextFieldController.dispose();
    mobileNumberTextFieldController.dispose();
    mapAddressTextFieldController.dispose();
    districtAddressTextFieldController.dispose();
    super.dispose();
  }

  void onPhoneNumberChanged(
    PhoneNumber? phoneNumbers,
  ) {
    if (phoneNumbers.isNotNull) {
      initialPhoneNumberValue = phoneNumbers!;
    }
    userEnteredPhoneNumber =
        '+${phoneNumbers?.countryCode} ${phoneNumbers?.getFormattedNsn().trim()}';
    final String countryDialCode = '+${phoneNumbers?.countryCode ?? '+966'}';
    final String country = phoneNumbers?.isoCode.name ?? 'SA';
    final result = getValidator(isAllowEmpty: false);
    phoneValidation = result?.call(initialPhoneNumberValue);

    if (phoneValidation != null && phoneValidation!.isNotEmpty) {
      valueNotifierPhoneNumberVerification.value =
          PhoneNumberVerification.invalid;
    } else {
      if (phoneValidation == null &&
          phoneNumbers != null &&
          phoneNumbers.getFormattedNsn().trim().isNotEmpty) {
        valueNotifierPhoneNumberVerification.value =
            PhoneNumberVerification.valid;
      } else {
        valueNotifierPhoneNumberVerification.value =
            PhoneNumberVerification.none;
      }
    }
    //setState(() {});
  }

  void phoneNumberValidationChanged(
    String? value,
    PhoneNumber? phoneNumbers,
    PhoneController phoneNumberControllers,
  ) {
    phoneValidation = value;
    if (phoneNumbers.isNotNull) {
      initialPhoneNumberValue = phoneNumbers!;
    }
    userEnteredPhoneNumber =
        '+${phoneNumbers?.countryCode} ${phoneNumbers?.getFormattedNsn().trim()}';
    controller = phoneNumberControllers;
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

  PhoneNumberInputValidator? getValidator({bool isAllowEmpty = false}) {
    List<PhoneNumberInputValidator> validators = [];
    if (!isAllowEmpty) {
      validators.add(
        PhoneValidator.required(errorText: "Phone number can't be empty"),
      );
    }

    if (mobileOnly) {
      validators.add(PhoneValidator.validMobile(allowEmpty: isAllowEmpty));
    } else {
      validators.add(PhoneValidator.valid(allowEmpty: isAllowEmpty));
    }
    //update();
    return validators.isNotEmpty ? PhoneValidator.compose(validators) : null;
  }

  void checkBoxOnChanged(bool? onChange) {
    checkBoxValue = onChange!;
    setState(() {});
  }

  void onToggleButtonPressed(int index) {
    for (int i = 0; i < isToggleButtonSelected.length; i++) {
      isToggleButtonSelected[i] = i == index;
    }
    indexOfSaveAddress = index;
    valueOfSavedAddress = valueOfToggleButtonSelected[index];
    setState(() {});
  }

  String? validateAddressType(bool? value) {
    return ValidatorGroup<bool>([
      CustomValidator<bool>(
        validator: (value) {
          final bool result =
              isToggleButtonSelected.any((element) => element == true);
          if (!result) {
            addressTypeValidation = 'Select any one address type';
            return addressTypeValidation;
          }
          return null;
        },
      ),
    ]).validate(value);
  }

  void setAddressEntityData(AddressModel? sharedAddressModel,
      {GBData? locationAddressData}) {
    if (sharedAddressModel.isNotNull && sharedAddressModel!.address != null) {
      areaTextFieldController.text = sharedAddressModel!.address?.area ?? '';
      mapAddressTextFieldController.text =
          sharedAddressModel!.address?.displayAddressName ?? '';
      districtAddressTextFieldController.text =
          sharedAddressModel!.address?.district ?? '';
      zipCodeTextFieldController.text =
          sharedAddressModel!.address?.postalCode.toString() ?? '';
      cityTextFieldController.text = sharedAddressModel!.address?.city ?? '';
      stateTextFieldController.text = sharedAddressModel!.address?.state ?? '';
      countryTextFieldController.text =
          sharedAddressModel!.address?.country ?? '';
      fullNameTextFieldController.text = sharedAddressModel!.fullName ?? '';
      if (sharedAddressModel!.phoneNumber != null) {
        mobileNumberTextFieldController.text =
            sharedAddressModel!.phoneNumber.toString();
      }
      buildingTextFieldController.text =
          sharedAddressModel!.address?.apartment ?? '';
      landmarkTextFieldController.text =
          sharedAddressModel!.address?.landmark ?? '';
      checkBoxValue = sharedAddressModel!.address?.isDefault ?? false;
      //isToggleButtonSelected
      if (sharedAddressModel!.address?.indexOfSavedAddressAs != null) {
        int? index = sharedAddressModel!.address?.indexOfSavedAddressAs!;
        isToggleButtonSelected[index!] = true;
        indexOfSaveAddress = index;
        valueOfSavedAddress = valueOfToggleButtonSelected[index];
      }
      // Phone number information
      mobileNumberTextFieldController.clear();
      mobileNumberTextFieldController.text =
          sharedAddressModel!.phoneNumber ?? '';
      initialPhoneNumberValue = PhoneNumber(
        isoCode:
            isoCodeNameMap.values.byName(sharedAddressModel!.isoCode ?? 'SA'),
        nsn: sharedAddressModel!.phoneNumber ?? '',
      );
      controller.value = PhoneNumber(
        isoCode:
            isoCodeNameMap.values.byName(sharedAddressModel!.isoCode ?? 'SA'),
        nsn: sharedAddressModel!.phoneNumber ?? '',
      );
      defaultCountry =
          isoCodeNameMap.values.byName(sharedAddressModel!.isoCode ?? 'SA');
      //phoneValidation = controller.phoneKey.currentState?.errorText;
    }
    if (locationAddressData.isNotNull &&
        locationAddressData!.address.isNotNull) {
      if (areaTextFieldController.text.isEmpty) {
        areaTextFieldController.text = locationAddressData.address?.village ??
            locationAddressData.address?.city ??
            locationAddressData.address?.county ??
            '';
      }
      if (mapAddressTextFieldController.text.isEmpty) {
        mapAddressTextFieldController.text =
            locationAddressData.displayName ?? '';
      }
      if (districtAddressTextFieldController.text.isEmpty) {
        districtAddressTextFieldController.text =
            locationAddressData.address?.cityDistrict ??
                locationAddressData.address?.stateDistrict ??
                '';
      }
      if (zipCodeTextFieldController.text.isEmpty) {
        zipCodeTextFieldController.text =
            locationAddressData.address?.postcode ?? '';
      }
      if (cityTextFieldController.text.isEmpty) {
        cityTextFieldController.text = locationAddressData.address?.city ??
            locationAddressData.address?.town ??
            locationAddressData.address?.suburb ??
            locationAddressData.address?.municipality ??
            locationAddressData.address?.cityDistrict ??
            locationAddressData.address?.stateDistrict ??
            '';
      }
      if (stateTextFieldController.text.isEmpty) {
        stateTextFieldController.text =
            locationAddressData.address?.state ?? '';
      }
      if (countryTextFieldController.text.isEmpty) {
        countryTextFieldController.text =
            locationAddressData.address?.country ?? '';
      }
    }
  }

  @override
  Widget build(BuildContext context) => BlocListener<AddressBloc, AddressState>(
        key: const Key('address-form-bloc-listener'),
        bloc: context.watch<AddressBloc>(),
        listener: (context, addressState) {
          switch (addressState) {
            case SaveAddressState():
              {
                appLog.d(
                    'SaveAddressState ${addressState.addressEntity.toMap()}');
                if (context.canPop()) {
                  context.pop();
                  context.pop();
                  //context.pop();
                  //context.pop();
                  //context.pushReplacement(Routes.ALL_SAVED_ADDRESS_LIST);
                }
              }
            case GetAddressByIDState():
              {
                final addressEntity = addressState.addressEntity;
                if (addressEntity.isNotNull) {
                  setAddressEntityData(addressEntity);
                }
              }
            case AddressProcessingState():
              {
                if (addressState.addressStatus == AddressStatus.saveAddress) {
                } else if (addressState.addressStatus ==
                    AddressStatus.getAddress) {}
              }
            case AddressExceptionState():
              {
                if (addressState.addressStatus == AddressStatus.saveAddress) {
                } else if (addressState.addressStatus ==
                    AddressStatus.getAddress) {}
              }
            case AddressFailedState():
              {
                if (addressState.addressStatus == AddressStatus.saveAddress) {
                } else if (addressState.addressStatus ==
                    AddressStatus.getAddress) {}
              }
            case _:
              appLog.d('Default case: address form page');
          }
        },
        child: _AddressFormPageView(this),
      );
}

class _AddressFormPageView
    extends WidgetView<AddressFormPage, _AddressFormPageController> {
  const _AddressFormPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding =
        margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = media.padding.bottom + margins;
    final double width = media.size.width;
    final ThemeData theme = Theme.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
        noAppBar: true,
      ),
      child: Scaffold(
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
              child: LanguageSelectionWidget(),
            ),
          ],
        ),
        body: Directionality(
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
          child: SlideInLeft(
            key: const Key('address-form-page-slideleft-widget'),
            delay: const Duration(milliseconds: 500),
            child: PageBody(
              controller: state.scrollController,
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: media.size.height,
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
                    padding: EdgeInsetsDirectional.only(
                      top: topPadding,
                      start: margins * 2.5,
                      end: margins * 2.5,
                      //bottom: bottomPadding,
                    ),
                    child: Form(
                      key: state.addressFormPageFormKey,
                      child: CustomScrollView(
                        controller: state.innerScrollController,
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
                                    Align(
                                      alignment: AlignmentDirectional.topStart,
                                      child: Text(
                                        'Address Details',
                                        style: context.titleLarge,
                                        textDirection:
                                            serviceLocator<LanguageController>()
                                                .targetTextDirection,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ).translate(),
                                    ),
                                    const AnimatedGap(6,
                                        duration: Duration(milliseconds: 500)),
                                    /*AddressFormMakerWidget(
                                      key: const Key('address-user-mobile-number'),
                                      title: 'Mobile number',
                                      child: PhoneNumberFieldWidget(
                                        //key: Key('address-phone-number-widget'),
                                        isCountryChipPersistent: false,
                                        outlineBorder: true,
                                        selectorNavigator: const CountrySelectorNavigator.searchDelegate(),
                                        shouldFormat: true,
                                        useRtl: false,
                                        withLabel: true,
                                        decoration: InputDecoration(
                                          hintText: 'Required',
                                          errorText: state.phoneValidation,
                                          helperText: "We'll call this number to coordinate delivery",
                                          isDense: true,
                                        ),
                                        isAllowEmpty: false,
                                        autofocus: false,
                                        style: context.bodyLarge,
                                        showFlagInInput: false,
                                        countryCodeStyle: context.bodyLarge,
                                        initialPhoneNumberValue: state.initialPhoneNumberValue,
                                        onPhoneNumberChanged: state.onPhoneNumberChanged,
                                        //phoneNumberValidationChanged: phoneNumberValidationChanged,
                                        haveStateManagement: false,
                                        keyboardType: const TextInputType.numberWithOptions(),
                                        textInputAction: TextInputAction.done,
                                      ),
                                    ),
                                    AddressFormMakerWidget(
                                      key: const Key('address-user-full-name'),
                                      title: 'Full name (First and Last name)',
                                      child: AppTextFieldWidget(
                                        controller: state.fullNameTextFieldController,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          hintText: 'Required',
                                          isDense: true,
                                        ),
                                        validator: (value) {
                                          return const ValidatorGroup<String>([
                                            RequiredValidator<String>(errorMessage: 'Enter full name'),
                                          ]).validate(value);
                                        },
                                      ),
                                    ),*/
                                    AddressFormMakerWidget(
                                      key: const Key(
                                          'address-user-flat-building'),
                                      title:
                                          'Flat, House no., Building, Company, Apartment',
                                      child: AppTextFieldWidget(
                                        controller:
                                            state.buildingTextFieldController,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          hintText: 'Optional',
                                          isDense: true,
                                        ),
                                        textDirection:
                                            serviceLocator<LanguageController>()
                                                .targetTextDirection,
                                      ),
                                    ),
                                    AddressFormMakerWidget(
                                      key:
                                          const Key('address-user-area-street'),
                                      title: 'Area, Street, Sector, Village',
                                      child: AppTextFieldWidget(
                                        controller:
                                            state.areaTextFieldController,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          hintText: 'Optional',
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    AddressFormMakerWidget(
                                      key: const Key('address-user-landmark'),
                                      title: 'Landmark',
                                      child: AppTextFieldWidget(
                                        controller:
                                            state.landmarkTextFieldController,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          hintText: 'Optional',
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    AddressFormMakerWidget(
                                      key:
                                          const Key('address-user-map-address'),
                                      title: 'Selected address',
                                      child: AppTextFieldWidget(
                                        controller:
                                            state.mapAddressTextFieldController,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          hintText: 'Required',
                                          helperText:
                                              'Your selected location is being shown here from the map',
                                          isDense: true,
                                          hintMaxLines: 2,
                                        ),
                                        validator: (value) {
                                          return const ValidatorGroup<String>([
                                            RequiredValidator<String>(
                                                errorMessage:
                                                    'Select your location address'),
                                          ]).validate(value);
                                        },
                                      ),
                                    ),
                                    AddressFormMakerWidget(
                                      key: const Key('address-user-district'),
                                      title: 'District',
                                      child: AppTextFieldWidget(
                                        controller: state
                                            .districtAddressTextFieldController,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          hintText: 'Optional',
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    AddressFormMakerWidget(
                                      key: const Key('address-user-zipcode'),
                                      title: 'Postal code',
                                      child: AppTextFieldWidget(
                                        controller:
                                            state.zipCodeTextFieldController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          hintText: 'Optional',
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    AddressFormMakerWidget(
                                      key: const Key('address-user-city'),
                                      title: 'City or Town',
                                      child: AppTextFieldWidget(
                                        controller:
                                            state.cityTextFieldController,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          hintText: 'Required',
                                          isDense: true,
                                        ),
                                        validator: (value) {
                                          return const ValidatorGroup<String>([
                                            RequiredValidator<String>(
                                                errorMessage:
                                                    'Enter your city or town'),
                                          ]).validate(value);
                                        },
                                      ),
                                    ),
                                    AddressFormMakerWidget(
                                      key: const Key('address-user-state'),
                                      title: 'State',
                                      child: AppTextFieldWidget(
                                        controller:
                                            state.stateTextFieldController,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          hintText: 'Required',
                                          isDense: true,
                                        ),
                                        enabled: false,
                                        validator: (value) {
                                          return const ValidatorGroup<String>([
                                            RequiredValidator<String>(
                                                errorMessage:
                                                    'Enter your state'),
                                          ]).validate(value);
                                        },
                                      ),
                                    ),
                                    AddressFormMakerWidget(
                                      key: const Key('address-user-country'),
                                      title: 'Country',
                                      gap: 1,
                                      child: AppTextFieldWidget(
                                        controller:
                                            state.countryTextFieldController,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          hintText: 'Required',
                                          isDense: true,
                                        ),
                                        enabled: false,
                                        validator: (value) {
                                          return const ValidatorGroup<String>([
                                            RequiredValidator<String>(
                                                errorMessage:
                                                    'Enter your country'),
                                          ]).validate(value);
                                        },
                                      ),
                                    ),
                                    ListTileTheme(
                                      contentPadding: EdgeInsets.zero,
                                      minVerticalPadding: 2,
                                      horizontalTitleGap: 0,
                                      child: CheckboxListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        title: const Text(
                                            'Make this is my default address'),
                                        value: state.checkBoxValue,
                                        onChanged: state.checkBoxOnChanged,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    AddressFormMakerWidget(
                                      key: const Key(
                                          'address-user-address-type'),
                                      title: 'Save address as',
                                      child: Flexible(
                                        child: FormField<bool>(
                                          initialValue:
                                              state.isToggleButtonSelected[0],
                                          validator: (value) {
                                            return state
                                                .validateAddressType(value!);
                                          },
                                          builder:
                                              (FormFieldState<bool> field) {
                                            return InputDecorator(
                                              decoration: InputDecoration(
                                                errorText:
                                                    state.addressTypeValidation,
                                                contentPadding: EdgeInsets.zero,
                                                border: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                focusedErrorBorder:
                                                    InputBorder.none,
                                                isDense: true,
                                              ),
                                              child: ScrollableRow(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ToggleButtons(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color: context
                                                                .colorScheme
                                                                .secondary,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(6)),
                                                    selectedBorderColor: context
                                                        .colorScheme.primary,
                                                    borderColor: context
                                                        .colorScheme.primary
                                                        .withOpacity(0.7),
                                                    selectedColor: Colors.white,
                                                    constraints:
                                                        const BoxConstraints(
                                                            minHeight: 44),
                                                    color: context
                                                        .colorScheme.primary,
                                                    fillColor: context
                                                        .colorScheme.primary,
                                                    isSelected: state
                                                        .isToggleButtonSelected,
                                                    onPressed: state
                                                        .onToggleButtonPressed,
                                                    children: state
                                                        .valueOfToggleButtonSelected
                                                        .map((name) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 12),
                                                        child: Text(
                                                          name,
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (state.addressFormPageFormKey
                                            .currentState!
                                            .validate()) {
                                          state.addressFormPageFormKey
                                              .currentState!
                                              .save();
                                          if (widget.hasViewAddress) {
                                            // View Address
                                            return;
                                          } else {
                                            /*  'locationData': locationAddressData,
                                        'latitude': defaultLatLng.latitude,
                                        'longitude': defaultLatLng.longitude,
                                        'addressModel': addressModel,*/
                                            final addressInfo = AddressModel(
                                              isDefault: state.checkBoxValue,
                                              address: AddressBean(
                                                city: state
                                                    .cityTextFieldController
                                                    .value
                                                    .text
                                                    .trim(),
                                                state: state
                                                    .stateTextFieldController
                                                    .value
                                                    .text
                                                    .trim(),
                                                country: state
                                                    .countryTextFieldController
                                                    .value
                                                    .text
                                                    .trim(),
                                                savedAddressAs:
                                                    state.valueOfSavedAddress,
                                                indexOfSavedAddressAs:
                                                    state.indexOfSaveAddress,
                                                addressType: state
                                                    .locationAddressData
                                                    .addresstype,
                                                apartment: state
                                                    .buildingTextFieldController
                                                    .value
                                                    .text,
                                                area: state
                                                    .areaTextFieldController
                                                    .value
                                                    .text,
                                                category: state
                                                    .locationAddressData
                                                    .category,
                                                cityCode: -1,
                                                cityDistrict: state
                                                    .locationAddressData
                                                    .address
                                                    ?.cityDistrict,
                                                countryCode: -1,
                                                county: state
                                                    .locationAddressData
                                                    .address
                                                    ?.county,
                                                district: state
                                                    .districtAddressTextFieldController
                                                    .value
                                                    .text
                                                    .trim(),
                                                //isDefault: checkBoxValue,
                                                landmark: state
                                                    .landmarkTextFieldController
                                                    .value
                                                    .text
                                                    .trim(),
                                                latitude: state.latitude,
                                                longitude: state.longitude,
                                                municipality: state
                                                    .locationAddressData
                                                    .address
                                                    ?.municipality,
                                                osmId: state
                                                    .locationAddressData.id,
                                                osmType: state
                                                    .locationAddressData
                                                    .osmType,
                                                pickupAddress: state
                                                    .locationAddressData
                                                    .displayName,
                                                placeId: state
                                                    .locationAddressData
                                                    .placeId,
                                                placeRank: state
                                                    .locationAddressData
                                                    .placeRank,
                                                postalCode: int.parse(state
                                                    .zipCodeTextFieldController
                                                    .value
                                                    .text
                                                    .trim()),
                                                road: state.locationAddressData
                                                    .address?.road,
                                                stateCode: -1,
                                                stateDistrict: state
                                                    .locationAddressData
                                                    .address
                                                    ?.stateDistrict,
                                                suburb: state
                                                    .locationAddressData
                                                    .address
                                                    ?.suburb,
                                                town: state.locationAddressData
                                                    .address?.town,
                                                type: state
                                                    .locationAddressData.type,
                                                village: state
                                                    .locationAddressData
                                                    .address
                                                    ?.village,
                                                displayAddressName: state
                                                    .mapAddressTextFieldController
                                                    .value
                                                    .text
                                                    .trim(),
                                              ),
                                            );
                                            AddressModel addressModel;
                                            if (!widget.hasNewAddress &&
                                                widget.addressModel.isNotNull) {
                                              // Edit Address
                                              addressModel =
                                                  addressInfo.copyWith(
                                                addressID: widget
                                                    .addressModel?.addressID,
                                              );
                                            } else {
                                              // New Address
                                              addressModel =
                                                  addressInfo.copyWith();
                                            }
                                            if (!state.mounted) {
                                              return;
                                            }
                                            context
                                                .read<AddressBloc>()
                                                .add(SaveAddress(
                                                  addressEntity: addressModel,
                                                  hasNewAddress:
                                                      widget.hasNewAddress,
                                                ));
                                            return;
                                          }
                                          return;
                                        }
                                        return;
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            69, 201, 125, 1),
                                      ),
                                      child: Text(
                                        'Save Address',
                                        textDirection:
                                            serviceLocator<LanguageController>()
                                                .targetTextDirection,
                                      ).translate(),
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
}
