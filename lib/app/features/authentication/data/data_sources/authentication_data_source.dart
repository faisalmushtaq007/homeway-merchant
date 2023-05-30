part of 'authentication_remote_data_source.dart';

abstract class AuthenticationDataSource {
  Future<void> sendOTP(String mobileNumber, {String dialCode = '+61'});

  Future<void> verifyOTP(String mobileNumber, String verificationCode,
      {String dialCode = '+61'});

  Future<ApiResultState<UserModel>> getUserProfile({String userID = ''});
}
