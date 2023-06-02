import 'dart:ui';

import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:homemakers_merchant/gen/assets.gen.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';

class Language with AppEquatable {
  /// Add another languages support here
  Language(
    this.value,
    this.image,
    this.text,
    this.sourceLanguage,
  );

  final Locale value;
  final SvgGenImage image;
  final String text;
  final TranslateLanguage sourceLanguage;

  @override
  String toString() => 'Language($value, $text, $sourceLanguage, $image)';

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [value, image, text, sourceLanguage];
}
