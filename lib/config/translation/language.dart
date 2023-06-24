import 'dart:ui';

import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:homemakers_merchant/config/translation/widgets/constants.dart';
import 'package:homemakers_merchant/gen/assets.gen.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';

class Language with AppEquatable {
  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      map['value'] as Locale,
      map['image'] as SvgGenImage,
      map['text'] as String,
      map['sourceLanguage'] as TranslateLanguage,
      languageDownloadStatus:
          map['languageDownloadStatus'] as LanguageDownloadStatus,
      textDirection: map['textDirection'] as TextDirection,
    );
  }

  /// Add another languages support here
  Language(
    this.value,
    this.image,
    this.text,
    this.sourceLanguage, {
    this.languageDownloadStatus = LanguageDownloadStatus.notDownloaded,
    this.textDirection = TextDirection.ltr,
  });

  final Locale value;
  final SvgGenImage image;
  final String text;
  final TranslateLanguage sourceLanguage;
  final LanguageDownloadStatus languageDownloadStatus;
  final TextDirection textDirection;

  @override
  String toString() =>
      'Language($value, $text, $sourceLanguage, $image, $languageDownloadStatus, $textDirection)';

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        value,
        image,
        text,
        sourceLanguage,
        languageDownloadStatus,
        textDirection
      ];

  Language copyWith({
    Locale? value,
    SvgGenImage? image,
    String? text,
    TranslateLanguage? sourceLanguage,
    LanguageDownloadStatus? languageDownloadStatus,
    TextDirection? textDirection,
  }) {
    return Language(
      value ?? this.value,
      image ?? this.image,
      text ?? this.text,
      sourceLanguage ?? this.sourceLanguage,
      languageDownloadStatus:
          languageDownloadStatus ?? this.languageDownloadStatus,
      textDirection: textDirection ?? this.textDirection,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': this.value,
      'image': this.image,
      'text': this.text,
      'sourceLanguage': this.sourceLanguage,
      'languageDownloadStatus': this.languageDownloadStatus,
      'textDirection': this.textDirection,
    };
  }
}
