part of 'package:homemakers_merchant/app/features/common/index.dart';

class ChangePhoneNumberPage extends StatefulWidget {
  const ChangePhoneNumberPage({
    super.key,
    this.changePhoneNumberPurpose = ChangePhoneNumberPurpose.profile,
    this.phoneNumberWithoutDialCode='',
    this.country='SA',
    this.dialCode='+91',
    this.id=-1,
  });

  final ChangePhoneNumberPurpose changePhoneNumberPurpose;
  final String phoneNumberWithoutDialCode;
  final String dialCode;
  final String country;
  final int id;
  @override
  _ChangePhoneNumberPageController createState() => _ChangePhoneNumberPageController();
}

class _ChangePhoneNumberPageController extends State<ChangePhoneNumberPage> {
  late final ScrollController scrollController;
  late final ScrollController _screenScrollController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late FocusNode existingPhoneNumberFocusNode;
  late FocusNode newPhoneNumberFocusNode;
  List<FocusNode> focusList = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  final TextEditingController existingPhoneNumberTextEditingController = TextEditingController();
  final TextEditingController newPhoneNumberTextEditingController = TextEditingController();

  String country = 'SA';
  String dialCode = '+91';
  String? phoneNumberValidation;
  String? existingPhoneNumberValidation;
  Widget? suffixIcon;
  String userNewEnteredPhoneNumber = '';
  String userExistingEnteredPhoneNumber = '';

  late PhoneNumber? phoneNumber;
  late PhoneController phoneNumberController;
  late PhoneNumber? existingPhoneNumber;
  late PhoneController existingPhoneNumberController;

  PhoneNumberVerification phoneNumberVerification = PhoneNumberVerification.none;
  ValueNotifier<PhoneNumberVerification> valueNotifierPhoneNumberVerification = ValueNotifier<PhoneNumberVerification>(
    PhoneNumberVerification.none,
  );

  PhoneNumberVerification existingPhoneNumberVerification = PhoneNumberVerification.valid;
  ValueNotifier<PhoneNumberVerification> valueNotifierExistingPhoneNumberVerification = ValueNotifier<PhoneNumberVerification>(
    PhoneNumberVerification.valid,
  );

  final isoCodeNameMap = IsoCode.values.asNameMap();
  IsoCode defaultCountry = IsoCode.SA;

