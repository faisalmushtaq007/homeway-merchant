import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:homemakers_merchant/app/features/authentication/data/service/type_definitions.dart';

abstract class FirebaseAuthentication {
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
  });

  Stream<User?> get user;

  User? get currentUser;
}
