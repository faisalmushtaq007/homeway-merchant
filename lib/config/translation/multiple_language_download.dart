import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:async/async.dart' show StreamGroup;
import 'package:flutter_background_executor/flutter_background_executor.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:homemakers_merchant/config/translation/language.dart';
import 'package:homemakers_merchant/config/translation/language_service.dart';
import 'package:homemakers_merchant/config/translation/widgets/constants.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

mixin class EnglishLanguage {
  final backgroundEnglishLanguageExecutor = FlutterBackgroundExecutor();
  StreamController<Language> englishLanguageStreamController =
      StreamController<Language>.broadcast();

  Stream<Language> get englishLanguageStream =>
      englishLanguageStreamController.stream;
  bool hasEnglishLanguageDownload = false;
  late final Language englishLanguage;

  Future<void> initEnglishLanguage(Language language) async {
    appLog.d('initEnglishLanguage ${language.sourceLanguage}');
    englishLanguage = language;
  }

  Future<bool> stopEnglishTranslateModelDownload() async {
    appLog.d('stopEnglishTranslateModelDownload');
    final isTaskRunning = await backgroundEnglishLanguageExecutor.isTaskRunning(
      'com.homemakers.merchant.english_language_download.task',
    );
    if (isTaskRunning) {
      final hasStopExecutingTask =
          await backgroundEnglishLanguageExecutor.stopExecutingTask(
        'com.homemakers.merchant.english_language_download.task',
      );
      if (hasStopExecutingTask) {
        return true;
      }
      return false;
    }
    return true;
  }

  Future<void> startEnglishTranslateModelDownload() async {
    appLog.d('startEnglishTranslateModelDownload');
    final result =
        await backgroundEnglishLanguageExecutor.runImmediatelyBackgroundTask(
      callback: immediatelyDownloadEnglishSourceModel,
      cancellable: true,
      withMessages: true,
      taskIdentifier: 'com.homemakers.merchant.english_language_download.task',
    );
  }

  Stream<Language> listenEnglishLanguageDownloadingStream() async* {
    appLog.d('listenEnglishLanguageDownloadingStream');
    final Language newLanguage = englishLanguage.copyWith(
      languageDownloadStatus: LanguageDownloadStatus.downloading,
    );
    englishLanguageStreamController.add(newLanguage);
    backgroundEnglishLanguageExecutor.createConnector().messageStream.listen(
      (status) {
        appLog.d(
            'listenEnglishLanguageDownloadingStream listen status ${status}');
        if (status != null && jsonDecode(status.content) == true) {
          final Language newLanguage = englishLanguage.copyWith(
            languageDownloadStatus: LanguageDownloadStatus.downloaded,
          );
          hasEnglishLanguageDownload = true;
          englishLanguageStreamController.add(newLanguage);
        } else {
          final Language newLanguage = englishLanguage.copyWith(
            languageDownloadStatus: LanguageDownloadStatus.downloadingFailed,
          );
          hasEnglishLanguageDownload = false;
          englishLanguageStreamController.add(newLanguage);
        }
      },
      onError: (e) {
        appLog.d('listenEnglishLanguageDownloadingStream error $e');
        final Language newLanguage = englishLanguage.copyWith(
          languageDownloadStatus: LanguageDownloadStatus.error,
        );
        hasEnglishLanguageDownload = false;
        englishLanguageStreamController.add(newLanguage);
      },
      onDone: () {
        appLog.d('listenEnglishLanguageDownloadingStream done');
        final Language newLanguage = englishLanguage.copyWith(
          languageDownloadStatus: LanguageDownloadStatus.downloaded,
        );
        hasEnglishLanguageDownload = true;
        englishLanguageStreamController.add(newLanguage);
      },
    );
    yield* englishLanguageStreamController.stream.map((event) => event);
  }

  Future<bool> hasEnglishDownload() async {
    return hasEnglishLanguageDownload;
  }
}

