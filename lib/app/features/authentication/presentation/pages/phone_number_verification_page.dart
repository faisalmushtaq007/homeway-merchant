import 'dart:convert';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/manager/phone_number_verification_bloc.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/widgets/terms_and_condition_privacy_policy_widget.dart';
import 'package:homemakers_merchant/config/translation/extension/string_extension.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/router/app_pages.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:homemakers_merchant/shared/widgets/universal/async_button/async_button.dart';
import 'package:homemakers_merchant/shared/widgets/universal/nil/src/nil.dart';
import 'package:homemakers_merchant/shared/widgets/universal/phone_number_text_field/phone_form_field_bloc.dart';
import 'package:homemakers_merchant/shared/widgets/universal/phone_number_text_field/phonenumber_form_field_widget.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:phone_form_field/phone_form_field.dart';

class PhoneNumberVerificationPage extends StatefulWidget {
  const PhoneNumberVerificationPage({super.key});

  @override
  _PhoneNumberVerificationPageState createState() =>
      _PhoneNumberVerificationPageState();
}

class _PhoneNumberVerificationPageState
    extends State<PhoneNumberVerificationPage> {
  late final ScrollController scrollController;

  // Local PhoneController variables
  String? phoneValidation;
  final requestOTPFormKey = GlobalKey<FormState>();

  // Button Controller
  AsyncBtnStatesController phoneNumberVerificationButtonController =
      AsyncBtnStatesController();
  String userEnteredPhoneNumber = '';
  PhoneController phoneController = PhoneController(null);
  PhoneNumberVerification phoneNumberVerification =
      PhoneNumberVerification.none;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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
      child: PlatformScaffold(
        /*appBar: PlatformAppBar(
          title: const Text('Phone number verification'),
          trailingActions: [
            //LanguageSelectionButton(),
          ],
        ),*/
        body: PageBody(
          controller: scrollController,
          constraints: BoxConstraints(
            minWidth: double.infinity,
            minHeight: media.size.height,
          ),
          child: Form(
            key: requestOTPFormKey,
            child: BlocListener<PhoneNumberVerificationBloc,
                PhoneNumberVerificationState>(
              bloc: context.read<PhoneNumberVerificationBloc>(),
              listenWhen: (previous, current) => previous != current,
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  success: (phoneNumberVerification,
                      phoneNumber,
                      countryDialCode,
                      country,
                      phoneController,
                      asyncBtnState) {
                    context.go(
                      Routes.AUTH_OTP_VERIFICATION,
                      extra: jsonEncode(
                        {'mobileNumber': phoneNumber},
                      ),
                    );
                    return;
                  },
                );
              },
              child: BlocBuilder<PhoneNumberVerificationBloc,
                  PhoneNumberVerificationState>(
                bloc: context.read<PhoneNumberVerificationBloc>(),
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) {
                  state.maybeWhen(
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
                      userEnteredPhoneNumber = phoneNumber;
                      this.phoneController = phoneController;
                      this.phoneNumberVerification = phoneNumberVerification;
                      if (phoneNumberVerification ==
                          PhoneNumberVerification.valid) {
                        this.phoneValidation = phoneValidation;
                      } else if (phoneNumberVerification ==
                          PhoneNumberVerification.invalid) {
                        this.phoneValidation = phoneValidation;
                      } else {
                        //phoneNumberVerificationButtonController.update(AsyncBtnState.idle)
                      }
                    },
                    orElse: () {},
                  );
                  return Container(
                    margin: EdgeInsetsDirectional.fromSTEB(
                      margins * 2.5,
                      topPadding,
                      margins * 2.5,
                      bottomPadding,
                    ),
                    height: context.height,
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(bottom: 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Join us',
                                style: context.headlineMedium,
                              ),
                            ],
                          ),
                        ),
                        /*Padding(
                          padding: const EdgeInsetsDirectional.only(top: 12, bottom: 8),
                          child: Row(
                            children: [
                              Text(
                                'Enter your phone number',
                                style: context.labelLarge,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),*/
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: PhoneNumberFieldWidget(
                                key: const Key('user-phone-number-widget'),
                                isCountryChipPersistent: false,
                                outlineBorder: true,
                                shouldFormat: true,
                                useRtl: false,
                                withLabel: true,
                                decoration: InputDecoration(
                                  labelText: 'Mobile number',
                                  alignLabelWithHint: true,
                                  //hintText: 'Mobile number',
                                  errorText: phoneValidation,
                                  suffixIcon:
                                      const PhoneNumberValidationIconWidget(),
                                  isDense: true,
                                ),
                                isAllowEmpty: false,
                                autofocus: false,
                                style: context.bodyLarge,
                                showFlagInInput: false,
                                countryCodeStyle: context.bodyLarge,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),
                        //const Spacer(),
                        SizedBox(
                          width: context.width,
                          child: AsyncElevatedBtn(
                            asyncBtnStatesController:
                                phoneNumberVerificationButtonController,
                            key: const Key(
                                'phone-number_verification-button-key'),
                            /*style: ElevatedButton.styleFrom(
                              disabledBackgroundColor: ,
                              disabledForegroundColor: ,
                            ),*/
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
                              widget: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check),
                                  SizedBox(width: 4),
                                  Text('Success!')
                                ],
                              ),
                            ),
                            failureStyle: AsyncBtnStateStyle(
                              style: ElevatedButton.styleFrom(
                                //backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                              widget: Text('Get OTP'.tr()),
                            ),
/*                            onPressed: () async => phoneNumberVerification ==
                                    PhoneNumberVerification.valid
                                ? verifyPhoneNumber()
                                : null,*/
                            child: Text('Get OTP'.tr()),
                            onPressed: phoneNumberVerification ==
                                    PhoneNumberVerification.valid
                                ? verifyPhoneNumber
                                : null,
                          ),
                        ),
                        const SizedBox(height: 32),
                        const TermsConditionStatementWidget(),
                      ],
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
    return BlocBuilder<PhoneNumberVerificationBloc,
        PhoneNumberVerificationState>(
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
            } else if (phoneNumberVerification ==
                PhoneNumberVerification.invalid) {
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
