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
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/main_development.dart';
import 'package:synchronized/synchronized.dart';
import 'package:isolate_manager/isolate_manager.dart';
import 'package:flutter_background_executor/flutter_background_executor.dart';

class AutoLocalizationException implements Exception {
  AutoLocalizationException(this.cause);
  String cause;
}

typedef IdentifiedLanguageTypeDef = void Function(String language);
typedef IdentifiedPossibleLanguageTypeDef = void Function(
  List<IdentifiedLanguage> languages,
  String language,
);

class TranslateApi {
  factory TranslateApi({
    required ILanguageService languageService,
    required String boxName,
  }) {
    _instance.languageService = languageService;
    _instance.boxName = boxName;
    return _instance;
  }

  TranslateApi._privateConstructor();
  static final TranslateApi _instance = TranslateApi._privateConstructor();

  static TranslateApi get instance => _instance;

  final backgroundSourceLanguageExecutor = FlutterBackgroundExecutor();
  final backgroundTargetLanguageExecutor = FlutterBackgroundExecutor();
  final backgroundNewLanguageExecutor = FlutterBackgroundExecutor();
//
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
  var _sourceLanguage = GlobalApp.defaultSourceTranslateLanguage;

  TranslateLanguage get sourceLanguage => _sourceLanguage;

  set sourceLanguage(TranslateLanguage value) {
    _sourceLanguage = value;
  }

  var _targetLanguage = GlobalApp.defaultSourceTranslateLanguage;

  TranslateLanguage get targetLanguage => _targetLanguage;

  set targetLanguage(TranslateLanguage value) {
    _sourceLanguage = value;
  }

  late final _onDeviceTranslator = OnDeviceTranslator(
    sourceLanguage: _sourceLanguage,
    targetLanguage: _targetLanguage,
  );

  bool _isInitialized = false;
  bool _clearCache = false;

  ///This parameter control the time between every request so you don't exceed the maximum amount of request. If you don't know what you are doing don't change it!
  int _delayTime = 300;

  int get delayTime => _delayTime;
  final Lock _lock = Lock();

  /// The Active Locale at the Moment while
  /// the String is translated
  Locale _activeLocale = const Locale('en');

  /// Getter for the Active Locale at the Moment while
  /// the String is translated
  Locale get activeLocale => _activeLocale;

  /// The Default Locale, the Language in which
  /// you write your Text / Strings in the Code
  final Locale _defaultLocale = Locale('en');

  /// The Default Locale, the Language in which
  /// you write your Text / Strings in the Code.
  /// This is hidden behind a getter because you have to
  /// set it in the [init] method and can't change it later
  Locale get defaultLocation => _defaultLocale;

  /// The Map with the Translations. From this map the HashMap is created
  static final Map<String, String> _translationsMap = {};

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

  late StreamSubscription<LanguageModelStatus> sourceModelStreamSubscription;

  late StreamSubscription<(LanguageModelStatus, LanguageDownloadStatus)>
      sourceModelDownloadingStreamSubscription;

  //
  StreamController<(LanguageModelStatus, LanguageDownloadStatus)>
      targetLanguageModelStreamController = StreamController<
          (LanguageModelStatus, LanguageDownloadStatus)>.broadcast();

  Stream<(LanguageModelStatus, LanguageDownloadStatus)>
      get targetLanguageModelDownloadStream =>
          targetLanguageModelStreamController.stream;

  late StreamSubscription<(LanguageModelStatus, LanguageDownloadStatus)>
      targetLanguageModelDownloadingStreamSubscription;
  // Secondary or Target
  StreamController<(LanguageModelStatus, LanguageDownloadStatus)>
      secondaryLanguageModelStreamController = StreamController<
          (LanguageModelStatus, LanguageDownloadStatus)>.broadcast();

  Stream<(LanguageModelStatus, LanguageDownloadStatus)>
      get secondaryLanguageModelDownloadStream =>
          secondaryLanguageModelStreamController.stream;

  late StreamSubscription<(LanguageModelStatus, LanguageDownloadStatus)>
      secondaryLanguageModelDownloadingStreamSubscription;

  // Change locale
  void changeLocale(Locale newLocale) {
    _activeLocale = newLocale;
  }

