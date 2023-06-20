import 'dart:async';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:homemakers_merchant/shared/widgets/universal/async_button/async_button.dart';
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
  AsyncBtnStatesController otpVerificationButtonController =
      AsyncBtnStatesController();
  final verifyOTPFormKey = GlobalKey<FormState>();
  final otpFocusNode = FocusNode();
  // Error text
  late String otpErrorText;

  @override
  void initState() {
    otpErrorText = '';
    super.initState();
    scrollController = ScrollController();
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
      await Future.delayed(Duration(seconds: 2));

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

        // Reset the OTP text field
        otpController.clear();
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
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
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
      child: PlatformScaffold(
        appBar: PlatformAppBar(
          title: const Text('OTP Verification'),
        ),
        body: PageBody(
          controller: scrollController,
          constraints: const BoxConstraints(
            minWidth: double.infinity,
            minHeight: double.infinity,
          ),
          child: Form(
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.fromLTRB(
                margins,
                topPadding,
                margins,
                bottomPadding,
              ),
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          widget.phoneNumber,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(-8, -4),
                        child: IconButton(
                          onPressed: () {
                            //editPhoneNumber();

                            return;
                          },
                          icon: Icon(Icons.edit_outlined,
                              color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter the OTP',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Pinput(
                    length: 6,
                    controller: otpController,
                    focusNode: otpFocusNode,
                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsUserConsentApi,
                    listenForMultipleSmsOnAndroid: true,
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    autofocus: true,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    errorPinTheme: errorPinTheme,
                    validator: (otpValue) {
                      return otpErrorText;
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
                SizedBox(height: 16),
                Text(
                  'OTP will expire in $countdown seconds',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text('Resend OTP'),
                      onPressed: isResendEnabled ? () => resendOTP() : null,
                    ),
                    SizedBox(width: 16),
                    AsyncElevatedBtn(
                      asyncBtnStatesController: otpVerificationButtonController,
                      onPressed: () async {
                        if (verifyOTPFormKey.currentState!.validate()) {
                          appLog.d('OTP Validate');
                          verifyOTPFormKey.currentState?.save();
                        } else {
                          appLog.d('OTP Invalid');
                        }
                        //context.read<PhoneNumberVerificationBloc>().add(VerifyPhoneNumber(),);
                        return;
                      },
                      child: Text('Verify OTP'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