mixin class ArabicLanguage {
  final backgroundArabicLanguageExecutor = FlutterBackgroundExecutor();
  StreamController<Language> arabicLanguageStreamController =
      StreamController<Language>.broadcast();

  Stream<Language> get arabicLanguageStream =>
      arabicLanguageStreamController.stream;
  bool hasArabicLanguageDownload = false;
  late final Language arabicLanguage;

  Future<void> initArabicLanguage(Language language) async {
    appLog.d('initArabicLanguage ${language.sourceLanguage}');
    arabicLanguage = language;
  }

  Future<bool> stopArabicTranslateModelDownload() async {
    appLog.d('stopArabicTranslateModelDownload');
    final isTaskRunning = await backgroundArabicLanguageExecutor.isTaskRunning(
      'com.homemakers.merchant.arabic_language_download.task',
    );
    if (isTaskRunning) {
      final hasStopExecutingTask =
          await backgroundArabicLanguageExecutor.stopExecutingTask(
        'com.homemakers.merchant.arabic_language_download.task',
      );
      if (hasStopExecutingTask) {
        return true;
      }
      return false;
    }
    return true;
  }

  Future<void> startArabicTranslateModelDownload() async {
    appLog.d('startArabicTranslateModelDownload');
    final result =
        await backgroundArabicLanguageExecutor.runImmediatelyBackgroundTask(
      callback: immediatelyDownloadArabicSourceModel,
      cancellable: true,
      withMessages: true,
      taskIdentifier: 'com.homemakers.merchant.arabic_language_download.task',
    );
  }

  Stream<Language> listenArabicLanguageDownloadingStream() async* {
    appLog.d('listenArabicLanguageDownloadingStream');
    final Language newLanguage = arabicLanguage.copyWith(
      languageDownloadStatus: LanguageDownloadStatus.downloading,
    );
    arabicLanguageStreamController.add(newLanguage);
    backgroundArabicLanguageExecutor.createConnector().messageStream.listen(
      (status) {
        appLog.d(
            'listenArabicLanguageDownloadingStream listen status ${jsonDecode(status.content)}');
        if (status != null && jsonDecode(status.content) == true) {
          final Language newLanguage = arabicLanguage.copyWith(
            languageDownloadStatus: LanguageDownloadStatus.downloaded,
          );
          hasArabicLanguageDownload = true;
          arabicLanguageStreamController.add(newLanguage);
        } else {
          final Language newLanguage = arabicLanguage.copyWith(
            languageDownloadStatus: LanguageDownloadStatus.downloadingFailed,
          );
          hasArabicLanguageDownload = false;
          arabicLanguageStreamController.add(newLanguage);
        }
      },
      onError: (e) {
        appLog.d('listenArabicLanguageDownloadingStream  error $e');
        final Language newLanguage = arabicLanguage.copyWith(
          languageDownloadStatus: LanguageDownloadStatus.error,
        );
        hasArabicLanguageDownload = false;
        arabicLanguageStreamController.add(newLanguage);
      },
      onDone: () {
        appLog.d('listenArabicLanguageDownloadingStream done');
        final Language newLanguage = arabicLanguage.copyWith(
          languageDownloadStatus: LanguageDownloadStatus.downloaded,
        );
        hasArabicLanguageDownload = true;
        arabicLanguageStreamController.add(newLanguage);
      },
    );
    yield* arabicLanguageStreamController.stream.map((event) => event);
  }

  Future<bool> hasArabicDownload() async {
    return hasArabicLanguageDownload;
  }
}

class MultipleLanguageDownload with EnglishLanguage, ArabicLanguage {
  factory MultipleLanguageDownload({
    required ILanguageService languageService,
    required String boxName,
  }) {
    _instance.languageService = languageService;
    _instance.boxName = boxName;
    return _instance;
  }

  MultipleLanguageDownload._privateConstructor();

  static final MultipleLanguageDownload _instance =
      MultipleLanguageDownload._privateConstructor();

  static MultipleLanguageDownload get instance => _instance;
  late final ILanguageService languageService;
  late final String boxName;
  final OnDeviceTranslatorModelManager modelManager =
      OnDeviceTranslatorModelManager();
  late OnDeviceTranslator onDeviceTranslator;

  List<Language> appLanguagesStatus = [];
  Map<TranslateLanguage, LanguageDownloadStatus> mapOfTranslateLanguage = {};

