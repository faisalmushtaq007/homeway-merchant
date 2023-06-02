import 'dart:collection' show HashMap;
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:hive/hive.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_service.dart';
import 'package:homemakers_merchant/config/translation/language_service_hive_adapter.dart';
import 'package:synchronized/synchronized.dart';

class AutoLocalizationException implements Exception {
  String cause;

  AutoLocalizationException(this.cause);
}

typedef IdentifiedLanguageTypeDef = void Function(String language);
typedef IdentifiedPossibleLanguageTypeDef = void Function(
    List<IdentifiedLanguage> languages, String language);

class TranslateApi {
  TranslateApi({required this.languageService, required this.boxName});

  final ILanguageService languageService;
  final String boxName;
  static List<IdentifiedLanguage> _identifiedLanguages = <IdentifiedLanguage>[];
  static final _languageIdentifier =
      LanguageIdentifier(confidenceThreshold: 0.5);
  static var _identifiedLanguage = '';
  String? _translatedText;
  static final _modelManager = OnDeviceTranslatorModelManager();
  static var _sourceLanguage = TranslateLanguage.arabic;
  static var _targetLanguage = TranslateLanguage.hindi;
  static late var _onDeviceTranslator = OnDeviceTranslator(
    sourceLanguage: _sourceLanguage,
    targetLanguage: _targetLanguage,
  );
  static bool hasSourceModelDownloaded = false;
  static bool hasTargetModelDownloaded = false;
  static bool hasSourceModelDeleted = false;
  static bool hasTargetModelDeleted = false;
  static bool hasSourceModelDownloadedSuccess = false;
  static bool hasTargetModelDownloadedSuccess = false;
  static bool _isInitialized = false;
  static bool _clearCache = false;

  ///This parameter control the time between every request so you don't exceed the maximum amount of request. If you don't know what you are doing don't change it!
  static int _delayTime = 300;

  static int get delayTime => _delayTime;
  static Lock _lock = Lock();

  /// The Active Locale at the Moment while
  /// the String is translated
  static Locale _activeLocale = Locale('en');

  /// Getter for the Active Locale at the Moment while
  /// the String is translated
  static Locale get activeLocale => _activeLocale;

  /// The Default Locale, the Language in which
  /// you write your Text / Strings in the Code
  static Locale _defaultLocale = Locale('en');

  /// The Default Locale, the Language in which
  /// you write your Text / Strings in the Code.
  /// This is hidden behind a getter because you have to
  /// set it in the [init] method and can't change it later
  static Locale get defaultLocation => _defaultLocale;

  /// The Map with the Translations. From this map the HashMap is created
  static Map<String, String> _translationsMap = {};

  /// The Translations as a [HashMap] because this is efficient calling.
  /// A HashMap has a constant Iteration Time.
  static final HashMap<String, String> _translations =
      HashMap.from(_translationsMap);

  static void changeLocale(Locale newLocale) {
    _activeLocale = newLocale;
  }

  Future<void> init(
      {TranslateLanguage? sourceLanguage,
      TranslateLanguage? targetLanguage,
      int? delayTime}) async {
    _sourceLanguage = sourceLanguage ?? _sourceLanguage;
    _targetLanguage = targetLanguage ?? _targetLanguage;
    _delayTime = delayTime ?? _delayTime;

    await _doInit();
  }

  ///SET APP LANGUAGE
  static set setDelayTime(int delayTime) {
    _delayTime = delayTime;
    if (_delayTime < 100) {
      throw AutoLocalizationException('Delay time is too low.');
    } else if (_delayTime < 300) {
      final String text =
          'WARNING: The provided delay time ($_delayTime ms) is lower than recommended time. It could cause a request block.';
      log('\x1B[33m$text\x1B[0m');
    }
  }

  Future<bool> _doInit() async {
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
    /*if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<SaveTranslationObject>(boxName);
    }*/
    _isInitialized = true;
    return true;
  }