  Future<void> init({
    TranslateLanguage? sourceLanguage,
    TranslateLanguage? targetLanguage,
    int? delayTime,
  }) async {
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
    //await TranslateApi.instance.startSourceModelDownload();

    // Listen stream till it has contains LanguageModelStatus.exists && LanguageDownloadStatus.downloaded
    final Stream<(LanguageModelStatus, LanguageDownloadStatus)>
        sourceTranslateDownloadStream = listenSourceTranslateLanguageDownload();
    //

    sourceTranslateDownloadStream.listen((event) {
      if (event
          case (
            LanguageModelStatus.exists,
            LanguageDownloadStatus.downloaded
          )) {
        _appDefaultSourceModelAvailabilityStreamController.add(event.$1);
        _appDefaultSourceModelDownloadStreamController.add(event.$2);
      } else if (event
          case (
            LanguageModelStatus.notExists,
            LanguageDownloadStatus.downloadingFailed
          )) {
        _appDefaultSourceModelAvailabilityStreamController.add(event.$1);
        _appDefaultSourceModelDownloadStreamController.add(event.$2);
      } else if (event
          case (
            LanguageModelStatus.notExists,
            LanguageDownloadStatus.downloading
          )) {
        _appDefaultSourceModelAvailabilityStreamController.add(event.$1);
        _appDefaultSourceModelDownloadStreamController.add(event.$2);
      } else if (event
          case (LanguageModelStatus.notExists, LanguageDownloadStatus.error)) {
        _appDefaultSourceModelAvailabilityStreamController.add(event.$1);
        _appDefaultSourceModelDownloadStreamController.add(event.$2);
      }
    });
    // Secondary language download
    //await TranslateApi.instance.startTargetModelDownload();

    // Listen stream till it has contains LanguageModelStatus.exists && LanguageDownloadStatus.downloaded
    final Stream<(LanguageModelStatus, LanguageDownloadStatus)>
        secondarySourceLanguageTranslateDownloadStream =
        listenSecondaryTranslateLanguageDownload();

    secondarySourceLanguageTranslateDownloadStream.listen((event) {
      if (event
          case (
            LanguageModelStatus.exists,
            LanguageDownloadStatus.downloaded
          )) {
        serviceLocator<LanguageController>().hasTargetModelDownloadedSuccess =
            true;
        serviceLocator<LanguageController>().hasTargetModelDownloaded = true;
      } else if (event
          case (
            LanguageModelStatus.notExists,
            LanguageDownloadStatus.downloadingFailed
          )) {
        serviceLocator<LanguageController>().hasTargetModelDownloadedSuccess =
            false;
        serviceLocator<LanguageController>().hasTargetModelDownloaded = false;
      } else if (event
          case (
            LanguageModelStatus.notExists,
            LanguageDownloadStatus.downloading
          )) {
        serviceLocator<LanguageController>().hasTargetModelDownloadedSuccess =
            false;
        serviceLocator<LanguageController>().hasTargetModelDownloaded = false;
      } else if (event
          case (LanguageModelStatus.notExists, LanguageDownloadStatus.error)) {
        serviceLocator<LanguageController>().hasTargetModelDownloadedSuccess =
            false;
        serviceLocator<LanguageController>().hasTargetModelDownloaded = false;
      }
    });
    //
    _appDefaultSourceModelAvailabilityStreamController
        .add(LanguageModelStatus.notExists);
    _appDefaultSourceModelDownloadStreamController
        .add(LanguageDownloadStatus.downloading);

    // lookUpAppSourceModel after interval
    Stream<LanguageModelStatus> lookUpAppSourceModel =
        startLookUpAppSourceModel();
    lookUpAppSourceModel.listen((LanguageModelStatus value) {
      log('Value lookUpAppSourceModel: $value');
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
    sourceModelStreamSubscription.cancel();
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
    SaveTranslationObject result = SaveTranslationObject(
      appLanguage: startingLanguage ?? _sourceLanguage,
      userLanguage: targetLanguage ?? _targetLanguage,
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
  Future<String> translate(
    String text, {
    bool cache = true,
    TranslateLanguage? startingLanguage,
    TranslateLanguage? targetLanguage,
    bool returnJSON = false,
  }) async {
    final result = await _lock.synchronized(() async {
      final executeTranslate = await _executeTranslate(
        text,
        cache: cache,
        startingLanguage: startingLanguage,
        targetLanguage: targetLanguage,
        returnJSON: returnJSON,
      );
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
    final bool hasDownloaded = await _modelManager
        .downloadModel(_sourceLanguage.bcpCode, isWifiRequired: false);
    //await TranslateApi.instance.isolateManagerSourceModelDownload.sendMessage(hasDownloaded);
    return hasDownloaded;
  }

  Future<bool> downloadTargetModel() async {
    final bool hasDownloaded = await _modelManager
        .downloadModel(_targetLanguage.bcpCode, isWifiRequired: false);

    return hasDownloaded;
  }

  Future<bool> downloadNewSourceModel(
    TranslateLanguage newTranslateLanguage,
  ) async {
    final bool hasDownloaded = await _modelManager
        .downloadModel(newTranslateLanguage.bcpCode, isWifiRequired: false);
    return hasDownloaded;
  }

  Future<bool> deleteSourceModel() async {
    final bool hasDeleted =
        await _modelManager.deleteModel(_sourceLanguage.bcpCode);

    return hasDeleted;
  }

  Future<bool> deleteTargetModel() async {
    final bool hasDeleted =
        await _modelManager.deleteModel(_targetLanguage.bcpCode);

    return hasDeleted;
  }

  Future<bool> deleteExistingSourceModel(
    TranslateLanguage existingTranslateLanguage,
  ) async {
    final bool hasDeleted =
        await _modelManager.deleteModel(existingTranslateLanguage.bcpCode);
    return hasDeleted;
  }

  Future<bool> isSourceModelDownloaded() async {
    final bool hasDownloaded =
        await _modelManager.isModelDownloaded(_sourceLanguage.bcpCode);

    return hasDownloaded;
  }

  Future<bool> isTargetModelDownloaded() async {
    final bool hasDownloaded =
        await _modelManager.isModelDownloaded(_targetLanguage.bcpCode);

    return hasDownloaded;
  }

  Future<bool> isTranslateModelDownloaded(
    TranslateLanguage translateLanguage,
  ) async {
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

  void updateSourceAndTargetLanguage({
    TranslateLanguage? newSourceLanguage,
    required TranslateLanguage newTargetLanguage,
    String currentText = '',
  }) {
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
    //isolateManagerSourceModelDownload.stop();
    TranslateApi.instance.backgroundSourceLanguageExecutor.stopExecutingTask(
      'com.homemakers.merchant.source_language_download.task',
    );
  }

  void stopTargetModelDownload() {
    isolateManagerTargetModelDownload.stop();
  }

  void stopNewTranslateModelDownload() {
    //isolateManagerNewTranslateModelDownload.stop();
    TranslateApi.instance.backgroundTargetLanguageExecutor.stopExecutingTask(
      'com.homemakers.merchant.target_language_download.task',
    );
  }

  Future<void> startSourceModelDownload() async {
    //await isolateManagerSourceModelDownload.start();
    //await isolateManagerSourceModelDownload.sendMessage(sourceLanguage);
    final result = await TranslateApi.instance.backgroundSourceLanguageExecutor
        .runImmediatelyBackgroundTask(
      callback: immediatelyDownloadSourceModel,
      cancellable: true,
      withMessages: true,
      taskIdentifier: 'com.homemakers.merchant.source_language_download.task',
    );
  }

  Future<void> startTargetModelDownload() async {
    //await isolateManagerTargetModelDownload.start();
    //await isolateManagerSourceModelDownload.sendMessage(targetLanguage);
    final result = await TranslateApi.instance.backgroundTargetLanguageExecutor
        .runImmediatelyBackgroundTask(
      callback: immediatelyDownloadSecondarySourceModel,
      cancellable: true,
      withMessages: true,
      taskIdentifier: 'com.homemakers.merchant.target_language_download.task',
    );
  }

  Future<void> startNewTranslateModelDownload(
    TranslateLanguage newTranslateLanguage,
    Language language,
  ) async {
    //await isolateManagerNewTranslateModelDownload.start();
    //await isolateManagerNewTranslateModelDownload.sendMessage(newTranslateLanguage);
    final result = await TranslateApi.instance.backgroundNewLanguageExecutor
        .runImmediatelyBackgroundTask(
      callback: immediatelyDownloadNewTargetLanguageModel,
      cancellable: true,
      withMessages: true,
      taskIdentifier: 'com.homemakers.merchant.new_language_download.task',
    )
        .whenComplete(() async {
      var inputResult = await FlutterBackgroundExecutor()
          .createConnector(currentTaskIdentifier: Tasks.mainApplication)
          .messageSender(
            message: jsonEncode(newTranslateLanguage.name),
            to: 'com.homemakers.merchant.new_language_download.task',
          );
    });

    var newLanguageDownloadingStream = newTargetTranslateLanguageDownload(
      newTranslateLanguage,
      language,
    );
    newLanguageDownloadingStream.listen((event) {});
  }

  Stream<LanguageModelStatus> startLookUpAppSourceModel() async* {
    yield* Stream.periodic(const Duration(seconds: 5), (_) {
      return isSourceModelDownloaded();
    }).asyncMap((event) async => await event).map((hasDownloaded) {
      if (hasDownloaded) {
        //_appDefaultSourceModelAvailabilityStreamController.add(LanguageModelStatus.exists);
        return LanguageModelStatus.exists;
      } else {
        //_appDefaultSourceModelAvailabilityStreamController.add(LanguageModelStatus.notExists);
        return LanguageModelStatus.notExists;
      }
    });
  }

  Stream<(LanguageModelStatus, LanguageDownloadStatus)>
      listenSourceTranslateLanguageDownload() async* {
    // _appDefaultSourceModelAvailabilityStreamController.add(LanguageModelStatus.notExists);
    downloadStreamController.add(
      (LanguageModelStatus.notExists, LanguageDownloadStatus.downloading),
    );
    // Listen downloading
    TranslateApi.instance.backgroundSourceLanguageExecutor
        .createConnector()
        .messageStream
        .listen(
      (status) {
        if (status != null && jsonDecode(status.content) == true) {
          downloadStreamController.add(
            (LanguageModelStatus.exists, LanguageDownloadStatus.downloaded),
          );
        } else {
          downloadStreamController.add(
            (
              LanguageModelStatus.notExists,
              LanguageDownloadStatus.downloadingFailed
            ),
          );
        }
      },
      onError: (e) {
        downloadStreamController
            .add((LanguageModelStatus.notExists, LanguageDownloadStatus.error));
      },
      onDone: () {
        downloadStreamController.add(
          (LanguageModelStatus.exists, LanguageDownloadStatus.downloaded),
        );
        //TranslateApi.instance.stopSourceModelDownload();
      },
    );
    yield* downloadStreamController.stream.map((event) => event);
  }

  Stream<(LanguageModelStatus, LanguageDownloadStatus)>
      listenSecondaryTranslateLanguageDownload() async* {
    //_newSourceModelDownloadStreamController
    //secondaryLanguageModelStreamController
    secondaryLanguageModelStreamController.add(
      (LanguageModelStatus.notExists, LanguageDownloadStatus.downloading),
    );
    // Listen downloading
    TranslateApi.instance.backgroundSourceLanguageExecutor
        .createConnector()
        .messageStream
        .listen(
      (status) {
        if (status != null && jsonDecode(status.content) == true) {
          secondaryLanguageModelStreamController.add(
            (LanguageModelStatus.exists, LanguageDownloadStatus.downloaded),
          );
        } else {
          secondaryLanguageModelStreamController.add(
            (
              LanguageModelStatus.notExists,
              LanguageDownloadStatus.downloadingFailed
            ),
          );
        }
      },
      onError: (e) {
        secondaryLanguageModelStreamController
            .add((LanguageModelStatus.notExists, LanguageDownloadStatus.error));
      },
      onDone: () {
        secondaryLanguageModelStreamController.add(
          (LanguageModelStatus.exists, LanguageDownloadStatus.downloaded),
        );
        //TranslateApi.instance.stopSourceModelDownload();
      },
    );
    yield* secondaryLanguageModelStreamController.stream.map((event) => event);
  }

  Stream<(LanguageModelStatus, LanguageDownloadStatus)>
      newTargetTranslateLanguageDownload(
    TranslateLanguage newTranslateLanguage,
    Language language,
  ) async* {
    // _appDefaultSourceModelAvailabilityStreamController.add(LanguageModelStatus.notExists);
    targetLanguageModelStreamController.add(
      (LanguageModelStatus.notExists, LanguageDownloadStatus.downloading),
    );
    // Listen downloading
    TranslateApi.instance.backgroundNewLanguageExecutor
        .createConnector()
        .messageStream
        .listen(
      (status) {
        if (status != null && jsonDecode(status.content) == true) {
          targetLanguageModelStreamController.add(
            (LanguageModelStatus.exists, LanguageDownloadStatus.downloaded),
          );
        } else {
          targetLanguageModelStreamController.add(
            (
              LanguageModelStatus.notExists,
              LanguageDownloadStatus.downloadingFailed
            ),
          );
        }
      },
      onError: (e) {
        downloadStreamController
            .add((LanguageModelStatus.notExists, LanguageDownloadStatus.error));
      },
      onDone: () {
        downloadStreamController.add(
          (LanguageModelStatus.exists, LanguageDownloadStatus.downloaded),
        );
        //TranslateApi.instance.stopSourceModelDownload();
      },
    );
    yield* targetLanguageModelStreamController.stream.map((event) => event);
  }
}

@pragma('vm:entry-point')
void isolateSourceModelDownloadedFunction(dynamic params) {
  final channel = IsolateManagerController<bool>(params);
  channel.onIsolateMessage.listen((message) async {
    // Do more stuff here
    final bool hasSourceModelDownloaded =
        await TranslateApi.instance.modelManager.downloadModel(
      TranslateApi.instance.sourceLanguage.bcpCode,
      isWifiRequired: false,
    );
    //final bool hasSourceModelDownloaded = await TranslateApi.instance.downloadSourceModel();
    // Send the result to your [onMessage] stream
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

@pragma('vm:entry-point')
Future<void> immediatelyDownloadSourceModel(EngineConnector? connector) async {
  final bool hasSourceModelDownloaded =
      await TranslateApi.instance.modelManager.downloadModel(
    TranslateApi.instance.sourceLanguage.bcpCode,
    isWifiRequired: false,
  );
  //TranslateApi.instance.hasSourceModelDownloadedSuccess = hasSourceModelDownloaded;
  final result = await connector?.messageSender(
    to: Tasks.mainApplication,
    message: jsonEncode(hasSourceModelDownloaded),
  );
  if (result != true) {
    return;
  }
}

@pragma('vm:entry-point')
Future<void> immediatelyDownloadSecondarySourceModel(
  EngineConnector? connector,
) async {
  final bool hasSecondarySourceModelDownloaded =
      await TranslateApi.instance.modelManager.downloadModel(
    TranslateApi.instance.targetLanguage.bcpCode,
    isWifiRequired: false,
  );
  //TranslateApi.instance.hasSourceModelDownloadedSuccess = hasSourceModelDownloaded;
  final result = await connector?.messageSender(
    to: Tasks.mainApplication,
    message: jsonEncode(hasSecondarySourceModelDownloaded),
  );
  if (result != true) {
    return;
  }
}

@pragma('vm:entry-point')
Future<void> immediatelyDownloadNewTargetLanguageModel(
  EngineConnector? connector,
) async {
  bool? hasResult;

  connector?.messageStream.listen((event) async {
    final bool hasNewSourceModelDownloaded =
        await TranslateApi.instance.modelManager.downloadModel(
      TranslateLanguage.values.byName(jsonDecode(event.content)).bcpCode,
      isWifiRequired: false,
    );
    //TranslateApi.instance.hasSourceModelDownloadedSuccess = hasSourceModelDownloaded;
    final result = await connector?.messageSender(
      to: Tasks.mainApplication,
      message: jsonEncode(hasNewSourceModelDownloaded),
    );
    hasResult = result;
    if (result != true) {
      return;
    }
  });
  if (hasResult != true) {
    return;
  }
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
