import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/manager/phone_number_verification_bloc.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/widgets/terms_and_condition_privacy_policy_widget.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_selection_widget.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/router/app_pages.dart';
import 'package:homemakers_merchant/shared/widgets/app/app_logo.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animate_do/animate_do.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/src/widgets/animated_gap.dart';
import 'package:homemakers_merchant/shared/widgets/universal/async_button/async_button.dart';
import 'package:homemakers_merchant/shared/widgets/universal/constrained_scrollable_views/constrained_scrollable_views.dart';
import 'package:homemakers_merchant/shared/widgets/universal/phone_number_text_field/phonenumber_form_field_widget.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:toastification/toastification.dart';

class PhoneNumberVerificationPage extends StatefulWidget {
  const PhoneNumberVerificationPage({super.key});

  @override
  _PhoneNumberVerificationPageState createState() =>
      _PhoneNumberVerificationPageState();
}

class _PhoneNumberVerificationPageState
    extends State<PhoneNumberVerificationPage>
    with SingleTickerProviderStateMixin {
  late final ScrollController scrollController;
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Local PhoneController variables
  String? phoneValidation;
  static final requestOTPFormKey = GlobalKey<FormState>();

  // Button Controller
  AsyncBtnStatesController phoneNumberVerificationButtonController =
      AsyncBtnStatesController();
  String userEnteredPhoneNumber = '';

  String phoneNumberWithFormat = '';
  PhoneNumberVerification phoneNumberVerification =
      PhoneNumberVerification.none;
  Widget? suffixIcon;
  PhoneNumber? phoneNumber;
  ValueNotifier<PhoneNumberVerification> valueNotifierPhoneNumberVerification =
      ValueNotifier<PhoneNumberVerification>(
    PhoneNumberVerification.none,
  );
  bool mobileOnly = true;

  // If set to true, the app will request notification permissions to use
// silent verification for SMS MFA instead of Recaptcha.
  static const withSilentVerificationSMSMFA = true;

  @override
  void initState() {
    scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: -1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _animationController.forward();
    if (withSilentVerificationSMSMFA && !kIsWeb) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      messaging.requestPermission();
    }
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void onPhoneNumberChanged(
    PhoneNumber? phoneNumbers,
  ) {
    phoneNumber = phoneNumbers;
    userEnteredPhoneNumber =
        '+${phoneNumbers?.countryCode}${phoneNumbers?.nsn.trim()}';
    phoneNumberWithFormat =
        '+${phoneNumbers?.countryCode} ${phoneNumbers?.formatNsn(isoCode: phoneNumbers.isoCode).trim()}';
    final result = getValidator(context: context, isAllowEmpty: false);
    phoneValidation = result?.call(phoneNumber);

    if (phoneValidation != null && phoneValidation!.isNotEmpty) {
      valueNotifierPhoneNumberVerification.value =
          PhoneNumberVerification.invalid;
    } else {
      if (phoneValidation == null &&
          phoneNumbers != null &&
          phoneNumbers
              .formatNsn(isoCode: phoneNumbers.isoCode)
              .trim()
              .isNotEmpty) {
        valueNotifierPhoneNumberVerification.value =
            PhoneNumberVerification.valid;
      } else {
        valueNotifierPhoneNumberVerification.value =
            PhoneNumberVerification.none;
      }
    }
    //setState(() {});
  }

  PhoneNumberInputValidator? getValidator(
      {required BuildContext context, bool isAllowEmpty = false}) {
    List<PhoneNumberInputValidator> validators = [];

    if (mobileOnly) {
      validators.add(PhoneValidator.validMobile(context));
    } else {
      validators.add(PhoneValidator.valid(context));
    }
    //update();
    return validators.isNotEmpty ? PhoneValidator.compose(validators) : null;
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = media.padding.top + kToolbarHeight + margins;
    final double bottomPadding = media.padding.bottom + margins;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
      ),
      child: Scaffold(
        /*appBar: AppBar(
          title: const Text('Phone number verification'),
          actions: [
            //LanguageSelectionButton(),
          ],
        ),*/
        body: BlocListener<PhoneNumberVerificationBloc,
            PhoneNumberVerificationState>(
          bloc: context.read<PhoneNumberVerificationBloc>(),
          listenWhen: (previous, current) => previous != current,
          listener: (context, state) {
             state.mapOrNull(
              processing: (value) {
                return toastification.show(
                  context: context,
                  title: 'Please wait while we are sending otp',
                  style: ToastificationStyle.flatColored,
                  type: ToastificationType.info,
                  autoCloseDuration: const Duration(seconds: 2),
                );
              },
              valid: (value) {
                return toastification.show(
                  context: context,
                  title: 'OTP sent',
                  style: ToastificationStyle.flatColored,
                  type: ToastificationType.success,
                  showProgressBar: false,
                  autoCloseDuration: const Duration(seconds: 2),
                );
              },
              error: (value) {
                return toastification.show(
                  context: context,
                  title: '${value.reason}',
                  style: ToastificationStyle.flatColored,
                  type: ToastificationType.error,
                  showProgressBar: false,
                  autoCloseDuration: const Duration(seconds: 3),
                );
              },
              invalid: (value) {
                return toastification.show(
                  context: context,
                  title: '${value.reason}',
                  style: ToastificationStyle.flatColored,
                  type: ToastificationType.error,
                  showProgressBar: false,
                  autoCloseDuration: const Duration(seconds: 3),
                );
              },
              success: (s) {
                return context.push(
                  Routes.AUTH_OTP_VERIFICATION,
                  extra: {
                    'phoneNumber': s.userEnteredPhoneNumber,
                    'countryDialCode': s.countryDialCode,
                    'phoneNumberWithFormat': s.phoneNumberWithFormat,
                  },
                ).whenComplete(() {});
              },
            );
          },
          child: SlideInLeft(
            key: const Key('phone-verification-slideinleft-widget'),
            from: context.width - 10,
            child: PageBody(
              controller: scrollController,
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: media.size.height,
              ),
              child: Stack(
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  PositionedDirectional(
                    top: margins,
                    end: 6,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(end: 14),
                      child: LanguageSelectionWidget(),
                    ),
                  ),
                  PositionedDirectional(
                    top: kToolbarHeight + media.padding.top - margins,
                    start: margins * 2.5,
                    //end: margins * 2.5,
                    child: const AppLogo(
                      height: 80,
                    ),
                  ),
                  Form(
                    key: requestOTPFormKey,
                    child: Container(
                      margin: EdgeInsetsDirectional.fromSTEB(
                        margins * 2.5,
                        topPadding * 1.75,
                        margins * 2.5,
                        bottomPadding,
                      ),
                      height: context.height,
                      width: double.infinity,
                      child: BlocBuilder<PhoneNumberVerificationBloc,
                          PhoneNumberVerificationState>(
                        bloc: context.read<PhoneNumberVerificationBloc>(),
                        buildWhen: (previous, current) => previous!=current,
                        builder: (context, state) {
                          return ScrollableColumn(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const AnimatedGap(8,
                                  duration: Duration(milliseconds: 500)),
                              Wrap(
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                                children: [
                                  Text(
                                    'Hi,',
                                    textDirection:
                                        serviceLocator<LanguageController>()
                                            .targetTextDirection,
                                    style: context.headlineLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      height: 0.9,
                                      fontSize: 45,
                                      color: Color.fromRGBO(255, 125, 113, 1),
                                    ),
                                  ).translate(),
                                ],
                              ),
                              const AnimatedGap(12,
                                  duration: Duration(milliseconds: 500)),
                              Wrap(
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                                children: [
                                  Text(
                                    'Create better together.',
                                    textDirection:
                                        serviceLocator<LanguageController>()
                                            .targetTextDirection,
                                    style: GoogleFonts.raleway(
                                      textStyle:
                                          context.headlineMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        height: 0.9,
                                      ),
                                    ),
                                  ).translate(),
                                ],
                              ),
                              const AnimatedGap(4,
                                  duration: Duration(milliseconds: 500)),
                              Wrap(
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                                children: [
                                  Text(
                                    'Join with us',
                                    textDirection:
                                        serviceLocator<LanguageController>()
                                            .targetTextDirection,
                                    style: context.bodyMedium!.copyWith(
                                      fontSize: 18,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ).translate(),
                                ],
                              ),
                              const AnimatedGap(36,
                                  duration: Duration(milliseconds: 500)),

                              /* SizedBox(
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      'Enter your mobile number',
                                      style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w600),
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    ),
                                  ],
                                ),
                              ),
                              const AnimatedGap(6, duration: Duration(milliseconds: 500)),*/
                              Row(
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Directionality(
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      child: PhoneNumberFieldWidget(
                                        key: const Key(
                                            'user-phone-number-widget'),
                                        isCountryChipPersistent: false,
                                        outlineBorder: true,
                                        shouldFormat: true,
                                        useRtl: false,
                                        withLabel: true,
                                        decoration: InputDecoration(
                                          labelText: 'Mobile number',
                                          //alignLabelWithHint: true,
                                          hintText: 'Enter your mobile number',
                                          errorText: phoneValidation,
                                          //suffixIcon: const PhoneNumberValidationIconWidget(),
                                          isDense: true,
                                        ),
                                        isAllowEmpty: false,
                                        autofocus: false,
                                        style: context.bodyLarge,
                                        showFlagInInput: false,
                                        countryCodeStyle: context.bodyLarge,
                                        onPhoneNumberChanged:
                                            onPhoneNumberChanged,
                                        //phoneNumberValidationChanged: phoneNumberValidationChanged,
                                        haveStateManagement: false,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(),
                                        textInputAction: TextInputAction.done,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const AnimatedGap(14,
                                  duration: Duration(milliseconds: 400)),
                              Wrap(
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                                children: [
                                  Text(
                                    'A 6 digit OTP code will be sent via SMS to verify your mobile number',
                                    style: context.labelMedium!.copyWith(
                                      color: Color.fromRGBO(127, 129, 132, 1),
                                    ),
                                    textDirection:
                                        serviceLocator<LanguageController>()
                                            .targetTextDirection,
                                  ).translate(),
                                ],
                              ),
                              const AnimatedGap(26,
                                  duration: Duration(milliseconds: 400)),
                              //const Spacer(),
                              SizedBox(
                                width: context.width,
                                child: ValueListenableBuilder<
                                    PhoneNumberVerification>(
                                  valueListenable:
                                      valueNotifierPhoneNumberVerification,
                                  builder: (context, value, child) {
                                    return ElevatedButton(
                                      key: const Key(
                                          'phone-number_verification-button-key'),
                                      style: ElevatedButton.styleFrom(
                                        disabledBackgroundColor:
                                            Color.fromRGBO(255, 219, 208, 1),
                                        disabledForegroundColor: Colors.white,
                                      ),
                                      onPressed: (value ==
                                              PhoneNumberVerification.valid)
                                          ? verifyPhoneNumber
                                          : null,
                                      child: Text(
                                        'Get OTP',
                                        textDirection:
                                            serviceLocator<LanguageController>()
                                                .targetTextDirection,
                                      ).translate(),
                                    );
                                  },
                                ),
                              ),
                              const AnimatedGap(26,
                                  duration: Duration(milliseconds: 500)),
                              const TermsConditionStatementWidget(),
                            ],
                          );
                        },
                      ),
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

  Future<void> verifyPhoneNumber() async {
    if (requestOTPFormKey.currentState!.validate()) {
      requestOTPFormKey.currentState?.save();
      context.read<PhoneNumberVerificationBloc>().add(
            VerifyPhoneNumber(
              countryDialCode: phoneNumber?.countryCode ?? '+966',
              userEnteredPhoneNumber: userEnteredPhoneNumber,
              phoneNumberWithFormat: phoneNumberWithFormat,
            ),
          );
      return;
    }
    return;
  }
}
