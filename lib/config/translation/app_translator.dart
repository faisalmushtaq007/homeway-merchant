import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/language_service.dart';
import 'package:homemakers_merchant/config/translation/language_service_hive_adapter.dart';
import 'package:homemakers_merchant/config/translation/multiple_language_download.dart';
import 'package:homemakers_merchant/config/translation/translate_api.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:synchronized/synchronized.dart';

class AppTranslator {
  factory AppTranslator({
    required ILanguageService languageService,
    required String boxName,
    required MultipleLanguageDownload multipleLanguageDownload,
  }) {
    _instance.languageService = languageService;
    _instance.boxName = boxName;
    _instance.multipleLanguageDownload = multipleLanguageDownload;
    return _instance;
  }

  AppTranslator._privateConstructor();

  static final AppTranslator _instance = AppTranslator._privateConstructor();

  static AppTranslator get instance => _instance;

  // Instance variable
  late final MultipleLanguageDownload multipleLanguageDownload;
  late final ILanguageService languageService;
  late final String boxName;
  late final LanguageController languageController;

  // Local variable
  List<Language> appLanguagesStatus = [];
  List<IdentifiedLanguage> identifiedLanguages = <IdentifiedLanguage>[];
  final languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
  String identifiedLanguage = '';
  final OnDeviceTranslatorModelManager modelManager =
      OnDeviceTranslatorModelManager();
  late OnDeviceTranslator onDeviceTranslator;
  late TranslateLanguage sourceTranslateLanguage;
  late TranslateLanguage targetTranslateLanguage;
  late Language sourceAppLanguage;
  late Language targetAppLanguage;
  bool _isInitialized = false;
  bool _clearCache = false;

  //This parameter control the time between every request so you
  // don't exceed the maximum amount of request. If you don't know
  // what you are doing don't change it!
  int _delayTime = 300;

  int get delayTime => _delayTime;
  final Lock _lock = Lock();

