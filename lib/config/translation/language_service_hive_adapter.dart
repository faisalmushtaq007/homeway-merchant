import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:hive/hive.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';
import 'package:homemakers_merchant/config/translation/language.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';

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

class SaveTranslationObject with AppEquatable {
  SaveTranslationObject(
      {required this.appLanguage,
      required this.userLanguage,
      required this.startText,
      this.resultText});
  final TranslateLanguage appLanguage;

  final TranslateLanguage userLanguage;

  final String startText;

  String? resultText;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters =>
      [appLanguage, userLanguage, startText, resultText];
}

class SaveTranslationObjectAdapter extends TypeAdapter<SaveTranslationObject> {
  @override
  final typeId = 206;

  @override
  SaveTranslationObject read(BinaryReader reader) {
    try {
      var data = reader.read();
      return SaveTranslationObject(
          appLanguage: data[0],
          userLanguage: data[1],
          startText: data[2],
          resultText: data[3]);
      final dynamic saveTranslationObjectStatus = reader.read();
      return saveTranslationObjectStatus as SaveTranslationObject;
    } catch (e) {
      log('Error : SaveTranslationObject read- ${e.toString()}');
      return SaveTranslationObject(
        appLanguage: TranslateLanguage.english,
        userLanguage: TranslateLanguage.arabic,
        startText: '',
      );
    }
  }

  @override
  void write(BinaryWriter writer, SaveTranslationObject obj) {
    try {
      writer.write([
        obj.appLanguage,
        obj.userLanguage,
        obj.startText,
        obj.resultText,
      ]);
      /* writer.write(obj.appLanguage.index);
      writer.write(obj.appLanguage.bcpCode);
      writer.write(obj.appLanguage.name);
      writer.write(obj.userLanguage.index);
      writer.write(obj.userLanguage.bcpCode);
      writer.write(obj.userLanguage.name);
      writer.write(obj.startText);
      writer.write(obj.resultText);*/
    } catch (e) {
      log('Error : SaveTranslationObject write- ${e.toString()}');
    }
  }
}

class TranslateLanguageAdapter extends TypeAdapter<TranslateLanguage> {
  @override
  final typeId = 207;

  @override
  TranslateLanguage read(BinaryReader reader) {
    final dynamic translateLanguage = reader.read();
    return translateLanguage as TranslateLanguage;
  }

  @override
  void write(BinaryWriter writer, TranslateLanguage obj) {
    writer.write(obj.index);
    writer.write(obj.bcpCode);
    writer.write(obj.name);
  }
}
