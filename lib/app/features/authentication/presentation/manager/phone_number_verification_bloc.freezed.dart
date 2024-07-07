// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_number_verification_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PhoneNumberVerificationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)
        phoneNumberChanged,
    required TResult Function(String userEnteredPhoneNumber,
            String countryDialCode, String phoneNumberWithFormat)
        verifyPhoneNumber,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)
        validatePhoneNumber,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    TResult? Function(String userEnteredPhoneNumber, String countryDialCode,
            String phoneNumberWithFormat)?
        verifyPhoneNumber,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    TResult Function(String userEnteredPhoneNumber, String countryDialCode,
            String phoneNumberWithFormat)?
        verifyPhoneNumber,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(VerifyPhoneNumber value) verifyPhoneNumber,
    required TResult Function(ValidatePhoneNumber value) validatePhoneNumber,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(VerifyPhoneNumber value)? verifyPhoneNumber,
    TResult? Function(ValidatePhoneNumber value)? validatePhoneNumber,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(VerifyPhoneNumber value)? verifyPhoneNumber,
    TResult Function(ValidatePhoneNumber value)? validatePhoneNumber,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhoneNumberVerificationEventCopyWith<$Res> {
  factory $PhoneNumberVerificationEventCopyWith(
          PhoneNumberVerificationEvent value,
          $Res Function(PhoneNumberVerificationEvent) then) =
      _$PhoneNumberVerificationEventCopyWithImpl<$Res,
          PhoneNumberVerificationEvent>;
}

/// @nodoc
class _$PhoneNumberVerificationEventCopyWithImpl<$Res,
        $Val extends PhoneNumberVerificationEvent>
    implements $PhoneNumberVerificationEventCopyWith<$Res> {
  _$PhoneNumberVerificationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$PhoneNumberVerificationEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'PhoneNumberVerificationEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)
        phoneNumberChanged,
    required TResult Function(String userEnteredPhoneNumber,
            String countryDialCode, String phoneNumberWithFormat)
        verifyPhoneNumber,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)
        validatePhoneNumber,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    TResult? Function(String userEnteredPhoneNumber, String countryDialCode,
            String phoneNumberWithFormat)?
        verifyPhoneNumber,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    TResult Function(String userEnteredPhoneNumber, String countryDialCode,
            String phoneNumberWithFormat)?
        verifyPhoneNumber,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(VerifyPhoneNumber value) verifyPhoneNumber,
    required TResult Function(ValidatePhoneNumber value) validatePhoneNumber,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(VerifyPhoneNumber value)? verifyPhoneNumber,
    TResult? Function(ValidatePhoneNumber value)? validatePhoneNumber,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(VerifyPhoneNumber value)? verifyPhoneNumber,
    TResult Function(ValidatePhoneNumber value)? validatePhoneNumber,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements PhoneNumberVerificationEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$PhoneNumberChangedImplCopyWith<$Res> {
  factory _$$PhoneNumberChangedImplCopyWith(_$PhoneNumberChangedImpl value,
          $Res Function(_$PhoneNumberChangedImpl) then) =
      __$$PhoneNumberChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String phoneNumber,
      String countryDialCode,
      String country,
      PhoneNumberInputValidator? phoneNumberInputValidator,
      String? phoneValidation,
      PhoneNumber? enteredPhoneNumber,
      PhoneController phoneController,
      String isoCode});
}

/// @nodoc
class __$$PhoneNumberChangedImplCopyWithImpl<$Res>
    extends _$PhoneNumberVerificationEventCopyWithImpl<$Res,
        _$PhoneNumberChangedImpl>
    implements _$$PhoneNumberChangedImplCopyWith<$Res> {
  __$$PhoneNumberChangedImplCopyWithImpl(_$PhoneNumberChangedImpl _value,
      $Res Function(_$PhoneNumberChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? countryDialCode = null,
    Object? country = null,
    Object? phoneNumberInputValidator = freezed,
    Object? phoneValidation = freezed,
    Object? enteredPhoneNumber = freezed,
    Object? phoneController = null,
    Object? isoCode = null,
  }) {
    return _then(_$PhoneNumberChangedImpl(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      countryDialCode: null == countryDialCode
          ? _value.countryDialCode
          : countryDialCode // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumberInputValidator: freezed == phoneNumberInputValidator
          ? _value.phoneNumberInputValidator
          : phoneNumberInputValidator // ignore: cast_nullable_to_non_nullable
              as PhoneNumberInputValidator?,
      phoneValidation: freezed == phoneValidation
          ? _value.phoneValidation
          : phoneValidation // ignore: cast_nullable_to_non_nullable
              as String?,
      enteredPhoneNumber: freezed == enteredPhoneNumber
          ? _value.enteredPhoneNumber
          : enteredPhoneNumber // ignore: cast_nullable_to_non_nullable
              as PhoneNumber?,
      phoneController: null == phoneController
          ? _value.phoneController
          : phoneController // ignore: cast_nullable_to_non_nullable
              as PhoneController,
      isoCode: null == isoCode
          ? _value.isoCode
          : isoCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PhoneNumberChangedImpl implements PhoneNumberChanged {
  const _$PhoneNumberChangedImpl(
      {required this.phoneNumber,
      this.countryDialCode = '+966',
      required this.country,
      this.phoneNumberInputValidator,
      this.phoneValidation,
      this.enteredPhoneNumber,
      required this.phoneController,
      this.isoCode = 'SA'});

  @override
  final String phoneNumber;
  @override
  @JsonKey()
  final String countryDialCode;
  @override
  final String country;
  @override
  final PhoneNumberInputValidator? phoneNumberInputValidator;
  @override
  final String? phoneValidation;
  @override
  final PhoneNumber? enteredPhoneNumber;
  @override
  final PhoneController phoneController;
  @override
  @JsonKey()
  final String isoCode;

  @override
  String toString() {
    return 'PhoneNumberVerificationEvent.phoneNumberChanged(phoneNumber: $phoneNumber, countryDialCode: $countryDialCode, country: $country, phoneNumberInputValidator: $phoneNumberInputValidator, phoneValidation: $phoneValidation, enteredPhoneNumber: $enteredPhoneNumber, phoneController: $phoneController, isoCode: $isoCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneNumberChangedImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.countryDialCode, countryDialCode) ||
                other.countryDialCode == countryDialCode) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.phoneNumberInputValidator,
                    phoneNumberInputValidator) ||
                other.phoneNumberInputValidator == phoneNumberInputValidator) &&
            (identical(other.phoneValidation, phoneValidation) ||
                other.phoneValidation == phoneValidation) &&
            (identical(other.enteredPhoneNumber, enteredPhoneNumber) ||
                other.enteredPhoneNumber == enteredPhoneNumber) &&
            (identical(other.phoneController, phoneController) ||
                other.phoneController == phoneController) &&
            (identical(other.isoCode, isoCode) || other.isoCode == isoCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      phoneNumber,
      countryDialCode,
      country,
      phoneNumberInputValidator,
      phoneValidation,
      enteredPhoneNumber,
      phoneController,
      isoCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneNumberChangedImplCopyWith<_$PhoneNumberChangedImpl> get copyWith =>
      __$$PhoneNumberChangedImplCopyWithImpl<_$PhoneNumberChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)
        phoneNumberChanged,
    required TResult Function(String userEnteredPhoneNumber,
            String countryDialCode, String phoneNumberWithFormat)
        verifyPhoneNumber,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)
        validatePhoneNumber,
  }) {
    return phoneNumberChanged(
        phoneNumber,
        countryDialCode,
        country,
        phoneNumberInputValidator,
        phoneValidation,
        enteredPhoneNumber,
        phoneController,
        isoCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    TResult? Function(String userEnteredPhoneNumber, String countryDialCode,
            String phoneNumberWithFormat)?
        verifyPhoneNumber,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
  }) {
    return phoneNumberChanged?.call(
        phoneNumber,
        countryDialCode,
        country,
        phoneNumberInputValidator,
        phoneValidation,
        enteredPhoneNumber,
        phoneController,
        isoCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    TResult Function(String userEnteredPhoneNumber, String countryDialCode,
            String phoneNumberWithFormat)?
        verifyPhoneNumber,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    required TResult orElse(),
  }) {
    if (phoneNumberChanged != null) {
      return phoneNumberChanged(
          phoneNumber,
          countryDialCode,
          country,
          phoneNumberInputValidator,
          phoneValidation,
          enteredPhoneNumber,
          phoneController,
          isoCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(VerifyPhoneNumber value) verifyPhoneNumber,
    required TResult Function(ValidatePhoneNumber value) validatePhoneNumber,
  }) {
    return phoneNumberChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(VerifyPhoneNumber value)? verifyPhoneNumber,
    TResult? Function(ValidatePhoneNumber value)? validatePhoneNumber,
  }) {
    return phoneNumberChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(VerifyPhoneNumber value)? verifyPhoneNumber,
    TResult Function(ValidatePhoneNumber value)? validatePhoneNumber,
    required TResult orElse(),
  }) {
    if (phoneNumberChanged != null) {
      return phoneNumberChanged(this);
    }
    return orElse();
  }
}

abstract class PhoneNumberChanged implements PhoneNumberVerificationEvent {
  const factory PhoneNumberChanged(
      {required final String phoneNumber,
      final String countryDialCode,
      required final String country,
      final PhoneNumberInputValidator? phoneNumberInputValidator,
      final String? phoneValidation,
      final PhoneNumber? enteredPhoneNumber,
      required final PhoneController phoneController,
      final String isoCode}) = _$PhoneNumberChangedImpl;