  // All languages
  StreamController<Map<TranslateLanguage, Language>>
      allLanguageSteamController =
      StreamController<Map<TranslateLanguage, Language>>.broadcast();

  Stream<Map<TranslateLanguage, Language>> get allLanguageSteam =>
      allLanguageSteamController.stream;

  // Init
  Future<void> init() async {
    appLanguagesStatus =
        List<Language>.from(GlobalApp.defaultLanguages.toList());
    await loadLanguages();
    return;
  }

  Future<void> loadLanguages() async {
    appLanguagesStatus.asMap().forEach((key, value) async {
      appLog.d('loadLanguages: iterate ${key} ${value.sourceLanguage}');
      // Compare english language
      if (value.sourceLanguage == TranslateLanguage.english) {
        appLog.d('loadLanguages: ${value.sourceLanguage} block');
        await initEnglishLanguage(value);
        mapOfTranslateLanguage = {
          TranslateLanguage.english: LanguageDownloadStatus.downloading,
        };
        // download english language
        await startEnglishTranslateModelDownload();
        // Listen english language
        final Stream<Language> englishLanguage =
            listenEnglishLanguageDownloadingStream();
        englishLanguage.listen((event) {
          appLog.d(
              'englishLanguage listen ${event.sourceLanguage}-${event.languageDownloadStatus}');
          allLanguageSteamController.add({TranslateLanguage.english: event});
          mapOfTranslateLanguage = {
            TranslateLanguage.english: event.languageDownloadStatus,
          };
        });
      }
      // Compare arabic language
      else if (value.sourceLanguage == TranslateLanguage.arabic) {
        appLog.d('loadLanguages: ${value.sourceLanguage} block');
        await initArabicLanguage(value);
        mapOfTranslateLanguage = {
          TranslateLanguage.arabic: LanguageDownloadStatus.downloading,
        };
        // download arabic language
        await startArabicTranslateModelDownload();
        // Listen arabic language
        final Stream<Language> arabicLanguage =
            listenArabicLanguageDownloadingStream();
        arabicLanguage.listen((event) {
          appLog.d(
              'arabicLanguage listen ${event.sourceLanguage}-${event.languageDownloadStatus}');
          allLanguageSteamController.add({TranslateLanguage.arabic: event});
          mapOfTranslateLanguage = {
            TranslateLanguage.arabic: event.languageDownloadStatus,
          };
        });
      }
    });
  }

  Future<bool> hasLanguageModelDownloaded({
    required TranslateLanguage sourceLanguage,
  }) async {
    final bool hasDownloaded = await MultipleLanguageDownload
        .instance.modelManager
        .isModelDownloaded(sourceLanguage.bcpCode);

    return hasDownloaded;
  }

  void dispose() {
    onDeviceTranslator.close();
  }
}

@pragma('vm:entry-point')
Future<void> immediatelyDownloadEnglishSourceModel(
  EngineConnector? connector,
) async {
  final bool hasEnglishSourceModelDownloaded = await MultipleLanguageDownload
      .instance.modelManager
      .downloadModel(TranslateLanguage.english.bcpCode, isWifiRequired: false);
  //TranslateApi.instance.hasSourceModelDownloadedSuccess = hasSourceModelDownloaded;
  final result = await connector?.messageSender(
    to: Tasks.mainApplication,
    message: jsonEncode(hasEnglishSourceModelDownloaded),
  );
  if (result != true) {
    return;
  }
}

@pragma('vm:entry-point')
Future<void> immediatelyDownloadArabicSourceModel(
  EngineConnector? connector,
) async {
  final bool hasArabicSourceModelDownloaded = await MultipleLanguageDownload
      .instance.modelManager
      .downloadModel(TranslateLanguage.arabic.bcpCode, isWifiRequired: false);
  //TranslateApi.instance.hasSourceModelDownloadedSuccess = hasSourceModelDownloaded;
  final result = await connector?.messageSender(
    to: Tasks.mainApplication,
    message: jsonEncode(hasArabicSourceModelDownloaded),
  );
  if (result != true) {
    return;
  }
}
