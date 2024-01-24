part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class SendFirebaseOtpUseCase extends UseCaseIO<SendOtpEntity,
    ResultState<SendOtpFirebaseResponseModel>> {
  SendFirebaseOtpUseCase({required this.firebaseAuthenticationRepository});

  final FirebaseAuthenticationRepository firebaseAuthenticationRepository;

  @override
  Future<ResultState<SendOtpFirebaseResponseModel>> call(
      SendOtpEntity input) async {
    var hasOtpCodeSent = false;
    var message = '';
    Object? error;
    StackTrace? stacktrace;
    hasOtpCodeSent = await firebaseAuthenticationRepository.sendOtp(
      mobileNumber: input.phoneNumberWithoutFormat,
      dialCode: input.country_dial_code,
      countryCode: input.isoCode,
      onLoginFailed: (firebaseException, stackTrace) {
        hasOtpCodeSent = false;
        stacktrace = stackTrace;
        error = firebaseException;
        message = firebaseException.message?.toString()??'';
      },
      onError: (object, stackTrace) {
        hasOtpCodeSent = false;
        stacktrace = stackTrace;
        error = object;
        message = object.toString();
      },
      onCodeSent: () {
        hasOtpCodeSent = true;
      },
    );
    if (hasOtpCodeSent) {
      final sendOtpFirebaseResponseModel = SendOtpFirebaseResponseModel(
        hasOtpCodeSent: firebaseAuthenticationRepository.codeSent,
        verificationId: firebaseAuthenticationRepository.verificationID,
      );
      return ResultState<SendOtpFirebaseResponseModel>.success(
        data: sendOtpFirebaseResponseModel,
      );
    } else {
      return ResultState.error(
        reason: message,
        error: error,
        stackTrace: stacktrace,
      );
    }
  }
}
