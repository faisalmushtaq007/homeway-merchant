part of 'package:homemakers_merchant/app/features/common/index.dart';

class CommonOtpVerification extends StatefulWidget {
  const CommonOtpVerification({
    super.key,
    this.userNewEnteredPhoneNumber = '',
    this.dialCode = '',
    this.country = '',
    this.userExistingEnteredPhoneNumber = '',
    this.userExistingEnteredPhoneNumberWithoutDialCode = '',
    this.userNewEnteredPhoneNumberWithoutDialCode = '',
    this.id = -1,
  });

  final String userNewEnteredPhoneNumber;
  final String userExistingEnteredPhoneNumber;
  final String userNewEnteredPhoneNumberWithoutDialCode;
  final String userExistingEnteredPhoneNumberWithoutDialCode;
  final String country;
  final String dialCode;
  final int id;

  @override
  _CommonOtpVerificationController createState() =>
      _CommonOtpVerificationController();
}

class _CommonOtpVerificationController extends State<CommonOtpVerification> {
  late final ScrollController scrollController;
  late final ScrollController _screenScrollController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late FocusNode otpFocusNode;
  final TextEditingController otpTextEditingController =
      TextEditingController();
  String userEnteredPhoneNumber = '';

  bool isResendEnabled = false;
  bool isVerifyEnabled = false;
  int countdown = 30;
  late Timer countdownTimer;
  String? otpErrorText;
  bool isOtpSending = false;
  bool isOtpVerifying = false;

  @override
  void initState() {
    super.initState();
    otpFocusNode = FocusNode();
    scrollController = ScrollController();
    _screenScrollController = ScrollController();
    // Send OTP bloc or usecase
    startCountdown();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    countdownTimer.cancel();
    otpFocusNode.dispose();
    otpTextEditingController.dispose();
    _screenScrollController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown == 0) {
        // Countdown finished, enable resend button
        setState(() {
          isResendEnabled = true;
        });
        timer.cancel();
      } else {
        setState(() {
          countdown--;
        });
      }
    });
  }

  void onOTPChanged() {
    setState(() {
      // Enable verify button if OTP has 6 digits
      isVerifyEnabled = otpTextEditingController.text.length == 6;
    });
  }

  void resendOTP() {
    // Implement your logic to resend the OTP
    // For example, you can make an API call here to generate and send a new OTP
    // After that, reset the countdown timer
    setState(() {
      isResendEnabled = false;
      countdown = 30;
    });
    // Call Bloc or UseCase
    startCountdown();
  }

  Future<void> verifyOTP() async {
    // Perform OTP validation
    if (otpTextEditingController.text.length == 6) {
      // Implement your logic to verify the OTP
      // For example, you can make an API call here to verify the OTP with the server

      // Show a progress loader while verifying the OTP
      setState(() {
        //verifyButtonState = AsyncButtonState.loading;
      });

      // Simulate a delay of 2 seconds to mimic the API call
      await Future.delayed(const Duration(seconds: 2), () {});

      // Perform OTP and phone number validation
      bool isOTPValid = validateOTP(otpTextEditingController.text);
      bool isPhoneNumberValid =
          validatePhoneNumber(widget.userNewEnteredPhoneNumber);

      // Update the button state based on validation results
      setState(() {
        //verifyButtonState = isOTPValid && isPhoneNumberValid ? AsyncButtonState.success : AsyncButtonState.error;
      });

      if (isOTPValid && isPhoneNumberValid) {
        // OTP and phone number validation successful
        // Perform further actions here, such as navigating to the next screen
        if (!mounted) {
          return;
        }

        return;
      }
    }
  }

  bool validateOTP(String otp) {
    // Implement your OTP validation logic here
    // Return true if OTP is valid, false otherwise
    // For example, you can check if the OTP matches the expected value
    // You can also add additional validation rules as per your requirements
    // Here, we're just checking if the OTP is numeric and has a length of 6
    return int.tryParse(otp) != null && otp.length == 6;
  }

  bool validatePhoneNumber(String phoneNumber) {
    // Implement your phone number validation logic here
    // Return true if phone number is valid, false otherwise
    // For example, you can check if the phone number matches a specific pattern
    // You can also add additional validation rules as per your requirements
    // Here, we're just checking if the phone number is not empty
    return phoneNumber.isNotEmpty;
  }

  Future<void> onSaveAndNext() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return;
    }
    return;
  }

  @override
  Widget build(BuildContext context) => _CommonOtpVerificationView(this);
}

