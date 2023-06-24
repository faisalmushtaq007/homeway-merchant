import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/manager/phone_number_verification_bloc.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/phone_number_verification_page.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/shared/widgets/universal/phone_number_text_field/phone_form_field_bloc.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:phone_form_field/phone_form_field.dart';

class PhoneNumberFieldWidget extends StatefulWidget {
  const PhoneNumberFieldWidget({
    required this.isCountryChipPersistent,
    required this.outlineBorder,
    required this.shouldFormat,
    required this.useRtl,
    required this.withLabel,
    this.selectorNavigator = const CountrySelectorNavigator.searchDelegate(),
    super.key,
    this.decoration,
    this.validator,
    this.isAllowEmpty = false,
    this.autovalidateMode,
    this.autofocus = true,
    this.style,
    this.showFlagInInput = true,
    this.enabled = true,
    this.countryCodeStyle,
    this.phoneValidation,
  });

  final CountrySelectorNavigator selectorNavigator;
  final bool withLabel;
  final bool outlineBorder;
  final bool shouldFormat;
  final bool isCountryChipPersistent;
  final bool useRtl;
  final InputDecoration? decoration;
  final PhoneNumberInputValidator? validator;
  final bool isAllowEmpty;
  final AutovalidateMode? autovalidateMode;
  final bool autofocus;
  final TextStyle? style;
  final bool showFlagInInput;
  final bool enabled;
  final TextStyle? countryCodeStyle;
  final String? phoneValidation;

  @override
  State<PhoneNumberFieldWidget> createState() => _PhoneNumberFieldWidgetState();
}

class _PhoneNumberFieldWidgetState extends State<PhoneNumberFieldWidget> {
  final isoCodeNameMap = IsoCode.values.asNameMap();
  IsoCode defaultCountry = IsoCode.SA;

  // Phone number
  PhoneNumber initialPhoneNumberValue = PhoneNumber(
    isoCode: IsoCode.values.asNameMap().values.byName('SA'),
    nsn: '',
  );
  PhoneController controller = PhoneController(PhoneNumber(
    isoCode: IsoCode.values.asNameMap().values.byName('SA'),
    nsn: '',
  ));

  // Country picker selector mode
  CountrySelectorNavigator selectorNavigator =
      const CountrySelectorNavigator.searchDelegate();
  final phoneKey = GlobalKey<FormFieldState<PhoneNumber>>();
  bool mobileOnly = true;
  String? phoneValidation;
  late FocusNode phoneNumberFocusNode;
  bool outlineBorder = true;
  bool shouldFormat = true;
  bool isCountryChipPersistent = false;
  bool withLabel = true;
  bool useRtl = false;

