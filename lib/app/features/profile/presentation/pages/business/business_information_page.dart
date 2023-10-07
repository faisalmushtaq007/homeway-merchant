part of 'package:homemakers_merchant/app/features/profile/index.dart';

class BusinessInformationPage extends StatefulWidget {
  const BusinessInformationPage({
    super.key,
    this.currentIndex = -1,
    this.hasEditBusinessProfile = false,
    this.businessProfileEntity,
    this.businessTypeEntity,
    this.selectionUseCase = SelectionUseCase.saveAndNext,
  });

  final BusinessProfileEntity? businessProfileEntity;
  final bool hasEditBusinessProfile;
  final int currentIndex;
  final BusinessTypeEntity? businessTypeEntity;
  final SelectionUseCase selectionUseCase;

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
  AddressModel? addressModel;

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
  final toolTipKey = GlobalKey();
  final phoneNumberToolTipKey = GlobalKey();
  final emailAddressToolTipKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    addressModel = null;
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
    addressModel = null;
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
      if (phoneValidation == null &&
          phoneNumberControllers.value != null &&
          phoneNumberControllers.value!.getFormattedNsn().trim().isNotEmpty) {
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
      child: Directionality(
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        child: DoubleTapToExit(
          key: const Key('business-information-doubleTap'),
          hasEnable: !(widget.selectionUseCase==SelectionUseCase.updateAndReturn || widget.selectionUseCase==SelectionUseCase.saveAndReturn)&&true,
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
                title: const Text('Business Profile'),
                actions: [
                  const LanguageSelectionWidget(),
                ],
              ),
              body: Directionality(
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                child: PageBody(
                  controller: scrollController,
                  constraints: BoxConstraints(
                    minWidth: 1000,
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
                                          _addressController.text = state
                                                  .businessProfileEntity.businessAddress?.address?.displayAddressName ??
                                              '';
                                          _emailController.text =
                                              state.businessProfileEntity.businessEmailAddress ?? '';
                                          _businessNameController.text = state.businessProfileEntity.businessName ?? '';
                                          userEnteredPhoneNumber = state.businessProfileEntity.businessPhoneNumber ??
                                              '+${initialPhoneNumberValue.countryCode} ${initialPhoneNumberValue.getFormattedNsn().trim()}';
                                          hasEditBusinessProfile = state.hasEditBusinessProfile;
                                          addressModel = state.businessProfileEntity.businessAddress;
                                          initialPhoneNumberValue = PhoneNumber(
                                            isoCode: IsoCode.values.byName(state.businessProfileEntity.isoCode ?? 'SA'),
                                            nsn: state.businessProfileEntity.businessPhoneNumber ?? '',
                                          );
                                          controller.value = PhoneNumber(
                                            isoCode: IsoCode.values.byName(state.businessProfileEntity.isoCode ?? 'SA'),
                                            nsn: state.businessProfileEntity.businessPhoneNumber ?? '',
                                          );
                                          defaultCountry =
                                              IsoCode.values.byName(state.businessProfileEntity.isoCode ?? 'SA');
                                          context.pushReplacement(
                                            Routes.CONFIRM_BUSINESS_TYPE_PAGE,
                                            extra: {
                                              'businessProfileEntity': state.businessProfileEntity,
                                              'hasEditBusinessProfile': state.hasEditBusinessProfile,
                                              'currentIndex': state.currentIndex,
                                              'businessTypeEntity': state.businessProfileEntity.businessTypeEntity ??
                                                  BusinessTypeEntity(),
                                              'selectionUseCase': widget.selectionUseCase,
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
                                          _addressController.text =
                                              businessProfileEntity?.businessAddress?.address?.displayAddressName ?? '';
                                          addressModel = businessProfileEntity?.businessAddress;
                                          _emailController.text = businessProfileEntity?.businessEmailAddress ?? '';
                                          _businessNameController.text = businessProfileEntity?.businessName ?? '';
                                          userEnteredPhoneNumber = businessProfileEntity?.businessPhoneNumber ??
                                              '+${initialPhoneNumberValue.countryCode} ${initialPhoneNumberValue.getFormattedNsn().trim()}';
                                          initialPhoneNumberValue = PhoneNumber(
                                            isoCode:
                                                IsoCode.values.byName(state.businessProfileEntity?.isoCode ?? 'SA'),
                                            nsn: state.businessProfileEntity?.businessPhoneNumber ?? '',
                                          );
                                          controller.value = PhoneNumber(
                                            isoCode:
                                                IsoCode.values.byName(state.businessProfileEntity?.isoCode ?? 'SA'),
                                            nsn: state.businessProfileEntity?.businessPhoneNumber ?? '',
                                          );
                                          defaultCountry =
                                              IsoCode.values.byName(state.businessProfileEntity?.isoCode ?? 'SA');
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
                                        const AnimatedGap(
                                          8,
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
                                              AppTranslator.instance.translate('Your Full Name'),
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
                                          initialStreamValue: const ['Your Full Name', 'Please enter a full name', ''],
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
                                                keyboardType: TextInputType.name,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(RegExp('[a-z A-Z ]')),
                                                  FilteringTextInputFormatter.deny('  ')
                                                ],
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
                                          12,
                                          duration: Duration(
                                            milliseconds: 300,
                                          ),
                                        ),
                                        MultiStreamBuilder(
                                          key: const Key(
                                            'business-name-textFormField-key',
                                          ),
                                          buildWhen: (previousDataList, latestDataList) =>
                                              previousDataList != latestDataList,
                                          streams: [
                                            Stream.fromFuture(
                                              AppTranslator.instance.translate('Business name'),
                                            ),
                                            Stream.fromFuture(
                                              AppTranslator.instance.translate(
                                                'Please enter a valid business name',
                                              ),
                                            ),
                                            Stream.fromFuture(
                                              AppTranslator.instance.translate(''
                                                  // _businessNameController.value.text.trim(),
                                                  ),
                                            ),
                                            Stream.fromFuture(
                                              AppTranslator.instance.translate(
                                                'The name of your core business that will appear on HomeWay App.',
                                              ),
                                            ),
                                            Stream.fromFuture(
                                              AppTranslator.instance.translate(
                                                'Your business name must be no longer than 20 characters.',
                                              ),
                                            ),
                                          ],
                                          initialStreamValue: const [
                                            'Business name',
                                            'Please enter a valid business name',
                                            '',
                                            'The name of your core business that will appear on HomeWay App.',
                                            'Your business name must be no longer than 20 characters.'
                                          ],
                                          builder: (context, snapshot) {
                                            return Directionality(
                                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                              child: AppTextFieldWidget(
                                                controller: _businessNameController,
                                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                keyboardType: TextInputType.text,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(RegExp('[a-z A-Z ]')),
                                                  FilteringTextInputFormatter.deny('  '),
                                                  LengthLimitingTextInputFormatter(20),
                                                ],
                                                decoration: InputDecoration(
                                                  labelText: snapshot[0],
                                                  isDense: true,
                                                  suffixIcon: Tooltip(
                                                    triggerMode: TooltipTriggerMode.tap,
                                                    onTriggered: () {
                                                      final dynamic tooltip = toolTipKey.currentState;
                                                      tooltip?.ensureTooltipVisible();
                                                    },
                                                    key: toolTipKey,
                                                    richMessage: TextSpan(
                                                      text: '${snapshot[3]}',
                                                      children: <InlineSpan>[
                                                        TextSpan(
                                                          text: '${snapshot[4]}',
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Icon(
                                                      Icons.info,
                                                      size: 22,
                                                    ),
                                                  ),
                                                ),
                                                //maxLength: 40,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty || value.length > 20) {
                                                    return '${snapshot[1]}';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        const AnimatedGap(
                                          12,
                                          duration: Duration(
                                            milliseconds: 300,
                                          ),
                                        ),
                                        MultiStreamBuilder(
                                          key: const Key(
                                            'business-email-address-textFormField-key',
                                          ),
                                          buildWhen: (previousDataList, latestDataList) =>
                                              previousDataList != latestDataList,
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
                                            Stream.fromFuture(
                                              AppTranslator.instance.translate(
                                                '',
                                              ),
                                            ),
                                            Stream.fromFuture(
                                              AppTranslator.instance.translate(
                                                'A primary email address is required for business.',
                                              ),
                                            ),
                                            Stream.fromFuture(
                                              AppTranslator.instance.translate(
                                                'This address for our Operation team to use to reach your business',
                                              ),
                                            ),
                                          ],
                                          initialStreamValue: const [
                                            'Business email address',
                                            'Please enter an email address',
                                            'Please enter a valid email address',
                                            '',
                                            'A primary email address is required for business.',
                                            'This address for our Operation team to use to reach your business'
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
                                                  suffixIcon: Tooltip(
                                                    triggerMode: TooltipTriggerMode.tap,
                                                    onTriggered: () {
                                                      final dynamic tooltip = emailAddressToolTipKey.currentState;
                                                      tooltip?.ensureTooltipVisible();
                                                    },
                                                    key: emailAddressToolTipKey,
                                                    richMessage: TextSpan(
                                                      text: '${snapshot[4]}',
                                                      children: <InlineSpan>[
                                                        TextSpan(
                                                          text: '${snapshot[5]}',
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Icon(
                                                      Icons.info,
                                                      size: 22,
                                                    ),
                                                  ),
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
                                          12,
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
                                                      Stream.fromFuture(
                                                        AppTranslator.instance.translate(
                                                          '',
                                                        ),
                                                      ),
                                                      Stream.fromFuture(
                                                        AppTranslator.instance.translate(
                                                          'A primary phone number is required for business.',
                                                        ),
                                                      ),
                                                      Stream.fromFuture(
                                                        AppTranslator.instance.translate(
                                                          'This number for our Operation team to use to reach your business',
                                                        ),
                                                      ),
                                                    ],
                                                    initialStreamValue: [
                                                      'Business phone number',
                                                      phoneValidation ?? '',
                                                      'A primary phone number is required for business.',
                                                      'This number for our Operation team to use to reach your business',
                                                    ],
                                                    builder: (context, snapshot) {
                                                      return Directionality(
                                                        textDirection:
                                                            serviceLocator<LanguageController>().targetTextDirection,
                                                        child: PhoneNumberFieldWidget(
                                                          key: const Key(
                                                            'user-business-phone-number-widget-key',
                                                          ),
                                                          isCountryChipPersistent: false,
                                                          outlineBorder: true,
                                                          shouldFormat: true,
                                                          useRtl: false,
                                                          withLabel: true,
                                                          enabled: false,
                                                          decoration: InputDecoration(
                                                            labelText: snapshot[0],
                                                            alignLabelWithHint: true,
                                                            //hintText: 'Mobile number',
                                                            errorText: phoneValidation,
                                                            isDense: true,
                                                            suffixIcon: Tooltip(
                                                              triggerMode: TooltipTriggerMode.tap,
                                                              onTriggered: () {
                                                                final dynamic tooltip =
                                                                    phoneNumberToolTipKey.currentState;
                                                                tooltip?.ensureTooltipVisible();
                                                              },
                                                              key: phoneNumberToolTipKey,
                                                              richMessage: TextSpan(
                                                                text: '${snapshot[2]}',
                                                                children: <InlineSpan>[
                                                                  TextSpan(
                                                                    text: '${snapshot[3]}',
                                                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                                                  ),
                                                                ],
                                                              ),
                                                              child: const Icon(
                                                                Icons.info,
                                                                size: 22,
                                                              ),
                                                            ),
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
                                          12,
                                          duration: Duration(
                                            milliseconds: 300,
                                          ),
                                        ),
                                        MultiStreamBuilder(
                                          key: const Key(
                                            'business-address-textFormField-key',
                                          ),
                                          buildWhen: (previousDataList, latestDataList) =>
                                              previousDataList != latestDataList,
                                          streams: [
                                            Stream.fromFuture(
                                              AppTranslator.instance.translate('Business address'),
                                            ),
                                            Stream.fromFuture(
                                              AppTranslator.instance.translate('Please enter an address'),
                                            ),
                                            Stream.fromFuture(
                                              AppTranslator.instance.translate(
                                                '',
                                              ),
                                            ),
                                          ],
                                          initialStreamValue: const ['Business address', 'Please enter an address', ''],
                                          builder: (context, snapshot) {
                                            return Directionality(
                                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                              child: AppTextFieldWidget(
                                                controller: _addressController,
                                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                maxLines: 3,
                                                readOnly: true,
                                                onTap: () async {
                                                  final result = await context.push<(String, AddressModel)>(
                                                    Routes.ALL_SAVED_ADDRESS_LIST,
                                                    extra: {
                                                      'selectItemUseCase': SelectItemUseCase.onlySelect,
                                                    },
                                                  );
                                                  if (result != null) {
                                                    _addressController.text = result.$1;
                                                    addressModel = result.$2;
                                                    setState(() {});
                                                  }
                                                },
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
                                                          onPressed: () async {
                                                            final result = await context.push<(String, AddressModel)>(
                                                              Routes.ALL_SAVED_ADDRESS_LIST,
                                                              extra: {
                                                                'selectItemUseCase': SelectItemUseCase.onlySelect,
                                                              },
                                                            );
                                                            if (result != null) {
                                                              _addressController.text = result.$1;
                                                              addressModel = result.$2;
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
                                          6,
                                          duration: Duration(
                                            milliseconds: 300,
                                          ),
                                        ),
                                        Wrap(
                                          children: [
                                            Text(
                                              'You may provide address for new businesses to help us place them on the customer app or map. Address is only used when a business is first created in your profile and orders',
                                              style: context.labelMedium!.copyWith(
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 4,
                                              softWrap: true,
                                            ).translate(),
                                          ],
                                        ),
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
                                              if (widget.hasEditBusinessProfile &&
                                                  widget.businessProfileEntity.isNotNull) {
                                                // Edit
                                                businessProfileEntity = widget.businessProfileEntity!.copyWith(
                                                    userName: _usernameController.value.text,
                                                    /*businessAddress: AddressModel(
                                                    address: AddressBean(displayAddressName: _addressController.value.text),
                                                  ),*/
                                                    businessAddress: addressModel,
                                                    businessEmailAddress: _emailController.value.text,
                                                    businessName: _businessNameController.value.text,
                                                    businessPhoneNumber:
                                                        '+${initialPhoneNumberValue.countryCode} ${initialPhoneNumberValue.getFormattedNsn().trim()}' ??
                                                            userEnteredPhoneNumber,
                                                    businessProfileID: widget.businessProfileEntity?.businessProfileID,
                                                    countryDialCode: initialPhoneNumberValue.countryCode,
                                                    isoCode: initialPhoneNumberValue.isoCode.name,
                                                    phoneNumberWithoutDialCode: initialPhoneNumberValue.nsn ?? '');
                                              } else {
                                                // New
                                                businessProfileEntity = BusinessProfileEntity(
                                                  userName: _usernameController.value.text,
                                                  businessAddress: addressModel,
                                                  /*businessAddress: AddressModel(
                                                    address: AddressBean(displayAddressName: _addressController.value.text),
                                                  ),*/
                                                  businessEmailAddress: _emailController.value.text,
                                                  businessName: _businessNameController.value.text,
                                                  businessPhoneNumber:
                                                      '+${initialPhoneNumberValue.countryCode} ${initialPhoneNumberValue.getFormattedNsn().trim()}' ??
                                                          userEnteredPhoneNumber,
                                                  businessTypeEntity: BusinessTypeEntity(),
                                                  countryDialCode: initialPhoneNumberValue.countryCode,
                                                  isoCode: initialPhoneNumberValue.isoCode.name,
                                                  phoneNumberWithoutDialCode: initialPhoneNumberValue.nsn ?? '',
                                                );
                                              }
                                              serviceLocator<AppUserEntity>().currentProfileStatus =
                                                  CurrentProfileStatus.basicProfileSaved;
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
        ),
      ),
    );
  }
}
