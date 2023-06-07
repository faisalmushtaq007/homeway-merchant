import 'dart:async';
import 'dart:collection' show HashMap;
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:hive/hive.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/language_service.dart';
import 'package:homemakers_merchant/config/translation/language_service_hive_adapter.dart';
import 'package:homemakers_merchant/config/translation/widgets/constants.dart';
import 'package:homemakers_merchant/main_development.dart';
import 'package:synchronized/synchronized.dart';
import 'package:isolate_manager/isolate_manager.dart';
import 'package:flutter_background_executor/flutter_background_executor.dart';

class AutoLocalizationException implements Exception {
  String cause;

  AutoLocalizationException(this.cause);
}

typedef IdentifiedLanguageTypeDef = void Function(String language);
typedef IdentifiedPossibleLanguageTypeDef = void Function(
    List<IdentifiedLanguage> languages, String language);
final backgroundSourceLanguageExecutor = FlutterBackgroundExecutor();
final _backgroundTargetExecutor = FlutterBackgroundExecutor();
final _backgroundNewLanguageExecutor = FlutterBackgroundExecutor();

class TranslateApi {
  static final TranslateApi _instance = TranslateApi._privateConstructor();
  static TranslateApi get instance => _instance;
  TranslateApi._privateConstructor();
  factory TranslateApi(
      {required ILanguageService languageService, required String boxName}) {
    _instance.languageService = languageService;
    _instance.boxName = boxName;
    return _instance;
  }
  //TranslateApi({required this.languageService, required this.boxName});

  late final ILanguageService languageService;
  late final String boxName;
  static List<IdentifiedLanguage> _identifiedLanguages = <IdentifiedLanguage>[];
  static final _languageIdentifier =
      LanguageIdentifier(confidenceThreshold: 0.5);
  static var _identifiedLanguage = '';
  String? _translatedText;
  late final OnDeviceTranslatorModelManager _modelManager =
      OnDeviceTranslatorModelManager();

  OnDeviceTranslatorModelManager get modelManager => _modelManager;
  var _sourceLanguage = TranslateLanguage.arabic;
  TranslateLanguage get sourceLanguage => _sourceLanguage;

  set sourceLanguage(TranslateLanguage value) {
    _sourceLanguage = value;
  }

  var _targetLanguage = TranslateLanguage.arabic;
  TranslateLanguage get targetLanguage => _targetLanguage;

  set targetLanguage(TranslateLanguage value) {
    _sourceLanguage = value;
  }

  late var _onDeviceTranslator = OnDeviceTranslator(
    sourceLanguage: _sourceLanguage,
    targetLanguage: _targetLanguage,
  );
  bool hasSourceModelDownloaded = false;
  bool hasTargetModelDownloaded = false;
  bool hasSourceModelDeleted = false;
  bool hasTargetModelDeleted = false;
  bool hasSourceModelDownloadedSuccess = false;
  bool hasTargetModelDownloadedSuccess = false;
  bool _isInitialized = false;
  bool _clearCache = false;

  ///This parameter control the time between every request so you don't exceed the maximum amount of request. If you don't know what you are doing don't change it!
  int _delayTime = 300;

  int get delayTime => _delayTime;
  Lock _lock = Lock();

  /// The Active Locale at the Moment while
  /// the String is translated
  Locale _activeLocale = Locale('en');

  /// Getter for the Active Locale at the Moment while
  /// the String is translated
  Locale get activeLocale => _activeLocale;

  /// The Default Locale, the Language in which
  /// you write your Text / Strings in the Code
  Locale _defaultLocale = Locale('en');

  /// The Default Locale, the Language in which
  /// you write your Text / Strings in the Code.
  /// This is hidden behind a getter because you have to
  /// set it in the [init] method and can't change it later
  Locale get defaultLocation => _defaultLocale;

  /// The Map with the Translations. From this map the HashMap is created
  static Map<String, String> _translationsMap = {};

  /// The Translations as a [HashMap] because this is efficient calling.
  /// A HashMap has a constant Iteration Time.
  static final HashMap<String, String> _translations =
      HashMap.from(_translationsMap);

  // AppDefault SourceModel Availability StreamController
  late StreamController<LanguageModelStatus>
      _appDefaultSourceModelAvailabilityStreamController;

  Stream<LanguageModelStatus> get appSourceModelStream =>
      _appDefaultSourceModelAvailabilityStreamController.stream;

