part of 'package:homemakers_merchant/app/features/store/index.dart';

class SaveDriverPage extends StatefulWidget {
  const SaveDriverPage({
    super.key,
    this.haveStoreOwnNewDeliveryPartnersInfo = true,
    this.storeOwnDeliveryPartnersInfo,
    this.currentIndex = -1,
  });

  final bool haveStoreOwnNewDeliveryPartnersInfo;
  final StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo;
  final int currentIndex;

  @override
  _SaveDriverPageController createState() => _SaveDriverPageController();
}

class _SaveDriverPageController extends State<SaveDriverPage> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  late final ScrollController listViewBuilderScrollController;

  static final GlobalKey<FormState> SaveDriverFormKey = GlobalKey<FormState>(debugLabel: 'save_addons-formkey');
  List<FocusNode> focusList = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  final TextEditingController driverNameTextEditingController = TextEditingController();
  final TextEditingController driverContactNumberTextEditingController = TextEditingController();
  final TextEditingController drivingLicenseNumberTextEditingController = TextEditingController();
  final TextEditingController driverVehicleNumberTextEditingController = TextEditingController();
  final TextEditingController addonsUnitTextEditingController = TextEditingController();
  List<StoreOwnDeliveryPartnersInfo> listOfStoreOwnDeliveryPartners = [];
  List<StoreOwnDeliveryPartnersInfo> listOfSelectedStoreOwnDeliveryPartner = [];
  List<VehicleInfo> listOfVehicleTypeInfo = [];
  List<VehicleInfo> listOfSelectedVehicleTypeInfo = [];
  String currency = 'SAR';
  String unit = '';
  String? phoneValidation;
  Widget? suffixIcon;
  String userEnteredPhoneNumber = '';
  PhoneNumber? phoneNumber;
  late PhoneController phoneNumberController;
  PhoneNumberVerification phoneNumberVerification = PhoneNumberVerification.none;
  ValueNotifier<PhoneNumberVerification> valueNotifierPhoneNumberVerification = ValueNotifier<PhoneNumberVerification>(
    PhoneNumberVerification.none,
  );

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    listViewBuilderScrollController = ScrollController();
    listOfStoreOwnDeliveryPartners = [];
    listOfSelectedStoreOwnDeliveryPartner = [];
    listOfVehicleTypeInfo = [];
    listOfSelectedVehicleTypeInfo = [];
    phoneNumber = PhoneNumber(
      isoCode: IsoCode.values.asNameMap().values.byName('SA'),
      nsn: '',
    );
    phoneNumberController = PhoneController(
      PhoneNumber(
        isoCode: IsoCode.values.asNameMap().values.byName('SA'),
        nsn: '',
      ),
    );
    initVehicleTypeInfo();
    //initStoreOwnDeliveryPartners();
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
    innerScrollController.dispose();
    listViewBuilderScrollController.dispose();
    drivingLicenseNumberTextEditingController.dispose();
    driverNameTextEditingController.dispose();
    driverContactNumberTextEditingController.dispose();
    driverVehicleNumberTextEditingController.dispose();
    addonsUnitTextEditingController.dispose();
    listOfStoreOwnDeliveryPartners = [];
    listOfSelectedStoreOwnDeliveryPartner = [];
    listOfVehicleTypeInfo = [];
    listOfSelectedVehicleTypeInfo = [];
    focusList.asMap().forEach((key, value) => value.dispose());
    super.dispose();
  }

  void initVehicleTypeInfo() {
    listOfVehicleTypeInfo = List<VehicleInfo>.from(localDriverVehicleType.toList());
  }

  void onSelectionChangedVehicleType(List<VehicleInfo> selectedMenuPortions) {
    listOfSelectedVehicleTypeInfo = List<VehicleInfo>.from(selectedMenuPortions.toList());
    setState(() {});
    return;
  }

  void _nextButtonOnPressed() {
    return;
  }

  void onPhoneNumberChanged(
    PhoneNumber? phoneNumbers,
  ) {
    phoneNumber = phoneNumbers;
    userEnteredPhoneNumber = '+${phoneNumbers?.countryCode} ${phoneNumbers?.getFormattedNsn().trim()}';
    String countryDialCode = '+${phoneNumbers?.countryCode ?? '+966'}';
    String country = phoneNumbers?.isoCode.name ?? 'SA';
    driverContactNumberTextEditingController.text = userEnteredPhoneNumber;
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
      valueNotifierPhoneNumberVerification.value = PhoneNumberVerification.invalid;
    } else {
      if (phoneValidation == null && phoneNumberControllers.value != null && phoneNumberControllers.value!.getFormattedNsn().trim().isNotEmpty) {
        phoneNumberVerification = PhoneNumberVerification.valid;
        valueNotifierPhoneNumberVerification.value = PhoneNumberVerification.valid;
      } else {
        phoneNumberVerification = PhoneNumberVerification.none;
        valueNotifierPhoneNumberVerification.value = PhoneNumberVerification.none;
      }
    }
    //setState(() {});
  }

  void onPhoneNumberSaved(PhoneNumber? value) {}

  String? phoneNumberValidator(PhoneNumber? phoneNumber) {
    //
  }

  @override
  Widget build(BuildContext context) => BlocListener<StoreBloc, StoreState>(
        key: const Key('save-driver-bloclistener-widget'),
        bloc: context.watch<StoreBloc>(),
        listener: (context, driverListenerState) {
          switch (driverListenerState) {
            case NavigateToNewDriverGreetingPageState():
              {
                context.go(
                  Routes.NEW_DRIVER_GREETING_PAGE,
                  extra: {
                    'storeOwnDeliveryPartnerEntity': driverListenerState.storeOwnDeliveryPartnerEntity,
                    'haveNewDriver': driverListenerState.hasNewDriver,
                  },
                );
              }
            case _:
              debugPrint('default');
          }
        },
        child: BlocBuilder<StoreBloc, StoreState>(
          key: const Key('save-driver-blocbuilder-widget'),
          bloc: context.watch<StoreBloc>(),
          builder: (context, driverState) {
            switch (driverState) {
              case SaveDriverState():
                {}
              case _:
                debugPrint('default');
            }
            return _SaveDriverPageView(this);
          },
        ),
      );
}

