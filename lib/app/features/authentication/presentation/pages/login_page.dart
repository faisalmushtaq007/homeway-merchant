import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homemakers_merchant/base/widget_view.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/shared/widgets/app/activity_indicator.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageController createState() => _LoginPageController();
}

class _LoginPageController extends State<LoginPage> {
  late final ScrollController scrollController;
  List<IdentifiedLanguage> _identifiedLanguages = <IdentifiedLanguage>[];
  final _languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
  var _identifiedLanguage = '';
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();
  String? _translatedText;
  final _modelManager = OnDeviceTranslatorModelManager();
  final _sourceLanguage = TranslateLanguage.arabic;
  final _targetLanguage = TranslateLanguage.hindi;
  late final _onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: _sourceLanguage, targetLanguage: _targetLanguage);
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    _languageIdentifier.close();
    _onDeviceTranslator.close();
    super.dispose();
  }

  Future<void> _identifyLanguage() async {
    if (_controller.text == '') return;
    String language;
    try {
      language = await _languageIdentifier.identifyLanguage(_controller.text);
    } on PlatformException catch (pe) {
      if (pe.code == _languageIdentifier.undeterminedLanguageCode) {
        language = 'error: no language identified!';
      }
      language = 'error: ${pe.code}: ${pe.message}';
    } catch (e) {
      language = 'error: ${e.toString()}';
    }
    setState(() {
      _identifiedLanguage = language;
    });
  }

  Future<void> _identifyPossibleLanguages() async {
    if (_controller.text == '') return;
    String error;
    try {
      final possibleLanguages =
          await _languageIdentifier.identifyPossibleLanguages(_controller.text);
      setState(() {
        _identifiedLanguages = possibleLanguages;
      });
      return;
    } on PlatformException catch (pe) {
      if (pe.code == _languageIdentifier.undeterminedLanguageCode) {
        error = 'error: no languages identified!';
      }
      error = 'error: ${pe.code}: ${pe.message}';
    } catch (e) {
      error = 'error: ${e.toString()}';
    }
    setState(() {
      _identifiedLanguages = [];
      _identifiedLanguage = error;
    });
  }

  Future<void> _downloadSourceModel() async {
    Toast().show(
        'Downloading model (${_sourceLanguage.name})...',
        // TODO(prasant): Set isWifiRequired: false.
        _modelManager
            .downloadModel(_sourceLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _downloadTargetModel() async {
    Toast().show(
        'Downloading model (${_targetLanguage.name})...',
        // TODO(prasant): Set isWifiRequired: false.
        _modelManager
            .downloadModel(_targetLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _deleteSourceModel() async {
    Toast().show(
        'Deleting model (${_sourceLanguage.name})...',
        _modelManager
            .deleteModel(_sourceLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _deleteTargetModel() async {
    Toast().show(
        'Deleting model (${_targetLanguage.name})...',
        _modelManager
            .deleteModel(_targetLanguage.bcpCode)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _isSourceModelDownloaded() async {
    Toast().show(
        'Checking if model (${_sourceLanguage.name}) is downloaded...',
        _modelManager
            .isModelDownloaded(_sourceLanguage.bcpCode)
            .then((value) => value ? 'downloaded' : 'not downloaded'),
        context,
        this);
  }

  Future<void> _isTargetModelDownloaded() async {
    Toast().show(
        'Checking if model (${_targetLanguage.name}) is downloaded...',
        _modelManager
            .isModelDownloaded(_targetLanguage.bcpCode)
            .then((value) => value ? 'downloaded' : 'not downloaded'),
        context,
        this);
  }

  Future<void> _translateText() async {
    FocusScope.of(context).unfocus();
    final result = await _onDeviceTranslator.translateText(_controller1.text);
    setState(() {
      _translatedText = result;
    });
  }

  @override
  Widget build(BuildContext context) => _LoginPageView(this);
}

class _LoginPageView extends WidgetView<LoginPage, _LoginPageController> {
  const _LoginPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = media.padding.top + kToolbarHeight + margins;
    final double bottomPadding = media.padding.bottom + margins;
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final bool isDark = theme.brightness == Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: PageBody(
          controller: state.scrollController,
          child: ListView(
            controller: state.scrollController,
            padding: EdgeInsets.fromLTRB(
                margins, topPadding, margins, bottomPadding),
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: state._controller,
                ),
              ),
              SizedBox(height: 15),
              state._identifiedLanguage == ''
                  ? Container()
                  : Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Identified Language: ${state._identifiedLanguage}',
                        style: TextStyle(fontSize: 20),
                      )),
              ElevatedButton(
                  onPressed: state._identifyLanguage,
                  child: const Text('Identify Language')),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: state._identifyPossibleLanguages,
                child: const Text('Identify possible languages'),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: state._identifiedLanguages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          'Language: ${state._identifiedLanguages[index].languageTag}  Confidence: ${state._identifiedLanguages[index].confidence.toString()}'),
                    );
                  }),
              SizedBox(height: 30),
              Center(
                  child: Text(
                      'Enter text (source: ${state._sourceLanguage.name})')),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(
                    width: 2,
                  )),
                  child: TextField(
                    controller: state._controller1,
                    decoration: InputDecoration(border: InputBorder.none),
                    maxLines: null,
                  ),
                ),
              ),
              Center(
                  child: Text(
                      'Translated Text (target: ${state._targetLanguage.name})')),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 2,
                    )),
                    child: Text(state._translatedText ?? '')),
              ),
              SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                    onPressed: state._translateText, child: Text('Translate'))
              ]),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                      onPressed: state._downloadSourceModel,
                      child: Text('Download Source Model')),
                  ElevatedButton(
                      onPressed: state._downloadTargetModel,
                      child: Text('Download Target Model')),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                      onPressed: state._deleteSourceModel,
                      child: Text('Delete Source Model')),
                  ElevatedButton(
                      onPressed: state._deleteTargetModel,
                      child: Text('Delete Target Model')),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                      onPressed: state._isSourceModelDownloaded,
                      child: Text('Source Downloaded?')),
                  ElevatedButton(
                      onPressed: state._isTargetModelDownloaded,
                      child: Text('Target Downloaded?')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
