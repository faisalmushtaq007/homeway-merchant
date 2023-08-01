import 'dart:async';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemakers_merchant/app/features/authentication/common/otp_verification_enum.dart';
import 'package:homemakers_merchant/app/features/authentication/domain/entities/phone_number_verification/send_otp_entity.dart';
import 'package:homemakers_merchant/app/features/authentication/domain/entities/phone_number_verification/verify_otp_entity.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/manager/otp_verification/otp_verification_bloc.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/manager/phone_number_verification_bloc.dart';
import 'package:homemakers_merchant/app/features/profile/common/profile_status_enum.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/user_entity.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_selection_widget.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/gen/assets.gen.dart';
import 'package:homemakers_merchant/shared/router/app_pages.dart';
import 'package:homemakers_merchant/shared/widgets/app/app_logo.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animate_do/animate_do.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/gap.dart';
import 'package:homemakers_merchant/shared/widgets/universal/async_button/async_button.dart';
import 'package:homemakers_merchant/shared/widgets/universal/constrained_scrollable_views/constrained_scrollable_views.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:pinput/pinput.dart';

class OTPVerificationPage extends StatefulWidget {
  final String phoneNumber;

  OTPVerificationPage({required this.phoneNumber});

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  late final ScrollController scrollController;
  final TextEditingController otpController = TextEditingController();
  bool isResendEnabled = false;
  bool isVerifyEnabled = false;
  int countdown = 30;
  late Timer countdownTimer;

  // Button Controller
  AsyncBtnStatesController otpVerificationButtonController = AsyncBtnStatesController();
  static final verifyOTPFormKey = GlobalKey<FormState>();
  final otpFocusNode = FocusNode();

