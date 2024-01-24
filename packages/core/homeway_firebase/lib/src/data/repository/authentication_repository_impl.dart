

part of 'package:homeway_firebase/src/domain/repository/authentication_repository.dart';

class FirebaseAuthenticationRepositoryImpl implements FirebaseAuthenticationRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static const kAutoRetrievalTimeOutDuration = Duration(minutes: 1);

  /// Web confirmation result for OTP.
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

  /// {@macro onCodeSent}
  VoidCallback? _onCodeSent;

  /// {@macro onLoginSuccess}
  OnLoginSuccess? _onLoginSuccess;

  /// {@macro onLoginFailed}
  OnLoginFailed? _onLoginFailed;

  OnError? _onError;

  static Duration _autoRetrievalTimeOutDuration = kAutoRetrievalTimeOutDuration;

  /// {@macro otpExpirationDuration}
  static Duration _otpExpirationDuration = kAutoRetrievalTimeOutDuration;

  /// [otpExpirationTimeLeft] can be used to display a reverse countdown, starting from
  /// [_otpExpirationDuration.inSeconds]s till 0, and can show the resend
  /// button, to let user request a new OTP.
  Duration get otpExpirationTimeLeft {
    final otpTickDuration = Duration(
      seconds: (_otpExpirationTimer?.tick ?? 0),
    );
    return _otpExpirationDuration - otpTickDuration;
  }

  /// [autoRetrievalTimeLeft] can be used to display a reverse countdown, starting from
  /// [_autoRetrievalTimeOutDuration.inSeconds]s till 0, and can show the
  /// the listening for OTP view, and also the time left.
  ///
  /// After this timer is exhausted, the device no longer tries to auto-fetch
  /// the OTP, and requires user to manually enter it.
  Duration get autoRetrievalTimeLeft {
    final otpTickDuration = Duration(
      seconds: (_otpAutoRetrievalTimer?.tick ?? 0),
    );
    return _autoRetrievalTimeOutDuration - otpTickDuration;
  }

  /// Whether the otp has expired or not.
  bool get isOtpExpired => !(_otpExpirationTimer?.isActive ?? false);

  /// Whether the otp retrieval timer is active or not.
  bool get isListeningForOtpAutoRetrieve =>
      _otpAutoRetrievalTimer?.isActive ?? false;

  /// Set callbacks and other data. (only for internal use)
  @override
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
  }) {
    signOutOnSuccessfulVerification = signOutOnSuccessfulVerification;
    _onLoginSuccess = onLoginSuccess;
    _onLoginFailed = onLoginFailed;
    _onError = onError;
    _onCodeSent = onCodeSent;
    linkWithExistingUser = linkWithExistingUser;
    _autoRetrievalTimeOutDuration = autoRetrievalTimeOutDuration;
    _otpExpirationDuration = otpExpirationDuration;
    if (kIsWeb) _recaptchaVerifierForWeb = recaptchaVerifierForWeb;
  }

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
    OnLoginSuccess? onLoginSuccess,
  }) async {
    if ((!kIsWeb && (verificationID == null && otpVerificationId.isEmpty)) ||
        (kIsWeb && _webConfirmationResult == null)) return false;

    try {
      if (kIsWeb) {
        final userCredential = await _webConfirmationResult!.confirm(otpCode);
        return await _loginUser(
          userCredential: userCredential,
          autoVerified: false,
          onLoginFailed: onLoginFailed,
          onError: onError,
          onLoginSuccess: onLoginSuccess,
        );
      } else {
        final credential = PhoneAuthProvider.credential(
          verificationId: verificationID??otpVerificationId,
          smsCode: otpCode,
        );
        return await _loginUser(
          authCredential: credential,
          autoVerified: false,
          onLoginFailed: onLoginFailed,
          onError: onError,
          onLoginSuccess: onLoginSuccess,
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
      _forceResendingToken = _forceResendingToken;
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
        _webConfirmationResult = await _auth.signInWithPhoneNumber(
          mobileNumber,
          _recaptchaVerifierForWeb,
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

  @override
  FirebaseAuth get firebaseAuth => _auth;

  // Clear all data
  void clear() {
    if (kIsWeb) {
      _recaptchaVerifierForWeb?.clear();
      _recaptchaVerifierForWeb = null;
    }
    codeSent = false;
    _webConfirmationResult = null;
    _onLoginSuccess = null;
    _onLoginFailed = null;
    _onError = null;
    _onCodeSent = null;
    signOutOnSuccessfulVerification = false;
    // _forceResendingToken = null;
    _otpExpirationTimer?.cancel();
    _otpExpirationTimer = null;
    _otpAutoRetrievalTimer?.cancel();
    _otpAutoRetrievalTimer = null;
    linkWithExistingUser = false;
    _autoRetrievalTimeOutDuration = kAutoRetrievalTimeOutDuration;
    _otpExpirationDuration = kAutoRetrievalTimeOutDuration;
    verificationID = null;
  }
}
