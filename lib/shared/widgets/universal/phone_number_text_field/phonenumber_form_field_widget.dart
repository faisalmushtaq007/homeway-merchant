import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/manager/phone_number_verification_bloc.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/phone_number_verification_page.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/app_translator.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/shared/widgets/universal/multi_stream_builder/multi_stream_builder.dart';
import 'package:homemakers_merchant/shared/widgets/universal/nil/src/nil.dart';
import 'package:homemakers_merchant/shared/widgets/universal/phone_number_text_field/phone_form_field_bloc.dart';
import 'package:homemakers_merchant/shared/widgets/universal/phone_number_text_field/phone_number_validate_widget.dart';
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
    this.onPhoneNumberChanged,
    this.onPhoneNumberSaved,
    this.phoneNumberValidator,
    this.suffixIcon,
    this.phoneNumberValidationChanged,
    this.haveStateManagement = true,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.phone,
    this.phoneNumberFocusNode,
    this.onPhoneNumberValidationMessage,
    this.initialPhoneNumberValue,
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
  final ValueChanged<PhoneNumber?>? onPhoneNumberChanged;
  final Function(PhoneNumber?)? onPhoneNumberSaved;
  final PhoneNumberInputValidator? phoneNumberValidator;
  final Function(
    String? phoneNumberValidation,
    PhoneNumber? phoneNumber,
    PhoneController controller,
  )? phoneNumberValidationChanged;
  final Widget? suffixIcon;
  final bool haveStateManagement;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FocusNode? phoneNumberFocusNode;
  final ValueChanged<PhoneNumberVerification?>? onPhoneNumberValidationMessage;
  final PhoneNumber? initialPhoneNumberValue;

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
  PhoneController controller = PhoneController(
    PhoneNumber(
      isoCode: IsoCode.values.asNameMap().values.byName('SA'),
      nsn: '',
    ),
  );

  // Country picker selector mode
  CountrySelectorNavigator selectorNavigator = const CountrySelectorNavigator.searchDelegate();
  final phoneKey = GlobalKey<FormFieldState<PhoneNumber>>();
  bool mobileOnly = true;
  String? phoneValidation;
  late FocusNode phoneNumberFocusNode;
  bool outlineBorder = true;
  bool shouldFormat = true;
  bool isCountryChipPersistent = false;
  bool withLabel = true;
  bool useRtl = false;
  ValueNotifier<PhoneNumberVerification> valueNotifierPhoneNumberVerification = ValueNotifier<PhoneNumberVerification>(
    PhoneNumberVerification.none,
  );

  @override
  void initState() {
    initialPhoneNumberValue = widget.initialPhoneNumberValue ??
        PhoneNumber(
          isoCode: isoCodeNameMap.values.byName('SA'),
          nsn: '',
        );
    controller = PhoneController(initialPhoneNumberValue);
    controller.value = initialPhoneNumberValue;
    defaultCountry = isoCodeNameMap.values.byName('SA');
    phoneNumberFocusNode = widget.phoneNumberFocusNode ?? FocusNode();
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
    valueNotifierPhoneNumberVerification.dispose();
    super.dispose();
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
                    phoneNumber: '+${phoneController.value?.countryCode} ${phoneController.value?.getFormattedNsn().trim()}',
                    countryDialCode: '+${phoneController.value?.countryCode ?? '+966'}',
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
                    phoneNumber: '+${controller?.value?.countryCode} ${controller?.value?.getFormattedNsn().trim()}',
                    countryDialCode: '+${controller?.value?.countryCode ?? '+966'}',
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
        return MultiStreamBuilder(
          key: const Key(
            'business-phone-number-widget-textFormField-key',
          ),
          buildWhen: (
            previousDataList,
            latestDataList,
          ) =>
              previousDataList != latestDataList,
          streams: [
            Stream.fromFuture(
              AppTranslator.instance.translate(
                'Mobile number',
              ),
            ),
            Stream.fromFuture(
              AppTranslator.instance.translate(
                '${widget.withLabel}',
              ),
            ),
            Stream.fromFuture(
              AppTranslator.instance.translate(
                '$phoneValidation',
              ),
            ),
          ],
          initialStreamValue: ['Mobile number', '${widget.withLabel}', phoneValidation],
          builder: (context, snapshot) {
            return AutofillGroup(
              child: Directionality(
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
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
                        suffixIcon: (!widget.haveStateManagement)
                            ? ValueListenableBuilder(
                                valueListenable: valueNotifierPhoneNumberVerification,
                                builder: (context, value, child) {
                                  return PhoneNumberValidateWidget(
                                    phoneNumberVerification: value,
                                  );
                                },
                              )
                            : const PhoneNumberValidationIconWidget(),
                      ) ??
                      InputDecoration(
                        label: widget.withLabel ? const Text('Mobile number').translate() : null,
                        border: widget.outlineBorder ? const OutlineInputBorder() : const UnderlineInputBorder(),
                        hintText: widget.withLabel ? '' : snapshot[0],
                        errorText: phoneValidation,
                        suffixIcon: widget.suffixIcon ?? const PhoneNumberValidationIconWidget(),
                      ),
                  enabled: widget.enabled,
                  textInputAction: widget.textInputAction,
                  keyboardType: widget.keyboardType,
                  showFlagInInput: widget.showFlagInInput,
                  validator: (PhoneNumber? phoneNumber) {
                    final result = widget.validator ?? getValidator(isAllowEmpty: widget.isAllowEmpty);
                    phoneValidation = result?.call(phoneNumber);
                    if (widget.haveStateManagement) {
                      context.read<PhoneFormFieldBloc>().add(
                            PhoneFormFieldValidate(
                              phoneNumberInputValidator: result,
                              phoneValidation: phoneValidation,
                              phoneController: controller,
                            ),
                          );
                    } else {
                      if (phoneValidation != null && phoneValidation!.isNotEmpty) {
                        valueNotifierPhoneNumberVerification.value = PhoneNumberVerification.invalid;
                      } else {
                        if (phoneValidation == null && controller.value != null && controller.value!.getFormattedNsn().trim().isNotEmpty) {
                          valueNotifierPhoneNumberVerification.value = PhoneNumberVerification.valid;
                        } else {
                          valueNotifierPhoneNumberVerification.value = PhoneNumberVerification.none;
                        }
                      }
                    }
                    widget.phoneNumberValidationChanged?.call(
                      phoneValidation,
                      phoneNumber,
                      controller,
                    );
                    return phoneValidation;
                  },
                  autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
                  cursorColor: Theme.of(context).colorScheme.primary,
                  onSaved: (PhoneNumber? p) {
                    widget.onPhoneNumberSaved?.call(p);
                    //return context.read<PhoneFormFieldBloc>().add(PhoneFormFieldOnSave(phoneNumber: p, controller: controller),);
                  },
                  onChanged: (PhoneNumber? p) {
                    widget.onPhoneNumberChanged?.call(p);
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
      },
    );
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