  // Error text
  String? otpErrorText;
  bool isOtpSending = false;
  bool isOtpVerifying = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    context.read<OtpVerificationBloc>().add(
          SendOtp(
            sendOtpEntity: SendOtpEntity(appUserType: 'merchant', userName: widget.phoneNumber, countryDialCode: ''),
            otpVerificationStatus: OtpVerificationStatus.otpSent,
          ),
        );
    // Start the countdown timer
    startCountdown();
  }

  @override
  void dispose() {
    scrollController.dispose();
    // Cancel the countdown timer
    countdownTimer.cancel();
    otpController.dispose();
    otpFocusNode.dispose();
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
      isVerifyEnabled = otpController.text.length == 6;
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
    context.read<OtpVerificationBloc>().add(
          SendOtp(
            sendOtpEntity: SendOtpEntity(appUserType: 'merchant', userName: widget.phoneNumber, countryDialCode: ''),
            otpVerificationStatus: OtpVerificationStatus.otpReSent,
          ),
        );
    startCountdown();
  }

  Future<void> verifyOTP() async {
    // Perform OTP validation
    if (otpController.text.length == 6) {
      // Implement your logic to verify the OTP
      // For example, you can make an API call here to verify the OTP with the server

      // Show a progress loader while verifying the OTP
      setState(() {
        //verifyButtonState = AsyncButtonState.loading;
      });

      // Simulate a delay of 2 seconds to mimic the API call
      await Future.delayed(const Duration(seconds: 2), () {});

      // Perform OTP and phone number validation
      bool isOTPValid = validateOTP(otpController.text);
      bool isPhoneNumberValid = validatePhoneNumber(widget.phoneNumber);

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
        context.read<OtpVerificationBloc>().add(
              VerifyOtp(
                verifyOtpEntity: VerifyOtpEntity(
                  appUserType: 'merchant',
                  login: widget.phoneNumber,
                  countryDialCode: '',
                  otpCode: int.parse(otpController.value.text.trim()),
                ),
                otpVerificationStatus: OtpVerificationStatus.otpSent,
              ),
            );
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

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = 0; //media.padding.top + kToolbarHeight + margins;
    final double bottomPadding = media.padding.bottom + margins;
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
      decoration:
          defaultPinTheme.decoration?.copyWith(color: const Color.fromRGBO(215, 243, 227, 1), border: Border.all(color: Color.fromRGBO(69, 201, 125, 1.0))),
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
      ),
      child: Directionality(
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        child: PlatformScaffold(
          material: (context, platform) {
            return MaterialScaffoldData(
              resizeToAvoidBottomInset: false,
            );
          },
          cupertino: (context, platform) {
            return CupertinoPageScaffoldData(
              resizeToAvoidBottomInset: false,
            );
          },
          appBar: PlatformAppBar(
            title: const Text('Phone Verification'),
            trailingActions: const [
              Padding(
                padding: EdgeInsetsDirectional.only(end: 14),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          body: SlideInLeft(
            key: const Key('otp-verification-slideinleft-widget'),
            from: context.width - 10,
            child: PageBody(
              key: const Key('otp-verification-page-body-widget'),
              controller: scrollController,
              constraints: const BoxConstraints(
                minWidth: double.infinity,
                minHeight: double.infinity,
              ),
              child: BlocBuilder<OtpVerificationBloc, OtpVerificationState>(
                bloc: context.read<OtpVerificationBloc>(),
                buildWhen: (previous, current) => previous != current,
                builder: (context, otpVerificationState) {
                  switch (otpVerificationState) {
                    case VerifyOtpState():
                      {
                        if (otpVerificationState.otpVerificationStatus == OtpVerificationStatus.otpVerified) {
                          // Reset the OTP text field
                          otpController.clear();
                        }
                        break;
                      }
                    case SendOtpState():
                      {
                        break;
                      }
                    case VerifyOtpFailedState():
                      {
                        break;
                      }
                    case SendOtpFailedState():
                      {
                        break;
                      }
                    case VerifyOtpProcessingState():
                      {
                        break;
                      }
                    case SendOtpProcessingState():
                      {
                        break;
                      }
                    case OtpTimerState():
                      {
                        break;
                      }
                    case _:
                      appLog.d('Default case: bloc builder PhoneNumberVerificationBloc page');
                  }

                  return Form(
                    key: verifyOTPFormKey,
                    child: Container(
                      margin: EdgeInsetsDirectional.fromSTEB(
                        margins * 2.5,
                        topPadding,
                        margins * 2.5,
                        bottomPadding,
                      ),
                      height: context.height,
                      width: double.infinity,
                      child: ScrollableColumn(
                        flexible: false,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        children: [
                          const AnimatedGap(16, duration: Duration(milliseconds: 400)),
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: const AppLogo(),
                          ),
                          const AnimatedGap(36, duration: Duration(milliseconds: 400)),
                          SizedBox(
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  'Enter verification code',
                                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w600),
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                ),
                              ],
                            ),
                          ),
                          const AnimatedGap(4, duration: Duration(milliseconds: 400)),
                          SizedBox(
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  "We've sent an OTP code to ${widget.phoneNumber}",
                                  style: Theme.of(context).textTheme.labelLarge,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                ),
                              ],
                            ),
                          ),
                          const AnimatedGap(16, duration: Duration(milliseconds: 400)),
                          Directionality(
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            child: Pinput(
                              length: 6,
                              controller: otpController,
                              focusNode: otpFocusNode,
                              androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                              listenForMultipleSmsOnAndroid: true,
                              hapticFeedbackType: HapticFeedbackType.lightImpact,
                              autofocus: true,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: focusedPinTheme,
                              submittedPinTheme: submittedPinTheme,
                              errorPinTheme: errorPinTheme,
                              forceErrorState: otpErrorText != null ? true : false,
                              validator: (otpValue) {
                                if (otpValue == null || otpValue.isEmpty || !validateOTP(otpValue)) {
                                  otpErrorText = 'Enter the OTP code';
                                  return 'Enter the OTP code';
                                } else {
                                  otpErrorText = null;
                                  return null;
                                }
                              },
                              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                              showCursor: true,
                              onCompleted: (pin) {
                                debugPrint('OTP onCompleted: pin');
                              },
                              onChanged: (value) {
                                debugPrint('OTP onChanged: $value');
                              },
                              errorText: otpErrorText,
                            ),
                          ),
                          const AnimatedGap(16, duration: Duration(milliseconds: 400)),
                          AnimatedCrossFade(
                            duration: const Duration(milliseconds: 700),
                            crossFadeState: isResendEnabled ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                            firstChild: Text(
                              'OTP will expire in $countdown seconds',
                              style: context.labelLarge!.copyWith(),
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            ),
                            secondChild: Wrap(
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              children: [
                                Text(
                                  "Didn't received the OTP? ",
                                  style: context.labelLarge!.copyWith(),
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                ),
                                InkWell(
                                  onTap: isResendEnabled ? () => resendOTP() : null,
                                  child: Text(
                                    'Resend OTP',
                                    style: context.labelLarge!.copyWith(
                                      color: context.primaryColor,
                                    ),
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const AnimatedGap(20, duration: Duration(milliseconds: 400)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: AsyncElevatedBtn(
                                  asyncBtnStatesController: otpVerificationButtonController,
                                  onPressed: () async {
                                    if (verifyOTPFormKey.currentState!.validate()) {
                                      appLog.d('OTP Validate');
                                      verifyOTPFormKey.currentState?.save();
                                      if (otpController.value.text == '123456') {
                                        // OTP is valid
                                        otpErrorText = null;

                                        setState(() {});
                                        await Future.delayed(const Duration(milliseconds: 500), () {});
                                        if (!mounted) {
                                          return;
                                        }
                                        serviceLocator<AppUserEntity>().phoneNumber = widget.phoneNumber;
                                        serviceLocator<AppUserEntity>().currentProfileStatus = CurrentProfileStatus.phoneNumberVerified;
                                        context.go(Routes.CREATE_BUSINESS_PROFILE_PAGE);
                                      } else {
                                        setState(() {
                                          otpErrorText = 'OTP is invalid';
                                        });
                                      }
                                    }
                                    //context.read<PhoneNumberVerificationBloc>().add(VerifyPhoneNumber(),);
                                    return;
                                  },
                                  child: Text(
                                    'Verify OTP',
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  ),
                                ),
                              ),
                            ],
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
