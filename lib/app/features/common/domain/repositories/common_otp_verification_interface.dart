part of 'package:homemakers_merchant/app/features/common/index.dart';

abstract class ICommonOtpVerification<T extends Object> {
  late final String existingPhoneNumber;
  late final String newPhoneNumber;

  void init(String existingPhoneNumber, String newPhoneNumber);

  Future<void> verifyOtpPhoneNumber(T bloc);

  Future<void> resendOtpPhoneNumber(T bloc);
}

class OtpVerificationForProfilePhoneNumber
    implements ICommonOtpVerification<BusinessProfileBloc> {
  @override
  late String existingPhoneNumber;

  @override
  late String newPhoneNumber;

  @override
  void init(String existingPhoneNumber, String newPhoneNumber) {
    // TODO: implement init
  }

  @override
  Future<void> resendOtpPhoneNumber(BusinessProfileBloc bloc) {
    // TODO: implement resendOtpPhoneNumber
    throw UnimplementedError();
  }

  @override
  Future<void> verifyOtpPhoneNumber(BusinessProfileBloc bloc) {
    // TODO: implement verifyOtpPhoneNumber
    throw UnimplementedError();
  }
}

class OtpVerificationForStorePhoneNumber
    implements ICommonOtpVerification<StoreBloc> {
  @override
  late String existingPhoneNumber;

  @override
  late String newPhoneNumber;

  @override
  void init(String existingPhoneNumber, String newPhoneNumber) {
    // TODO: implement init
  }

  @override
  Future<void> resendOtpPhoneNumber(StoreBloc bloc) {
    // TODO: implement resendOtpPhoneNumber
    throw UnimplementedError();
  }

  @override
  Future<void> verifyOtpPhoneNumber(StoreBloc bloc) {
    // TODO: implement verifyOtpPhoneNumber
    throw UnimplementedError();
  }
}

class OtpVerificationForDriverPhoneNumber
    implements ICommonOtpVerification<StoreBloc> {
  @override
  late String existingPhoneNumber;

  @override
  late String newPhoneNumber;

  @override
  void init(String existingPhoneNumber, String newPhoneNumber) {
    // TODO: implement init
  }

  @override
  Future<void> resendOtpPhoneNumber(StoreBloc bloc) {
    // TODO: implement resendOtpPhoneNumber
    throw UnimplementedError();
  }

  @override
  Future<void> verifyOtpPhoneNumber(StoreBloc bloc) {
    // TODO: implement verifyOtpPhoneNumber
    throw UnimplementedError();
  }
}
