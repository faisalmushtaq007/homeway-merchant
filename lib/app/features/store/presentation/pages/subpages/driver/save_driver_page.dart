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

  static final GlobalKey<FormState> SaveDriverFormKey =
      GlobalKey<FormState>(debugLabel: 'save-driver--formkey');
  List<FocusNode> focusList = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  final TextEditingController driverNameTextEditingController =
      TextEditingController();
  final TextEditingController driverContactNumberTextEditingController =
      TextEditingController();
  final TextEditingController drivingLicenseNumberTextEditingController =
      TextEditingController();
  final TextEditingController driverVehicleNumberTextEditingController =
      TextEditingController();
  final TextEditingController driverDeliveryTypeNumberTextEditingController =
      TextEditingController();
  final TextEditingController addonsUnitTextEditingController =
      TextEditingController();
  List<StoreOwnDeliveryPartnersInfo> listOfStoreOwnDeliveryPartners = [];
  List<StoreOwnDeliveryPartnersInfo> listOfSelectedStoreOwnDeliveryPartner = [];
  List<VehicleInfo> listOfVehicleTypeInfo = [];
  List<VehicleInfo> listOfInitialSelectedVehicleTypeInfo = [];
  List<VehicleInfo> listOfSelectedVehicleTypeInfo = [];
  String currency = 'SAR';
  String unit = '';
  String? phoneValidation;
  Widget? suffixIcon;
  String userEnteredPhoneNumber = '';
  late PhoneNumber phoneNumber;
  late PhoneController phoneNumberController;
  PhoneNumberVerification phoneNumberVerification =
      PhoneNumberVerification.none;
  ValueNotifier<PhoneNumberVerification> valueNotifierPhoneNumberVerification =
      ValueNotifier<PhoneNumberVerification>(
    PhoneNumberVerification.none,
  );
  String userImagePath = '';
  final isoCodeNameMap = IsoCode.values.asNameMap();
  IsoCode defaultCountry = IsoCode.SA;
  NewBusinessDocumentEntity? newBusinessDocumentEntity;

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
    listOfInitialSelectedVehicleTypeInfo = [];
    phoneNumber = PhoneNumber(
      isoCode: IsoCode.values.asNameMap().values.byName('SA'),
      nsn: '',
    );
    phoneNumberController = PhoneController(
      initialValue: PhoneNumber(
        isoCode: IsoCode.values.asNameMap().values.byName('SA'),
        nsn: '',
      ),
    );
    defaultCountry = IsoCode.values.byName('SA');
    initVehicleTypeInfo();
    initStoreOwnDeliveryPartners(widget.storeOwnDeliveryPartnersInfo);
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
    driverDeliveryTypeNumberTextEditingController.dispose();
    listOfStoreOwnDeliveryPartners = [];
    listOfSelectedStoreOwnDeliveryPartner = [];
    listOfVehicleTypeInfo = [];
    listOfSelectedVehicleTypeInfo = [];
    listOfInitialSelectedVehicleTypeInfo = [];
    focusList.asMap().forEach((key, value) => value.dispose());
    super.dispose();
  }

  void initVehicleTypeInfo() {
    listOfVehicleTypeInfo =
        List<VehicleInfo>.from(localDriverVehicleType.toList());
  }

  void onSelectionChangedVehicleType(List<VehicleInfo> selectedMenuPortions) {
    listOfSelectedVehicleTypeInfo =
        List<VehicleInfo>.from(selectedMenuPortions.toList());
    setState(() {});
    return;
  }

  void _nextButtonOnPressed() {
    return;
  }

  void onPhoneNumberChanged(
    PhoneNumber? phoneNumbers,
  ) {
    if(phoneNumbers!=null) {
      phoneNumber = phoneNumbers;
      userEnteredPhoneNumber =
      '+${phoneNumbers?.countryCode} ${phoneNumbers?.formatNsn(
        isoCode: phoneNumbers.isoCode,
      ).trim()}';
      String countryDialCode = '+${phoneNumbers?.countryCode ?? '+966'}';
      String country = phoneNumbers?.isoCode.name ?? 'SA';
      driverContactNumberTextEditingController.text = userEnteredPhoneNumber;
      //setState(() {});
    }
  }

  void phoneNumberValidationChanged(
    String? value,
    PhoneNumber? phoneNumbers,
    PhoneController phoneNumberControllers,
  ) {
    if(phoneNumbers!=null) {
      phoneValidation = value;
      phoneNumber = phoneNumbers;
      phoneNumberController = phoneNumberControllers;
      if (phoneValidation != null && phoneValidation!.isNotEmpty) {
        phoneNumberVerification = PhoneNumberVerification.invalid;
        valueNotifierPhoneNumberVerification.value =
            PhoneNumberVerification.invalid;
      } else {
        if (phoneValidation == null &&
            phoneNumberControllers.value
                .formatNsn(
              isoCode: phoneNumbers?.isoCode,
            )
                .trim()
                .isNotEmpty) {
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
  }

  void onPhoneNumberSaved(PhoneNumber? value) {}

  String? phoneNumberValidator(PhoneNumber? phoneNumber) {
    //
  }

  void updateDriverDeliveryType(String deliveryType) {
    setState(() {
      driverDeliveryTypeNumberTextEditingController.text = deliveryType;
    });
    return;
  }

  void updateUserProfileImage(String profileImage) {
    userImagePath = profileImage;
    setState(() {});
  }

  void initStoreOwnDeliveryPartners(
    StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnersInfo,
  ) {
    if (storeOwnDeliveryPartnersInfo.isNotNull) {
      drivingLicenseNumberTextEditingController.text =
          storeOwnDeliveryPartnersInfo?.drivingLicenseNumber ?? '';
      driverNameTextEditingController.text =
          storeOwnDeliveryPartnersInfo?.driverName ?? '';
      driverContactNumberTextEditingController.text =
          storeOwnDeliveryPartnersInfo?.driverMobileNumber ?? '';

      driverDeliveryTypeNumberTextEditingController.text =
          storeOwnDeliveryPartnersInfo?.deliveryMode ?? '';
      if (storeOwnDeliveryPartnersInfo?.vehicleInfo != null) {
        listOfInitialSelectedVehicleTypeInfo = [
          storeOwnDeliveryPartnersInfo!.vehicleInfo!,
        ];
        driverVehicleNumberTextEditingController.text =
            storeOwnDeliveryPartnersInfo?.vehicleInfo?.vehicleNumber ?? '';
      }
      phoneNumber = PhoneNumber(
        isoCode: IsoCode.values
            .byName(storeOwnDeliveryPartnersInfo?.isoCode ?? 'SA'),
        nsn: storeOwnDeliveryPartnersInfo?.phoneNumberWithoutDialCode ?? '',
      );
      phoneNumberController = PhoneController(initialValue: phoneNumber);
      phoneNumberController.value = phoneNumber;
      userEnteredPhoneNumber =
          storeOwnDeliveryPartnersInfo?.driverMobileNumber ?? '';
      defaultCountry =
          IsoCode.values.byName(storeOwnDeliveryPartnersInfo?.isoCode ?? 'SA');
    }
  }

  void uploadDrivingLicense(
    Map<String, dynamic> mapData,
    CaptureImageEntity captureImageEntity,
  ) {
    newBusinessDocumentEntity = NewBusinessDocumentEntity(
      documentType: captureImageEntity.documentType,
      base64: captureImageEntity.base64Encode,
      captureDocumentID: captureImageEntity.captureDocumentID,
      mimeType: captureImageEntity.mimeType,
      networkAssetPath: captureImageEntity.networkUrl,
      documentIdNumber:
          drivingLicenseNumberTextEditingController.value.text.trim(),
      localAssetPath: captureImageEntity.croppedFilePath.isEmptyOrNull
          ? captureImageEntity.originalFilePath
          : captureImageEntity.croppedFilePath,
      fileExtension: captureImageEntity.fileExtension,
      fileName: captureImageEntity.fileName,
      fileNameWithExtension: captureImageEntity.fileNameWithExtension,
      height: captureImageEntity.height,
      width: captureImageEntity.width,
    );
  }

  @override
  Widget build(BuildContext context) => BlocListener<StoreBloc, StoreState>(
        key: const Key('save-driver-bloclistener-widget'),
        bloc: context.watch<StoreBloc>(),
        listener: (context, driverListenerState) {
          switch (driverListenerState) {
            case NavigateToNewDriverGreetingPageState():
              {
                context.pushReplacement(
                  Routes.NEW_DRIVER_GREETING_PAGE,
                  extra: {
                    'storeOwnDeliveryPartnerEntity':
                        driverListenerState.storeOwnDeliveryPartnerEntity,
                    'haveNewDriver': driverListenerState.hasNewDriver,
                  },
                );
              }
            case GetDriverState():
              {
                initStoreOwnDeliveryPartners(
                    driverListenerState.storeOwnDeliveryPartnerEntity);
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

class _SaveDriverPageView
    extends WidgetView<SaveDriverPage, _SaveDriverPageController> {
  const _SaveDriverPageView(super.state);

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
              'Driver',
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
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
              padding: EdgeInsetsDirectional.only(
                top: topPadding,
                //bottom: bottomPadding,
                start: margins * 2.5,
                end: margins * 2.5,
              ),
              child: Form(
                key: _SaveDriverPageController.SaveDriverFormKey,
                child: CustomScrollView(
                  controller: state.innerScrollController,
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadiusDirectional.circular(6)),
                            child: DisplayImage(
                              imagePath: state.userImagePath,
                              onPressed: () async {
                                final result = await UploadImageUtils()
                                    .selectImagePicker(context);
                                if (result.imagePath.isNotEmpty) {
                                  state.updateUserProfileImage(
                                    result.imagePath,
                                  );
                                } else {}
                              },
                              hasIconImage:
                                  state.userImagePath.isEmpty ? true : false,
                              hasEditButton:
                                  state.userImagePath.isEmpty ? false : true,
                              hasCustomIcon:
                                  state.userImagePath.isEmpty ? true : false,
                              customIcon: Icon(Icons.camera_alt),
                              circularRadius: 40,
                              borderRadius: 10,
                              end: -2,
                              bottom: 1,
                            ),
                          ),
                          const AnimatedGap(
                            6,
                            duration: Duration(milliseconds: 500),
                          ),
                          //const Spacer(),
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Text(
                                'Upload Driver Profile Image',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: context.labelMedium!.copyWith(),
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                              ),
                            ],
                          ),
                          const AnimatedGap(
                            6,
                            duration: Duration(milliseconds: 500),
                          ),
                          const AnimatedGap(
                            12,
                            duration: Duration(milliseconds: 500),
                          ),
                          AppTextFieldWidget(
                            controller: state.driverNameTextEditingController,
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            //focusNode: state.focusList[0],
                            textInputAction: TextInputAction.next,
                            //onFieldSubmitted: (_) => fieldFocusChange(context, state.focusList[0], state.focusList[1]),
                            keyboardType: TextInputType.name,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-z A-Z ]')),
                              FilteringTextInputFormatter.deny('  ')
                            ],
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
                          const AnimatedGap(
                            12,
                            duration: Duration(milliseconds: 500),
                          ),
                          Directionality(
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
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
                              phoneNumberValidationChanged:
                                  state.phoneNumberValidationChanged,
                              haveStateManagement: false,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                            ),
                          ),
                          const AnimatedGap(
                            12,
                            duration: Duration(milliseconds: 500),
                          ),
                          AppTextFieldWidget(
                            controller:
                                state.drivingLicenseNumberTextEditingController,
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            //focusNode: state.focusList[2],
                            textInputAction: TextInputAction.next,
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                              labelText: 'Driving License Number',
                              hintText: 'Enter driving license number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              isDense: true,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter driving license number';
                              }
                              return null;
                            },
                          ),
                          const AnimatedGap(
                            12,
                            duration: Duration(milliseconds: 500),
                          ),
                          NewBusinessDocumentComponentWidget(
                            key: const Key('upload-driver-license-widget'),
                            documentPlaceHolderImage: 'assets/svg/id_card.svg',
                            animate: false,
                            currentIndex: 0,
                            businessDocumentUploadedEntity: (widget
                                        .storeOwnDeliveryPartnersInfo
                                        .isNotNull &&
                                    widget.storeOwnDeliveryPartnersInfo
                                            ?.driverLicenseDocument !=
                                        null)
                                ? widget.storeOwnDeliveryPartnersInfo
                                    ?.driverLicenseDocument
                                : null,
                            selectedImageMetaData: (
                              Map<String, dynamic> metaData,
                              CaptureImageEntity captureImageEntity,
                            ) {
                              state.uploadDrivingLicense(
                                metaData,
                                captureImageEntity,
                              );
                              return;
                            },
                            documentPlaceHolderWidget: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                              children: [
                                Wrap(
                                  textDirection:
                                      serviceLocator<LanguageController>()
                                          .targetTextDirection,
                                  children: [
                                    Text(
                                      'Upload License',
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: context.labelLarge!.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ).translate(),
                                  ],
                                ),
                                const AnimatedGap(
                                  8,
                                  duration: Duration(milliseconds: 100),
                                ),
                                Wrap(
                                  textDirection:
                                      serviceLocator<LanguageController>()
                                          .targetTextDirection,
                                  children: [
                                    Text(
                                      'We accept only',
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: context.labelMedium!.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ).translate(),
                                  ],
                                ),
                                const AnimatedGap(
                                  2,
                                  duration: Duration(milliseconds: 100),
                                ),
                                Wrap(
                                  textDirection:
                                      serviceLocator<LanguageController>()
                                          .targetTextDirection,
                                  children: [
                                    Text(
                                      'Driving License',
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: context.bodySmall!.copyWith(
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ).translate(),
                                  ],
                                ),
                              ],
                            ),
                            documentType: DocumentType.nationalID,
                          ),
                          const AnimatedGap(
                            12,
                            duration: Duration(milliseconds: 500),
                          ),
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
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                              ).translate(),
                              const AnimatedGap(
                                4,
                                duration: Duration(milliseconds: 500),
                              ),
                              Text(
                                'Select the vehicle type of your own driver',
                                style: context.labelMedium,
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                              ).translate(),
                            ],
                          ),
                          const AnimatedGap(
                            6,
                            duration: Duration(milliseconds: 500),
                          ),
                          StoreOwnPartnerVehicleTypeFormField(
                            key: const Key(
                              'store-own-partner-vehicle-type-formfield',
                            ),
                            onSelectionChanged:
                                state.onSelectionChangedVehicleType,
                            availableVehicleInfoList:
                                state.listOfVehicleTypeInfo.toList(),
                            initialVehicleInfoList: state
                                .listOfInitialSelectedVehicleTypeInfo
                                .toList(),
                            onSaved: (newValue) {},
                            isSingleSelect: true,
                            validator: (value) {
                              if (value == null || value.length == 0) {
                                return "Select driver's vehicle type";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const AnimatedGap(
                            12,
                            duration: Duration(milliseconds: 500),
                          ),
                          AppTextFieldWidget(
                            controller:
                                state.driverVehicleNumberTextEditingController,
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
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
                              prefixIcon: const Icon(
                                Icons.drive_eta,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter driver vehicle number';
                              }
                              return null;
                            },
                          ),
                          const AnimatedGap(
                            12,
                            duration: Duration(milliseconds: 500),
                          ),
                          AppTextFieldWidget(
                            controller: state
                                .driverDeliveryTypeNumberTextEditingController,
                            readOnly: true,
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Delivery Mode',
                              hintText: 'Select your delivery mode',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              isDense: true,
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  final result =
                                      await selectDeliveryCategory(context);

                                  if (result != null) {
                                    state.updateDriverDeliveryType(result);
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
                                return 'Select your delivery mode';
                              }
                              return null;
                            },
                            onTap: () async {
                              final result =
                                  await selectDeliveryCategory(context);
                              if (result != null) {
                                state.updateDriverDeliveryType(result);
                              }
                              return;
                            },
                          ),
                          const AnimatedGap(
                            12,
                            duration: Duration(milliseconds: 500),
                          ),
                        ],
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: [
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Form validate and save
                                    if (_SaveDriverPageController
                                        .SaveDriverFormKey.currentState!
                                        .validate()) {
                                      _SaveDriverPageController
                                          .SaveDriverFormKey.currentState!
                                          .save();
                                      StoreOwnDeliveryPartnersInfo
                                          storeOwnDeliveryPartnerEntity;
                                      // Existing driver
                                      if (widget
                                              .haveStoreOwnNewDeliveryPartnersInfo &&
                                          widget.storeOwnDeliveryPartnersInfo !=
                                              null) {
                                        storeOwnDeliveryPartnerEntity = widget
                                            .storeOwnDeliveryPartnersInfo!
                                            .copyWith(
                                          driverMobileNumber:
                                              state.userEnteredPhoneNumber,
                                          drivingLicenseNumber: state
                                              .drivingLicenseNumberTextEditingController
                                              .value
                                              .text
                                              .trim(),
                                          driverName: state
                                              .driverNameTextEditingController
                                              .value
                                              .text
                                              .trim(),
                                          vehicleInfo: VehicleInfo(
                                            vehicleID: state
                                                .listOfSelectedVehicleTypeInfo[
                                                    0]
                                                .vehicleID,
                                            vehicleType: state
                                                .listOfSelectedVehicleTypeInfo[
                                                    0]
                                                .vehicleType,
                                            vehicleNumber: state
                                                .driverVehicleNumberTextEditingController
                                                .value
                                                .text
                                                .trim(),
                                          ),
                                          hasDriverImage:
                                              state.userImagePath.isNotEmpty
                                                  ? true
                                                  : false,
                                          imageEntity: ImageEntity(
                                            imagePath: state.userImagePath,
                                          ),
                                          deliveryMode: state
                                              .driverDeliveryTypeNumberTextEditingController
                                              .value
                                              .text
                                              .trim(),
                                          phoneNumberWithoutDialCode:
                                              state.phoneNumber?.nsn ?? '',
                                          countryDialCode:
                                              state.phoneNumber?.countryCode ??
                                                  '+966',
                                          isoCode:
                                              state.phoneNumber?.isoCode.name ??
                                                  'SA',
                                          driverLicenseDocument:
                                              state.newBusinessDocumentEntity,
                                        );
                                      }
                                      // New driver
                                      else {
                                        storeOwnDeliveryPartnerEntity =
                                            StoreOwnDeliveryPartnersInfo(
                                          driverMobileNumber:
                                              state.userEnteredPhoneNumber,
                                          drivingLicenseNumber: state
                                              .drivingLicenseNumberTextEditingController
                                              .value
                                              .text
                                              .trim(),
                                          driverName: state
                                              .driverNameTextEditingController
                                              .value
                                              .text
                                              .trim(),
                                          vehicleInfo: VehicleInfo(
                                            vehicleID: state
                                                .listOfSelectedVehicleTypeInfo[
                                                    0]
                                                .vehicleID,
                                            vehicleType: state
                                                .listOfSelectedVehicleTypeInfo[
                                                    0]
                                                .vehicleType,
                                            vehicleNumber: state
                                                .driverVehicleNumberTextEditingController
                                                .value
                                                .text
                                                .trim(),
                                          ),
                                          hasDriverImage:
                                              state.userImagePath.isNotEmpty
                                                  ? true
                                                  : false,
                                          imageEntity: ImageEntity(
                                            imagePath: state.userImagePath,
                                          ),
                                          deliveryMode: state
                                              .driverDeliveryTypeNumberTextEditingController
                                              .value
                                              .text
                                              .trim(),
                                          phoneNumberWithoutDialCode:
                                              state.phoneNumber?.nsn ?? '',
                                          countryDialCode:
                                              state.phoneNumber?.countryCode ??
                                                  '+966',
                                          isoCode:
                                              state.phoneNumber?.isoCode.name ??
                                                  'SA',
                                          driverLicenseDocument:
                                              state.newBusinessDocumentEntity,
                                        );
                                      }
                                      // Execute save action
                                      context.read<StoreBloc>().add(
                                            SaveDriver(
                                              haveNewDriver: widget
                                                  .haveStoreOwnNewDeliveryPartnersInfo,
                                              storeOwnDeliveryPartnerEntity:
                                                  storeOwnDeliveryPartnerEntity,
                                            ),
                                          );
                                      return;
                                    }
                                    return;
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(69, 201, 125, 1),
                                  ),
                                  child: Text(
                                    'Save Driver',
                                    textDirection:
                                        serviceLocator<LanguageController>()
                                            .targetTextDirection,
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
    );
  }

  Future<String?> selectDeliveryCategory(BuildContext context) async {
    final String? category = await showConfirmationDialog<String>(
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
              key: const Key('delivery-confirm-dialog'),
              title: 'Delivery Category',
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
                itemCount: driverDeliveryType.length,
                itemBuilder: (context, index) =>
                    _allDriverDeliveryTypes(context, index, setState),
                shrinkWrap: true,
              ),
            );
          },
        );
      },
    );
    return category;
  }

  Widget _allDriverDeliveryTypes(
    BuildContext context,
    int index,
    StateSetter innerSetState,
  ) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: (index == 0)
              ? BorderSide(color: Theme.of(context).dividerColor)
              : BorderSide.none,
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: ListTile(
        dense: true,
        minVerticalPadding: 0,
        minLeadingWidth: 0,
        horizontalTitleGap: 0,
        visualDensity: const VisualDensity(vertical: -1, horizontal: 0),
        title: Text(
          driverDeliveryType[index],
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
        ),
        onTap: () {
          innerSetState(() {});
          Navigator.of(context).pop(driverDeliveryType[index]);
          return;
        },
      ),
    );
  }
}
