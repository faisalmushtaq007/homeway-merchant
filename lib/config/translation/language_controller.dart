import 'dart:async';

//import 'dart:collection' show HashMap;
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/app_translator.dart';
import 'package:homemakers_merchant/config/translation/language.dart';
import 'package:homemakers_merchant/config/translation/language_service.dart';
import 'package:homemakers_merchant/config/translation/translate_api.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

import '../../utils/app_log.dart';

class LanguageController with ChangeNotifier {
  LanguageController(this._languageService);

  final ILanguageService _languageService;
  List<IdentifiedLanguage> _identifiedLanguages = <IdentifiedLanguage>[];
  final _languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
  var _identifiedLanguage = '';
  String? _translatedText;
  final _modelManager = OnDeviceTranslatorModelManager();
  var _sourceLanguage = GlobalApp.defaultSourceTranslateLanguage;
  var _targetLanguage = GlobalApp.defaultTargetTranslateLanguage;
  late final _onDeviceTranslator = OnDeviceTranslator(
    sourceLanguage: _sourceLanguage,
    targetLanguage: _targetLanguage,
  );
  bool hasSourceModelDownloaded = false;
  bool hasTargetModelDownloaded = false;
  bool hasSourceModelDeleted = false;
  bool hasTargetModelDeleted = false;
  bool hasSourceModelDownloadedSuccess = false;
  bool hasTargetModelDownloadedSuccess = false;
  final Locale _activeAppLocale = const Locale('en');

  Locale get activeLocale => _activeAppLocale;
  final Locale _defaultLocale = const Locale('en');

  Locale get defaultAppLocale => _defaultLocale;

  final List<String> _translation = [];
  final Map<String, String> _translated = {};
  double _percentage = 0.0;

  //late final HashMap<String, String> _translations = HashMap.from(_translated);

  double get percentage => _percentage;

  List<String> get startingTexts => _translation;

  String get(String key) => _translated[key]!;

  String getById(int id) => _translated[_translated.keys.elementAt(id)]!;

  Future<void> loadAll() async {
    _sourceAppLanguage = await _languageService.load<Language>(
      GlobalApp.keyLanguage,
      GlobalApp.defaultLanguageSelect,
    );
    _targetAppLanguage = await _languageService.load<Language>(
      GlobalApp.keyTargetAppLanguage,
      GlobalApp.defaultTargetLanguageSelect,
    );
    // _sourceTranslateLanguage
    _sourceTranslateLanguage = await _languageService.load<TranslateLanguage>(
      GlobalApp.keySourceTranslateLanguage,
      GlobalApp.defaultSourceTranslateLanguage,
    );
    // _targetTranslateLanguage
    _targetTranslateLanguage = await _languageService.load<TranslateLanguage>(
      GlobalApp.keyTargetTranslateLanguage,
      GlobalApp.defaultTargetTranslateLanguage,
    );
    _sourceLocale = await _languageService.load<Locale>(
      GlobalApp.keySourceLocale,
      GlobalApp.defaultSourceLocale,
    );
    _targetLocale = await _languageService.load<Locale>(
      GlobalApp.keyTargetLocale,
      GlobalApp.defaultTargetLocale,
    );
  }

  @override
  void dispose() {
    _languageIdentifier.close();
    _onDeviceTranslator.close();
    super.dispose();
  }

  Future<void> resetAllToDefaults({
    /// If false, theme mode & scheme index are not reset.
    bool resetMode = true,
    // If false, notifyListeners is not called.
    bool doNotify = true,
  }) async {
    setLanguage(GlobalApp.defaultLanguageSelect, false);
    setTargetLanguage(GlobalApp.defaultTargetLanguageSelect, false);
    setSourceTranslateLanguage(GlobalApp.defaultSourceTranslateLanguage, false);
    setTargetTranslateLanguage(GlobalApp.defaultTargetTranslateLanguage, false);
    setTargetLocale(GlobalApp.defaultTargetLocale, false);
    setSourceLocale(GlobalApp.defaultSourceLocale, false);
    // Only notify at end, if asked to do so, to do so is default.
    if (doNotify) notifyListeners();
  }

  Future<void> identifyLanguage(String text) async {
    await AppTranslator.instance.identifyLanguage(text, (String language) {
      _identifiedLanguage = language;
      notifyListeners();
    });
    return;
  }