  String get phoneNumber;
  String get countryDialCode;
  String get country;
  PhoneNumberInputValidator? get phoneNumberInputValidator;
  String? get phoneValidation;
  PhoneNumber? get enteredPhoneNumber;
  PhoneController get phoneController;
  String get isoCode;
  @JsonKey(ignore: true)
  _$$PhoneNumberChangedImplCopyWith<_$PhoneNumberChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VerifyPhoneNumberImplCopyWith<$Res> {
  factory _$$VerifyPhoneNumberImplCopyWith(_$VerifyPhoneNumberImpl value,
          $Res Function(_$VerifyPhoneNumberImpl) then) =
      __$$VerifyPhoneNumberImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String userEnteredPhoneNumber,
      String countryDialCode,
      String phoneNumberWithFormat});
}

/// @nodoc
class __$$VerifyPhoneNumberImplCopyWithImpl<$Res>
    extends _$PhoneNumberVerificationEventCopyWithImpl<$Res,
        _$VerifyPhoneNumberImpl>
    implements _$$VerifyPhoneNumberImplCopyWith<$Res> {
  __$$VerifyPhoneNumberImplCopyWithImpl(_$VerifyPhoneNumberImpl _value,
      $Res Function(_$VerifyPhoneNumberImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userEnteredPhoneNumber = null,
    Object? countryDialCode = null,
    Object? phoneNumberWithFormat = null,
  }) {
    return _then(_$VerifyPhoneNumberImpl(
      userEnteredPhoneNumber: null == userEnteredPhoneNumber
          ? _value.userEnteredPhoneNumber
          : userEnteredPhoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      countryDialCode: null == countryDialCode
          ? _value.countryDialCode
          : countryDialCode // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumberWithFormat: null == phoneNumberWithFormat
          ? _value.phoneNumberWithFormat
          : phoneNumberWithFormat // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$VerifyPhoneNumberImpl implements VerifyPhoneNumber {
  const _$VerifyPhoneNumberImpl(
      {required this.userEnteredPhoneNumber,
      this.countryDialCode = '+966',
      required this.phoneNumberWithFormat});

  @override
  final String userEnteredPhoneNumber;
  @override
  @JsonKey()
  final String countryDialCode;
  @override
  final String phoneNumberWithFormat;

  @override
  String toString() {
    return 'PhoneNumberVerificationEvent.verifyPhoneNumber(userEnteredPhoneNumber: $userEnteredPhoneNumber, countryDialCode: $countryDialCode, phoneNumberWithFormat: $phoneNumberWithFormat)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyPhoneNumberImpl &&
            (identical(other.userEnteredPhoneNumber, userEnteredPhoneNumber) ||
                other.userEnteredPhoneNumber == userEnteredPhoneNumber) &&
            (identical(other.countryDialCode, countryDialCode) ||
                other.countryDialCode == countryDialCode) &&
            (identical(other.phoneNumberWithFormat, phoneNumberWithFormat) ||
                other.phoneNumberWithFormat == phoneNumberWithFormat));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userEnteredPhoneNumber,
      countryDialCode, phoneNumberWithFormat);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyPhoneNumberImplCopyWith<_$VerifyPhoneNumberImpl> get copyWith =>
      __$$VerifyPhoneNumberImplCopyWithImpl<_$VerifyPhoneNumberImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)
        phoneNumberChanged,
    required TResult Function(String userEnteredPhoneNumber,
            String countryDialCode, String phoneNumberWithFormat)
        verifyPhoneNumber,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)
        validatePhoneNumber,
  }) {
    return verifyPhoneNumber(
        userEnteredPhoneNumber, countryDialCode, phoneNumberWithFormat);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    TResult? Function(String userEnteredPhoneNumber, String countryDialCode,
            String phoneNumberWithFormat)?
        verifyPhoneNumber,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
  }) {
    return verifyPhoneNumber?.call(
        userEnteredPhoneNumber, countryDialCode, phoneNumberWithFormat);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    TResult Function(String userEnteredPhoneNumber, String countryDialCode,
            String phoneNumberWithFormat)?
        verifyPhoneNumber,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    required TResult orElse(),
  }) {
    if (verifyPhoneNumber != null) {
      return verifyPhoneNumber(
          userEnteredPhoneNumber, countryDialCode, phoneNumberWithFormat);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(VerifyPhoneNumber value) verifyPhoneNumber,
    required TResult Function(ValidatePhoneNumber value) validatePhoneNumber,
  }) {
    return verifyPhoneNumber(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(VerifyPhoneNumber value)? verifyPhoneNumber,
    TResult? Function(ValidatePhoneNumber value)? validatePhoneNumber,
  }) {
    return verifyPhoneNumber?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(VerifyPhoneNumber value)? verifyPhoneNumber,
    TResult Function(ValidatePhoneNumber value)? validatePhoneNumber,
    required TResult orElse(),
  }) {
    if (verifyPhoneNumber != null) {
      return verifyPhoneNumber(this);
    }
    return orElse();
  }
}

abstract class VerifyPhoneNumber implements PhoneNumberVerificationEvent {
  const factory VerifyPhoneNumber(
      {required final String userEnteredPhoneNumber,
      final String countryDialCode,
      required final String phoneNumberWithFormat}) = _$VerifyPhoneNumberImpl;

  String get userEnteredPhoneNumber;
  String get countryDialCode;
  String get phoneNumberWithFormat;
  @JsonKey(ignore: true)
  _$$VerifyPhoneNumberImplCopyWith<_$VerifyPhoneNumberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidatePhoneNumberImplCopyWith<$Res> {
  factory _$$ValidatePhoneNumberImplCopyWith(_$ValidatePhoneNumberImpl value,
          $Res Function(_$ValidatePhoneNumberImpl) then) =
      __$$ValidatePhoneNumberImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String phoneNumber,
      String countryDialCode,
      String country,
      PhoneNumberInputValidator? phoneNumberInputValidator,
      String? phoneValidation,
      PhoneNumber? enteredPhoneNumber,
      PhoneNumberVerification phoneNumberVerification,
      PhoneController phoneController,
      String isoCode});
}

/// @nodoc
class __$$ValidatePhoneNumberImplCopyWithImpl<$Res>
    extends _$PhoneNumberVerificationEventCopyWithImpl<$Res,
        _$ValidatePhoneNumberImpl>
    implements _$$ValidatePhoneNumberImplCopyWith<$Res> {
  __$$ValidatePhoneNumberImplCopyWithImpl(_$ValidatePhoneNumberImpl _value,
      $Res Function(_$ValidatePhoneNumberImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? countryDialCode = null,
    Object? country = null,
    Object? phoneNumberInputValidator = freezed,
    Object? phoneValidation = freezed,
    Object? enteredPhoneNumber = freezed,
    Object? phoneNumberVerification = null,
    Object? phoneController = null,
    Object? isoCode = null,
  }) {
    return _then(_$ValidatePhoneNumberImpl(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      countryDialCode: null == countryDialCode
          ? _value.countryDialCode
          : countryDialCode // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumberInputValidator: freezed == phoneNumberInputValidator
          ? _value.phoneNumberInputValidator
          : phoneNumberInputValidator // ignore: cast_nullable_to_non_nullable
              as PhoneNumberInputValidator?,
      phoneValidation: freezed == phoneValidation
          ? _value.phoneValidation
          : phoneValidation // ignore: cast_nullable_to_non_nullable
              as String?,
      enteredPhoneNumber: freezed == enteredPhoneNumber
          ? _value.enteredPhoneNumber
          : enteredPhoneNumber // ignore: cast_nullable_to_non_nullable
              as PhoneNumber?,
      phoneNumberVerification: null == phoneNumberVerification
          ? _value.phoneNumberVerification
          : phoneNumberVerification // ignore: cast_nullable_to_non_nullable
              as PhoneNumberVerification,
      phoneController: null == phoneController
          ? _value.phoneController
          : phoneController // ignore: cast_nullable_to_non_nullable
              as PhoneController,
      isoCode: null == isoCode
          ? _value.isoCode
          : isoCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ValidatePhoneNumberImpl implements ValidatePhoneNumber {
  const _$ValidatePhoneNumberImpl(
      {required this.phoneNumber,
      this.countryDialCode = '+966',
      required this.country,
      this.phoneNumberInputValidator,
      this.phoneValidation,
      this.enteredPhoneNumber,
      this.phoneNumberVerification = PhoneNumberVerification.none,
      required this.phoneController,
      this.isoCode = 'SA'});

  @override
  final String phoneNumber;
  @override
  @JsonKey()
  final String countryDialCode;
  @override
  final String country;
  @override
  final PhoneNumberInputValidator? phoneNumberInputValidator;
  @override
  final String? phoneValidation;
  @override
  final PhoneNumber? enteredPhoneNumber;
  @override
  @JsonKey()
  final PhoneNumberVerification phoneNumberVerification;
  @override
  final PhoneController phoneController;
  @override
  @JsonKey()
  final String isoCode;

  @override
  String toString() {
    return 'PhoneNumberVerificationEvent.validatePhoneNumber(phoneNumber: $phoneNumber, countryDialCode: $countryDialCode, country: $country, phoneNumberInputValidator: $phoneNumberInputValidator, phoneValidation: $phoneValidation, enteredPhoneNumber: $enteredPhoneNumber, phoneNumberVerification: $phoneNumberVerification, phoneController: $phoneController, isoCode: $isoCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidatePhoneNumberImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.countryDialCode, countryDialCode) ||
                other.countryDialCode == countryDialCode) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.phoneNumberInputValidator,
                    phoneNumberInputValidator) ||
                other.phoneNumberInputValidator == phoneNumberInputValidator) &&
            (identical(other.phoneValidation, phoneValidation) ||
                other.phoneValidation == phoneValidation) &&
            (identical(other.enteredPhoneNumber, enteredPhoneNumber) ||
                other.enteredPhoneNumber == enteredPhoneNumber) &&
            (identical(
                    other.phoneNumberVerification, phoneNumberVerification) ||
                other.phoneNumberVerification == phoneNumberVerification) &&
            (identical(other.phoneController, phoneController) ||
                other.phoneController == phoneController) &&
            (identical(other.isoCode, isoCode) || other.isoCode == isoCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      phoneNumber,
      countryDialCode,
      country,
      phoneNumberInputValidator,
      phoneValidation,
      enteredPhoneNumber,
      phoneNumberVerification,
      phoneController,
      isoCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidatePhoneNumberImplCopyWith<_$ValidatePhoneNumberImpl> get copyWith =>
      __$$ValidatePhoneNumberImplCopyWithImpl<_$ValidatePhoneNumberImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)
        phoneNumberChanged,
    required TResult Function(String userEnteredPhoneNumber,
            String countryDialCode, String phoneNumberWithFormat)
        verifyPhoneNumber,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)
        validatePhoneNumber,
  }) {
    return validatePhoneNumber(
        phoneNumber,
        countryDialCode,
        country,
        phoneNumberInputValidator,
        phoneValidation,
        enteredPhoneNumber,
        phoneNumberVerification,
        phoneController,
        isoCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    TResult? Function(String userEnteredPhoneNumber, String countryDialCode,
            String phoneNumberWithFormat)?
        verifyPhoneNumber,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
  }) {
    return validatePhoneNumber?.call(
        phoneNumber,
        countryDialCode,
        country,
        phoneNumberInputValidator,
        phoneValidation,
        enteredPhoneNumber,
        phoneNumberVerification,
        phoneController,
        isoCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    TResult Function(String userEnteredPhoneNumber, String countryDialCode,
            String phoneNumberWithFormat)?
        verifyPhoneNumber,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    required TResult orElse(),
  }) {
    if (validatePhoneNumber != null) {
      return validatePhoneNumber(
          phoneNumber,
          countryDialCode,
          country,
          phoneNumberInputValidator,
          phoneValidation,
          enteredPhoneNumber,
          phoneNumberVerification,
          phoneController,
          isoCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(VerifyPhoneNumber value) verifyPhoneNumber,
    required TResult Function(ValidatePhoneNumber value) validatePhoneNumber,
  }) {
    return validatePhoneNumber(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(VerifyPhoneNumber value)? verifyPhoneNumber,
    TResult? Function(ValidatePhoneNumber value)? validatePhoneNumber,
  }) {
    return validatePhoneNumber?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(VerifyPhoneNumber value)? verifyPhoneNumber,
    TResult Function(ValidatePhoneNumber value)? validatePhoneNumber,
    required TResult orElse(),
  }) {
    if (validatePhoneNumber != null) {
      return validatePhoneNumber(this);
    }
    return orElse();
  }
}

