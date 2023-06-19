import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/manager/phone_number_verification_bloc.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
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
  // Local PhoneController variables
  String? phoneValidation;
  final requestOTPFormKey = GlobalKey<FormState>();
  // Button Controller
  AsyncBtnStatesController phoneNumberVerificationButtonController =
      AsyncBtnStatesController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Phone Number Verification'),
        trailingActions: [
          //LanguageSelectionButton(),
        ],
      ),
      body: Form(
        key: requestOTPFormKey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: BlocBuilder<PhoneNumberVerificationBloc,
              PhoneNumberVerificationState>(
            bloc: context.read<PhoneNumberVerificationBloc>(),
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
                ) {
                  if (phoneNumberVerification ==
                      PhoneNumberVerification.valid) {
                    this.phoneValidation = phoneValidation;
                  } else if (phoneNumberVerification ==
                      PhoneNumberVerification.invalid) {
                    this.phoneValidation = phoneValidation;
                  } else {}
                },
                orElse: () {},
              );
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Phone Number',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
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
                            hintText: 'Required',
                            errorText: phoneValidation,
                            suffixIcon: const PhoneNumberValidationIconWidget(),
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
                  SizedBox(height: 16),
                  Spacer(),
                  AsyncElevatedBtn(
                    asyncBtnStatesController:
                        phoneNumberVerificationButtonController,
                    onPressed: () async {
                      if (requestOTPFormKey.currentState!.validate()) {
                        appLog.d('Validate');
                        requestOTPFormKey.currentState?.save();
                      } else {
                        appLog.d('Invalid');
                      }
                      //context.read<PhoneNumberVerificationBloc>().add(VerifyPhoneNumber(),);
                      return;
                    },
                    child: Text('Send OTP'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class PhoneNumberValidationIconWidget extends StatelessWidget {
  const PhoneNumberValidationIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneNumberVerificationBloc,
        PhoneNumberVerificationState>(
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