  // AppDefault SourceModel Download StreamController
  late StreamController<LanguageDownloadStatus>
      _appDefaultSourceModelDownloadStreamController;

  Stream<LanguageDownloadStatus> get appDefaultSourceModelDownloadStream =>
      _appDefaultSourceModelDownloadStreamController.stream;

  // New SourceModel Download StreamController
  late StreamController<NewLanguageDownloadStatus>
      _newSourceModelDownloadStreamController;

  Stream<NewLanguageDownloadStatus> get newSourceModelDownloadStream =>
      _newSourceModelDownloadStreamController.stream;

  StreamController<(LanguageModelStatus, LanguageDownloadStatus)>
      downloadStreamController = StreamController<
          (LanguageModelStatus, LanguageDownloadStatus)>.broadcast();

  void changeLocale(Locale newLocale) {
    _activeLocale = newLocale;
  }

  Future<void> init(
      {TranslateLanguage? sourceLanguage,
      TranslateLanguage? targetLanguage,
      int? delayTime}) async {
    _sourceLanguage = sourceLanguage ?? _sourceLanguage;
    _targetLanguage = targetLanguage ?? _targetLanguage;
    _delayTime = delayTime ?? _delayTime;
    _appDefaultSourceModelAvailabilityStreamController =
        StreamController<LanguageModelStatus>.broadcast();
    _appDefaultSourceModelDownloadStreamController =
        StreamController<LanguageDownloadStatus>.broadcast();
    //_newSourceModelDownloadStreamController
    _newSourceModelDownloadStreamController =
        StreamController<NewLanguageDownloadStatus>.broadcast();
    // start SourceModelDownload
    await TranslateApi.instance.startSourceModelDownload();
    //
    final Stream<(LanguageModelStatus, LanguageDownloadStatus)>
        sourceTranslateDownloadStream = hasSourceTranslateLanguageDownload();
    //
    sourceTranslateDownloadStream.listen((event) {
      log('Translate Api - sourceTranslateDownloadStream ${event}');
      if (event
          case (
            LanguageModelStatus.exists,
            LanguageDownloadStatus.downloaded
          )) {
        log('Translate Api - downloaded sourceTranslateDownloadStream ${event}');
        serviceLocator<LanguageController>().hasSourceModelDownloadedSuccess =
            true;
        serviceLocator<LanguageController>().hasSourceModelDownloaded = true;
        hasSourceModelDownloaded = true;
        hasSourceModelDownloadedSuccess = true;
        _appDefaultSourceModelAvailabilityStreamController.add(event.$1);
        _appDefaultSourceModelDownloadStreamController.add(event.$2);
      } else if (event
          case (
            LanguageModelStatus.notExists,
            LanguageDownloadStatus.downloadingFailed
          )) {
        log('Translate Api - downloadedFailed sourceTranslateDownloadStream ${event}');
        serviceLocator<LanguageController>().hasSourceModelDownloadedSuccess =
            false;
        serviceLocator<LanguageController>().hasSourceModelDownloaded = false;
        hasSourceModelDownloaded = false;
        hasSourceModelDownloadedSuccess = false;
        _appDefaultSourceModelAvailabilityStreamController.add(event.$1);
        _appDefaultSourceModelDownloadStreamController.add(event.$2);
      } else if (event
          case (
            LanguageModelStatus.notExists,
            LanguageDownloadStatus.downloading
          )) {
        log('Translate Api - downloading sourceTranslateDownloadStream ${event}');
        serviceLocator<LanguageController>().hasSourceModelDownloadedSuccess =
            false;
        serviceLocator<LanguageController>().hasSourceModelDownloaded = false;
        hasSourceModelDownloaded = false;
        hasSourceModelDownloadedSuccess = false;
        _appDefaultSourceModelAvailabilityStreamController.add(event.$1);
        _appDefaultSourceModelDownloadStreamController.add(event.$2);
      } else if (event
          case (LanguageModelStatus.notExists, LanguageDownloadStatus.error)) {
        log('Translate Api - downloaded error sourceTranslateDownloadStream ${event}');
        serviceLocator<LanguageController>().hasSourceModelDownloadedSuccess =
            false;
        serviceLocator<LanguageController>().hasSourceModelDownloaded = false;
        hasSourceModelDownloaded = false;
        hasSourceModelDownloadedSuccess = false;
        _appDefaultSourceModelAvailabilityStreamController.add(event.$1);
        _appDefaultSourceModelDownloadStreamController.add(event.$2);
      }
    });
    //
    _appDefaultSourceModelAvailabilityStreamController
        .add(LanguageModelStatus.notExists);
    _appDefaultSourceModelDownloadStreamController
        .add(LanguageDownloadStatus.downloading);
    //
    Stream<LanguageModelStatus> lookUpAppSourceModel =
        startLookUpAppSourceModel();

    //use AsyncGenerator
    lookUpAppSourceModel.listen((LanguageModelStatus value) {
      print('Value lookUpAppSourceModel: $value');
      _appDefaultSourceModelAvailabilityStreamController.add(value);
    });

    await _doInit();
  }