abstract class ValidatePhoneNumber implements PhoneNumberVerificationEvent {
  const factory ValidatePhoneNumber(
      {required final String phoneNumber,
      final String countryDialCode,
      required final String country,
      final PhoneNumberInputValidator? phoneNumberInputValidator,
      final String? phoneValidation,
      final PhoneNumber? enteredPhoneNumber,
      final PhoneNumberVerification phoneNumberVerification,
      required final PhoneController phoneController,
      final String isoCode}) = _$ValidatePhoneNumberImpl;

  String get phoneNumber;
  String get countryDialCode;
  String get country;
  PhoneNumberInputValidator? get phoneNumberInputValidator;
  String? get phoneValidation;
  PhoneNumber? get enteredPhoneNumber;
  PhoneNumberVerification get phoneNumberVerification;
  PhoneController get phoneController;
  String get isoCode;
  @JsonKey(ignore: true)
  _$$ValidatePhoneNumberImplCopyWith<_$ValidatePhoneNumberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PhoneNumberVerificationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        initial,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)
        success,
    required TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)
        error,
    required TResult Function() loading,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        processing,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        valid,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)
        invalid,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)
        validatePhoneNumber,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)
        phoneNumberChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult? Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult? Function()? loading,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult Function()? loading,
    TResult Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PhoneNumberVerificationInitialState value)
        initial,
    required TResult Function(PhoneNumberVerificationSuccessState value)
        success,
    required TResult Function(PhoneNumberVerificationErrorState value) error,
    required TResult Function(PhoneNumberVerificationLoadingState value)
        loading,
    required TResult Function(PhoneNumberVerificationProcessingState value)
        processing,
    required TResult Function(PhoneNumberVerificationValidState value) valid,
    required TResult Function(PhoneNumberVerificationInvalidState value)
        invalid,
    required TResult Function(PhoneNumberVerificationValidatePhoneNumber value)
        validatePhoneNumber,
    required TResult Function(PhoneNumberVerificationPhoneNumberChanged value)
        phoneNumberChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerificationInitialState value)? initial,
    TResult? Function(PhoneNumberVerificationSuccessState value)? success,
    TResult? Function(PhoneNumberVerificationErrorState value)? error,
    TResult? Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult? Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult? Function(PhoneNumberVerificationValidState value)? valid,
    TResult? Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult? Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult? Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PhoneNumberVerificationInitialState value)? initial,
    TResult Function(PhoneNumberVerificationSuccessState value)? success,
    TResult Function(PhoneNumberVerificationErrorState value)? error,
    TResult Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult Function(PhoneNumberVerificationValidState value)? valid,
    TResult Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhoneNumberVerificationStateCopyWith<$Res> {
  factory $PhoneNumberVerificationStateCopyWith(
          PhoneNumberVerificationState value,
          $Res Function(PhoneNumberVerificationState) then) =
      _$PhoneNumberVerificationStateCopyWithImpl<$Res,
          PhoneNumberVerificationState>;
}

/// @nodoc
class _$PhoneNumberVerificationStateCopyWithImpl<$Res,
        $Val extends PhoneNumberVerificationState>
    implements $PhoneNumberVerificationStateCopyWith<$Res> {
  _$PhoneNumberVerificationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$PhoneNumberVerificationInitialStateImplCopyWith<$Res> {
  factory _$$PhoneNumberVerificationInitialStateImplCopyWith(
          _$PhoneNumberVerificationInitialStateImpl value,
          $Res Function(_$PhoneNumberVerificationInitialStateImpl) then) =
      __$$PhoneNumberVerificationInitialStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PhoneNumberVerification phoneNumberVerification});
}

/// @nodoc
class __$$PhoneNumberVerificationInitialStateImplCopyWithImpl<$Res>
    extends _$PhoneNumberVerificationStateCopyWithImpl<$Res,
        _$PhoneNumberVerificationInitialStateImpl>
    implements _$$PhoneNumberVerificationInitialStateImplCopyWith<$Res> {
  __$$PhoneNumberVerificationInitialStateImplCopyWithImpl(
      _$PhoneNumberVerificationInitialStateImpl _value,
      $Res Function(_$PhoneNumberVerificationInitialStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumberVerification = null,
  }) {
    return _then(_$PhoneNumberVerificationInitialStateImpl(
      phoneNumberVerification: null == phoneNumberVerification
          ? _value.phoneNumberVerification
          : phoneNumberVerification // ignore: cast_nullable_to_non_nullable
              as PhoneNumberVerification,
    ));
  }
}

/// @nodoc

class _$PhoneNumberVerificationInitialStateImpl
    implements PhoneNumberVerificationInitialState {
  const _$PhoneNumberVerificationInitialStateImpl(
      {this.phoneNumberVerification = PhoneNumberVerification.none});

  @override
  @JsonKey()
  final PhoneNumberVerification phoneNumberVerification;

  @override
  String toString() {
    return 'PhoneNumberVerificationState.initial(phoneNumberVerification: $phoneNumberVerification)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneNumberVerificationInitialStateImpl &&
            (identical(
                    other.phoneNumberVerification, phoneNumberVerification) ||
                other.phoneNumberVerification == phoneNumberVerification));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNumberVerification);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneNumberVerificationInitialStateImplCopyWith<
          _$PhoneNumberVerificationInitialStateImpl>
      get copyWith => __$$PhoneNumberVerificationInitialStateImplCopyWithImpl<
          _$PhoneNumberVerificationInitialStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        initial,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)
        success,
    required TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)
        error,
    required TResult Function() loading,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        processing,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        valid,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)
        invalid,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)
        validatePhoneNumber,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)
        phoneNumberChanged,
  }) {
    return initial(phoneNumberVerification);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult? Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult? Function()? loading,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
  }) {
    return initial?.call(phoneNumberVerification);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult Function()? loading,
    TResult Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(phoneNumberVerification);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PhoneNumberVerificationInitialState value)
        initial,
    required TResult Function(PhoneNumberVerificationSuccessState value)
        success,
    required TResult Function(PhoneNumberVerificationErrorState value) error,
    required TResult Function(PhoneNumberVerificationLoadingState value)
        loading,
    required TResult Function(PhoneNumberVerificationProcessingState value)
        processing,
    required TResult Function(PhoneNumberVerificationValidState value) valid,
    required TResult Function(PhoneNumberVerificationInvalidState value)
        invalid,
    required TResult Function(PhoneNumberVerificationValidatePhoneNumber value)
        validatePhoneNumber,
    required TResult Function(PhoneNumberVerificationPhoneNumberChanged value)
        phoneNumberChanged,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerificationInitialState value)? initial,
    TResult? Function(PhoneNumberVerificationSuccessState value)? success,
    TResult? Function(PhoneNumberVerificationErrorState value)? error,
    TResult? Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult? Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult? Function(PhoneNumberVerificationValidState value)? valid,
    TResult? Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult? Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult? Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PhoneNumberVerificationInitialState value)? initial,
    TResult Function(PhoneNumberVerificationSuccessState value)? success,
    TResult Function(PhoneNumberVerificationErrorState value)? error,
    TResult Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult Function(PhoneNumberVerificationValidState value)? valid,
    TResult Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class PhoneNumberVerificationInitialState
    implements PhoneNumberVerificationState {
  const factory PhoneNumberVerificationInitialState(
          {final PhoneNumberVerification phoneNumberVerification}) =
      _$PhoneNumberVerificationInitialStateImpl;

  PhoneNumberVerification get phoneNumberVerification;
  @JsonKey(ignore: true)
  _$$PhoneNumberVerificationInitialStateImplCopyWith<
          _$PhoneNumberVerificationInitialStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PhoneNumberVerificationSuccessStateImplCopyWith<$Res> {
  factory _$$PhoneNumberVerificationSuccessStateImplCopyWith(
          _$PhoneNumberVerificationSuccessStateImpl value,
          $Res Function(_$PhoneNumberVerificationSuccessStateImpl) then) =
      __$$PhoneNumberVerificationSuccessStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {PhoneNumberVerification phoneNumberVerification,
      String userEnteredPhoneNumber,
      String countryDialCode,
      AsyncBtnState asyncBtnState,
      String phoneNumberWithFormat});
}

