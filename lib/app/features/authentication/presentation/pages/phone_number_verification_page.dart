import 'dart:convert';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/manager/phone_number_verification_bloc.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/widgets/terms_and_condition_privacy_policy_widget.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/extension/string_extension.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_selection_widget.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/gen/assets.gen.dart';
import 'package:homemakers_merchant/shared/router/app_pages.dart';
import 'package:homemakers_merchant/shared/widgets/app/app_logo.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animate_do/animate_do.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/src/widgets/animated_gap.dart';
import 'package:homemakers_merchant/shared/widgets/universal/async_button/async_button.dart';
import 'package:homemakers_merchant/shared/widgets/universal/constrained_scrollable_views/constrained_scrollable_views.dart';
import 'package:homemakers_merchant/shared/widgets/universal/nil/src/nil.dart';
import 'package:homemakers_merchant/shared/widgets/universal/phone_number_text_field/phone_form_field_bloc.dart';
import 'package:homemakers_merchant/shared/widgets/universal/phone_number_text_field/phonenumber_form_field_widget.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:phone_form_field/phone_form_field.dart';

class PhoneNumberVerificationPage extends StatefulWidget {
  const PhoneNumberVerificationPage({super.key});

  @override
  _PhoneNumberVerificationPageState createState() => _PhoneNumberVerificationPageState();
}

class _PhoneNumberVerificationPageState extends State<PhoneNumberVerificationPage> with SingleTickerProviderStateMixin {
  late final ScrollController scrollController;
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Local PhoneController variables
  String? phoneValidation;
  static final requestOTPFormKey = GlobalKey<FormState>();

  // Button Controller
  AsyncBtnStatesController phoneNumberVerificationButtonController = AsyncBtnStatesController();
  String userEnteredPhoneNumber = '';
  PhoneController phoneController = PhoneController(null);
  PhoneNumberVerification phoneNumberVerification = PhoneNumberVerification.none;
  Widget? suffixIcon;
  PhoneNumber? phoneNumber;
  late PhoneController phoneNumberController;
  ValueNotifier<PhoneNumberVerification> valueNotifierPhoneNumberVerification = ValueNotifier<PhoneNumberVerification>(
    PhoneNumberVerification.none,
  );
  bool mobileOnly = true;

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
    userEnteredPhoneNumber = '+${phoneNumbers?.countryCode} ${phoneNumbers?.getFormattedNsn().trim()}';
    String countryDialCode = '+${phoneNumbers?.countryCode ?? '+966'}';
    String country = phoneNumbers?.isoCode.name ?? 'SA';
    final result = getValidator(isAllowEmpty: false);
    phoneValidation = result?.call(phoneNumber);