class _CommonOtpVerificationView extends WidgetView<CommonOtpVerification,
    _CommonOtpVerificationController> {
  const _CommonOtpVerificationView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding =
        margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final ThemeData theme = Theme.of(context);
    const borderColor = Color.fromRGBO(114, 178, 238, 1);
    const errorColor = Color.fromRGBO(255, 234, 238, 1);
    const fillColor = Color.fromRGBO(222, 231, 240, .57);
    final defaultPinTheme = PinTheme(
      width: 46,
      height: 46,
      textStyle: theme.textTheme.titleMedium!.copyWith(
        fontSize: 18,
        color: const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      height: 48,
      width: 46,
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: borderColor),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
          color: const Color.fromRGBO(215, 243, 227, 1),
          border: Border.all(color: Color.fromRGBO(69, 201, 125, 1.0))),
    );
    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: errorColor,
        borderRadius: BorderRadius.circular(8),
      ),
    );
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
            title: const Text('Verification'),
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
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
              child: PageBody(
                controller: state.scrollController,
                constraints: BoxConstraints(
                  minWidth: 1000,
                  minHeight: media.size.height -
                      (media.padding.top +
                          kToolbarHeight +
                          media.padding.bottom),
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
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                              children: [
                                const AnimatedGap(8,
                                    duration: Duration(milliseconds: 500)),
                                const Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: AppLogo(),
                                ),
                                const AnimatedGap(16,
                                    duration: Duration(milliseconds: 500)),
                                SizedBox(
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                        'Enter verification code',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w600),
                                        textDirection:
                                            serviceLocator<LanguageController>()
                                                .targetTextDirection,
                                      ),
                                    ],
                                  ),
                                ),
                                const AnimatedGap(4,
                                    duration: Duration(milliseconds: 400)),
                                SizedBox(
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                        "We've sent an OTP code to ${widget.userNewEnteredPhoneNumber}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                        textDirection:
                                            serviceLocator<LanguageController>()
                                                .targetTextDirection,
                                      ),
                                    ],
                                  ),
                                ),
                                const AnimatedGap(16,
                                    duration: Duration(milliseconds: 400)),
                                Directionality(
                                  textDirection:
                                      serviceLocator<LanguageController>()
                                          .targetTextDirection,
                                  child: Pinput(
                                    length: 6,
                                    controller: state.otpTextEditingController,
                                    focusNode: state.otpFocusNode,
                                    androidSmsAutofillMethod:
                                        AndroidSmsAutofillMethod
                                            .smsUserConsentApi,
                                    listenForMultipleSmsOnAndroid: true,
                                    hapticFeedbackType:
                                        HapticFeedbackType.lightImpact,
                                    autofocus: true,
                                    defaultPinTheme: defaultPinTheme,
                                    focusedPinTheme: focusedPinTheme,
                                    submittedPinTheme: submittedPinTheme,
                                    errorPinTheme: errorPinTheme,
                                    forceErrorState: state.otpErrorText != null
                                        ? true
                                        : false,
                                    validator: (otpValue) {
                                      if (otpValue == null ||
                                          otpValue.isEmpty ||
                                          !state.validateOTP(otpValue)) {
                                        state.otpErrorText =
                                            'Enter the OTP code';
                                        return 'Enter the OTP code';
                                      } else {
                                        state.otpErrorText = null;
                                        return null;
                                      }
                                    },
                                    pinputAutovalidateMode:
                                        PinputAutovalidateMode.onSubmit,
                                    showCursor: true,
                                    onCompleted: (pin) {
                                      debugPrint('OTP onCompleted: pin');
                                    },
                                    onChanged: (value) {
                                      debugPrint('OTP onChanged: $value');
                                    },
                                    errorText: state.otpErrorText,
                                  ),
                                ),
                                const AnimatedGap(16,
                                    duration: Duration(milliseconds: 400)),
                                AnimatedCrossFade(
                                  duration: const Duration(milliseconds: 700),
                                  crossFadeState: state.isResendEnabled
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                                  firstChild: Text(
                                    'OTP will expire in ${state.countdown} seconds',
                                    style: context.labelLarge!.copyWith(),
                                    textDirection:
                                        serviceLocator<LanguageController>()
                                            .targetTextDirection,
                                  ),
                                  secondChild: Wrap(
                                    textDirection:
                                        serviceLocator<LanguageController>()
                                            .targetTextDirection,
                                    children: [
                                      Text(
                                        "Didn't received the OTP? ",
                                        style: context.labelLarge!.copyWith(),
                                        textDirection:
                                            serviceLocator<LanguageController>()
                                                .targetTextDirection,
                                      ),
                                      InkWell(
                                        onTap: state.isResendEnabled
                                            ? () => state.resendOTP()
                                            : null,
                                        child: Text(
                                          'Resend OTP',
                                          style: context.labelLarge!.copyWith(
                                            color: context.primaryColor,
                                          ),
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const AnimatedGap(20,
                                    duration: Duration(milliseconds: 400)),
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
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
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
                                      disabledBackgroundColor:
                                          const Color.fromRGBO(
                                              255, 219, 208, 1),
                                      disabledForegroundColor: Colors.white,
                                    ),
                                    child: Text(
                                      'Verify OTP',
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
      ),
    );
  }
}