/// @nodoc
class __$$PhoneNumberVerificationSuccessStateImplCopyWithImpl<$Res>
    extends _$PhoneNumberVerificationStateCopyWithImpl<$Res,
        _$PhoneNumberVerificationSuccessStateImpl>
    implements _$$PhoneNumberVerificationSuccessStateImplCopyWith<$Res> {
  __$$PhoneNumberVerificationSuccessStateImplCopyWithImpl(
      _$PhoneNumberVerificationSuccessStateImpl _value,
      $Res Function(_$PhoneNumberVerificationSuccessStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumberVerification = null,
    Object? userEnteredPhoneNumber = null,
    Object? countryDialCode = null,
    Object? asyncBtnState = null,
    Object? phoneNumberWithFormat = null,
  }) {
    return _then(_$PhoneNumberVerificationSuccessStateImpl(
      phoneNumberVerification: null == phoneNumberVerification
          ? _value.phoneNumberVerification
          : phoneNumberVerification // ignore: cast_nullable_to_non_nullable
              as PhoneNumberVerification,
      userEnteredPhoneNumber: null == userEnteredPhoneNumber
          ? _value.userEnteredPhoneNumber
          : userEnteredPhoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      countryDialCode: null == countryDialCode
          ? _value.countryDialCode
          : countryDialCode // ignore: cast_nullable_to_non_nullable
              as String,
      asyncBtnState: null == asyncBtnState
          ? _value.asyncBtnState
          : asyncBtnState // ignore: cast_nullable_to_non_nullable
              as AsyncBtnState,
      phoneNumberWithFormat: null == phoneNumberWithFormat
          ? _value.phoneNumberWithFormat
          : phoneNumberWithFormat // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PhoneNumberVerificationSuccessStateImpl
    implements PhoneNumberVerificationSuccessState {
  const _$PhoneNumberVerificationSuccessStateImpl(
      {this.phoneNumberVerification = PhoneNumberVerification.otpSent,
      required this.userEnteredPhoneNumber,
      this.countryDialCode = '+966',
      this.asyncBtnState = AsyncBtnState.success,
      required this.phoneNumberWithFormat});

  @override
  @JsonKey()
  final PhoneNumberVerification phoneNumberVerification;
  @override
  final String userEnteredPhoneNumber;
  @override
  @JsonKey()
  final String countryDialCode;
  @override
  @JsonKey()
  final AsyncBtnState asyncBtnState;
  @override
  final String phoneNumberWithFormat;

  @override
  String toString() {
    return 'PhoneNumberVerificationState.success(phoneNumberVerification: $phoneNumberVerification, userEnteredPhoneNumber: $userEnteredPhoneNumber, countryDialCode: $countryDialCode, asyncBtnState: $asyncBtnState, phoneNumberWithFormat: $phoneNumberWithFormat)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneNumberVerificationSuccessStateImpl &&
            (identical(
                    other.phoneNumberVerification, phoneNumberVerification) ||
                other.phoneNumberVerification == phoneNumberVerification) &&
            (identical(other.userEnteredPhoneNumber, userEnteredPhoneNumber) ||
                other.userEnteredPhoneNumber == userEnteredPhoneNumber) &&
            (identical(other.countryDialCode, countryDialCode) ||
                other.countryDialCode == countryDialCode) &&
            (identical(other.asyncBtnState, asyncBtnState) ||
                other.asyncBtnState == asyncBtnState) &&
            (identical(other.phoneNumberWithFormat, phoneNumberWithFormat) ||
                other.phoneNumberWithFormat == phoneNumberWithFormat));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      phoneNumberVerification,
      userEnteredPhoneNumber,
      countryDialCode,
      asyncBtnState,
      phoneNumberWithFormat);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneNumberVerificationSuccessStateImplCopyWith<
          _$PhoneNumberVerificationSuccessStateImpl>
      get copyWith => __$$PhoneNumberVerificationSuccessStateImplCopyWithImpl<
          _$PhoneNumberVerificationSuccessStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        initial,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)
        success,
    required TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)
        error,
    required TResult Function() loading,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        processing,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        valid,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)
        invalid,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)
        validatePhoneNumber,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)
        phoneNumberChanged,
  }) {
    return success(phoneNumberVerification, userEnteredPhoneNumber,
        countryDialCode, asyncBtnState, phoneNumberWithFormat);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult? Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult? Function()? loading,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
  }) {
    return success?.call(phoneNumberVerification, userEnteredPhoneNumber,
        countryDialCode, asyncBtnState, phoneNumberWithFormat);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult Function()? loading,
    TResult Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(phoneNumberVerification, userEnteredPhoneNumber,
          countryDialCode, asyncBtnState, phoneNumberWithFormat);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PhoneNumberVerificationInitialState value)
        initial,
    required TResult Function(PhoneNumberVerificationSuccessState value)
        success,
    required TResult Function(PhoneNumberVerificationErrorState value) error,
    required TResult Function(PhoneNumberVerificationLoadingState value)
        loading,
    required TResult Function(PhoneNumberVerificationProcessingState value)
        processing,
    required TResult Function(PhoneNumberVerificationValidState value) valid,
    required TResult Function(PhoneNumberVerificationInvalidState value)
        invalid,
    required TResult Function(PhoneNumberVerificationValidatePhoneNumber value)
        validatePhoneNumber,
    required TResult Function(PhoneNumberVerificationPhoneNumberChanged value)
        phoneNumberChanged,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerificationInitialState value)? initial,
    TResult? Function(PhoneNumberVerificationSuccessState value)? success,
    TResult? Function(PhoneNumberVerificationErrorState value)? error,
    TResult? Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult? Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult? Function(PhoneNumberVerificationValidState value)? valid,
    TResult? Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult? Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult? Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PhoneNumberVerificationInitialState value)? initial,
    TResult Function(PhoneNumberVerificationSuccessState value)? success,
    TResult Function(PhoneNumberVerificationErrorState value)? error,
    TResult Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult Function(PhoneNumberVerificationValidState value)? valid,
    TResult Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class PhoneNumberVerificationSuccessState
    implements PhoneNumberVerificationState {
  const factory PhoneNumberVerificationSuccessState(
          {final PhoneNumberVerification phoneNumberVerification,
          required final String userEnteredPhoneNumber,
          final String countryDialCode,
          final AsyncBtnState asyncBtnState,
          required final String phoneNumberWithFormat}) =
      _$PhoneNumberVerificationSuccessStateImpl;

  PhoneNumberVerification get phoneNumberVerification;
  String get userEnteredPhoneNumber;
  String get countryDialCode;
  AsyncBtnState get asyncBtnState;
  String get phoneNumberWithFormat;
  @JsonKey(ignore: true)
  _$$PhoneNumberVerificationSuccessStateImplCopyWith<
          _$PhoneNumberVerificationSuccessStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PhoneNumberVerificationErrorStateImplCopyWith<$Res> {
  factory _$$PhoneNumberVerificationErrorStateImplCopyWith(
          _$PhoneNumberVerificationErrorStateImpl value,
          $Res Function(_$PhoneNumberVerificationErrorStateImpl) then) =
      __$$PhoneNumberVerificationErrorStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {PhoneNumberVerification phoneNumberVerification,
      String reason,
      AsyncBtnState asyncBtnState});
}

/// @nodoc
class __$$PhoneNumberVerificationErrorStateImplCopyWithImpl<$Res>
    extends _$PhoneNumberVerificationStateCopyWithImpl<$Res,
        _$PhoneNumberVerificationErrorStateImpl>
    implements _$$PhoneNumberVerificationErrorStateImplCopyWith<$Res> {
  __$$PhoneNumberVerificationErrorStateImplCopyWithImpl(
      _$PhoneNumberVerificationErrorStateImpl _value,
      $Res Function(_$PhoneNumberVerificationErrorStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumberVerification = null,
    Object? reason = null,
    Object? asyncBtnState = null,
  }) {
    return _then(_$PhoneNumberVerificationErrorStateImpl(
      phoneNumberVerification: null == phoneNumberVerification
          ? _value.phoneNumberVerification
          : phoneNumberVerification // ignore: cast_nullable_to_non_nullable
              as PhoneNumberVerification,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      asyncBtnState: null == asyncBtnState
          ? _value.asyncBtnState
          : asyncBtnState // ignore: cast_nullable_to_non_nullable
              as AsyncBtnState,
    ));
  }
}

/// @nodoc

