import 'package:flutter/widgets.dart';
import 'package:homemakers_merchant/config/translation/widgets/constants.dart';

class LanguageInheritedWidget extends InheritedWidget {
  const LanguageInheritedWidget({
    super.key,
    required this.isConnected,
    required this.sourceModelStatus,
    required this.sourceLanguageDownloadStatus,
    required this.newSourceLanguageDownloadStatus,
    required super.child,
  });

  final bool? isConnected;
  final LanguageModelStatus sourceModelStatus;
  final LanguageDownloadStatus sourceLanguageDownloadStatus;
  final NewLanguageDownloadStatus newSourceLanguageDownloadStatus;

  @override
  bool updateShouldNotify(LanguageInheritedWidget oldWidget) {
    return oldWidget.isConnected != isConnected ||
        oldWidget.sourceModelStatus != sourceModelStatus ||
        oldWidget.sourceLanguageDownloadStatus !=
            sourceLanguageDownloadStatus ||
        oldWidget.newSourceLanguageDownloadStatus !=
            newSourceLanguageDownloadStatus;
  }

  static LanguageInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LanguageInheritedWidget>();
  }
}