  @override
  void initState() {
    super.initState();
    existingPhoneNumberFocusNode = FocusNode();
    newPhoneNumberFocusNode = FocusNode();
    scrollController = ScrollController();
    _screenScrollController = ScrollController();

    existingPhoneNumber = PhoneNumber(
      isoCode: IsoCode.values.asNameMap().values.byName(country),
      nsn: '547533381',//widget.phoneNumberWithoutDialCode,
    );
    existingPhoneNumberController = PhoneController(
      existingPhoneNumber,
    );
    existingPhoneNumberController.value=existingPhoneNumber;

    phoneNumber = PhoneNumber(
      isoCode: IsoCode.values.asNameMap().values.byName(country),
      nsn: '',
    );
    phoneNumberController = PhoneController(
      phoneNumber,
    );
    phoneNumberController.value=phoneNumber;
    defaultCountry = IsoCode.values.byName(country);
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    existingPhoneNumberFocusNode.dispose();
    newPhoneNumberFocusNode.dispose();
    existingPhoneNumberTextEditingController.dispose();
    newPhoneNumberTextEditingController.dispose();
    _screenScrollController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void onExistingPhoneNumberChanged(
      PhoneNumber? phoneNumbers,
      ) {
    existingPhoneNumber = phoneNumbers;
    userExistingEnteredPhoneNumber = '+${phoneNumbers?.countryCode} ${phoneNumbers?.getFormattedNsn().trim()}';
    String countryDialCode = '+${phoneNumbers?.countryCode ?? '+966'}';
    String country = phoneNumbers?.isoCode.name ?? 'SA';
    existingPhoneNumberTextEditingController.text = userExistingEnteredPhoneNumber;
    //setState(() {});
  }

  void existingPhoneNumberValidationChanged(
      String? value,
      PhoneNumber? phoneNumbers,
      PhoneController phoneNumberControllers,
      ) {
    existingPhoneNumberValidation = value;
    existingPhoneNumber = phoneNumbers;
    existingPhoneNumberController = phoneNumberControllers;
    if (existingPhoneNumberValidation != null && existingPhoneNumberValidation!.isNotEmpty) {
      existingPhoneNumberVerification = PhoneNumberVerification.invalid;
      valueNotifierExistingPhoneNumberVerification.value = PhoneNumberVerification.invalid;
    } else {
      if (existingPhoneNumberValidation == null &&
          existingPhoneNumberController.value != null &&
          existingPhoneNumberController.value!.getFormattedNsn().trim().isNotEmpty) {
        existingPhoneNumberVerification = PhoneNumberVerification.valid;
        valueNotifierExistingPhoneNumberVerification.value = PhoneNumberVerification.valid;
      } else {
        existingPhoneNumberVerification = PhoneNumberVerification.none;
        valueNotifierExistingPhoneNumberVerification.value = PhoneNumberVerification.none;
      }
    }
    //setState(() {});
  }

  void onPhoneNumberChanged(
      PhoneNumber? phoneNumbers,
      ) {
    phoneNumber = phoneNumbers;
    userNewEnteredPhoneNumber = '+${phoneNumbers?.countryCode} ${phoneNumbers?.getFormattedNsn().trim()}';
    String countryDialCode = '+${phoneNumbers?.countryCode ?? '+966'}';
    String country = phoneNumbers?.isoCode.name ?? 'SA';
    newPhoneNumberTextEditingController.text = userNewEnteredPhoneNumber;
    //setState(() {});
  }

  void phoneNumberValidationChanged(
      String? value,
      PhoneNumber? phoneNumbers,
      PhoneController phoneNumberControllers,
      ) {
    phoneNumberValidation = value;
    phoneNumber = phoneNumbers;
    phoneNumberController = phoneNumberControllers;
    if (phoneNumberValidation != null && phoneNumberValidation!.isNotEmpty) {
      phoneNumberVerification = PhoneNumberVerification.invalid;
      valueNotifierPhoneNumberVerification.value = PhoneNumberVerification.invalid;
    } else {
      if (phoneNumberValidation == null &&
          phoneNumberControllers.value != null &&
          phoneNumberControllers.value!.getFormattedNsn().trim().isNotEmpty) {
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

  Future<void> onSaveAndNext() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return;
    }
    return;
  }

  @override
  Widget build(BuildContext context) => _ChangePhoneNumberPageView(this);
}

class _ChangePhoneNumberPageView extends WidgetView<ChangePhoneNumberPage, _ChangePhoneNumberPageController> {
  const _ChangePhoneNumberPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
        noAppBar: true,
      ),
      child: Directionality(
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Phone Number'),
            centerTitle: false,
            actions: const [
              Padding(
                padding: EdgeInsetsDirectional.only(end: 8),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          body: FadeInDown(
            key: const Key('change-mobile-number-fade-widget'),
            from: context.width / 2 - 60,
            duration: const Duration(milliseconds: 500),
            child: Directionality(
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
              child: PageBody(
                controller: state.scrollController,
                constraints: BoxConstraints(
                  minWidth: 1000,
                  minHeight: media.size.height - (media.padding.top + kToolbarHeight + media.padding.bottom),
                ),
                padding: EdgeInsetsDirectional.only(
                  top: topPadding,
                  //bottom: bottomPadding,
                  start: margins * 2.5,
                  end: margins * 2.5,
                ),
                child: Form(
                  key: state.formKey,
                  child: CustomScrollView(
                    controller: state._screenScrollController,
                    shrinkWrap: true,
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Column(
                              //controller: scrollController,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              children: [
                                const AnimatedGap(8, duration: Duration(milliseconds: 500)),
                                Wrap(
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  children: [
                                    Text(
                                      'Change your phone number',
                                      style: context.headlineSmall!.copyWith(
                                        //color: const Color.fromRGBO(127, 129, 132, 1),
                                      ),
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ).translate(),
                                  ],
                                ),
                                const AnimatedGap(8, duration: Duration(milliseconds: 500)),
                                Wrap(
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  children: [
                                    Text(
                                      'Make sure your existing and new phone is valid, and it will be verify by OTP',
                                      style: context.bodySmall!.copyWith(
                                          //color: const Color.fromRGBO(127, 129, 132, 1),
                                          ),
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ).translate(),
                                  ],
                                ),
                                const AnimatedGap(
                                  24,
                                  duration: Duration(milliseconds: 500),
                                ),
                                Directionality(
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  child: PhoneNumberFieldWidget(
                                    key: const Key('existing-phone-number-widget'),
                                    isCountryChipPersistent: false,
                                    outlineBorder: true,
                                    shouldFormat: true,
                                    useRtl: false,
                                    withLabel: true,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      labelText: 'Existing mobile number',
                                      //hintText: 'Enter driver number',
                                      alignLabelWithHint: true,
                                      errorText: state.existingPhoneNumberValidation,
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
                                    initialPhoneNumberValue: state.existingPhoneNumber,
                                    //validator: state.phoneNumberValidator,
                                    //suffixIcon: PhoneNumberValidateWidget(phoneNumberVerification: value),
                                    onPhoneNumberChanged: state.onExistingPhoneNumberChanged,
                                    phoneNumberValidator: state.phoneNumberValidator,
                                    onPhoneNumberSaved: state.onPhoneNumberSaved,
                                    phoneNumberValidationChanged: state.existingPhoneNumberValidationChanged,
                                    haveStateManagement: false,
                                    keyboardType: const TextInputType.numberWithOptions(),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                const AnimatedGap(
                                  16,
                                  duration: Duration(milliseconds: 500),
                                ),
                                Directionality(
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  child: PhoneNumberFieldWidget(
                                    key: const Key('new-phone-number-widget'),
                                    isCountryChipPersistent: false,
                                    outlineBorder: true,
                                    shouldFormat: true,
                                    useRtl: false,
                                    withLabel: true,
                                    decoration: InputDecoration(
                                      labelText: 'New mobile number',
                                      //hintText: 'Enter driver number',
                                      alignLabelWithHint: true,
                                      errorText: state.phoneNumberValidation,
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
                                    initialPhoneNumberValue: state.phoneNumber,
                                    //validator: state.phoneNumberValidator,
                                    //suffixIcon: PhoneNumberValidateWidget(phoneNumberVerification: value),
                                    onPhoneNumberChanged: state.onPhoneNumberChanged,
                                    phoneNumberValidator: state.phoneNumberValidator,
                                    onPhoneNumberSaved: state.onPhoneNumberSaved,
                                    phoneNumberValidationChanged: state.phoneNumberValidationChanged,
                                    haveStateManagement: false,
                                    keyboardType: const TextInputType.numberWithOptions(),
                                    textInputAction: TextInputAction.done,
                                  ),
                                ),
                                const AnimatedGap(
                                  16,
                                  duration: Duration(milliseconds: 500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SliverFillRemaining(
                        fillOverscroll: true,
                        hasScrollBody: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          children: [
                            const Spacer(),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: ElevatedButton(
                                    onPressed: state.onSaveAndNext,
                                    style: ElevatedButton.styleFrom(
                                      //minimumSize: Size(180, 40),
                                      disabledBackgroundColor: const Color.fromRGBO(255, 219, 208, 1),
                                      disabledForegroundColor: Colors.white,
                                    ),
                                    child: Text(
                                      'Update & Next',
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
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
      ),
    );
  }
}
