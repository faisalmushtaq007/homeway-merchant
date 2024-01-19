import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:homemakers_merchant/app/features/authentication/data/service/type_definitions.dart';
import 'package:homemakers_merchant/app/features/authentication/domain/service/firebase_authentication.dart';

class FirebaseAuthenticationImpl implements FirebaseAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static const kAutoRetrievalTimeOutDuration = Duration(minutes: 1);

  /// Web confirmation result for OTP.
  ConfirmationResult? webConfirmationResult;

  /// {@macro recaptchaVerifierForWeb}
  RecaptchaVerifier? recaptchaVerifierForWeb;

  /// The [_forceResendingToken] obtained from [codeSent]
  /// callback to force re-sending another verification SMS before the
  /// auto-retrieval timeout.
  int? forceResendingToken;

  /// Timer object for SMS auto-retrieval.
  Timer? otpAutoRetrievalTimer;

  /// Timer object for OTP expiration.
  Timer? otpExpirationTimer;

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

  @override
  Future<User?> getFirebaseUser() async {
    return _auth.currentUser;
  }

  @override
  Future<bool> verifyOtp({
    required String otpCode,
    required String otpVerificationId,
    VoidCallback? onCodeSent,
    OnLoginFailed? onLoginFailed,
    OnError? onError,
  }) async {
    if ((!kIsWeb && (verificationID == null && otpVerificationId.isEmpty)) ||
        (kIsWeb && webConfirmationResult == null)) return false;

    try {
      if (kIsWeb) {
        final userCredential = await webConfirmationResult!.confirm(otpCode);
        return await _loginUser(
          userCredential: userCredential,
          autoVerified: false,
        );
      } else {
        final credential = PhoneAuthProvider.credential(
          verificationId: verificationID??otpVerificationId,
          smsCode: otpCode,
        );
        return await _loginUser(
          authCredential: credential,
          autoVerified: false,
        );
      }
    } on FirebaseAuthException catch (e, s) {
      onLoginFailed?.call(e, s);
      return false;
    } catch (e, s) {
      onError?.call(e, s);
      return false;
    }
  }

  @override
  Future<bool> sendOtp({
    required String mobileNumber,
    required String dialCode,
    required String countryCode,
    bool isResend = false,
    bool shouldAwaitCodeSend = true,
    VoidCallback? onCodeSent,
    OnLoginFailed? onLoginFailed,
    OnError? onError,
  }) async {
    Completer? codeSendCompleter;

    bool codeSent = false;
    await Future.delayed(
      Duration.zero,
      () {},
    );
    verificationCompletedCallback(PhoneAuthCredential authCredential) async {
      await _loginUser(authCredential: authCredential, autoVerified: true);
      //await _auth.signInWithCredential(credential);
      print("TEST_LOG============verificationCompleted=========>");
    }

    verificationFailedCallback(FirebaseAuthException authException) {
      final stackTrace = authException.stackTrace ?? StackTrace.current;

      if (codeSendCompleter != null && !codeSendCompleter.isCompleted) {
        codeSendCompleter.completeError(authException, stackTrace);
      }
      onLoginFailed?.call(authException, stackTrace);
      print("TEST_LOG========failure=============>${authException.message}");
    }

    codeSentCallback(String verificationId, int? resendToken) async{
      verificationID = verificationId;
      forceResendingToken = forceResendingToken;
      codeSent = true;
      onCodeSent?.call();
      if (codeSendCompleter != null && !codeSendCompleter.isCompleted) {
        codeSendCompleter.complete();
      }
      //_setTimer();
      print("TEST_LOG===========Code shared==========>${verificationId}");
    }

    codeAutoRetrievalTimeout(String verificationId) {
      verificationID = verificationId;
      print("TEST_LOG===========Time out==========>${verificationId}");
    }

    try {
      if (kIsWeb) {
        webConfirmationResult = await _auth.signInWithPhoneNumber(
          mobileNumber,
          recaptchaVerifierForWeb,
        );
        codeSent = true;
        onCodeSent?.call();
        //_setTimer();
      } else {
        codeSendCompleter = Completer();
        await _auth.verifyPhoneNumber(
          phoneNumber: mobileNumber,
          //timeout: const Duration(seconds: 30,),
          verificationCompleted: verificationCompletedCallback,
          verificationFailed: verificationFailedCallback,
          codeSent: codeSentCallback,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        );
        if (shouldAwaitCodeSend) await codeSendCompleter.future;
      }
      return true;
    } on FirebaseAuthException catch (e, s) {
      if (codeSendCompleter != null && !codeSendCompleter.isCompleted) {
        codeSendCompleter.completeError(e, s);
      }
      onLoginFailed?.call(e, s);
      return false;
    } catch (e, s) {
      if (codeSendCompleter != null && !codeSendCompleter.isCompleted) {
        codeSendCompleter.completeError(e, s);
      }
      onError?.call(e, s);
      return false;
    }

  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();

    return;
  }

  // create user obj based on firebase user
  User? _userFromFirebaseUser(User? user) {
    return user;
  }

  // auth change user stream
  @override
  Stream<User?> get user {
    return _auth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  @override
  User? get currentUser => _auth.currentUser;

  /// Called when the otp is verified either automatically (OTP auto fetched)
  /// or [verifyOtp] was called with the correct OTP.
  ///
  /// If true is returned that means the user was logged in successfully.
  ///
  /// If for any reason, the user fails to login,
  /// [_onLoginFailed] is called with [FirebaseAuthException]
  /// object to handle the error and false is returned.
  Future<bool> _loginUser({
    AuthCredential? authCredential,
    UserCredential? userCredential,
    required bool autoVerified,
    OnLoginFailed? onLoginFailed,
    OnError? onError,
    OnLoginSuccess? onLoginSuccess,
  }) async {
    if (kIsWeb) {
      if (userCredential != null) {
        if (signOutOnSuccessfulVerification) await signOut();
        onLoginSuccess?.call(userCredential, autoVerified);
        return true;
      } else {
        return false;
      }
    }

    // Not on web.
    try {
      late final UserCredential authResult;

      if (linkWithExistingUser) {
        authResult = await _auth.currentUser!.linkWithCredential(
          authCredential!,
        );
      } else {
        authResult = await _auth.signInWithCredential(authCredential!);
      }

      if (signOutOnSuccessfulVerification) await signOut();
      onLoginSuccess?.call(authResult, autoVerified);
      return true;
    } on FirebaseAuthException catch (e, s) {
      onLoginFailed?.call(e, s);
      return false;
    } catch (e, s) {
      onError?.call(e, s);
      return false;
    }
  }
}
