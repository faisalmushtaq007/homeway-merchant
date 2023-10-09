import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:hive/hive.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';
import 'package:homemakers_merchant/config/translation/language.dart';
import 'package:homemakers_merchant/config/translation/widgets/constants.dart';
import 'package:homemakers_merchant/gen/assets.gen.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';

class LanguageAdapter extends TypeAdapter<Language> {
  @override
  Language read(BinaryReader reader) {
    var data = reader.read();
    return Language(
      data[0] as Locale,
      data[1] as SvgGenImage,
      data[2] as String,
      TranslateLanguage.values.byName(data[3]),
      languageDownloadStatus: LanguageDownloadStatus.values.byName(data[4])
          as LanguageDownloadStatus,
      textDirection: TextDirection.values.byName(
        data[5],
      ) as TextDirection,
    );
  }

  @override
  int get typeId => 201;

  @override
  void write(BinaryWriter writer, Language obj) {
    writer.write([
      obj.value,
      obj.image,
      obj.text,
      obj.sourceLanguage.name,
      obj.languageDownloadStatus.name,
      obj.textDirection.name,
    ]);
    writer.write(obj);
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
  bool get cacheHash => false;

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
          appLanguage: TranslateLanguage.values.byName(data[0]),
          userLanguage: TranslateLanguage.values.byName(data[1]),
          startText: data[2],
          resultText: data[3]);
      final dynamic saveTranslationObjectStatus = reader.read();
      return saveTranslationObjectStatus as SaveTranslationObject;
    } catch (e) {
      log('Error : SaveTranslationObject read- ${e.toString()}');
      return SaveTranslationObject(
        appLanguage: TranslateLanguage.english,
        userLanguage: TranslateLanguage.english,
        startText: '',
        resultText: '',
      );
    }
  }

  @override
  void write(BinaryWriter writer, SaveTranslationObject obj) {
    try {
      writer.write([
        obj.appLanguage.name,
        obj.userLanguage.name,
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
    return TranslateLanguage.values.byName(translateLanguage);
  }

  @override
  void write(BinaryWriter writer, TranslateLanguage obj) {
    writer.write(obj.name);
  }
}

class SvgGenImageAdapter extends TypeAdapter<SvgGenImage> {
  @override
  final typeId = 209;

  @override
  SvgGenImage read(BinaryReader reader) {
    final dynamic svgGenImage = reader.read();
    return svgGenImage as SvgGenImage;
  }

  @override
  void write(BinaryWriter writer, SvgGenImage obj) {
    //writer.write(obj.index);
    //writer.write(obj.bcpCode);
    writer.write(obj);
  }
}

class LocaleAdapter extends TypeAdapter<Locale> {
  @override
  final typeId = 210;

  @override
  Locale read(BinaryReader reader) {
    final dynamic locale = reader.read();
    return locale as Locale;
  }

  @override
  void write(BinaryWriter writer, Locale obj) {
    writer.write(obj);
  }
}

//LanguageDownloadStatus
class LanguageDownloadStatusAdapter
    extends TypeAdapter<LanguageDownloadStatus> {
  @override
  final typeId = 211;

  @override
  LanguageDownloadStatus read(BinaryReader reader) {
    final dynamic languageDownloadStatus = reader.read();
    return LanguageDownloadStatus.values.byName(languageDownloadStatus);
  }

  @override
  void write(BinaryWriter writer, LanguageDownloadStatus obj) {
    //writer.write(obj.hashCode);
    //writer.write(obj.index);
    writer.write(obj.name);
  }
}

class TextDirectionAdapter extends TypeAdapter<TextDirection> {
  @override
  final typeId = 212;

  @override
  TextDirection read(BinaryReader reader) {
    final dynamic translateLanguage = reader.read();
    return TextDirection.values.byName(translateLanguage);
  }

  @override
  void write(BinaryWriter writer, TextDirection obj) {
    //writer.write(obj.hashCode);
    //writer.write(obj.index);
    writer.write(obj.name);
  }
}
