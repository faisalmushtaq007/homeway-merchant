import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:homeway_firebase/src/domain/type_definitions.dart';

part 'package:homeway_firebase/src/data/repository/authentication_repository_impl.dart';

abstract class FirebaseAuthenticationRepository {
  Future<User?> getFirebaseUser();

  Future<void> signOut();

  /// Send OTP to the given [_phoneNumber].
  ///
  /// Returns true if OTP was sent successfully.
  ///
  /// If for any reason, the OTP is not send,
  /// [_onLoginFailed] is called with [FirebaseAuthException]
  /// object to handle the error.
  ///
  /// [shouldAwaitCodeSend] can be used to await the OTP send.
  /// The firebase method completes early, and if [shouldAwaitCodeSend] is false,
  /// [sendOTP] will complete early, and the OTP will be sent in the background.
  /// Whereas, if [shouldAwaitCodeSend] is true, [sendOTP] will wait for the
  /// code send callback to be fired, and [sendOTP] will complete only after
  /// that callback is fired. Not applicable on web.
  Future<bool> sendOtp({
    required String mobileNumber,
    required String dialCode,
    required String countryCode,
    bool isResend = false,
    bool shouldAwaitCodeSend = true,
    VoidCallback? onCodeSent,
    OnLoginFailed? onLoginFailed,
    OnError? onError,
  });

  /// Verify the OTP sent to [_phoneNumber] and login user is OTP was correct.
  ///
  /// Returns true if the [otp] passed was correct and the user was logged in successfully.
  /// On login success, [_onLoginSuccess] is called.
  ///
  /// If the [otp] passed is incorrect, or the [otp] is expired or any other
  /// error occurs, the functions returns false.
  ///
  /// Also, [_onLoginFailed] is called with [FirebaseAuthException]
  /// object to handle the error.
  Future<bool> verifyOtp({
    required String otpCode,
    required String otpVerificationId,
    VoidCallback? onCodeSent,
    OnLoginFailed? onLoginFailed,
    OnError? onError,
    OnLoginSuccess? onLoginSuccess,
  });

  Stream<User?> get user;

  User? get currentUser;

  FirebaseAuth get firebaseAuth;

  void initialize({
    required OnLoginSuccess? onLoginSuccess,
    required OnLoginFailed? onLoginFailed,
    required OnError? onError,
    required VoidCallback? onCodeSent,
    required bool signOutOnSuccessfulVerification,
    required RecaptchaVerifier? recaptchaVerifierForWeb,
    required Duration autoRetrievalTimeOutDuration,
    required Duration otpExpirationDuration,
    required bool linkWithExistingUser,
  });

  ConfirmationResult? _webConfirmationResult;

  /// {@macro recaptchaVerifierForWeb}
  RecaptchaVerifier? _recaptchaVerifierForWeb;

  /// The [_forceResendingToken] obtained from [codeSent]
  /// callback to force re-sending another verification SMS before the
  /// auto-retrieval timeout.
  int? _forceResendingToken;

  /// Timer object for SMS auto-retrieval.
  Timer? _otpAutoRetrievalTimer;

  /// Timer object for OTP expiration.
  Timer? _otpExpirationTimer;

  /// Whether OTP to the given phoneNumber is sent or not.
  bool codeSent = false;

  /// Whether OTP is being sent to the given phoneNumber.
  bool get isSendingCode => !codeSent;

  /// Whether the current platform is web or not;
  bool get isWeb => kIsWeb;

  /// The phone auth verification ID.
  String? verificationID;

  late bool signOutOnSuccessfulVerification;

  late bool linkWithExistingUser;
}