class _$PhoneNumberVerificationErrorStateImpl
    implements PhoneNumberVerificationErrorState {
  const _$PhoneNumberVerificationErrorStateImpl(
      {this.phoneNumberVerification = PhoneNumberVerification.error,
      required this.reason,
      this.asyncBtnState = AsyncBtnState.failure});

  @override
  @JsonKey()
  final PhoneNumberVerification phoneNumberVerification;
  @override
  final String reason;
  @override
  @JsonKey()
  final AsyncBtnState asyncBtnState;

  @override
  String toString() {
    return 'PhoneNumberVerificationState.error(phoneNumberVerification: $phoneNumberVerification, reason: $reason, asyncBtnState: $asyncBtnState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneNumberVerificationErrorStateImpl &&
            (identical(
                    other.phoneNumberVerification, phoneNumberVerification) ||
                other.phoneNumberVerification == phoneNumberVerification) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.asyncBtnState, asyncBtnState) ||
                other.asyncBtnState == asyncBtnState));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, phoneNumberVerification, reason, asyncBtnState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneNumberVerificationErrorStateImplCopyWith<
          _$PhoneNumberVerificationErrorStateImpl>
      get copyWith => __$$PhoneNumberVerificationErrorStateImplCopyWithImpl<
          _$PhoneNumberVerificationErrorStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        initial,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)
        success,
    required TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)
        error,
    required TResult Function() loading,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        processing,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        valid,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)
        invalid,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)
        validatePhoneNumber,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)
        phoneNumberChanged,
  }) {
    return error(phoneNumberVerification, reason, asyncBtnState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult? Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult? Function()? loading,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
  }) {
    return error?.call(phoneNumberVerification, reason, asyncBtnState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult Function()? loading,
    TResult Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(phoneNumberVerification, reason, asyncBtnState);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PhoneNumberVerificationInitialState value)
        initial,
    required TResult Function(PhoneNumberVerificationSuccessState value)
        success,
    required TResult Function(PhoneNumberVerificationErrorState value) error,
    required TResult Function(PhoneNumberVerificationLoadingState value)
        loading,
    required TResult Function(PhoneNumberVerificationProcessingState value)
        processing,
    required TResult Function(PhoneNumberVerificationValidState value) valid,
    required TResult Function(PhoneNumberVerificationInvalidState value)
        invalid,
    required TResult Function(PhoneNumberVerificationValidatePhoneNumber value)
        validatePhoneNumber,
    required TResult Function(PhoneNumberVerificationPhoneNumberChanged value)
        phoneNumberChanged,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerificationInitialState value)? initial,
    TResult? Function(PhoneNumberVerificationSuccessState value)? success,
    TResult? Function(PhoneNumberVerificationErrorState value)? error,
    TResult? Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult? Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult? Function(PhoneNumberVerificationValidState value)? valid,
    TResult? Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult? Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult? Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PhoneNumberVerificationInitialState value)? initial,
    TResult Function(PhoneNumberVerificationSuccessState value)? success,
    TResult Function(PhoneNumberVerificationErrorState value)? error,
    TResult Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult Function(PhoneNumberVerificationValidState value)? valid,
    TResult Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PhoneNumberVerificationErrorState
    implements PhoneNumberVerificationState {
  const factory PhoneNumberVerificationErrorState(
          {final PhoneNumberVerification phoneNumberVerification,
          required final String reason,
          final AsyncBtnState asyncBtnState}) =
      _$PhoneNumberVerificationErrorStateImpl;

  PhoneNumberVerification get phoneNumberVerification;
  String get reason;
  AsyncBtnState get asyncBtnState;
  @JsonKey(ignore: true)
  _$$PhoneNumberVerificationErrorStateImplCopyWith<
          _$PhoneNumberVerificationErrorStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PhoneNumberVerificationLoadingStateImplCopyWith<$Res> {
  factory _$$PhoneNumberVerificationLoadingStateImplCopyWith(
          _$PhoneNumberVerificationLoadingStateImpl value,
          $Res Function(_$PhoneNumberVerificationLoadingStateImpl) then) =
      __$$PhoneNumberVerificationLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PhoneNumberVerificationLoadingStateImplCopyWithImpl<$Res>
    extends _$PhoneNumberVerificationStateCopyWithImpl<$Res,
        _$PhoneNumberVerificationLoadingStateImpl>
    implements _$$PhoneNumberVerificationLoadingStateImplCopyWith<$Res> {
  __$$PhoneNumberVerificationLoadingStateImplCopyWithImpl(
      _$PhoneNumberVerificationLoadingStateImpl _value,
      $Res Function(_$PhoneNumberVerificationLoadingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PhoneNumberVerificationLoadingStateImpl
    implements PhoneNumberVerificationLoadingState {
  const _$PhoneNumberVerificationLoadingStateImpl();

  @override
  String toString() {
    return 'PhoneNumberVerificationState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneNumberVerificationLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        initial,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)
        success,
    required TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)
        error,
    required TResult Function() loading,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        processing,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        valid,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)
        invalid,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)
        validatePhoneNumber,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)
        phoneNumberChanged,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult? Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult? Function()? loading,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult Function()? loading,
    TResult Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PhoneNumberVerificationInitialState value)
        initial,
    required TResult Function(PhoneNumberVerificationSuccessState value)
        success,
    required TResult Function(PhoneNumberVerificationErrorState value) error,
    required TResult Function(PhoneNumberVerificationLoadingState value)
        loading,
    required TResult Function(PhoneNumberVerificationProcessingState value)
        processing,
    required TResult Function(PhoneNumberVerificationValidState value) valid,
    required TResult Function(PhoneNumberVerificationInvalidState value)
        invalid,
    required TResult Function(PhoneNumberVerificationValidatePhoneNumber value)
        validatePhoneNumber,
    required TResult Function(PhoneNumberVerificationPhoneNumberChanged value)
        phoneNumberChanged,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerificationInitialState value)? initial,
    TResult? Function(PhoneNumberVerificationSuccessState value)? success,
    TResult? Function(PhoneNumberVerificationErrorState value)? error,
    TResult? Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult? Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult? Function(PhoneNumberVerificationValidState value)? valid,
    TResult? Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult? Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult? Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PhoneNumberVerificationInitialState value)? initial,
    TResult Function(PhoneNumberVerificationSuccessState value)? success,
    TResult Function(PhoneNumberVerificationErrorState value)? error,
    TResult Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult Function(PhoneNumberVerificationValidState value)? valid,
    TResult Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class PhoneNumberVerificationLoadingState
    implements PhoneNumberVerificationState {
  const factory PhoneNumberVerificationLoadingState() =
      _$PhoneNumberVerificationLoadingStateImpl;
}

/// @nodoc
abstract class _$$PhoneNumberVerificationProcessingStateImplCopyWith<$Res> {
  factory _$$PhoneNumberVerificationProcessingStateImplCopyWith(
          _$PhoneNumberVerificationProcessingStateImpl value,
          $Res Function(_$PhoneNumberVerificationProcessingStateImpl) then) =
      __$$PhoneNumberVerificationProcessingStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PhoneNumberVerification phoneNumberVerification});
}

/// @nodoc
class __$$PhoneNumberVerificationProcessingStateImplCopyWithImpl<$Res>
    extends _$PhoneNumberVerificationStateCopyWithImpl<$Res,
        _$PhoneNumberVerificationProcessingStateImpl>
    implements _$$PhoneNumberVerificationProcessingStateImplCopyWith<$Res> {
  __$$PhoneNumberVerificationProcessingStateImplCopyWithImpl(
      _$PhoneNumberVerificationProcessingStateImpl _value,
      $Res Function(_$PhoneNumberVerificationProcessingStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumberVerification = null,
  }) {
    return _then(_$PhoneNumberVerificationProcessingStateImpl(
      phoneNumberVerification: null == phoneNumberVerification
          ? _value.phoneNumberVerification
          : phoneNumberVerification // ignore: cast_nullable_to_non_nullable
              as PhoneNumberVerification,
    ));
  }
}

/// @nodoc

class _$PhoneNumberVerificationProcessingStateImpl
    implements PhoneNumberVerificationProcessingState {
  const _$PhoneNumberVerificationProcessingStateImpl(
      {this.phoneNumberVerification = PhoneNumberVerification.processing});

  @override
  @JsonKey()
  final PhoneNumberVerification phoneNumberVerification;

  @override
  String toString() {
    return 'PhoneNumberVerificationState.processing(phoneNumberVerification: $phoneNumberVerification)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneNumberVerificationProcessingStateImpl &&
            (identical(
                    other.phoneNumberVerification, phoneNumberVerification) ||
                other.phoneNumberVerification == phoneNumberVerification));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNumberVerification);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneNumberVerificationProcessingStateImplCopyWith<
          _$PhoneNumberVerificationProcessingStateImpl>
      get copyWith =>
          __$$PhoneNumberVerificationProcessingStateImplCopyWithImpl<
              _$PhoneNumberVerificationProcessingStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        initial,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)
        success,
    required TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)
        error,
    required TResult Function() loading,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        processing,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        valid,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)
        invalid,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)
        validatePhoneNumber,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)
        phoneNumberChanged,
  }) {
    return processing(phoneNumberVerification);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult? Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult? Function()? loading,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
  }) {
    return processing?.call(phoneNumberVerification);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult Function()? loading,
    TResult Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing(phoneNumberVerification);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PhoneNumberVerificationInitialState value)
        initial,
    required TResult Function(PhoneNumberVerificationSuccessState value)
        success,
    required TResult Function(PhoneNumberVerificationErrorState value) error,
    required TResult Function(PhoneNumberVerificationLoadingState value)
        loading,
    required TResult Function(PhoneNumberVerificationProcessingState value)
        processing,
    required TResult Function(PhoneNumberVerificationValidState value) valid,
    required TResult Function(PhoneNumberVerificationInvalidState value)
        invalid,
    required TResult Function(PhoneNumberVerificationValidatePhoneNumber value)
        validatePhoneNumber,
    required TResult Function(PhoneNumberVerificationPhoneNumberChanged value)
        phoneNumberChanged,
  }) {
    return processing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerificationInitialState value)? initial,
    TResult? Function(PhoneNumberVerificationSuccessState value)? success,
    TResult? Function(PhoneNumberVerificationErrorState value)? error,
    TResult? Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult? Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult? Function(PhoneNumberVerificationValidState value)? valid,
    TResult? Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult? Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult? Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
  }) {
    return processing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PhoneNumberVerificationInitialState value)? initial,
    TResult Function(PhoneNumberVerificationSuccessState value)? success,
    TResult Function(PhoneNumberVerificationErrorState value)? error,
    TResult Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult Function(PhoneNumberVerificationValidState value)? valid,
    TResult Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing(this);
    }
    return orElse();
  }
}

