part of 'package:homemakers_merchant/app/features/authentication/index.dart';

class VerifyFirebaseOtpUseCase extends UseCaseIO<VerifyOtpEntity,
    ResultState<VerifyOtpFirebaseResponseModel>> {
  VerifyFirebaseOtpUseCase({required this.firebaseAuthenticationRepository});

  final FirebaseAuthenticationRepository firebaseAuthenticationRepository;

  @override
  Future<ResultState<VerifyOtpFirebaseResponseModel>> call(
      VerifyOtpEntity input) async {
    var hasOtpCodeVerified = false;
    var message = '';
    Object? error;
    StackTrace? stacktrace;
    UserCredential? userCredentials;
    var otpAutoVerified = false;

    hasOtpCodeVerified = await firebaseAuthenticationRepository.verifyOtp(
      otpCode: input.otp.toString(),
      onLoginFailed: (firebaseException, stackTrace) {
        hasOtpCodeVerified = false;
        stacktrace = stackTrace;
        error = firebaseException;
        message = firebaseException.message?.toString() ?? '';
      },
      onError: (object, stackTrace) {
        hasOtpCodeVerified = false;
        stacktrace = stackTrace;
        error = object;
        message = object.toString();
      },
      onCodeSent: () {},
      otpVerificationId: input.verificationId,
      onLoginSuccess: (userCredential, autoVerified) {
        hasOtpCodeVerified = true;
        userCredentials = userCredential;
        otpAutoVerified = autoVerified;
      },
    );
    if (hasOtpCodeVerified) {
      final verifyOtpFirebaseResponseModel = VerifyOtpFirebaseResponseModel(
        hasOtpCodeVerified: hasOtpCodeVerified,
        firebaseUserData: firebaseAuthenticationRepository.currentUser,
        firebaseUserId: firebaseAuthenticationRepository.currentUser?.uid,
        otpAutoVerified: otpAutoVerified,
        userCredentials: userCredentials,
      );
      return ResultState<VerifyOtpFirebaseResponseModel>.success(
        data: verifyOtpFirebaseResponseModel,
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
