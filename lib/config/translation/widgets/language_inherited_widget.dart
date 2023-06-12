import 'package:flutter/widgets.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:homemakers_merchant/config/translation/language.dart';
import 'package:homemakers_merchant/config/translation/widgets/constants.dart';

class LanguageInheritedWidget extends InheritedWidget {
  const LanguageInheritedWidget({
    super.key,
    required this.isConnected,
    required this.allLanguageModelStatus,
    required this.arabicLanguage,
    required super.child,
  });

  final bool? isConnected;
  final Map<TranslateLanguage, Language> allLanguageModelStatus;
  final Map<TranslateLanguage, Language> arabicLanguage;

  @override
  bool updateShouldNotify(LanguageInheritedWidget oldWidget) {
    /*return oldWidget.isConnected != isConnected ||
        oldWidget.allLanguageModelStatus != allLanguageModelStatus ||
        oldWidget.arabicLanguage != arabicLanguage;*/
    return true;
  }

  static LanguageInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LanguageInheritedWidget>();
  }
}
