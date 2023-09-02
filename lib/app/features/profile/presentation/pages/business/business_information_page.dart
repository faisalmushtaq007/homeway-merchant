part of 'package:homemakers_merchant/app/features/profile/index.dart';

class BusinessInformationPage extends StatefulWidget {
  const BusinessInformationPage({
    super.key,
    this.currentIndex = -1,
    this.hasEditBusinessProfile = false,
    this.businessProfileEntity,
    this.businessTypeEntity,
  });

  final BusinessProfileEntity? businessProfileEntity;
  final bool hasEditBusinessProfile;
  final int currentIndex;
  final BusinessTypeEntity? businessTypeEntity;

  @override
  _BusinessInformationPageState createState() => _BusinessInformationPageState();
}

class _BusinessInformationPageState extends State<BusinessInformationPage> with SingleTickerProviderStateMixin {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  final _createBusinessProfileFormKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _businessNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  String _selectedGender = 'Male';

  // Local PhoneController variables
  String? phoneValidation;
  String userEnteredPhoneNumber = '';
  PhoneNumberVerification phoneNumberVerification = PhoneNumberVerification.none;
  BusinessProfileEntity? businessProfileEntity;
  bool hasEditBusinessProfile = false;
  int currentIndex = -1;
  BusinessTypeEntity? businessTypeEntity;
  final isoCodeNameMap = IsoCode.values.asNameMap();
  IsoCode defaultCountry = IsoCode.SA;
  late PhoneNumber initialPhoneNumberValue;
  late PhoneController controller;
  int businessProfileID = -1;
  ValueNotifier<PhoneNumberVerification> valueNotifierPhoneNumberVerification = ValueNotifier<PhoneNumberVerification>(
    PhoneNumberVerification.none,
  );
  bool mobileOnly = true;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    _usernameController = TextEditingController();
    _businessNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: -1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _animationController.forward();
    businessProfileEntity = widget.businessProfileEntity;
    hasEditBusinessProfile = widget.hasEditBusinessProfile;
    currentIndex = widget.currentIndex;
    businessTypeEntity = widget.businessTypeEntity;
    defaultCountry = IsoCode.values.byName(businessProfileEntity?.isoCode ?? 'SA');
    initialPhoneNumberValue = PhoneNumber(
      isoCode: IsoCode.values.byName(businessProfileEntity?.isoCode ?? 'SA'),
      nsn: businessProfileEntity?.phoneNumberWithoutDialCode ?? '',
    );
    controller = PhoneController(initialPhoneNumberValue);
    controller.value = initialPhoneNumberValue;
    if (mounted) {
      if (widget.hasEditBusinessProfile) {
        context.read<BusinessProfileBloc>().add(GetBusinessProfile(
              businessProfileID: widget.businessProfileEntity?.businessProfileID ?? -1,
              businessProfileEntity: widget.businessProfileEntity,
              index: widget.currentIndex,
            ));
      }
    }
    Future.delayed(const Duration(milliseconds: 300), () {
      context.read<PermissionBloc>().add(const RequestLocationPermissionEvent());
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _usernameController.dispose();
    _businessNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    innerScrollController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void onPhoneNumberChanged(
    PhoneNumber? phoneNumbers,
  ) {
    if (phoneNumbers.isNotNull) {
      initialPhoneNumberValue = phoneNumbers!;
    }
    userEnteredPhoneNumber = '+${phoneNumbers?.countryCode} ${phoneNumbers?.getFormattedNsn().trim()}';
    String countryDialCode = '+${phoneNumbers?.countryCode ?? '+966'}';
    String country = phoneNumbers?.isoCode.name ?? 'SA';
    final result = getValidator(isAllowEmpty: false);
    phoneValidation = result?.call(initialPhoneNumberValue);

    if (phoneValidation != null && phoneValidation!.isNotEmpty) {
      valueNotifierPhoneNumberVerification.value = PhoneNumberVerification.invalid;
    } else {
      if (phoneValidation == null && phoneNumbers != null && phoneNumbers.getFormattedNsn().trim().isNotEmpty) {
        valueNotifierPhoneNumberVerification.value = PhoneNumberVerification.valid;
      } else {
        valueNotifierPhoneNumberVerification.value = PhoneNumberVerification.none;
      }
    }
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
    userEnteredPhoneNumber = '+${phoneNumbers?.countryCode} ${phoneNumbers?.getFormattedNsn().trim()}';
    controller = phoneNumberControllers;
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

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        super.setState(fn);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = media.padding.bottom + margins;
    final double width = media.size.width;
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
        noAppBar: true,
      ),
      child: BlocListener<PermissionBloc, PermissionState>(
        key: const Key(
          'business-profile-permission-bloc-listener-key',
        ),
        bloc: context.read<PermissionBloc>(),
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          // TODO: implement listener
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            actions: const [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          body: Directionality(
            textDirection: serviceLocator<LanguageController>().targetTextDirection,
            child: PageBody(
              controller: scrollController,
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: media.size.height,
              ),
              child: SlideInLeft(
                key: const Key('select-business-information-page-slideleft-widget'),
                delay: const Duration(milliseconds: 500),
                child: Container(
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
                  child: CustomScrollView(
                    controller: innerScrollController,
                    shrinkWrap: true,
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            BlocListener<BusinessProfileBloc, BusinessProfileState>(
                              key: const Key('business-profile-bloc-listener'),
                              bloc: context.read<BusinessProfileBloc>(),
                              listener: (context, state) {
                                switch (state) {
                                  case SaveBusinessProfileState():
                                    {
                                      _usernameController.text = state.businessProfileEntity.userName ?? '';
                                      _addressController.text = state.businessProfileEntity.businessAddress?.address?.area ?? '';
                                      _emailController.text = state.businessProfileEntity.businessEmailAddress ?? '';
                                      _businessNameController.text = state.businessProfileEntity.businessName ?? '';
                                      userEnteredPhoneNumber = state.businessProfileEntity.businessPhoneNumber ?? '';
                                      hasEditBusinessProfile = state.hasEditBusinessProfile;
                                      initialPhoneNumberValue = PhoneNumber(
                                        isoCode: IsoCode.values.byName(state.businessProfileEntity.isoCode ?? 'SA'),
                                        nsn: state.businessProfileEntity.businessPhoneNumber ?? '',
                                      );
                                      controller.value = PhoneNumber(
                                        isoCode: IsoCode.values.byName(state.businessProfileEntity.isoCode ?? 'SA'),
                                        nsn: state.businessProfileEntity.businessPhoneNumber ?? '',
                                      );
                                      defaultCountry = IsoCode.values.byName(state.businessProfileEntity.isoCode ?? 'SA');
                                      context.push(
                                        Routes.CONFIRM_BUSINESS_TYPE_PAGE,
                                        extra: {
                                          'businessProfileEntity': state.businessProfileEntity,
                                          'hasEditBusinessProfile': state.hasEditBusinessProfile,
                                          'currentIndex': state.currentIndex,
                                          'businessTypeEntity': state.businessProfileEntity.businessTypeEntity ?? BusinessTypeEntity(),
                                        },
                                      );
                                    }
                                  case GetBusinessProfileState():
                                    {
                                      businessProfileEntity = state.businessProfileEntity;
                                      businessProfileID = state.businessProfileID;
                                      initialPhoneNumberValue = PhoneNumber(
                                        isoCode: IsoCode.values.byName('SA'),
                                        nsn: businessProfileEntity?.businessPhoneNumber ?? '',
                                      );
                                      _usernameController.text = businessProfileEntity?.userName ?? '';
                                      _addressController.text = businessProfileEntity?.businessAddress?.address?.area ?? '';
                                      _emailController.text = businessProfileEntity?.businessEmailAddress ?? '';
                                      _businessNameController.text = businessProfileEntity?.businessName ?? '';
                                      userEnteredPhoneNumber = businessProfileEntity?.businessPhoneNumber ?? '';
                                      initialPhoneNumberValue = PhoneNumber(
                                        isoCode: IsoCode.values.byName(state.businessProfileEntity?.isoCode ?? 'SA'),
                                        nsn: state.businessProfileEntity?.businessPhoneNumber ?? '',
                                      );
                                      controller.value = PhoneNumber(
                                        isoCode: IsoCode.values.byName(state.businessProfileEntity?.isoCode ?? 'SA'),
                                        nsn: state.businessProfileEntity?.businessPhoneNumber ?? '',
                                      );
                                      defaultCountry = IsoCode.values.byName(state.businessProfileEntity?.isoCode ?? 'SA');
                                    }
                                  case _:
                                    {}
                                }
                              },
                              child: Form(
                                key: _createBusinessProfileFormKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  children: [
                                    Text(
                                      'Enter the business details',
                                      style: context.titleLarge,
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    ).translate(),
                                    const AnimatedGap(
                                      16,
                                      duration: Duration(
                                        milliseconds: 300,
                                      ),
                                    ),
                                    MultiStreamBuilder(
                                      key: const Key(
                                        'business-fullname-textFormField-key',
                                      ),
                                      buildWhen: (previousDataList, latestDataList) => previousDataList != latestDataList,
                                      streams: [
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate('Full name'),
                                        ),
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate('Please enter a full name'),
                                        ),
                                        /*Stream.fromFuture(
                                            AppTranslator.instance.translate(
                                              _usernameController.value.text.trim(),
                                            ),
                                          ),*/
                                      ],
                                      initialStreamValue: const ['Full name', 'Please enter a full name', ''],
                                      builder: (context, snapshot) {
                                        //final String translateString = snapshot[2] as String;
                                        return Directionality(
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          child: AppTextFieldWidget(
                                            controller: _usernameController,
                                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                            decoration: InputDecoration(
                                              labelText: snapshot[0],
                                              isDense: true,
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return '${snapshot[1]}';
                                              }
                                              return null;
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    const AnimatedGap(
                                      16,
                                      duration: Duration(
                                        milliseconds: 300,
                                      ),
                                    ),
                                    MultiStreamBuilder(
                                      key: const Key(
                                        'business-name-textFormField-key',
                                      ),
                                      buildWhen: (previousDataList, latestDataList) => previousDataList != latestDataList,
                                      streams: [
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate('Business name'),
                                        ),
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate(
                                            'Please enter a business name',
                                          ),
                                        ),
                                        /* Stream.fromFuture(
                                            AppTranslator.instance.translate(
                                              _businessNameController.value.text.trim(),
                                            ),
                                          ),*/
                                      ],
                                      initialStreamValue: const ['Business name', 'Please enter a business name', ''],
                                      builder: (context, snapshot) {
                                        return Directionality(
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          child: AppTextFieldWidget(
                                            controller: _businessNameController,
                                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                            decoration: InputDecoration(
                                              labelText: snapshot[0],
                                              isDense: true,
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return '${snapshot[1]}';
                                              }
                                              return null;
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    const AnimatedGap(
                                      16,
                                      duration: Duration(
                                        milliseconds: 300,
                                      ),
                                    ),
                                    MultiStreamBuilder(
                                      key: const Key(
                                        'business-email-address-textFormField-key',
                                      ),
                                      buildWhen: (previousDataList, latestDataList) => previousDataList != latestDataList,
                                      streams: [
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate('Business email address'),
                                        ),
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate(
                                            'Please enter an email address',
                                          ),
                                        ),
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate(
                                            'Please enter a valid email address',
                                          ),
                                        ),
                                        /*Stream.fromFuture(
                                            AppTranslator.instance.translate(
                                              _emailController.value.text.trim(),
                                            ),
                                          ),*/
                                      ],
                                      initialStreamValue: const [
                                        'Business email address',
                                        'Please enter an email address',
                                        'Please enter a valid email address',
                                        ''
                                      ],
                                      builder: (context, snapshot) {
                                        return Directionality(
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          child: AppTextFieldWidget(
                                            controller: _emailController,
                                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                            decoration: InputDecoration(
                                              labelText: snapshot[0],
                                              isDense: true,
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return '${snapshot[1]}';
                                              }
                                              /*else if (!value.contains('@')) {
                                            return 'Please enter a valid email address'.tr();
                                          }*/
                                              else if (!value.hasValidEmailAddress(value)) {
                                                return '${snapshot[2]}';
                                              }
                                              return null;
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    const AnimatedGap(
                                      16,
                                      duration: Duration(
                                        milliseconds: 300,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: BlocBuilder<PhoneFormFieldBloc, PhoneNumberFormFieldState>(
                                            bloc: context.read<PhoneFormFieldBloc>(),
                                            buildWhen: (previous, current) => previous != current,
                                            builder: (context, state) {
                                              state.maybeWhen(
                                                orElse: () {},
                                                validate: (
                                                  isAllowEmpty,
                                                  mobileOnly,
                                                  phoneNumberInputValidator,
                                                  phoneValidation,
                                                  phoneController,
                                                  phoneNumber,
                                                  phoneNumberVerification,
                                                  userEnteredPhoneNumber,
                                                  countryDialCode,
                                                  country,
                                                ) {
                                                  if (phoneNumber != null) {
                                                    initialPhoneNumberValue = phoneNumber;
                                                  }
                                                  controller = phoneController;
                                                  this.phoneNumberVerification = phoneNumberVerification;
                                                  this.userEnteredPhoneNumber = userEnteredPhoneNumber;
                                                },
                                              );
                                              return MultiStreamBuilder(
                                                key: const Key(
                                                  'business-phone-number-textFormField-key',
                                                ),
                                                buildWhen: (
                                                  previousDataList,
                                                  latestDataList,
                                                ) =>
                                                    previousDataList != latestDataList,
                                                streams: [
                                                  Stream.fromFuture(
                                                    AppTranslator.instance.translate(
                                                      'Business phone number',
                                                    ),
                                                  ),
                                                  /*Stream.fromFuture(
                                                      AppTranslator.instance.translate(
                                                        '$phoneValidation',
                                                      ),
                                                    ),*/
                                                ],
                                                initialStreamValue: [
                                                  'Business phone number',
                                                  phoneValidation,
                                                ],
                                                builder: (context, snapshot) {
                                                  return Directionality(
                                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                    child: PhoneNumberFieldWidget(
                                                      key: const Key(
                                                        'user-business-phone-number-widget-key',
                                                      ),
                                                      isCountryChipPersistent: false,
                                                      outlineBorder: true,
                                                      shouldFormat: true,
                                                      useRtl: false,
                                                      withLabel: true,
                                                      decoration: InputDecoration(
                                                        labelText: snapshot[0],
                                                        alignLabelWithHint: true,
                                                        //hintText: 'Mobile number',
                                                        errorText: phoneValidation,
                                                        isDense: true,
                                                      ),
                                                      isAllowEmpty: false,
                                                      autofocus: false,
                                                      style: context.bodyLarge,
                                                      showFlagInInput: false,
                                                      countryCodeStyle: context.bodyLarge,
                                                      initialPhoneNumberValue: initialPhoneNumberValue,
                                                      onPhoneNumberChanged: onPhoneNumberChanged,
                                                      //phoneNumberValidationChanged: phoneNumberValidationChanged,
                                                      haveStateManagement: false,
                                                      keyboardType: const TextInputType.numberWithOptions(),
                                                      textInputAction: TextInputAction.done,
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const AnimatedGap(
                                      16,
                                      duration: Duration(
                                        milliseconds: 300,
                                      ),
                                    ),
                                    MultiStreamBuilder(
                                      key: const Key(
                                        'business-address-textFormField-key',
                                      ),
                                      buildWhen: (previousDataList, latestDataList) => previousDataList != latestDataList,
                                      streams: [
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate('Business address'),
                                        ),
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate('Please enter an address'),
                                        ),
                                        /*Stream.fromFuture(
                                            AppTranslator.instance.translate(
                                              _addressController.value.text.trim(),
                                            ),
                                          ),*/
                                      ],
                                      initialStreamValue: const ['Business address', 'Please enter an address', ''],
                                      builder: (context, snapshot) {
                                        return Directionality(
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          child: AppTextFieldWidget(
                                            controller: _addressController,
                                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                            maxLines: 3,
                                            decoration: InputDecoration(
                                              labelText: snapshot[0],
                                              isDense: true,
                                              suffixIcon: Container(
                                                width: kMinInteractiveDimension * 1.05,
                                                constraints: const BoxConstraints(
                                                  minWidth: kMinInteractiveDimension * 1.05,
                                                  minHeight: kMinInteractiveDimension * 2,
                                                ),
                                                decoration: const BoxDecoration(
                                                  border: BorderDirectional(
                                                    start: BorderSide(
                                                      width: 1.0,
                                                      color: Color.fromRGBO(
                                                        201,
                                                        201,
                                                        203,
                                                        1.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        Icons.my_location,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return '${snapshot[1]}';
                                              }
                                              return null;
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    /*                              const AnimatedGap(
                                  16,
                                  duration: Duration(
                                    milliseconds: 300,
                                  ),
                              ),
                              MultiStreamBuilder(
                                  key: const Key(
                                    'business-fullname-textFormField-key',
                                  ),
                                  buildWhen: (previousDataList, latestDataList) =>
                                      previousDataList != latestDataList,
                                  streams: [
                                    Stream.fromFuture(
                                      AppTranslator.instance.translate('Gender'),
                                    ),
                                    Stream.fromFuture(
                                      AppTranslator.instance.translate('Male'),
                                    ),
                                    Stream.fromFuture(
                                      AppTranslator.instance.translate(
                                        'Female',
                                      ),
                                    ),
                                    Stream.fromFuture(
                                      AppTranslator.instance.translate(
                                        'Other',
                                      ),
                                    ),
                                    Stream.fromFuture(
                                      AppTranslator.instance.translate(
                                        _selectedGender,
                                      ),
                                    ),
                                  ],
                                  initialStreamValue: [
                                    'Gender',
                                    'Male',
                                    'Female',
                                    'Other',
                                    _selectedGender
                                  ],
                                  builder: (context, snapshot) {
                                    return DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: snapshot[0],
                                        isDense: true,
                                      ),
                                      value: snapshot[4],
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: snapshot[1],
                                          child: Text('Male').translate(),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: snapshot[2],
                                          child: Text('Female').translate(),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: snapshot[3],
                                          child: Text('Other').translate(),
                                        ),
                                      ],
                                      onChanged: (String? value) {
                                        setState(() {
                                          _selectedGender = value!;
                                        });
                                      },
                                    );
                                  },
                              ),*/
                                    const AnimatedGap(
                                      16,
                                      duration: Duration(
                                        milliseconds: 300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Spacer(),
                            Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      key: const Key('save-business-profile-button-widget'),
                                      onPressed: () async {
                                        if (_createBusinessProfileFormKey.currentState!.validate()) {
                                          _createBusinessProfileFormKey.currentState!.save();
                                          //await Future.delayed(const Duration(milliseconds: 500), () {});
                                          BusinessProfileEntity businessProfileEntity;
                                          if (widget.hasEditBusinessProfile && widget.businessProfileEntity.isNotNull) {
                                            // Edit
                                            businessProfileEntity = widget.businessProfileEntity!.copyWith(
                                              userName: _usernameController.value.text,
                                              businessAddress: AddressModel(
                                                address: AddressBean(area: _addressController.value.text),
                                              ),
                                              businessEmailAddress: _emailController.value.text,
                                              businessName: _businessNameController.value.text,
                                              businessPhoneNumber: userEnteredPhoneNumber,
                                              businessProfileID: widget.businessProfileEntity?.businessProfileID,
                                              countryDialCode: initialPhoneNumberValue.countryCode,
                                              isoCode: initialPhoneNumberValue.isoCode.name,
                                            );
                                          } else {
                                            // New
                                            businessProfileEntity = BusinessProfileEntity(
                                              userName: _usernameController.value.text,
                                              businessAddress: AddressModel(
                                                address: AddressBean(area: _addressController.value.text),
                                              ),
                                              businessEmailAddress: _emailController.value.text,
                                              businessName: _businessNameController.value.text,
                                              businessPhoneNumber: userEnteredPhoneNumber,
                                              businessTypeEntity: BusinessTypeEntity(),
                                              countryDialCode: initialPhoneNumberValue.countryCode,
                                              isoCode: initialPhoneNumberValue.isoCode.name,
                                            );
                                          }
                                          serviceLocator<AppUserEntity>().currentProfileStatus = CurrentProfileStatus.basicProfileSaved;
                                          serviceLocator<AppUserEntity>().businessProfile = businessProfileEntity;
                                          if (!mounted) {
                                            return;
                                          }
                                          context.read<BusinessProfileBloc>().add(
                                                SaveBusinessProfile(
                                                  businessProfileEntity: businessProfileEntity,
                                                  hasEditBusinessProfile: widget.hasEditBusinessProfile,
                                                  currentIndex: widget.currentIndex,
                                                ),
                                              );
                                        }
                                      },
                                      child: Text(
                                        'Save & Next',
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