  void dispose() {
    _languageIdentifier.close();
    _onDeviceTranslator.close();
    _appDefaultSourceModelAvailabilityStreamController.close();
    _appDefaultSourceModelDownloadStreamController.close();
    _newSourceModelDownloadStreamController.close();
  }

  ///SET APP LANGUAGE
  set setDelayTime(int delayTime) {
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
    /*if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<SaveTranslationObject>(boxName);
    }*/

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

  Future<String> _executeTranslate(String text,
      {bool cache = true,
      TranslateLanguage? startingLanguage,
      TranslateLanguage? targetLanguage,
      bool returnJSON = false}) async {
    //CACHE CHECK
    await _doInit();
    Box<dynamic> dbHive = Hive.box(boxName);
    if (_clearCache) {
      await dbHive.deleteAll(dbHive.keys);
      _clearCache = false;
    }
    SaveTranslationObject result = SaveTranslationObject(
        appLanguage: startingLanguage ?? _sourceLanguage,
        userLanguage: targetLanguage ?? _targetLanguage,
        startText: text);
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
    //await TranslateApi.instance.isolateManagerSourceModelDownload.sendMessage(hasDownloaded);
    return hasDownloaded;
  }

  Future<bool> downloadTargetModel() async {
    log('Downloading model (${_targetLanguage.name})...');
    final bool hasDownloaded = await _modelManager
        .downloadModel(_targetLanguage.bcpCode, isWifiRequired: false);
    hasTargetModelDownloadedSuccess = hasDownloaded;

    return hasDownloaded;
  }

  Future<bool> downloadNewSourceModel(
      TranslateLanguage newTranslateLanguage) async {
    log('Downloading model (${newTranslateLanguage.name})...');
    final bool hasDownloaded = await _modelManager
        .downloadModel(newTranslateLanguage.bcpCode, isWifiRequired: false);
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

  Future<bool> deleteExistingSourceModel(
      TranslateLanguage existingTranslateLanguage) async {
    log('Deleting model (${existingTranslateLanguage.name})...');
    final bool hasDeleted =
        await _modelManager.deleteModel(existingTranslateLanguage.bcpCode);
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

  Future<bool> isTranslateModelDownloaded(
      TranslateLanguage translateLanguage) async {
    log('Checking if model (${translateLanguage.name}) is downloaded...');
    final bool hasDownloaded =
        await _modelManager.isModelDownloaded(translateLanguage.bcpCode);
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

  Future<String> _translateText(String text) async {
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

  Future<String> _translate(String input) async {
    final translatedMap = _translations[input];
    if (translatedMap != null) {
      final result = await _translateText(input);
      return result;
    } else {
      return input;
    }
  }

  final IsolateManager<bool> isolateManagerSourceModelDownload =
      IsolateManager.createOwnIsolate(
    concurrent: 2,
    isolateSourceModelDownloadedFunction,
    isDebug: true,
    workerName: 'sourceModelDownloadedFunction',
  );

  final IsolateManager<bool> isolateManagerTargetModelDownload =
      IsolateManager.createOwnIsolate(
    concurrent: 2,
    isolateTargetModelDownloadedFunction,
    isDebug: true,
    workerName: 'targetModelDownloadedFunction',
  );

  /*final IsolateManager<bool> isolateManagerNewSourceModelDownload =
      IsolateManager.createOwnIsolate(
    concurrent: 2,
    isolateSourceModelDownloadedFunction,
    isDebug: true,
    workerName: 'newSourceModelDownloadedFunction',
  );*/

  final IsolateManager<bool> isolateManagerNewTranslateModelDownload =
      IsolateManager.createOwnIsolate(
    concurrent: 2,
    isolateNewTranslateModelDownloadedFunction,
    isDebug: true,
    workerName: 'newTranslateModelDownloadedFunction',
  );

  void stopSourceModelDownload() {
    isolateManagerSourceModelDownload.stop();
  }

  void stopTargetModelDownload() {
    isolateManagerTargetModelDownload.stop();
  }

  void stopNewTranslateModelDownload() {
    isolateManagerNewTranslateModelDownload.stop();
  }

  Future<void> startSourceModelDownload() async {
    await isolateManagerSourceModelDownload.start();
    await isolateManagerSourceModelDownload.sendMessage(sourceLanguage);
  }

  Future<void> startTargetModelDownload() async {
    await isolateManagerTargetModelDownload.start();
    await isolateManagerSourceModelDownload.sendMessage(targetLanguage);
  }

  Future<void> startNewTranslateModelDownload(
      TranslateLanguage newTranslateLanguage) async {
    await isolateManagerNewTranslateModelDownload.start();
    await isolateManagerNewTranslateModelDownload
        .sendMessage(newTranslateLanguage);
  }

  Stream<LanguageModelStatus> startLookUpAppSourceModel() async* {
    log('Translate Api - startLookUpAppSourceModel');
    yield* Stream.periodic(const Duration(seconds: 5), (_) {
      return isSourceModelDownloaded();
    }).asyncMap((event) async => await event).map((hasDownloaded) {
      if (hasDownloaded) {
        log('Translate Api - startLookUpAppSourceModel if');
        hasSourceModelDownloaded = true;
        //_appDefaultSourceModelAvailabilityStreamController.add(LanguageModelStatus.exists);
        return LanguageModelStatus.exists;
      } else {
        log('Translate Api - startLookUpAppSourceModel else');
        hasSourceModelDownloaded = false;
        //_appDefaultSourceModelAvailabilityStreamController.add(LanguageModelStatus.notExists);
        return LanguageModelStatus.notExists;
      }
    });
  }

  Stream<(LanguageModelStatus, LanguageDownloadStatus)>
      hasSourceTranslateLanguageDownload() async* {
    // _appDefaultSourceModelAvailabilityStreamController.add(LanguageModelStatus.notExists);
    log('Translate Api - hasSourceTranslateLanguageDownload - else ');

    log('Translate Api - hasSourceTranslateLanguageDownload - else start download');
    downloadStreamController.add(
        (LanguageModelStatus.notExists, LanguageDownloadStatus.downloading));
    // Listen downloading
    TranslateApi.instance.isolateManagerSourceModelDownload.onMessage.listen(
      (status) {
        log('Translate Api - hasSourceTranslateLanguageDownload - else start status - ${status}');
        if (status) {
          log('Translate Api - hasSourceTranslateLanguageDownload - else start status - if');
          downloadStreamController.add(
              (LanguageModelStatus.exists, LanguageDownloadStatus.downloaded));
        } else {
          log('Translate Api - hasSourceTranslateLanguageDownload - else start status - else');
          downloadStreamController.add((
            LanguageModelStatus.notExists,
            LanguageDownloadStatus.downloadingFailed
          ));
        }
      },
      onError: (e) {
        log('Translate Api - hasSourceTranslateLanguageDownload - else start error $e');
        downloadStreamController
            .add((LanguageModelStatus.notExists, LanguageDownloadStatus.error));
      },
      onDone: () {
        log('Translate Api - hasSourceTranslateLanguageDownload - else start done');
        downloadStreamController.add(
            (LanguageModelStatus.exists, LanguageDownloadStatus.downloaded));
        //TranslateApi.instance.stopSourceModelDownload();
      },
    );
    log('Translate Api - hasSourceTranslateLanguageDownload - outside');
    yield* downloadStreamController.stream.map((event) => event);
  }

  Future<void> hasTargetTranslateLanguageDownload() async {
    //_newSourceModelDownloadStreamController
    final bool hasDownloaded =
        await TranslateApi.instance.isTargetModelDownloaded();
    if (hasDownloaded) {
      return;
    } else {
      // Start downloading
      await TranslateApi.instance.startTargetModelDownload();
      // Listen downloading
/*      TranslateApi.instance
          .isolateManagerTargetModelDownload
          .onMessage
          .listen(
        (status) {
          if (status) {
            serviceLocator<LanguageController>()
                .hasTargetModelDownloadedSuccess = true;
            serviceLocator<LanguageController>().hasTargetModelDownloaded =
                true;
          } else {
            serviceLocator<LanguageController>()
                .hasTargetModelDownloadedSuccess = false;
            serviceLocator<LanguageController>().hasTargetModelDownloaded =
                false;
          }
          TranslateApi.instance.stopTargetModelDownload();
        },
        onError: (e) {
          serviceLocator<LanguageController>().hasTargetModelDownloadedSuccess =
              false;
          serviceLocator<LanguageController>().hasTargetModelDownloaded = false;
          TranslateApi.instance.stopTargetModelDownload();
        },
        onDone: () {
          TranslateApi.instance.stopTargetModelDownload();
        },

      );*/
    }
  }

  Future<void> newTargetTranslateLanguageDownload(
      TranslateLanguage newTranslateLanguage, Language language) async {
    if (!await TranslateApi.instance.isTranslateModelDownloaded(
      newTranslateLanguage,
    )) {
      // Start downloading
      await TranslateApi.instance.startNewTranslateModelDownload(
        newTranslateLanguage,
      );
      _newSourceModelDownloadStreamController
          .add(NewLanguageDownloadStatus.downloading);
      TranslateApi.instance.isolateManagerNewTranslateModelDownload.onMessage
          .listen(
        (status) {
          if (status) {
            // Save user selected language into local db
            _newSourceModelDownloadStreamController
                .add(NewLanguageDownloadStatus.downloaded);
          } else {
            _newSourceModelDownloadStreamController
                .add(NewLanguageDownloadStatus.notDownloaded);
          }
        },
        onDone: () {
          //TranslateApi.instance.stopNewTranslateModelDownload();
        },
        onError: (er) {
          _newSourceModelDownloadStreamController
              .add(NewLanguageDownloadStatus.error);
          TranslateApi.instance.stopNewTranslateModelDownload();
        },
      );
    } else {
      _newSourceModelDownloadStreamController
          .add(NewLanguageDownloadStatus.downloaded);
    }
  }
}

@pragma('vm:entry-point')
void isolateSourceModelDownloadedFunction(dynamic params) {
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
  final channel = IsolateManagerController<bool>(params);
  channel.onIsolateMessage.listen((message) async {
    // Do more stuff here
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
    final bool hasSourceModelDownloaded = await TranslateApi
        .instance.modelManager
        .downloadModel(TranslateApi.instance.sourceLanguage.bcpCode,
            isWifiRequired: false);
    TranslateApi.instance.hasSourceModelDownloadedSuccess =
        hasSourceModelDownloaded;
    //final bool hasSourceModelDownloaded = await TranslateApi.instance.downloadSourceModel();
    // Send the result to your [onMessage] stream
    log('isolateSourceModelDownloadedFunction ${hasSourceModelDownloaded}');
    channel.sendResult(hasSourceModelDownloaded);
  });
}

@pragma('vm:entry-point')
void isolateTargetModelDownloadedFunction(dynamic params) {
  final channel = IsolateManagerController<bool>(params);
  channel.onIsolateMessage.listen((message) async {
    // Do more stuff here
    final bool hasTargetModelDownloaded =
        await TranslateApi.instance.downloadTargetModel();
    // Send the result to your [onMessage] stream
    channel.sendResult(hasTargetModelDownloaded);
  });
}

@pragma('vm:entry-point')
void isolateNewTranslateModelDownloadedFunction(dynamic params) {
  final channel = IsolateManagerController<bool>(params);
  channel.onIsolateMessage.listen((message) async {
    // Do more stuff here
    final bool hasNewTargetModelDownloaded = await TranslateApi.instance
        .downloadNewSourceModel(message as TranslateLanguage);
    // Send the result to your [onMessage] stream
    channel.sendResult(hasNewTargetModelDownloaded);
  });
}

/// Extension on String to Translate the String.
extension Translate on String {
  /// Method that actually translates
  /// the String
  /// This method takes no time when calling it with the default Locale
  /// because then it just returns the String you called it on
  Future<String> tr() async {
    if (TranslateApi.instance.activeLocale ==
        TranslateApi.instance.defaultLocation) {
      return Future.value(this);
    } else {
      return Future.value(await TranslateApi.instance.translate(this));
    }
  }
}
