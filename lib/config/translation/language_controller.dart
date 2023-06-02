import 'dart:async';
import 'dart:collection' show HashMap;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language.dart';
import 'package:homemakers_merchant/config/translation/language_service.dart';
import 'package:homemakers_merchant/config/translation/translate_api.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/keys/app_key.dart';
import 'package:homemakers_merchant/shared/widgets/app/activity_indicator.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class LanguageController with ChangeNotifier {
  LanguageController(this._languageService);

  final ILanguageService _languageService;
  List<IdentifiedLanguage> _identifiedLanguages = <IdentifiedLanguage>[];
  final _languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
  var _identifiedLanguage = '';
  String? _translatedText;
  final _modelManager = OnDeviceTranslatorModelManager();
  var _sourceLanguage = TranslateLanguage.arabic;
  var _targetLanguage = TranslateLanguage.hindi;
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

  List<String>? _translation = [];
  Map<String, String> _translated = {};
  double _percentage = 0.0;
  late final HashMap<String, String> _translations = HashMap.from(_translated);

  double get percentage => _percentage;
  List<String> get startingTexts => _translation ?? [];

  String get(String key) => _translations[key]!;
  String getById(int id) => _translations[_translations.keys.elementAt(id)]!;

  Future<void> loadAll() async {
    _language = await _languageService.load(
      GlobalApp.keyLanguage,
      GlobalApp.defaultLanguageSelect,
    );
    // _sourceTranslateLanguage
    _sourceTranslateLanguage = await _languageService.load(
      GlobalApp.keySourceTranslateLanguage,
      GlobalApp.defaultSourceTranslateLanguage,
    );
    // _targetTranslateLanguage
    _targetTranslateLanguage = await _languageService.load(
      GlobalApp.keyTargetTranslateLanguage,
      GlobalApp.defaultTargetTranslateLanguage,
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
    setLanguage(GlobalApp.keyLanguage, false);
    setSourceTranslateLanguage(GlobalApp.keySourceTranslateLanguage, false);
    setTargetTranslateLanguage(GlobalApp.keyTargetTranslateLanguage, false);
    // Only notify at end, if asked to do so, to do so is default.
    if (doNotify) notifyListeners();
  }

  Future<void> identifyLanguage(String text) async {
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
    _identifiedLanguage = language;
    notifyListeners();
  }

  Future<void> identifyPossibleLanguages(String text) async {
    if (text == '') return;
    String error;
    try {
      final possibleLanguages =
          await _languageIdentifier.identifyPossibleLanguages(text);

      _identifiedLanguages = possibleLanguages;
      notifyListeners();

      return;
    } on PlatformException catch (pe) {
      if (pe.code == _languageIdentifier.undeterminedLanguageCode) {
        error = 'error: no languages identified!';
      }
      error = 'error: ${pe.code}: ${pe.message}';
    } catch (e) {
      error = 'error: ${e.toString()}';
    }
    _identifiedLanguages = [];
    _identifiedLanguage = error;
    notifyListeners();
  }

  Future<bool> downloadSourceModel() async {
    log('Downloading model (${_sourceLanguage.name})...');
    final bool hasDownloaded = await _modelManager
        .downloadModel(_sourceLanguage.bcpCode, isWifiRequired: false);
    hasSourceModelDownloadedSuccess = hasDownloaded;
    notifyListeners();
    return hasDownloaded;
  }

  Future<bool> downloadTargetModel() async {
    log('Downloading model (${_targetLanguage.name})...');
    final bool hasDownloaded = await _modelManager
        .downloadModel(_targetLanguage.bcpCode, isWifiRequired: false);
    hasTargetModelDownloadedSuccess = hasDownloaded;
    notifyListeners();
    return hasDownloaded;
  }

  Future<bool> deleteSourceModel() async {
    log('Deleting model (${_sourceLanguage.name})...');
    final bool hasDeleted =
        await _modelManager.deleteModel(_sourceLanguage.bcpCode);
    hasSourceModelDeleted = hasDeleted;
    notifyListeners();
    return hasDeleted;
  }

  Future<bool> deleteTargetModel() async {
    log('Deleting model (${_targetLanguage.name})...');
    final bool hasDeleted =
        await _modelManager.deleteModel(_targetLanguage.bcpCode);
    hasTargetModelDeleted = hasDeleted;
    notifyListeners();
    return hasDeleted;
  }

  Future<bool> isSourceModelDownloaded() async {
    log('Checking if model (${_sourceLanguage.name}) is downloaded...');
    final bool hasDownloaded =
        await _modelManager.isModelDownloaded(_sourceLanguage.bcpCode);
    hasSourceModelDownloaded = hasDownloaded;
    notifyListeners();
    return hasDownloaded;
  }

  Future<bool> isTargetModelDownloaded() async {
    log('Checking if model (${_targetLanguage.name}) is downloaded...');
    final bool hasDownloaded =
        await _modelManager.isModelDownloaded(_targetLanguage.bcpCode);
    hasTargetModelDownloaded = hasDownloaded;
    notifyListeners();
    return hasDownloaded;
  }

  Future<void> translateText(String text) async {
    final result = await _onDeviceTranslator.translateText(text);
    _translatedText = result;
  }

  void changeSourceLanguage(TranslateLanguage newSourceLanguage) {
    _sourceLanguage = newSourceLanguage;
    notifyListeners();
  }

  void changeTargetLanguage(TranslateLanguage newTargetLanguage) {
    _targetLanguage = newTargetLanguage;
    notifyListeners();
  }

  void updateSourceAndTargetLanguage({
    required TranslateLanguage newSourceLanguage,
    required TranslateLanguage newTargetLanguage,
  }) {
    _sourceLanguage = newSourceLanguage;
    _targetLanguage = newTargetLanguage;
    notifyListeners();
  }

  void switchCurrentSourceAndTargetLanguage() {
    _sourceLanguage = _targetLanguage;
    _targetLanguage = _sourceLanguage;
    notifyListeners();
  }

  late Language _language;

  Language get language => _language;

  void setLanguage(Language value, [bool notify = true]) {
    if (value == _language) return;
    _language = value;
    if (notify) notifyListeners();
    unawaited(_languageService.save(GlobalApp.keyLanguage, value));
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
    _translations.addEntries(
      translation
          .where((element) => !_translations.keys.contains(translation))
          .map((e) => MapEntry(e, e)),
    );
  }

  Future<void> run({bool useCache = false}) async {
    if (_translations.isNotEmpty) {
      for (int i = 0; i < _translations.length; i++) {
        _translations[_translations.keys.elementAt(i)] =
            await serviceLocator<TranslateApi>().translate(
          _translations[_translations.keys.elementAt(i)]!,
          cache: useCache,
        );
        _percentage = i / _translations.length;
        notifyListeners();
      }
    }
  }
}