    if (phoneValidation != null && phoneValidation!.isNotEmpty) {
      valueNotifierPhoneNumberVerification.value = PhoneNumberVerification.invalid;
    } else {
      if (phoneValidation == null && phoneNumbers != null && phoneNumbers.getFormattedNsn().trim().isNotEmpty) {
        valueNotifierPhoneNumberVerification.value = PhoneNumberVerification.valid;
      } else {
        valueNotifierPhoneNumberVerification.value = PhoneNumberVerification.none;
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
    phoneNumber = phoneNumbers;
    userEnteredPhoneNumber = '+${phoneNumbers?.countryCode} ${phoneNumbers?.getFormattedNsn().trim()}';
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
        phoneNumberVerificationButtonController.update(AsyncBtnState.idle);
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
        body: BlocListener<PhoneNumberVerificationBloc, PhoneNumberVerificationState>(
          bloc: context.read<PhoneNumberVerificationBloc>(),
          listenWhen: (previous, current) => previous != current,
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              success: (phoneNumberVerification, phoneNumber, countryDialCode, country, phoneController, asyncBtnState) {
                context.push(
                  Routes.AUTH_OTP_VERIFICATION,
                  extra: jsonEncode(
                    {'mobileNumber': phoneNumber},
                  ),
                );
                return;
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
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
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
                      child: ScrollableColumn(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const AnimatedGap(8, duration: Duration(milliseconds: 500)),
                          Wrap(
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            children: [
                              Text(
                                'Hi,',
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                style: context.headlineLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  height: 0.9,
                                  fontSize: 45,
                                  color: Color.fromRGBO(255, 125, 113, 1),
                                ),
                              ).translate(),
                            ],
                          ),

                          const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                          Wrap(
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            children: [
                              Text(
                                'Create better together.',
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                style: GoogleFonts.raleway(
                                  textStyle: context.headlineMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    height: 0.9,
                                  ),
                                ),
                              ).translate(),
                            ],
                          ),
                          const AnimatedGap(4, duration: Duration(milliseconds: 500)),
                          Wrap(
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            children: [
                              Text(
                                'Join with us',
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                style: context.bodyMedium!.copyWith(
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal,
                                ),
                              ).translate(),
                            ],
                          ),
                          const AnimatedGap(36, duration: Duration(milliseconds: 500)),

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
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Directionality(
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  child: PhoneNumberFieldWidget(
                                    key: const Key('user-phone-number-widget'),
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
                                    onPhoneNumberChanged: onPhoneNumberChanged,
                                    //phoneNumberValidationChanged: phoneNumberValidationChanged,
                                    haveStateManagement: false,
                                    keyboardType: const TextInputType.numberWithOptions(),
                                    textInputAction: TextInputAction.done,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const AnimatedGap(14, duration: Duration(milliseconds: 400)),
                          Wrap(
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            children: [
                              Text(
                                'A 6 digit OTP code will be sent via SMS to verify your mobile number',
                                style: context.labelMedium!.copyWith(
                                  color: Color.fromRGBO(127, 129, 132, 1),
                                ),
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              ).translate(),
                            ],
                          ),
                          const AnimatedGap(26, duration: Duration(milliseconds: 400)),
                          //const Spacer(),
                          SizedBox(
                            width: context.width,
                            child: ValueListenableBuilder<PhoneNumberVerification>(
                              valueListenable: valueNotifierPhoneNumberVerification,
                              builder: (context, value, child) {
                                return AsyncElevatedBtn(
                                  asyncBtnStatesController: phoneNumberVerificationButtonController,
                                  key: const Key('phone-number_verification-button-key'),
                                  style: ElevatedButton.styleFrom(
                                    disabledBackgroundColor: Color.fromRGBO(255, 219, 208, 1),
                                    disabledForegroundColor: Colors.white,
                                  ),
                                  loadingStyle: AsyncBtnStateStyle(
                                    style: ElevatedButton.styleFrom(
                                        //backgroundColor: Colors.amber,
                                        ),
                                    widget: const SizedBox.square(
                                      dimension: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  successStyle: AsyncBtnStateStyle(
                                    style: ElevatedButton.styleFrom(
                                      //backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                    ),
                                    widget: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Icon(
                                          Icons.check,
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'Success!',
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate()
                                      ],
                                    ),
                                  ),
                                  failureStyle: AsyncBtnStateStyle(
                                    style: ElevatedButton.styleFrom(
                                      //backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                    ),
                                    widget: Text(
                                      'Get OTP',
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    ).translate(),
                                  ),
                                  onPressed: (value == PhoneNumberVerification.valid) ? verifyPhoneNumber : null,
                                  child: Text(
                                    'Get OTP',
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  ).translate(),
                                );
                              },
                            ),
                          ),
                          const AnimatedGap(26, duration: Duration(milliseconds: 500)),
                          const TermsConditionStatementWidget(),
                        ],
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
              phoneNumber: userEnteredPhoneNumber,
              countryDialCode: phoneController.value?.countryCode ?? '+966',
              country: phoneController.value?.isoCode.name ?? 'SA',
              phoneController: phoneController,
            ),
          );
      return;
    }
    return;
  }
}

class PhoneNumberValidationIconWidget extends StatelessWidget {
  const PhoneNumberValidationIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneNumberVerificationBloc, PhoneNumberVerificationState>(
      bloc: context.read<PhoneNumberVerificationBloc>(),
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return state.maybeWhen(
          validatePhoneNumber: (
            phoneNumber,
            countryDialCode,
            country,
            phoneNumberInputValidator,
            phoneValidation,
            enteredPhoneNumber,
            phoneNumberVerification,
            phoneController,
          ) {
            if (phoneNumberVerification == PhoneNumberVerification.valid) {
              return const Icon(
                Icons.check_circle,
                color: Colors.green,
              );
            } else if (phoneNumberVerification == PhoneNumberVerification.invalid) {
              return const Icon(
                Icons.error,
                color: Colors.red,
              );
            }
            return nil;
          },
          orElse: () {
            return nil;
          },
        );
      },
    );
  }
}
