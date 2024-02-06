part of 'package:homemakers_merchant/app/features/common/index.dart';

abstract class IChangePhoneNumber<T extends Object> {
  late final String phoneNumber;
  late final String dialCode;
  late final String countryCode;

  void init(String phoneNumber, String dialCode, String countryCode);

  Future<void> updatePhoneNumber(T bloc);
}

class UpdateProfilePhoneNumber
    implements IChangePhoneNumber<BusinessProfileBloc> {
  @override
  late String countryCode;

  @override
  late String dialCode;

  @override
  late String phoneNumber;

  @override
  void init(String phoneNumber, String dialCode, String countryCode) {
    this.phoneNumber = phoneNumber;
    this.dialCode = dialCode;
    this.countryCode = countryCode;
  }

  @override
  Future<void> updatePhoneNumber(BusinessProfileBloc bloc) {
    throw UnimplementedError();
  }
}

class UpdateStorePhoneNumber implements IChangePhoneNumber<StoreBloc> {
  final ChangePhoneNumberPurpose changePhoneNumberPurpose =
      ChangePhoneNumberPurpose.store;

  @override
  void init(String phoneNumber, String dialCode, String countryCode) {
    this.phoneNumber = phoneNumber;
    this.dialCode = dialCode;
    this.countryCode = countryCode;
  }

  @override
  Future<void> updatePhoneNumber(StoreBloc bloc) async {
    //bloc.add(event);
  }

  @override
  late String countryCode;

  @override
  late String dialCode;

  @override
  late String phoneNumber;
}

class UpdateDriverPhoneNumber implements IChangePhoneNumber<StoreBloc> {
  final ChangePhoneNumberPurpose changePhoneNumberPurpose =
      ChangePhoneNumberPurpose.store;

  @override
  void init(String phoneNumber, String dialCode, String countryCode) {
    this.phoneNumber = phoneNumber;
    this.dialCode = dialCode;
    this.countryCode = countryCode;
  }

  @override
  Future<void> updatePhoneNumber(StoreBloc bloc) async {
    throw UnimplementedError();
  }

  @override
  late String countryCode;

  @override
  late String dialCode;

  @override
  late String phoneNumber;
}
