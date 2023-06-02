import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:hive/hive.dart';
import 'package:homemakers_merchant/config/translation/language.dart';

class LanguageAdapter extends TypeAdapter<Language> {
  @override
  Language read(BinaryReader reader) {
    final dynamic languageStatus = reader.read();
    return languageStatus as Language;
  }

  @override
  int get typeId => 201;

  @override
  void write(BinaryWriter writer, Language obj) {
    writer.write<Language>(obj);
  }
}

@HiveType(typeId: 202)
class SaveTranslationObject {
  SaveTranslationObject(
      {required this.appLanguage,
      required this.userLanguage,
      required this.startText,
      this.resultText});
  @HiveField(0)
  final TranslateLanguage appLanguage;
  @HiveField(1)
  final TranslateLanguage userLanguage;
  @HiveField(2)
  final String startText;
  @HiveField(3)
  String? resultText;

  @override
  bool operator ==(Object other) {
    if (other is SaveTranslationObject) {
      return (other.appLanguage == appLanguage &&
              other.userLanguage == userLanguage &&
              other.startText.toLowerCase().trim() ==
                  startText.toLowerCase().trim()) ||
          (other.appLanguage == userLanguage &&
              other.userLanguage == appLanguage &&
              other.startText.toLowerCase().trim() ==
                  resultText?.toLowerCase().trim());
    }
    return false;
  }

  @override
  int get hashCode => super.hashCode;
}

class SaveTranslationObjectAdapter extends TypeAdapter<SaveTranslationObject> {
  @override
  final typeId = 202;

  @override
  SaveTranslationObject read(BinaryReader reader) {
    var data = reader.read();
    return SaveTranslationObject(
        appLanguage: data[0],
        userLanguage: data[1],
        startText: data[2],
        resultText: data[3]);
  }

  @override
  void write(BinaryWriter writer, SaveTranslationObject obj) {
    writer.write([
      obj.appLanguage,
      obj.userLanguage,
      obj.startText,
      obj.resultText,
    ]);
  }
}