class _SaveDriverPageView extends WidgetView<SaveDriverPage, _SaveDriverPageController> {
  const _SaveDriverPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
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
              'Driver',
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
            ),
            actions: const [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          body: SlideInLeft(
            key: const Key('save-partner-slideinleft-widget'),
            delay: const Duration(milliseconds: 500),
            from: context.width - 40,
            child: PageBody(
              controller: state.scrollController,
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: media.size.height,
              ),
              child: CustomScrollView(
                controller: state.innerScrollController,
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const AnimatedGap(50, duration: Duration(milliseconds: 500)),
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
                            color: Colors.white,
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
                              SizedBox(
                                height: 26,
                                child: Stack(
                                  alignment: AlignmentDirectional.topCenter,
                                  clipBehavior: Clip.none,
                                  children: [
                                    AnimatedPositioned(
                                      duration: const Duration(milliseconds: 300),
                                      top: -54,
                                      child: DisplayImage(
                                        imagePath: '',
                                        onPressed: () {},
                                        hasIconImage: true,
                                        hasEditButton: false,
                                        hasCustomIcon: true,
                                        customIcon: Icon(Icons.person),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  AnimatedSwitcher(
                                    duration: const Duration(
                                      milliseconds: 500,
                                    ),
                                    child: Text(
                                      '${((!widget.haveStoreOwnNewDeliveryPartnersInfo) && widget.storeOwnDeliveryPartnersInfo?.driverName != null) ? widget.storeOwnDeliveryPartnersInfo?.driverName : 'Add New Driver'}',
                                      style: context.titleLarge!.copyWith(
                                        color: context.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ).translate(),
                                  ),
                                ],
                              ),
                              //const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                              Expanded(
                                flex: 3,
                                child: Form(
                                  key: _SaveDriverPageController.SaveDriverFormKey,
                                  child: ListView(
                                    controller: state.listViewBuilderScrollController,
                                    physics: const ClampingScrollPhysics(),
                                    //shrinkWrap: true,
                                    children: [
                                      const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                      AppTextFieldWidget(
                                        controller: state.driverNameTextEditingController,
                                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        //focusNode: state.focusList[0],
                                        textInputAction: TextInputAction.next,
                                        //onFieldSubmitted: (_) => fieldFocusChange(context, state.focusList[0], state.focusList[1]),
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          labelText: 'Driver name',
                                          hintText: 'Enter driver name',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          isDense: true,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter driver name';
                                          }
                                          return null;
                                        },
                                      ),
                                      const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                      Directionality(
                                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        child: PhoneNumberFieldWidget(
                                          key: const Key('driver-phone-number-widget'),
                                          isCountryChipPersistent: false,
                                          outlineBorder: true,
                                          shouldFormat: true,
                                          useRtl: false,
                                          withLabel: true,
                                          decoration: InputDecoration(
                                            labelText: 'Driver mobile number',
                                            //hintText: 'Enter driver number',
                                            alignLabelWithHint: true,
                                            errorText: state.phoneValidation,
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
                                          //validator: state.phoneNumberValidator,
                                          //suffixIcon: PhoneNumberValidateWidget(phoneNumberVerification: value),
                                          onPhoneNumberChanged: state.onPhoneNumberChanged,
                                          phoneNumberValidator: state.phoneNumberValidator,
                                          onPhoneNumberSaved: state.onPhoneNumberSaved,
                                          phoneNumberValidationChanged: state.phoneNumberValidationChanged,
                                          haveStateManagement: false,
                                          keyboardType: const TextInputType.numberWithOptions(),
                                        ),
                                      ),
                                      const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                      AppTextFieldWidget(
                                        controller: state.drivingLicenseNumberTextEditingController,
                                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        //focusNode: state.focusList[2],
                                        textInputAction: TextInputAction.next,
                                        keyboardType: const TextInputType.numberWithOptions(),
                                        decoration: InputDecoration(
                                          labelText: 'Driving License Number',
                                          hintText: 'Enter driving license number',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          isDense: true,
                                          suffixText: state.currency,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter driving license number';
                                          }
                                          return null;
                                        },
                                      ),
                                      const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            'Vehicle Type',
                                            style: context.titleLarge!.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          ).translate(),
                                          const AnimatedGap(4, duration: Duration(milliseconds: 500)),
                                          Text(
                                            'Select the vehicle type of your own driver',
                                            style: context.labelMedium,
                                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          ).translate(),
                                        ],
                                      ),
                                      const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                      StoreOwnPartnerVehicleTypeFormField(
                                        key: const Key('store-own-partner-vehicle-type-formfield'),
                                        onSelectionChanged: state.onSelectionChangedVehicleType,
                                        availableVehicleInfoList: state.listOfVehicleTypeInfo.toList(),
                                        initialVehicleInfoList: [],
                                        onSaved: (newValue) {},
                                        isSingleSelect: true,
                                      ),
                                      const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                      AppTextFieldWidget(
                                        controller: state.driverVehicleNumberTextEditingController,
                                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        //focusNode: state.focusList[2],
                                        textInputAction: TextInputAction.done,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            labelText: 'Vehicle Number',
                                            hintText: 'Enter driver vehicle number',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            isDense: true,
                                            suffixText: state.currency,
                                            prefixIcon: const Icon(
                                              Icons.drive_eta,
                                            )),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter driver vehicle number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                            ],
                          ),
                        ),
                        const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                        Padding(
                          padding: EdgeInsetsDirectional.symmetric(horizontal: margins * 1.5),
                          child: ElevatedButton(
                            onPressed: () {
                              // Form validate and save
                              if (_SaveDriverPageController.SaveDriverFormKey.currentState!.validate()) {
                                _SaveDriverPageController.SaveDriverFormKey.currentState!.save();
                                StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnerEntity;
                                // Existing driver
                                if (widget.haveStoreOwnNewDeliveryPartnersInfo && widget.storeOwnDeliveryPartnersInfo != null) {
                                  storeOwnDeliveryPartnerEntity = widget.storeOwnDeliveryPartnersInfo!.copyWith(
                                    driverMobileNumber: state.userEnteredPhoneNumber,
                                    drivingLicenseNumber: state.drivingLicenseNumberTextEditingController.value.text.trim(),
                                    driverName: state.driverNameTextEditingController.value.text.trim(),
                                    vehicleInfo: VehicleInfo(
                                      vehicleID: state.listOfSelectedVehicleTypeInfo[0].vehicleID,
                                      vehicleType: state.listOfSelectedVehicleTypeInfo[0].vehicleType,
                                      vehicleNumber: state.listOfSelectedVehicleTypeInfo[0].vehicleNumber,
                                    ),
                                  );
                                }
                                // New driver
                                else {
                                  storeOwnDeliveryPartnerEntity = StoreOwnDeliveryPartnersInfo(
                                    driverMobileNumber: state.userEnteredPhoneNumber,
                                    drivingLicenseNumber: state.drivingLicenseNumberTextEditingController.value.text.trim(),
                                    driverName: state.driverNameTextEditingController.value.text.trim(),
                                    vehicleInfo: VehicleInfo(
                                      vehicleID: state.listOfSelectedVehicleTypeInfo[0].vehicleID,
                                      vehicleType: state.listOfSelectedVehicleTypeInfo[0].vehicleType,
                                      vehicleNumber: state.listOfSelectedVehicleTypeInfo[0].vehicleNumber,
                                    ),
                                  );
                                }
                                // Execute save action
                                context.read<StoreBloc>().add(
                                      SaveDriver(
                                        haveNewDriver: widget.haveStoreOwnNewDeliveryPartnersInfo,
                                        storeOwnDeliveryPartnerEntity: storeOwnDeliveryPartnerEntity,
                                      ),
                                    );
                                return;
                              }
                              return;
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(69, 201, 125, 1),
                            ),
                            child: Text(
                              'Save Driver',
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
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