  static void lazyClearCache() {
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

  Future<String> _executeTranslate(String text,
      {bool cache = true,
      TranslateLanguage? startingLanguage,
      TranslateLanguage? targetLanguage,
      bool returnJSON = false}) async {
    //CACHE CHECK
    await _doInit();
    Box<SaveTranslationObject> dbHive =
        Hive.box(boxName) as Box<SaveTranslationObject>;
    if (_clearCache) {
      await dbHive.deleteAll(dbHive.keys);
      _clearCache = false;
    }
    SaveTranslationObject result = SaveTranslationObject(
        appLanguage: startingLanguage ?? _sourceLanguage,
        userLanguage: targetLanguage ?? _targetLanguage,
        startText: text);
    List<SaveTranslationObject> search =
        dbHive.values.where((element) => element == result).toList();

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
          'lang_start': startingLanguage ?? _sourceLanguage,
          'lang_end': targetLanguage ?? _targetLanguage,
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
            (search.first.appLanguage == (targetLanguage ?? _targetLanguage) &&
                    search.first.userLanguage ==
                        (startingLanguage ?? _sourceLanguage))
                ? (search.first.startText)
                : (search.first.resultText!),
        'cache': true,
        'reverse_cache': search.first.appLanguage ==
                (targetLanguage ?? _targetLanguage) &&
            search.first.userLanguage == (startingLanguage ?? _sourceLanguage),
        'lang_start': startingLanguage ?? _sourceLanguage,
        'lang_end': targetLanguage ?? _targetLanguage,
        'time': DateTime.now().toIso8601String()
      });
    }
    if (search.first.appLanguage == (targetLanguage ?? _targetLanguage) &&
        search.first.userLanguage == (startingLanguage ?? _sourceLanguage)) {
      return search.first.startText;
    }
    return search.first.resultText!;
  }

  ///Execute an async translation
  Future<String> translate(String text,
      {bool cache = true,
      TranslateLanguage? startingLanguage,
      TranslateLanguage? targetLanguage,
      bool returnJSON = false}) async {
    final result = await _lock.synchronized(() async {
      final executeTranslate = await _executeTranslate(text,
          cache: cache,
          startingLanguage: startingLanguage,
          targetLanguage: targetLanguage,
          returnJSON: returnJSON);
      return executeTranslate;
    });
    return result;
  }

  static void dispose() {
    _languageIdentifier.close();
    _onDeviceTranslator.close();
  }

  Future<void> identifyLanguage(
    String text,
    IdentifiedLanguageTypeDef identifiedLanguage, {
    bool updateCurrentIdentifiedLanguage = true,
  }) async {
    if (text == '') return;
    String language;
    try {
      language = await _languageIdentifier.identifyLanguage(text);
    } on PlatformException catch (pe) {
      if (pe.code == _languageIdentifier.undeterminedLanguageCode) {
        language = 'error: no language identified!';
      }
      language = 'error: ${pe.code}: ${pe.message}';
    } catch (e) {
      language = 'error: ${e.toString()}';
    }
    if (updateCurrentIdentifiedLanguage) {
      _identifiedLanguage = language;
    }
    identifiedLanguage(language);
  }

  Future<void> identifyPossibleLanguages(String text,
      IdentifiedPossibleLanguageTypeDef identifiedPossibleLanguageTypeDef,
      {bool updateCurrentIdentifiedLanguage = true,
      bool updateCurrentPossibleIdentifiedLanguages = true}) async {
    if (text == '') return;
    String error;
    try {
      final possibleLanguages =
          await _languageIdentifier.identifyPossibleLanguages(text);
      if (updateCurrentPossibleIdentifiedLanguages) {
        _identifiedLanguages = possibleLanguages;
      }

      identifiedPossibleLanguageTypeDef(possibleLanguages, '');
      return;
    } on PlatformException catch (pe) {
      if (pe.code == _languageIdentifier.undeterminedLanguageCode) {
        error = 'error: no languages identified!';
      }
      error = 'error: ${pe.code}: ${pe.message}';
    } catch (e) {
      error = 'error: ${e.toString()}';
    }
    if (updateCurrentPossibleIdentifiedLanguages ||
        updateCurrentIdentifiedLanguage) {
      _identifiedLanguages = [];
      _identifiedLanguage = error;
    }
    identifiedPossibleLanguageTypeDef([], error);
    return;
  }

  Future<bool> downloadSourceModel() async {
    log('Downloading model (${_sourceLanguage.name})...');
    final bool hasDownloaded = await _modelManager
        .downloadModel(_sourceLanguage.bcpCode, isWifiRequired: false);
    hasSourceModelDownloadedSuccess = hasDownloaded;

    return hasDownloaded;
  }

  Future<bool> downloadTargetModel() async {
    log('Downloading model (${_targetLanguage.name})...');
    final bool hasDownloaded = await _modelManager
        .downloadModel(_targetLanguage.bcpCode, isWifiRequired: false);
    hasTargetModelDownloadedSuccess = hasDownloaded;

    return hasDownloaded;
  }

  Future<bool> deleteSourceModel() async {
    log('Deleting model (${_sourceLanguage.name})...');
    final bool hasDeleted =
        await _modelManager.deleteModel(_sourceLanguage.bcpCode);
    hasSourceModelDeleted = hasDeleted;

    return hasDeleted;
  }

  Future<bool> deleteTargetModel() async {
    log('Deleting model (${_targetLanguage.name})...');
    final bool hasDeleted =
        await _modelManager.deleteModel(_targetLanguage.bcpCode);
    hasTargetModelDeleted = hasDeleted;

    return hasDeleted;
  }

  Future<bool> isSourceModelDownloaded() async {
    log('Checking if model (${_sourceLanguage.name}) is downloaded...');
    final bool hasDownloaded =
        await _modelManager.isModelDownloaded(_sourceLanguage.bcpCode);
    hasSourceModelDownloaded = hasDownloaded;

    return hasDownloaded;
  }

  Future<bool> isTargetModelDownloaded() async {
    log('Checking if model (${_targetLanguage.name}) is downloaded...');
    final bool hasDownloaded =
        await _modelManager.isModelDownloaded(_targetLanguage.bcpCode);
    hasTargetModelDownloaded = hasDownloaded;

    return hasDownloaded;
  }

  Future<String> translateText(String text) async {
    final result = await _onDeviceTranslator.translateText(text);
    _translatedText = result;
    return result;
  }

  void changeSourceTranslateLanguage(TranslateLanguage newSourceLanguage) {
    _sourceLanguage = newSourceLanguage;
  }

  void changeTargetTranslateLanguage(TranslateLanguage newTargetLanguage) {
    _targetLanguage = newTargetLanguage;
  }

  void updateSourceAndTargetLanguage(
      {required TranslateLanguage newSourceLanguage,
      required TranslateLanguage newTargetLanguage}) {
    _sourceLanguage = newSourceLanguage;
    _targetLanguage = newTargetLanguage;
  }

  void switchCurrentSourceAndTargetLanguage() {
    _sourceLanguage = _targetLanguage;
    _targetLanguage = _sourceLanguage;
  }

  static Future<String> _translateText(String text) async {
    final result = await _onDeviceTranslator.translateText(text);
    return result;
  }

  Future<String?> translateToEnglishText(String text) async {
    var languageCode = '';
    Lock _lock = Lock();
    final result = await _lock.synchronized(() async {
      await identifyLanguage(
        text,
        (language) {
          languageCode = language;
        },
        updateCurrentIdentifiedLanguage: false,
      );
      TranslateLanguage sourceLanguage = TranslateLanguage.values
          .firstWhere((element) => element.bcpCode == languageCode);
      if (sourceLanguage == TranslateLanguage.english) {
        return text;
      }
      final onDeviceTranslator = OnDeviceTranslator(
        sourceLanguage: sourceLanguage,
        targetLanguage: TranslateLanguage.english,
      );
      final result = await onDeviceTranslator.translateText(text);
      return result;
    });
    return result;
  }

  Future<String?> translateToArabicText(String text) async {
    var languageCode = '';
    Lock _lock = Lock();
    final result = await _lock.synchronized(() async {
      await identifyLanguage(
        text,
        (language) {
          languageCode = language;
        },
        updateCurrentIdentifiedLanguage: false,
      );
      TranslateLanguage sourceLanguage = TranslateLanguage.values
          .firstWhere((element) => element.bcpCode == languageCode);
      if (sourceLanguage == TranslateLanguage.arabic) {
        return text;
      }
      final onDeviceTranslator = OnDeviceTranslator(
        sourceLanguage: sourceLanguage,
        targetLanguage: TranslateLanguage.arabic,
      );
      final result = await onDeviceTranslator.translateText(text);
      return result;
    });
    return result;
  }

  static Future<String> _translate(String input) async {
    final translatedMap = _translations[input];
    if (translatedMap != null) {
      final result = await _translateText(input);
      return result;
    } else {
      return input;
    }
  }
}

/// Extension on String to Translate the String.
extension Translate on String {
  /// Method that actually translates
  /// the String
  /// This method takes no time when calling it with the default Locale
  /// because then it just returns the String you called it on
  Future<String> tr() async {
    if (TranslateApi._activeLocale == TranslateApi.defaultLocation) {
      return Future.value(this);
    } else {
      return Future.value(await serviceLocator<TranslateApi>().translate(this));
    }
  }
}