abstract class PhoneNumberVerificationProcessingState
    implements PhoneNumberVerificationState {
  const factory PhoneNumberVerificationProcessingState(
          {final PhoneNumberVerification phoneNumberVerification}) =
      _$PhoneNumberVerificationProcessingStateImpl;

  PhoneNumberVerification get phoneNumberVerification;
  @JsonKey(ignore: true)
  _$$PhoneNumberVerificationProcessingStateImplCopyWith<
          _$PhoneNumberVerificationProcessingStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PhoneNumberVerificationValidStateImplCopyWith<$Res> {
  factory _$$PhoneNumberVerificationValidStateImplCopyWith(
          _$PhoneNumberVerificationValidStateImpl value,
          $Res Function(_$PhoneNumberVerificationValidStateImpl) then) =
      __$$PhoneNumberVerificationValidStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PhoneNumberVerification phoneNumberVerification});
}

/// @nodoc
class __$$PhoneNumberVerificationValidStateImplCopyWithImpl<$Res>
    extends _$PhoneNumberVerificationStateCopyWithImpl<$Res,
        _$PhoneNumberVerificationValidStateImpl>
    implements _$$PhoneNumberVerificationValidStateImplCopyWith<$Res> {
  __$$PhoneNumberVerificationValidStateImplCopyWithImpl(
      _$PhoneNumberVerificationValidStateImpl _value,
      $Res Function(_$PhoneNumberVerificationValidStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumberVerification = null,
  }) {
    return _then(_$PhoneNumberVerificationValidStateImpl(
      phoneNumberVerification: null == phoneNumberVerification
          ? _value.phoneNumberVerification
          : phoneNumberVerification // ignore: cast_nullable_to_non_nullable
              as PhoneNumberVerification,
    ));
  }
}

/// @nodoc

class _$PhoneNumberVerificationValidStateImpl
    implements PhoneNumberVerificationValidState {
  const _$PhoneNumberVerificationValidStateImpl(
      {this.phoneNumberVerification = PhoneNumberVerification.valid});

  @override
  @JsonKey()
  final PhoneNumberVerification phoneNumberVerification;

  @override
  String toString() {
    return 'PhoneNumberVerificationState.valid(phoneNumberVerification: $phoneNumberVerification)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneNumberVerificationValidStateImpl &&
            (identical(
                    other.phoneNumberVerification, phoneNumberVerification) ||
                other.phoneNumberVerification == phoneNumberVerification));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNumberVerification);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneNumberVerificationValidStateImplCopyWith<
          _$PhoneNumberVerificationValidStateImpl>
      get copyWith => __$$PhoneNumberVerificationValidStateImplCopyWithImpl<
          _$PhoneNumberVerificationValidStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        initial,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)
        success,
    required TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)
        error,
    required TResult Function() loading,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        processing,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        valid,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)
        invalid,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)
        validatePhoneNumber,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)
        phoneNumberChanged,
  }) {
    return valid(phoneNumberVerification);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult? Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult? Function()? loading,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
  }) {
    return valid?.call(phoneNumberVerification);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult Function()? loading,
    TResult Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    required TResult orElse(),
  }) {
    if (valid != null) {
      return valid(phoneNumberVerification);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PhoneNumberVerificationInitialState value)
        initial,
    required TResult Function(PhoneNumberVerificationSuccessState value)
        success,
    required TResult Function(PhoneNumberVerificationErrorState value) error,
    required TResult Function(PhoneNumberVerificationLoadingState value)
        loading,
    required TResult Function(PhoneNumberVerificationProcessingState value)
        processing,
    required TResult Function(PhoneNumberVerificationValidState value) valid,
    required TResult Function(PhoneNumberVerificationInvalidState value)
        invalid,
    required TResult Function(PhoneNumberVerificationValidatePhoneNumber value)
        validatePhoneNumber,
    required TResult Function(PhoneNumberVerificationPhoneNumberChanged value)
        phoneNumberChanged,
  }) {
    return valid(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerificationInitialState value)? initial,
    TResult? Function(PhoneNumberVerificationSuccessState value)? success,
    TResult? Function(PhoneNumberVerificationErrorState value)? error,
    TResult? Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult? Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult? Function(PhoneNumberVerificationValidState value)? valid,
    TResult? Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult? Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult? Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
  }) {
    return valid?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PhoneNumberVerificationInitialState value)? initial,
    TResult Function(PhoneNumberVerificationSuccessState value)? success,
    TResult Function(PhoneNumberVerificationErrorState value)? error,
    TResult Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult Function(PhoneNumberVerificationValidState value)? valid,
    TResult Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
    required TResult orElse(),
  }) {
    if (valid != null) {
      return valid(this);
    }
    return orElse();
  }
}

abstract class PhoneNumberVerificationValidState
    implements PhoneNumberVerificationState {
  const factory PhoneNumberVerificationValidState(
          {final PhoneNumberVerification phoneNumberVerification}) =
      _$PhoneNumberVerificationValidStateImpl;

  PhoneNumberVerification get phoneNumberVerification;
  @JsonKey(ignore: true)
  _$$PhoneNumberVerificationValidStateImplCopyWith<
          _$PhoneNumberVerificationValidStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PhoneNumberVerificationInvalidStateImplCopyWith<$Res> {
  factory _$$PhoneNumberVerificationInvalidStateImplCopyWith(
          _$PhoneNumberVerificationInvalidStateImpl value,
          $Res Function(_$PhoneNumberVerificationInvalidStateImpl) then) =
      __$$PhoneNumberVerificationInvalidStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PhoneNumberVerification phoneNumberVerification, String reason});
}

/// @nodoc
class __$$PhoneNumberVerificationInvalidStateImplCopyWithImpl<$Res>
    extends _$PhoneNumberVerificationStateCopyWithImpl<$Res,
        _$PhoneNumberVerificationInvalidStateImpl>
    implements _$$PhoneNumberVerificationInvalidStateImplCopyWith<$Res> {
  __$$PhoneNumberVerificationInvalidStateImplCopyWithImpl(
      _$PhoneNumberVerificationInvalidStateImpl _value,
      $Res Function(_$PhoneNumberVerificationInvalidStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumberVerification = null,
    Object? reason = null,
  }) {
    return _then(_$PhoneNumberVerificationInvalidStateImpl(
      phoneNumberVerification: null == phoneNumberVerification
          ? _value.phoneNumberVerification
          : phoneNumberVerification // ignore: cast_nullable_to_non_nullable
              as PhoneNumberVerification,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PhoneNumberVerificationInvalidStateImpl
    implements PhoneNumberVerificationInvalidState {
  const _$PhoneNumberVerificationInvalidStateImpl(
      {this.phoneNumberVerification = PhoneNumberVerification.invalid,
      required this.reason});

  @override
  @JsonKey()
  final PhoneNumberVerification phoneNumberVerification;
  @override
  final String reason;

  @override
  String toString() {
    return 'PhoneNumberVerificationState.invalid(phoneNumberVerification: $phoneNumberVerification, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneNumberVerificationInvalidStateImpl &&
            (identical(
                    other.phoneNumberVerification, phoneNumberVerification) ||
                other.phoneNumberVerification == phoneNumberVerification) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNumberVerification, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneNumberVerificationInvalidStateImplCopyWith<
          _$PhoneNumberVerificationInvalidStateImpl>
      get copyWith => __$$PhoneNumberVerificationInvalidStateImplCopyWithImpl<
          _$PhoneNumberVerificationInvalidStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        initial,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)
        success,
    required TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)
        error,
    required TResult Function() loading,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        processing,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        valid,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)
        invalid,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)
        validatePhoneNumber,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)
        phoneNumberChanged,
  }) {
    return invalid(phoneNumberVerification, reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult? Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult? Function()? loading,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
  }) {
    return invalid?.call(phoneNumberVerification, reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult Function()? loading,
    TResult Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    required TResult orElse(),
  }) {
    if (invalid != null) {
      return invalid(phoneNumberVerification, reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PhoneNumberVerificationInitialState value)
        initial,
    required TResult Function(PhoneNumberVerificationSuccessState value)
        success,
    required TResult Function(PhoneNumberVerificationErrorState value) error,
    required TResult Function(PhoneNumberVerificationLoadingState value)
        loading,
    required TResult Function(PhoneNumberVerificationProcessingState value)
        processing,
    required TResult Function(PhoneNumberVerificationValidState value) valid,
    required TResult Function(PhoneNumberVerificationInvalidState value)
        invalid,
    required TResult Function(PhoneNumberVerificationValidatePhoneNumber value)
        validatePhoneNumber,
    required TResult Function(PhoneNumberVerificationPhoneNumberChanged value)
        phoneNumberChanged,
  }) {
    return invalid(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerificationInitialState value)? initial,
    TResult? Function(PhoneNumberVerificationSuccessState value)? success,
    TResult? Function(PhoneNumberVerificationErrorState value)? error,
    TResult? Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult? Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult? Function(PhoneNumberVerificationValidState value)? valid,
    TResult? Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult? Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult? Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
  }) {
    return invalid?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PhoneNumberVerificationInitialState value)? initial,
    TResult Function(PhoneNumberVerificationSuccessState value)? success,
    TResult Function(PhoneNumberVerificationErrorState value)? error,
    TResult Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult Function(PhoneNumberVerificationValidState value)? valid,
    TResult Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
    required TResult orElse(),
  }) {
    if (invalid != null) {
      return invalid(this);
    }
    return orElse();
  }
}