  @override
  void initState() {
    initialPhoneNumberValue = PhoneNumber(
      isoCode: isoCodeNameMap.values.byName('SA'),
      nsn: '',
    );
    controller = PhoneController(initialPhoneNumberValue);
    controller.value = initialPhoneNumberValue;
    defaultCountry = isoCodeNameMap.values.byName('SA');
    phoneNumberFocusNode = FocusNode();
    mobileOnly = true;
    phoneValidation = phoneKey.currentState?.errorText;
    super.initState();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    phoneNumberFocusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  PhoneNumberInputValidator? getValidator({bool isAllowEmpty = false}) {
    List<PhoneNumberInputValidator> validators = [];
    if (!isAllowEmpty) {
      validators.add(
          PhoneValidator.required(errorText: "Phone number can't be empty"));
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
    return BlocBuilder<PhoneFormFieldBloc, PhoneNumberFormFieldState>(
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
            String country,
          ) {
            /*PhoneNumberVerification phoneNumberVerification =
                PhoneNumberVerification.none;
            if (phoneValidation != null && phoneValidation.isNotEmpty) {
              phoneNumberVerification = PhoneNumberVerification.invalid;
            } else {
              if (phoneValidation == null &&
                  phoneController.value != null &&
                  phoneController.value!.getFormattedNsn().trim().isNotEmpty) {
                phoneNumberVerification = PhoneNumberVerification.valid;
              } else {
                phoneNumberVerification = PhoneNumberVerification.none;
              }
            }*/
            context.read<PhoneNumberVerificationBloc>().add(
                  ValidatePhoneNumber(
                    phoneNumber:
                        '+${phoneController.value?.countryCode} ${phoneController.value?.getFormattedNsn().trim()}',
                    countryDialCode:
                        '+${phoneController.value?.countryCode ?? '+966'}',
                    country: phoneController.value?.isoCode.name ?? 'SA',
                    phoneValidation: phoneValidation,
                    phoneNumberInputValidator: phoneNumberInputValidator,
                    enteredPhoneNumber: phoneNumber,
                    phoneNumberVerification: phoneNumberVerification,
                    phoneController: phoneController,
                  ),
                );
          },
          onChange: (phoneNumber, controller) {
            context.read<PhoneNumberVerificationBloc>().add(
                  PhoneNumberChanged(
                    phoneNumber:
                        '+${controller?.value?.countryCode} ${controller?.value?.getFormattedNsn().trim()}',
                    countryDialCode:
                        '+${controller?.value?.countryCode ?? '+966'}',
                    country: controller?.value?.isoCode.name ?? 'SA',
                    enteredPhoneNumber: phoneNumber,
                    phoneController: controller!,
                  ),
                );
          },
          setPhoneNumber: (userPhoneNumber, countryDialCode, country) {
            initialPhoneNumberValue = PhoneNumber(
              isoCode: isoCodeNameMap.values.byName(country),
              nsn: userPhoneNumber,
            );
            controller.value = initialPhoneNumberValue;
            defaultCountry = isoCodeNameMap.values.byName(country);
            phoneValidation = phoneKey.currentState?.errorText;
          },
        );
        return AutofillGroup(
          child: Directionality(
            textDirection:
                serviceLocator<LanguageController>().targetTextDirection,
            //widget.useRtl ? TextDirection.rtl : TextDirection.ltr,
            child: PhoneFormField(
              key: phoneKey,
              controller: controller,
              //initialValue: initialPhoneNumberValue,
              shouldFormat: widget.shouldFormat && !widget.useRtl,
              autofocus: widget.autofocus,
              focusNode: phoneNumberFocusNode,
              autofillHints: const [AutofillHints.telephoneNumber],
              countrySelectorNavigator: widget.selectorNavigator,
              defaultCountry: defaultCountry,
              decoration: widget.decoration?.copyWith(
                    suffixIcon: const PhoneNumberValidationIconWidget(),
                  ) ??
                  InputDecoration(
                    label:
                        widget.withLabel ? const Text('Mobile number') : null,
                    border: widget.outlineBorder
                        ? const OutlineInputBorder()
                        : const UnderlineInputBorder(),
                    hintText: widget.withLabel ? '' : 'Mobile number',
                    errorText: phoneValidation,
                    suffixIcon: const PhoneNumberValidationIconWidget(),
                  ),
              enabled: widget.enabled,
              showFlagInInput: widget.showFlagInInput,
              validator: (PhoneNumber? phoneNumber) {
                final result = widget.validator ??
                    getValidator(isAllowEmpty: widget.isAllowEmpty);
                phoneValidation = result?.call(phoneNumber);
                context.read<PhoneFormFieldBloc>().add(
                      PhoneFormFieldValidate(
                        phoneNumberInputValidator: result,
                        phoneValidation: phoneValidation,
                        phoneController: controller,
                      ),
                    );
                return phoneValidation;
              },
              autovalidateMode:
                  widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
              cursorColor: Theme.of(context).colorScheme.primary,
              onSaved: (PhoneNumber? p) {
                //return context.read<PhoneFormFieldBloc>().add(PhoneFormFieldOnSave(phoneNumber: p, controller: controller),);
              },
              onChanged: (PhoneNumber? p) {
                //return context.read<PhoneFormFieldBloc>().add(PhoneFormFieldOnChange(phoneNumber: p, controller: controller),);
              },
              //print('changed $p'),
              isCountryChipPersistent: widget.isCountryChipPersistent,
              style: widget.style,
              countryCodeStyle: widget.countryCodeStyle,
            ),
          ),
        );
      },
    );
  }
}
