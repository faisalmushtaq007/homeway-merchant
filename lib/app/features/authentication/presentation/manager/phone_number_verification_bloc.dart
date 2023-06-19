import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homemakers_merchant/shared/widgets/universal/phone_number_text_field/phone_form_field_bloc.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:phone_form_field/phone_form_field.dart';

part 'package:homemakers_merchant/app/features/authentication/common/phone_number_verification_enum.dart';

part 'phone_number_verification_event.dart';

part 'phone_number_verification_state.dart';

part 'phone_number_verification_bloc.freezed.dart';

class PhoneNumberVerificationBloc
    extends Bloc<PhoneNumberVerificationEvent, PhoneNumberVerificationState> {
  PhoneNumberVerificationBloc({
    required this.phoneFormFieldBloc,
  }) : super(const PhoneNumberVerificationState.initial()) {
    phoneFormFieldSubscription =
        phoneFormFieldBloc.stream.listen((phoneNumberFormFieldState) {
      appLog
          .d('phoneFormFieldSubscription listen: ${phoneNumberFormFieldState}');
      phoneNumberFormFieldState.when(
        initialize: () {},
        validate: (
          isAllowEmpty,
          mobileOnly,
          phoneNumberInputValidator,
          phoneValidation,
          phoneController,
          phoneNumber,
        ) {
          PhoneNumberVerification phoneNumberVerification =
              PhoneNumberVerification.none;
          if (phoneNumberVerification != null) {
            appLog.d('PhoneNumberVerification.invalid: ${phoneValidation}');
            phoneNumberVerification = PhoneNumberVerification.invalid;
          } else {
            if (phoneNumberVerification == null &&
                phoneController.value != null &&
                phoneController.value!.getFormattedNsn().trim().isNotEmpty) {
              appLog.d('PhoneNumberVerification.valid: ${phoneValidation}');
              phoneNumberVerification = PhoneNumberVerification.valid;
            } else {
              appLog.d('PhoneNumberVerification.none: ${phoneValidation}');
              phoneNumberVerification = PhoneNumberVerification.none;
            }
          }
          add(
            ValidatePhoneNumber(
              phoneNumber:
                  '+${phoneController?.value?.countryCode} ${phoneController?.value?.getFormattedNsn().trim()}',
              countryDialCode:
                  '+${phoneController?.value?.countryCode ?? '966'}',
              country: phoneController?.value?.isoCode.name ?? 'SA',
              phoneValidation: phoneValidation,
              phoneNumberInputValidator: phoneNumberInputValidator,
              enteredPhoneNumber: phoneNumber,
              phoneNumberVerification: phoneNumberVerification,
            ),
          );
        },
        onChange: (phoneNumber, controller) {
          add(
            PhoneNumberChanged(
              phoneNumber:
                  '+${controller?.value?.countryCode} ${controller?.value?.getFormattedNsn().trim()}',
              countryDialCode: '+${controller?.value?.countryCode ?? '966'}',
              country: controller?.value?.isoCode.name ?? 'SA',
              enteredPhoneNumber: phoneNumber,
            ),
          );
        },
        onSave: (phoneNumber, controller) {},
      );
    });
    on<PhoneNumberChanged>(_phoneNumberChangedEvent);
    on<ValidatePhoneNumber>(_validatePhoneNumberEvent);
    on<VerifyPhoneNumber>(_verifyPhoneNumber);
  }

  final PhoneFormFieldBloc phoneFormFieldBloc;
  late final StreamSubscription phoneFormFieldSubscription;

  FutureOr<void> _phoneNumberChangedEvent(
      PhoneNumberChanged event, Emitter<PhoneNumberVerificationState> emit) {
    emit(PhoneNumberVerificationState.phoneNumberChanged(
      phoneNumber: event.phoneNumber,
      countryDialCode: event.countryDialCode,
      country: event.country,
      phoneValidation: event.phoneValidation,
      phoneNumberInputValidator: event.phoneNumberInputValidator,
      enteredPhoneNumber: event.enteredPhoneNumber,
    ));
  }

  FutureOr<void> _validatePhoneNumberEvent(
      ValidatePhoneNumber event, Emitter<PhoneNumberVerificationState> emit) {
    emit(PhoneNumberVerificationValidatePhoneNumber(
      phoneNumber: event.phoneNumber,
      country: event.country,
      countryDialCode: event.countryDialCode,
      enteredPhoneNumber: event.enteredPhoneNumber,
      phoneNumberVerification: event.phoneNumberVerification,
      phoneNumberInputValidator: event.phoneNumberInputValidator,
      phoneValidation: event.phoneValidation,
    ));
  }

  FutureOr<void> _verifyPhoneNumber(
      VerifyPhoneNumber event, Emitter<PhoneNumberVerificationState> emit) {}

  @override
  Future<void> close() {
    phoneFormFieldSubscription.cancel();
    return super.close();
  }
}
