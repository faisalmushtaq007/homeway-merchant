import 'package:flutter/material.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_screen_wrapper.dart';

///default value for height
const double defaultHeight = 40;

///default padding
const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(8);

///default message
const String disconnectedMessage =
    'Please connect to an active internet connection!';

///default message Style
const TextStyle defaultMessageStyle = TextStyle(
  fontSize: 15,
  color: Colors.white,
  inherit: false,
);

extension PositionOnScreenExtention on PositionOnScreen {
  bool get isTOP => this == PositionOnScreen.TOP;

  bool get isBOTTOM => this == PositionOnScreen.BOTTOM;

  double? top(double height, bool isOffline) {
    if (isTOP) {
      return isOffline ? 0 : (-height);
    }
    return null;
  }

  double? bottom(double height, bool isOffline) {
    if (isBOTTOM) {
      return isOffline ? 0 : (-height);
    }
    return null;
  }
}

enum LanguageModelStatus {
  exists,
  notExists,
  deleted,
  downloaded,
  notDownloaded,
  none
}

enum LanguageDownloadStatus {
  downloading,
  downloadingFailed,
  downloaded,
  error,
  uncaughtException,
  notDownloaded,
  none
}

enum NewLanguageDownloadStatus {
  downloading,
  downloadingFailed,
  downloaded,
  error,
  uncaughtException,
  exists,
  notExists,
  deleted,
  notDownloaded,
  none
}