abstract class PhoneNumberVerificationInvalidState
    implements PhoneNumberVerificationState {
  const factory PhoneNumberVerificationInvalidState(
          {final PhoneNumberVerification phoneNumberVerification,
          required final String reason}) =
      _$PhoneNumberVerificationInvalidStateImpl;

  PhoneNumberVerification get phoneNumberVerification;
  String get reason;
  @JsonKey(ignore: true)
  _$$PhoneNumberVerificationInvalidStateImplCopyWith<
          _$PhoneNumberVerificationInvalidStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PhoneNumberVerificationValidatePhoneNumberImplCopyWith<$Res> {
  factory _$$PhoneNumberVerificationValidatePhoneNumberImplCopyWith(
          _$PhoneNumberVerificationValidatePhoneNumberImpl value,
          $Res Function(_$PhoneNumberVerificationValidatePhoneNumberImpl)
              then) =
      __$$PhoneNumberVerificationValidatePhoneNumberImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String phoneNumber,
      String countryDialCode,
      String country,
      PhoneNumberInputValidator? phoneNumberInputValidator,
      String? phoneValidation,
      PhoneNumber? enteredPhoneNumber,
      PhoneNumberVerification phoneNumberVerification,
      PhoneController phoneController,
      String isoCode});
}

/// @nodoc
class __$$PhoneNumberVerificationValidatePhoneNumberImplCopyWithImpl<$Res>
    extends _$PhoneNumberVerificationStateCopyWithImpl<$Res,
        _$PhoneNumberVerificationValidatePhoneNumberImpl>
    implements _$$PhoneNumberVerificationValidatePhoneNumberImplCopyWith<$Res> {
  __$$PhoneNumberVerificationValidatePhoneNumberImplCopyWithImpl(
      _$PhoneNumberVerificationValidatePhoneNumberImpl _value,
      $Res Function(_$PhoneNumberVerificationValidatePhoneNumberImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? countryDialCode = null,
    Object? country = null,
    Object? phoneNumberInputValidator = freezed,
    Object? phoneValidation = freezed,
    Object? enteredPhoneNumber = freezed,
    Object? phoneNumberVerification = null,
    Object? phoneController = null,
    Object? isoCode = null,
  }) {
    return _then(_$PhoneNumberVerificationValidatePhoneNumberImpl(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      countryDialCode: null == countryDialCode
          ? _value.countryDialCode
          : countryDialCode // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumberInputValidator: freezed == phoneNumberInputValidator
          ? _value.phoneNumberInputValidator
          : phoneNumberInputValidator // ignore: cast_nullable_to_non_nullable
              as PhoneNumberInputValidator?,
      phoneValidation: freezed == phoneValidation
          ? _value.phoneValidation
          : phoneValidation // ignore: cast_nullable_to_non_nullable
              as String?,
      enteredPhoneNumber: freezed == enteredPhoneNumber
          ? _value.enteredPhoneNumber
          : enteredPhoneNumber // ignore: cast_nullable_to_non_nullable
              as PhoneNumber?,
      phoneNumberVerification: null == phoneNumberVerification
          ? _value.phoneNumberVerification
          : phoneNumberVerification // ignore: cast_nullable_to_non_nullable
              as PhoneNumberVerification,
      phoneController: null == phoneController
          ? _value.phoneController
          : phoneController // ignore: cast_nullable_to_non_nullable
              as PhoneController,
      isoCode: null == isoCode
          ? _value.isoCode
          : isoCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PhoneNumberVerificationValidatePhoneNumberImpl
    implements PhoneNumberVerificationValidatePhoneNumber {
  const _$PhoneNumberVerificationValidatePhoneNumberImpl(
      {required this.phoneNumber,
      this.countryDialCode = '+966',
      required this.country,
      this.phoneNumberInputValidator,
      this.phoneValidation,
      this.enteredPhoneNumber,
      this.phoneNumberVerification = PhoneNumberVerification.none,
      required this.phoneController,
      this.isoCode = 'SA'});

  @override
  final String phoneNumber;
  @override
  @JsonKey()
  final String countryDialCode;
  @override
  final String country;
  @override
  final PhoneNumberInputValidator? phoneNumberInputValidator;
  @override
  final String? phoneValidation;
  @override
  final PhoneNumber? enteredPhoneNumber;
  @override
  @JsonKey()
  final PhoneNumberVerification phoneNumberVerification;
  @override
  final PhoneController phoneController;
  @override
  @JsonKey()
  final String isoCode;

  @override
  String toString() {
    return 'PhoneNumberVerificationState.validatePhoneNumber(phoneNumber: $phoneNumber, countryDialCode: $countryDialCode, country: $country, phoneNumberInputValidator: $phoneNumberInputValidator, phoneValidation: $phoneValidation, enteredPhoneNumber: $enteredPhoneNumber, phoneNumberVerification: $phoneNumberVerification, phoneController: $phoneController, isoCode: $isoCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneNumberVerificationValidatePhoneNumberImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.countryDialCode, countryDialCode) ||
                other.countryDialCode == countryDialCode) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.phoneNumberInputValidator,
                    phoneNumberInputValidator) ||
                other.phoneNumberInputValidator == phoneNumberInputValidator) &&
            (identical(other.phoneValidation, phoneValidation) ||
                other.phoneValidation == phoneValidation) &&
            (identical(other.enteredPhoneNumber, enteredPhoneNumber) ||
                other.enteredPhoneNumber == enteredPhoneNumber) &&
            (identical(
                    other.phoneNumberVerification, phoneNumberVerification) ||
                other.phoneNumberVerification == phoneNumberVerification) &&
            (identical(other.phoneController, phoneController) ||
                other.phoneController == phoneController) &&
            (identical(other.isoCode, isoCode) || other.isoCode == isoCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      phoneNumber,
      countryDialCode,
      country,
      phoneNumberInputValidator,
      phoneValidation,
      enteredPhoneNumber,
      phoneNumberVerification,
      phoneController,
      isoCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneNumberVerificationValidatePhoneNumberImplCopyWith<
          _$PhoneNumberVerificationValidatePhoneNumberImpl>
      get copyWith =>
          __$$PhoneNumberVerificationValidatePhoneNumberImplCopyWithImpl<
                  _$PhoneNumberVerificationValidatePhoneNumberImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        initial,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)
        success,
    required TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)
        error,
    required TResult Function() loading,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        processing,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        valid,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)
        invalid,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)
        validatePhoneNumber,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)
        phoneNumberChanged,
  }) {
    return validatePhoneNumber(
        phoneNumber,
        countryDialCode,
        country,
        phoneNumberInputValidator,
        phoneValidation,
        enteredPhoneNumber,
        phoneNumberVerification,
        phoneController,
        isoCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult? Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult? Function()? loading,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
  }) {
    return validatePhoneNumber?.call(
        phoneNumber,
        countryDialCode,
        country,
        phoneNumberInputValidator,
        phoneValidation,
        enteredPhoneNumber,
        phoneNumberVerification,
        phoneController,
        isoCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult Function()? loading,
    TResult Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    required TResult orElse(),
  }) {
    if (validatePhoneNumber != null) {
      return validatePhoneNumber(
          phoneNumber,
          countryDialCode,
          country,
          phoneNumberInputValidator,
          phoneValidation,
          enteredPhoneNumber,
          phoneNumberVerification,
          phoneController,
          isoCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PhoneNumberVerificationInitialState value)
        initial,
    required TResult Function(PhoneNumberVerificationSuccessState value)
        success,
    required TResult Function(PhoneNumberVerificationErrorState value) error,
    required TResult Function(PhoneNumberVerificationLoadingState value)
        loading,
    required TResult Function(PhoneNumberVerificationProcessingState value)
        processing,
    required TResult Function(PhoneNumberVerificationValidState value) valid,
    required TResult Function(PhoneNumberVerificationInvalidState value)
        invalid,
    required TResult Function(PhoneNumberVerificationValidatePhoneNumber value)
        validatePhoneNumber,
    required TResult Function(PhoneNumberVerificationPhoneNumberChanged value)
        phoneNumberChanged,
  }) {
    return validatePhoneNumber(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerificationInitialState value)? initial,
    TResult? Function(PhoneNumberVerificationSuccessState value)? success,
    TResult? Function(PhoneNumberVerificationErrorState value)? error,
    TResult? Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult? Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult? Function(PhoneNumberVerificationValidState value)? valid,
    TResult? Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult? Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult? Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
  }) {
    return validatePhoneNumber?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PhoneNumberVerificationInitialState value)? initial,
    TResult Function(PhoneNumberVerificationSuccessState value)? success,
    TResult Function(PhoneNumberVerificationErrorState value)? error,
    TResult Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult Function(PhoneNumberVerificationValidState value)? valid,
    TResult Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
    required TResult orElse(),
  }) {
    if (validatePhoneNumber != null) {
      return validatePhoneNumber(this);
    }
    return orElse();
  }
}

abstract class PhoneNumberVerificationValidatePhoneNumber
    implements PhoneNumberVerificationState {
  const factory PhoneNumberVerificationValidatePhoneNumber(
      {required final String phoneNumber,
      final String countryDialCode,
      required final String country,
      final PhoneNumberInputValidator? phoneNumberInputValidator,
      final String? phoneValidation,
      final PhoneNumber? enteredPhoneNumber,
      final PhoneNumberVerification phoneNumberVerification,
      required final PhoneController phoneController,
      final String isoCode}) = _$PhoneNumberVerificationValidatePhoneNumberImpl;

  String get phoneNumber;
  String get countryDialCode;
  String get country;
  PhoneNumberInputValidator? get phoneNumberInputValidator;
  String? get phoneValidation;
  PhoneNumber? get enteredPhoneNumber;
  PhoneNumberVerification get phoneNumberVerification;
  PhoneController get phoneController;
  String get isoCode;
  @JsonKey(ignore: true)
  _$$PhoneNumberVerificationValidatePhoneNumberImplCopyWith<
          _$PhoneNumberVerificationValidatePhoneNumberImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PhoneNumberVerificationPhoneNumberChangedImplCopyWith<$Res> {
  factory _$$PhoneNumberVerificationPhoneNumberChangedImplCopyWith(
          _$PhoneNumberVerificationPhoneNumberChangedImpl value,
          $Res Function(_$PhoneNumberVerificationPhoneNumberChangedImpl) then) =
      __$$PhoneNumberVerificationPhoneNumberChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String phoneNumber,
      String countryDialCode,
      String country,
      PhoneNumberInputValidator? phoneNumberInputValidator,
      String? phoneValidation,
      PhoneNumber? enteredPhoneNumber,
      PhoneController phoneController,
      String isoCode});
}

