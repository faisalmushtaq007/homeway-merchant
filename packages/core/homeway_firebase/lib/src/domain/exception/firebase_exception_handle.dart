import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;

String? localizedErrorText(
  String? errorCode,
  FirebaseUILocalizationLabels labels,
) {
  switch (errorCode) {
    case 'user-not-found':
      return labels.userNotFoundErrorText;
    case 'email-already-in-use':
      return labels.emailTakenErrorText;
    case 'too-many-requests':
      return labels.accessDisabledErrorText;
    case 'wrong-password':
      return labels.wrongOrNoPasswordErrorText;
    case 'credential-already-in-use':
      return labels.credentialAlreadyInUseErrorText;
    case 'invalid-verification-code':
      return labels.invalidVerificationCodeErrorText;
    case 'weak-password':
      return labels.weakPasswordErrorText;

    default:
      return null;
  }
}

class FirebaseExceptionHandle {
  FirebaseExceptionHandle({
    required this.exception,
  });

  final Exception exception;
}