  Future<void> identifyPossibleLanguages(String text) async {
    if (text == '') return;
    String error;
    await AppTranslator.instance.identifyPossibleLanguages(text,
        (List<IdentifiedLanguage> possibleLanguages, String language) {
      if (language.isNotEmpty) {
        _identifiedLanguage = language;
      }
      _identifiedLanguages = possibleLanguages;
      notifyListeners();
    });
    return;
  }

/*  Future<bool> downloadSourceModel() async {
    log('Downloading model (${_sourceLanguage.name})...');
    final bool hasDownloaded =
        await AppTranslator.instance.downloadSourceModel();
    hasSourceModelDownloadedSuccess = hasDownloaded;
    notifyListeners();
    return hasDownloaded;
  }

  Future<bool> downloadTargetModel() async {
    log('Downloading model (${_targetLanguage.name})...');
    final bool hasDownloaded =
        await AppTranslator.instance.downloadTargetModel();
    hasTargetModelDownloadedSuccess = hasDownloaded;
    notifyListeners();
    return hasDownloaded;
  }

  Future<bool> deleteSourceModel() async {
    log('Deleting model (${_sourceLanguage.name})...');
    final bool hasDeleted = await AppTranslator.instance.deleteSourceModel();
    hasSourceModelDeleted = hasDeleted;
    notifyListeners();
    return hasDeleted;
  }

  Future<bool> deleteTargetModel() async {
    log('Deleting model (${_targetLanguage.name})...');
    final bool hasDeleted = await AppTranslator.instance.deleteTargetModel();
    hasTargetModelDeleted = hasDeleted;
    notifyListeners();
    return hasDeleted;
  }

  Future<bool> isSourceModelDownloaded() async {
    log('Checking if model (${_sourceLanguage.name}) is downloaded...');
    final bool hasDownloaded =
        await AppTranslator.instance.isSourceModelDownloaded();
    hasSourceModelDownloaded = hasDownloaded;
    notifyListeners();
    return hasDownloaded;
  }

  Future<bool> isTargetModelDownloaded() async {
    log('Checking if model (${_targetLanguage.name}) is downloaded...');
    final bool hasDownloaded =
        await AppTranslator.instance.isTargetModelDownloaded();
    hasTargetModelDownloaded = hasDownloaded;
    notifyListeners();
    return hasDownloaded;
  }*/

  Future<void> translateText(String text) async {
    final result = await _onDeviceTranslator.translateText(text);
    _translatedText = result;
  }

  void changeSourceLanguage(TranslateLanguage newSourceLanguage) {
    AppTranslator.instance.changeSourceTranslateLanguage(newSourceLanguage);
    _sourceLanguage = newSourceLanguage;
    notifyListeners();
  }

  void changeTargetLanguage(Language language) {
    AppTranslator.instance.changeTargetTranslateLanguage(language);
    _targetLanguage = language.sourceLanguage;
    setTargetLanguage(language);
    notifyListeners();
  }

  void switchCurrentSourceAndTargetLanguage() {
    final languageRecord =
        AppTranslator.instance.switchCurrentSourceAndTargetLanguage();
    _sourceLanguage = languageRecord.$1;
    _targetLanguage = languageRecord.$2;
    notifyListeners();
  }

  // App Language
  late Language _sourceAppLanguage;

  Language get sourceApplanguage => _sourceAppLanguage;

  void setLanguage(Language value, [bool notify = true]) {
    if (value == _sourceAppLanguage) return;
    _sourceAppLanguage = value;
    if (notify) notifyListeners();
    unawaited(_languageService.save(GlobalApp.keyLanguage, value));
  }

  // Target App Language
  late Language _targetAppLanguage;

  Language get targetAppLanguage => _targetAppLanguage;

  void setTargetLanguage(Language value, [bool notify = true]) {
    if (value == _targetAppLanguage) return;
    _targetAppLanguage = value;
    if (notify) notifyListeners();
    unawaited(_languageService.save(GlobalApp.keyLanguage, value));
  }

  // App Locale
  late Locale _targetLocale;

  Locale get appLocale => _targetLocale;

  void setTargetLocale(Locale value, [bool notify = true]) {
    if (value == _targetLocale) return;
    _targetLocale = value;
    if (notify) notifyListeners();
    unawaited(_languageService.save(GlobalApp.keyTargetLocale, value));
  }

  // User Locale
  late Locale _sourceLocale;

  Locale get userLocale => _targetLocale;

  void setSourceLocale(Locale value, [bool notify = true]) {
    if (value == _sourceLocale) return;
    _sourceLocale = value;
    if (notify) notifyListeners();
    unawaited(_languageService.save(GlobalApp.keySourceLocale, value));
  }

  // Source language
  late TranslateLanguage _sourceTranslateLanguage;

  TranslateLanguage get sourceTranslateLanguage => _sourceTranslateLanguage;

  void setSourceTranslateLanguage(
    TranslateLanguage value, [
    bool notify = true,
  ]) {
    if (value == _sourceTranslateLanguage) return;
    _sourceTranslateLanguage = value;
    if (notify) notifyListeners();
    unawaited(
      _languageService.save(GlobalApp.keySourceTranslateLanguage, value),
    );
  }

  // Target language
  late TranslateLanguage _targetTranslateLanguage;

  TranslateLanguage get targetTranslateLanguage => _targetTranslateLanguage;

  void setTargetTranslateLanguage(
    TranslateLanguage value, [
    bool notify = true,
  ]) {
    if (value == _targetTranslateLanguage) return;
    _targetTranslateLanguage = value;
    if (notify) notifyListeners();
    unawaited(
      _languageService.save(GlobalApp.keyTargetTranslateLanguage, value),
    );
  }

  void set(List<String> translation) {
    this._translation?.addAll(translation);
    appLog.d('Length of _translation ${_translation.length}');
    _translated.addEntries(
      translation
          .where((element) => !_translated.keys.contains(translation))
          .map((e) => MapEntry(e, e)),
    );
  }

  Future<void> run({bool useCache = false}) async {
    if (_translated.isNotEmpty) {
      for (int i = 0; i < _translated.length; i++) {
        _translated[_translated.keys.elementAt(i)] =
            await AppTranslator.instance.translate(
          _translated[_translated.keys.elementAt(i)]!,
          cache: useCache,
        );
        appLog.d('Run ${_translated[_translated.keys.elementAt(i)]}');
        _percentage = i / _translated.length;
        //notifyListeners();
      }
    }
  }
}