/// @nodoc
class __$$PhoneNumberVerificationPhoneNumberChangedImplCopyWithImpl<$Res>
    extends _$PhoneNumberVerificationStateCopyWithImpl<$Res,
        _$PhoneNumberVerificationPhoneNumberChangedImpl>
    implements _$$PhoneNumberVerificationPhoneNumberChangedImplCopyWith<$Res> {
  __$$PhoneNumberVerificationPhoneNumberChangedImplCopyWithImpl(
      _$PhoneNumberVerificationPhoneNumberChangedImpl _value,
      $Res Function(_$PhoneNumberVerificationPhoneNumberChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? countryDialCode = null,
    Object? country = null,
    Object? phoneNumberInputValidator = freezed,
    Object? phoneValidation = freezed,
    Object? enteredPhoneNumber = freezed,
    Object? phoneController = null,
    Object? isoCode = null,
  }) {
    return _then(_$PhoneNumberVerificationPhoneNumberChangedImpl(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      countryDialCode: null == countryDialCode
          ? _value.countryDialCode
          : countryDialCode // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumberInputValidator: freezed == phoneNumberInputValidator
          ? _value.phoneNumberInputValidator
          : phoneNumberInputValidator // ignore: cast_nullable_to_non_nullable
              as PhoneNumberInputValidator?,
      phoneValidation: freezed == phoneValidation
          ? _value.phoneValidation
          : phoneValidation // ignore: cast_nullable_to_non_nullable
              as String?,
      enteredPhoneNumber: freezed == enteredPhoneNumber
          ? _value.enteredPhoneNumber
          : enteredPhoneNumber // ignore: cast_nullable_to_non_nullable
              as PhoneNumber?,
      phoneController: null == phoneController
          ? _value.phoneController
          : phoneController // ignore: cast_nullable_to_non_nullable
              as PhoneController,
      isoCode: null == isoCode
          ? _value.isoCode
          : isoCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PhoneNumberVerificationPhoneNumberChangedImpl
    implements PhoneNumberVerificationPhoneNumberChanged {
  const _$PhoneNumberVerificationPhoneNumberChangedImpl(
      {required this.phoneNumber,
      this.countryDialCode = '+966',
      required this.country,
      this.phoneNumberInputValidator,
      this.phoneValidation,
      this.enteredPhoneNumber,
      required this.phoneController,
      this.isoCode = 'SA'});

  @override
  final String phoneNumber;
  @override
  @JsonKey()
  final String countryDialCode;
  @override
  final String country;
  @override
  final PhoneNumberInputValidator? phoneNumberInputValidator;
  @override
  final String? phoneValidation;
  @override
  final PhoneNumber? enteredPhoneNumber;
  @override
  final PhoneController phoneController;
  @override
  @JsonKey()
  final String isoCode;

  @override
  String toString() {
    return 'PhoneNumberVerificationState.phoneNumberChanged(phoneNumber: $phoneNumber, countryDialCode: $countryDialCode, country: $country, phoneNumberInputValidator: $phoneNumberInputValidator, phoneValidation: $phoneValidation, enteredPhoneNumber: $enteredPhoneNumber, phoneController: $phoneController, isoCode: $isoCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneNumberVerificationPhoneNumberChangedImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.countryDialCode, countryDialCode) ||
                other.countryDialCode == countryDialCode) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.phoneNumberInputValidator,
                    phoneNumberInputValidator) ||
                other.phoneNumberInputValidator == phoneNumberInputValidator) &&
            (identical(other.phoneValidation, phoneValidation) ||
                other.phoneValidation == phoneValidation) &&
            (identical(other.enteredPhoneNumber, enteredPhoneNumber) ||
                other.enteredPhoneNumber == enteredPhoneNumber) &&
            (identical(other.phoneController, phoneController) ||
                other.phoneController == phoneController) &&
            (identical(other.isoCode, isoCode) || other.isoCode == isoCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      phoneNumber,
      countryDialCode,
      country,
      phoneNumberInputValidator,
      phoneValidation,
      enteredPhoneNumber,
      phoneController,
      isoCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneNumberVerificationPhoneNumberChangedImplCopyWith<
          _$PhoneNumberVerificationPhoneNumberChangedImpl>
      get copyWith =>
          __$$PhoneNumberVerificationPhoneNumberChangedImplCopyWithImpl<
                  _$PhoneNumberVerificationPhoneNumberChangedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        initial,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)
        success,
    required TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)
        error,
    required TResult Function() loading,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        processing,
    required TResult Function(PhoneNumberVerification phoneNumberVerification)
        valid,
    required TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)
        invalid,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)
        validatePhoneNumber,
    required TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)
        phoneNumberChanged,
  }) {
    return phoneNumberChanged(
        phoneNumber,
        countryDialCode,
        country,
        phoneNumberInputValidator,
        phoneValidation,
        enteredPhoneNumber,
        phoneController,
        isoCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult? Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult? Function()? loading,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult? Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult? Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult? Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
  }) {
    return phoneNumberChanged?.call(
        phoneNumber,
        countryDialCode,
        country,
        phoneNumberInputValidator,
        phoneValidation,
        enteredPhoneNumber,
        phoneController,
        isoCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PhoneNumberVerification phoneNumberVerification)? initial,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification,
            String userEnteredPhoneNumber,
            String countryDialCode,
            AsyncBtnState asyncBtnState,
            String phoneNumberWithFormat)?
        success,
    TResult Function(PhoneNumberVerification phoneNumberVerification,
            String reason, AsyncBtnState asyncBtnState)?
        error,
    TResult Function()? loading,
    TResult Function(PhoneNumberVerification phoneNumberVerification)?
        processing,
    TResult Function(PhoneNumberVerification phoneNumberVerification)? valid,
    TResult Function(
            PhoneNumberVerification phoneNumberVerification, String reason)?
        invalid,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneNumberVerification phoneNumberVerification,
            PhoneController phoneController,
            String isoCode)?
        validatePhoneNumber,
    TResult Function(
            String phoneNumber,
            String countryDialCode,
            String country,
            PhoneNumberInputValidator? phoneNumberInputValidator,
            String? phoneValidation,
            PhoneNumber? enteredPhoneNumber,
            PhoneController phoneController,
            String isoCode)?
        phoneNumberChanged,
    required TResult orElse(),
  }) {
    if (phoneNumberChanged != null) {
      return phoneNumberChanged(
          phoneNumber,
          countryDialCode,
          country,
          phoneNumberInputValidator,
          phoneValidation,
          enteredPhoneNumber,
          phoneController,
          isoCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PhoneNumberVerificationInitialState value)
        initial,
    required TResult Function(PhoneNumberVerificationSuccessState value)
        success,
    required TResult Function(PhoneNumberVerificationErrorState value) error,
    required TResult Function(PhoneNumberVerificationLoadingState value)
        loading,
    required TResult Function(PhoneNumberVerificationProcessingState value)
        processing,
    required TResult Function(PhoneNumberVerificationValidState value) valid,
    required TResult Function(PhoneNumberVerificationInvalidState value)
        invalid,
    required TResult Function(PhoneNumberVerificationValidatePhoneNumber value)
        validatePhoneNumber,
    required TResult Function(PhoneNumberVerificationPhoneNumberChanged value)
        phoneNumberChanged,
  }) {
    return phoneNumberChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberVerificationInitialState value)? initial,
    TResult? Function(PhoneNumberVerificationSuccessState value)? success,
    TResult? Function(PhoneNumberVerificationErrorState value)? error,
    TResult? Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult? Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult? Function(PhoneNumberVerificationValidState value)? valid,
    TResult? Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult? Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult? Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
  }) {
    return phoneNumberChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PhoneNumberVerificationInitialState value)? initial,
    TResult Function(PhoneNumberVerificationSuccessState value)? success,
    TResult Function(PhoneNumberVerificationErrorState value)? error,
    TResult Function(PhoneNumberVerificationLoadingState value)? loading,
    TResult Function(PhoneNumberVerificationProcessingState value)? processing,
    TResult Function(PhoneNumberVerificationValidState value)? valid,
    TResult Function(PhoneNumberVerificationInvalidState value)? invalid,
    TResult Function(PhoneNumberVerificationValidatePhoneNumber value)?
        validatePhoneNumber,
    TResult Function(PhoneNumberVerificationPhoneNumberChanged value)?
        phoneNumberChanged,
    required TResult orElse(),
  }) {
    if (phoneNumberChanged != null) {
      return phoneNumberChanged(this);
    }
    return orElse();
  }
}

abstract class PhoneNumberVerificationPhoneNumberChanged
    implements PhoneNumberVerificationState {
  const factory PhoneNumberVerificationPhoneNumberChanged(
      {required final String phoneNumber,
      final String countryDialCode,
      required final String country,
      final PhoneNumberInputValidator? phoneNumberInputValidator,
      final String? phoneValidation,
      final PhoneNumber? enteredPhoneNumber,
      required final PhoneController phoneController,
      final String isoCode}) = _$PhoneNumberVerificationPhoneNumberChangedImpl;

  String get phoneNumber;
  String get countryDialCode;
  String get country;
  PhoneNumberInputValidator? get phoneNumberInputValidator;
  String? get phoneValidation;
  PhoneNumber? get enteredPhoneNumber;
  PhoneController get phoneController;
  String get isoCode;
  @JsonKey(ignore: true)
  _$$PhoneNumberVerificationPhoneNumberChangedImplCopyWith<
          _$PhoneNumberVerificationPhoneNumberChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}