  Future<void> init({
    TranslateLanguage? sourceLanguage,
    TranslateLanguage? targetLanguage,
    Language? sourceAppLanguage,
    Language? targetAppLanguage,
    int? delayTime,
    required LanguageController languageController,
  }) async {
    sourceTranslateLanguage =
        sourceLanguage ?? languageController.sourceTranslateLanguage;
    targetTranslateLanguage =
        targetLanguage ?? languageController.targetTranslateLanguage;
    this.sourceAppLanguage = languageController.sourceApplanguage;
    this.targetAppLanguage = languageController.targetAppLanguage;
    onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: sourceTranslateLanguage,
      targetLanguage: targetTranslateLanguage,
    );
    _delayTime = delayTime ?? _delayTime;
    await _doInit();
  }

  void setDelayTime(int delayTime) {
    _delayTime = delayTime;
    if (_delayTime < 100) {
      throw AutoLocalizationException('Delay time is too low.');
    } else if (_delayTime < 300) {
      final String text =
          'WARNING: The provided delay time ($_delayTime ms) is lower than recommended time. It could cause a request block.';
      log('\x1B[33m$text\x1B[0m');
    }
  }

  Future<bool> _doInit({bool clearCache = false}) async {
    if (_delayTime < 100) {
      throw AutoLocalizationException('Delay time is too low.');
    } else if (_delayTime < 300) {
      final String text =
          'WARNING: The provided delay time ($_delayTime ms) is lower than recommended time. It could cause a request block.';
      log('\x1B[33m$text\x1B[0m');
    }
    if (_isInitialized) {
      return true;
    }
    if (!Hive.isAdapterRegistered(206)) {
      Hive.registerAdapter(SaveTranslationObjectAdapter());
    }

    _isInitialized = true;
    return true;
  }

  void lazyClearCache() {
    _clearCache = true;
  }

  Future<bool> clearCache() async {
    try {
      await _doInit();
      final Box<dynamic> dbHive = Hive.box(boxName);
      await dbHive.deleteAll(dbHive.keys);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> _executeTranslate(
    String text, {
    bool cache = true,
    TranslateLanguage? startingLanguage,
    TranslateLanguage? targetLanguage,
    bool returnJSON = false,
  }) async {
    //CACHE CHECK
    await _doInit();
    Box<dynamic> dbHive = Hive.box(boxName);
    if (_clearCache) {
      await dbHive.deleteAll(dbHive.keys);
      _clearCache = false;
    }
    final SaveTranslationObject result = SaveTranslationObject(
      appLanguage: startingLanguage ?? sourceTranslateLanguage,
      userLanguage: targetLanguage ?? targetTranslateLanguage,
      startText: text,
    );
    List<dynamic> dynamicSearch =
        dbHive.values.where((element) => element == result).toList();
    List<SaveTranslationObject> search =
        List<SaveTranslationObject>.from(dynamicSearch);

    //CACHE NOT FOUND
    if (search.isEmpty || !cache) {
      /*result.resultText = (await _translator.translate(text,
              from: startingLanguage ?? _sourceLanguage,
              to: targetLanguage ?? _targetLanguage))
          .text;*/
      result.resultText = await translateText(text);
      await dbHive.add(result);
      await Future.delayed(Duration(milliseconds: _delayTime), () {});
      if (returnJSON) {
        return jsonEncode({
          'text': text,
          'translation': result.resultText!,
          'cache': false,
          'reverse_cache': false,
          'lang_start': startingLanguage ?? sourceTranslateLanguage,
          'lang_end': targetLanguage ?? targetLanguage,
          'time': DateTime.now().toIso8601String()
        });
      }
      return result.resultText!;
    }

    //CACHE FOUND
    if (returnJSON) {
      return jsonEncode({
        'text': text,
        'translation':
            (search.first.appLanguage == (targetLanguage ?? targetLanguage) &&
                    search.first.userLanguage ==
                        (startingLanguage ?? sourceTranslateLanguage))
                ? (search.first.startText)
                : (search.first.resultText!),
        'cache': true,
        'reverse_cache':
            search.first.appLanguage == (targetLanguage ?? targetLanguage) &&
                search.first.userLanguage ==
                    (startingLanguage ?? sourceTranslateLanguage),
        'lang_start': startingLanguage ?? sourceTranslateLanguage,
        'lang_end': targetLanguage ?? targetLanguage,
        'time': DateTime.now().toIso8601String()
      });
    }
    if (search.first.appLanguage == (targetLanguage ?? targetLanguage) &&
        search.first.userLanguage ==
            (startingLanguage ?? sourceTranslateLanguage)) {
      return search.first.startText;
    }
    return search.first.resultText!;
  }

  Future<String> translateText(String text) async {
    final result = await onDeviceTranslator.translateText(text);
    return result;
  }

  //Execute an async translation
  Future<String> translate(
    String text, {
    bool cache = true,
    TranslateLanguage? startingLanguage,
    TranslateLanguage? targetLanguage,
    bool returnJSON = false,
  }) async {
    /*var identifiedSourceLanguage = sourceTranslateLanguage;
    await AppTranslator.instance.identifyLanguage(text, (language) {
      log('translate: Identify Language ${language}');
      if (language.contains('en')) {
        identifiedSourceLanguage = TranslateLanguage.english;
      } else if (language.contains('ar')) {
        identifiedSourceLanguage = TranslateLanguage.arabic;
      } else {
        identifiedSourceLanguage = TranslateLanguage.values.firstWhere(
          (element) => element.bcpCode == language,
          orElse: () =>
              serviceLocator<LanguageController>().sourceTranslateLanguage,
        );
      }
    });*/
    // Execute the translation process
    final executeTranslate = await _executeTranslate(
      text,
      cache: cache,
      startingLanguage: sourceTranslateLanguage,
      targetLanguage: targetLanguage,
      returnJSON: returnJSON,
    );
    return executeTranslate;
  }

  Future<String> autoDetectTranslate(
    String text, {
    bool cache = true,
    TranslateLanguage? targetLanguage,
    bool returnJSON = false,
  }) async {
    final result = await _lock.synchronized(() async {
      // Identify the language of text
      var identifiedSourceLanguage = TranslateLanguage.english;
      await AppTranslator.instance.identifyLanguage(text, (language) {
        if (language.contains('en')) {
          identifiedSourceLanguage = TranslateLanguage.english;
        } else if (language.contains('ar')) {
          identifiedSourceLanguage = TranslateLanguage.arabic;
        } else {
          identifiedSourceLanguage =
              identifiedSourceLanguage = TranslateLanguage.values.firstWhere(
            (element) => element.bcpCode == language,
            orElse: () =>
                serviceLocator<LanguageController>().sourceTranslateLanguage,
          );
        }
      });
      late final onDeviceTranslator = OnDeviceTranslator(
        sourceLanguage: identifiedSourceLanguage,
        targetLanguage: targetLanguage ??
            serviceLocator<LanguageController>().targetTranslateLanguage,
      );
      // Execute the translation process
      final result = await onDeviceTranslator.translateText(text);
      await onDeviceTranslator.close();
      return result;
    });
    return result;
  }

  Future<void> identifyLanguage(
    String text,
    IdentifiedLanguageTypeDef identifiedLanguage, {
    bool updateCurrentIdentifiedLanguage = true,
  }) async {
    if (text == '') return;
    String language;
    try {
      language = await languageIdentifier.identifyLanguage(text);
    } on PlatformException catch (pe) {
      if (pe.code == languageIdentifier.undeterminedLanguageCode) {
        language = 'identifyLanguage error: no language identified!';
      }
      language = 'identifyLanguage error: ${pe.code}: ${pe.message}';
    } catch (e) {
      language = 'identifyLanguage error: ${e.toString()}';
    }
    if (updateCurrentIdentifiedLanguage) {
      this.identifiedLanguage = language;
    }
    identifiedLanguage(language);
  }

  Future<void> identifyPossibleLanguages(
    String text,
    IdentifiedPossibleLanguageTypeDef identifiedPossibleLanguageTypeDef, {
    bool updateCurrentIdentifiedLanguage = true,
    bool updateCurrentPossibleIdentifiedLanguages = true,
  }) async {
    if (text == '') return;
    String error;
    try {
      final possibleLanguages =
          await languageIdentifier.identifyPossibleLanguages(text);
      if (updateCurrentPossibleIdentifiedLanguages) {
        identifiedLanguages = possibleLanguages;
      }

      identifiedPossibleLanguageTypeDef(possibleLanguages, '');
      return;
    } on PlatformException catch (pe) {
      if (pe.code == languageIdentifier.undeterminedLanguageCode) {
        error = 'identifyPossibleLanguages error: no languages identified!';
      }
      error = 'identifyPossibleLanguages error: ${pe.code}: ${pe.message}';
    } catch (e) {
      error = 'identifyPossibleLanguages error: $e';
    }
    if (updateCurrentPossibleIdentifiedLanguages ||
        updateCurrentIdentifiedLanguage) {
      identifiedLanguages = [];
      identifiedLanguage = error;
    }
    identifiedPossibleLanguageTypeDef([], error);
    return;
  }

  void changeSourceTranslateLanguage(TranslateLanguage newSourceLanguage) {
    sourceTranslateLanguage = newSourceLanguage;
  }

  Future<void> changeTargetTranslateLanguage(Language language) async {
    targetTranslateLanguage = language.sourceLanguage;
    targetAppLanguage = language;
    await init(
        languageController: serviceLocator<LanguageController>(),
        targetAppLanguage: targetAppLanguage,
        targetLanguage: targetTranslateLanguage);
  }

  (TranslateLanguage, TranslateLanguage)
      switchCurrentSourceAndTargetLanguage() {
    var tempSourceLanguage = sourceTranslateLanguage;
    sourceTranslateLanguage = targetTranslateLanguage;
    targetTranslateLanguage = tempSourceLanguage;
    return (sourceTranslateLanguage, targetTranslateLanguage);
  }

  void dispose() {
    languageIdentifier.close();
    onDeviceTranslator.close();
  }
}
