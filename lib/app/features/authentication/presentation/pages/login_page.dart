import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:homemakers_merchant/base/widget_view.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/auto_locale_builder.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/translate_api.dart';
import 'package:homemakers_merchant/config/translation/widgets/constants.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/shared/widgets/app/activity_indicator.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:isolate_manager/isolate_manager.dart';

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
  final _sourceLanguage = TranslateLanguage.english;
  final _targetLanguage = TranslateLanguage.hindi;
  late final _onDeviceTranslator = OnDeviceTranslator(
    sourceLanguage: _sourceLanguage,
    targetLanguage: _targetLanguage,
  );

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    _listenSourceLanguageDownload();
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
      this,
    );
  }

  Future<void> _downloadTargetModel() async {
    Toast().show(
      'Downloading model (${_targetLanguage.name})...',
      // TODO(prasant): Set isWifiRequired: false.
      _modelManager
          .downloadModel(_targetLanguage.bcpCode)
          .then((value) => value ? 'success' : 'failed'),
      context,
      this,
    );
  }

  Future<void> _deleteSourceModel() async {
    Toast().show(
      'Deleting model (${_sourceLanguage.name})...',
      _modelManager
          .deleteModel(_sourceLanguage.bcpCode)
          .then((value) => value ? 'success' : 'failed'),
      context,
      this,
    );
  }

  Future<void> _deleteTargetModel() async {
    Toast().show(
      'Deleting model (${_targetLanguage.name})...',
      _modelManager
          .deleteModel(_targetLanguage.bcpCode)
          .then((value) => value ? 'success' : 'failed'),
      context,
      this,
    );
  }

  Future<void> _isSourceModelDownloaded() async {
    Toast().show(
      'Checking if model (${_sourceLanguage.name}) is downloaded...',
      _modelManager
          .isModelDownloaded(_sourceLanguage.bcpCode)
          .then((value) => value ? 'downloaded' : 'not downloaded'),
      context,
      this,
    );
  }

  Future<void> _isTargetModelDownloaded() async {
    Toast().show(
      'Checking if model (${_targetLanguage.name}) is downloaded...',
      _modelManager
          .isModelDownloaded(_targetLanguage.bcpCode)
          .then((value) => value ? 'downloaded' : 'not downloaded'),
      context,
      this,
    );
  }

  Future<void> _translateText() async {
    FocusScope.of(context).unfocus();
    final result = await _onDeviceTranslator.translateText(_controller1.text);
    setState(() {
      _translatedText = result;
    });
  }

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (context) {
        return ListenableBuilder(
          listenable: serviceLocator<LanguageController>(),
          builder: (context, child) {
            return AutoLocalBuilder(
              text: ['Choose Preferred Language'],
              //translationWorker: serviceLocator<LanguageController>(),
              builder: (languageController) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        languageController.get('Choose Preferred Language'),
                      ),
                      const SizedBox(height: 16),
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: GlobalApp.defaultLanguages.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () async {
                              // Check has target language downloaded?
                              // If false, download new language
                              if (!await serviceLocator<TranslateApi>()
                                  .isTranslateModelDownloaded(
                                GlobalApp
                                    .defaultLanguages[index].sourceLanguage,
                              )) {
                                await serviceLocator<TranslateApi>()
                                    .newTargetTranslateLanguageDownload(
                                  GlobalApp
                                      .defaultLanguages[index].sourceLanguage,
                                  GlobalApp.defaultLanguages[index],
                                );
                                serviceLocator<TranslateApi>()
                                    .newSourceModelDownloadStream
                                    .listen(
                                  (event) {
                                    if (event
                                        case NewLanguageDownloadStatus
                                            .downloading) {
                                      log('New language downloading');
                                      Toast().showLoadingIndicator(
                                        context,
                                        'While we are downloading your default app language...',
                                      );
                                    } else if (event
                                        case NewLanguageDownloadStatus
                                            .downloaded) {
                                      log('New language downloaded');
                                      languageController
                                        ..setLanguage(
                                            GlobalApp.defaultLanguages[index])
                                        // Switch source and target language
                                        ..switchCurrentSourceAndTargetLanguage();
                                      Toast().show(
                                        'New language Downloaded',
                                        Future.value(''),
                                        context,
                                        this,
                                      );
                                    } else if (event
                                        case NewLanguageDownloadStatus
                                            .notDownloaded) {
                                      log('New language downloaded failed');
                                      Toast().show(
                                        'Downloading failed',
                                        Future.value(''),
                                        context,
                                        this,
                                      );
                                    }
                                  },
                                  onError: (Object e,
                                      [StackTrace? stackTrace]) {
                                    //
                                    log('New language downloaded error $e');
                                    Toast().show(
                                      'Downloading failed, something went wrong. Try again',
                                      Future.value(''),
                                      context,
                                      this,
                                    );
                                  },
                                  onDone: () {
                                    log('New language downloaded or failed');
                                  },
                                );
                              } else {
                                languageController
                                  ..setLanguage(
                                      GlobalApp.defaultLanguages[index])
                                  // Switch source and target language
                                  ..switchCurrentSourceAndTargetLanguage();
                              }
                              // Close bottom sheet
                              Future.delayed(
                                const Duration(milliseconds: 300),
                                () {},
                              ).then((value) => Navigator.of(context).pop());
                            },
                            leading: ClipOval(
                              child:
                                  GlobalApp.defaultLanguages[index].image.svg(
                                height: 32.0,
                                width: 32.0,
                              ),
                            ),
                            title: Text(GlobalApp.defaultLanguages[index].text),
                            trailing: GlobalApp.defaultLanguages[index] ==
                                    languageController.language
                                ? Icon(
                                    Icons.check_circle_rounded,
                                    color: Theme.of(context).primaryColorLight,
                                  )
                                : null,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: GlobalApp.defaultLanguages[index] ==
                                      languageController.language
                                  ? BorderSide(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      width: 1.5,
                                    )
                                  : BorderSide(color: Colors.grey[300]!),
                            ),
                            tileColor: GlobalApp.defaultLanguages[index] ==
                                    languageController.language
                                ? Theme.of(context)
                                    .primaryColorLight
                                    .withOpacity(0.05)
                                : null,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 16.0);
                        },
                      )
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _listenSourceLanguageDownload() {
    serviceLocator<TranslateApi>()
        .isolateManagerSourceModelDownload
        .onMessage
        .listen(
      (status) {
        if (status) {
          serviceLocator<LanguageController>().hasSourceModelDownloadedSuccess =
              status;
          serviceLocator<LanguageController>().hasSourceModelDownloaded =
              status;
          if (status) {
            // Show dialog for success
          } else {
            // Show dialog for error
          }
        }
      },
      onError: (e) {
        serviceLocator<LanguageController>().hasSourceModelDownloadedSuccess =
            false;
        serviceLocator<LanguageController>().hasSourceModelDownloaded = false;
        serviceLocator<TranslateApi>().stopSourceModelDownload();
        // Show Dialog
      },
      onDone: () {},
    );
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
    final double topPadding = 0; //media.padding.top + kToolbarHeight + margins;
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
      child: ListenableBuilder(
        listenable: serviceLocator<LanguageController>(),
        builder: (context, child) {
          return AutoLocalBuilder(
            text: const [
              'Login',
              'Identify possible languages',
              'Identify Language',
              'Identified Language'
            ],
            //translationWorker: serviceLocator<LanguageController>(),
            builder: (languageController) {
              return PlatformScaffold(
                appBar: PlatformAppBar(
                  title: Text(languageController.get('Login')),
                  trailingActions: [
                    Container(
                      height: 38,
                      width: 55,
                      margin: EdgeInsets.only(right: 8, left: 8),
                      child: Center(
                        child: OutlinedButton(
                          onPressed: () =>
                              state.showLanguageBottomSheet(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            minimumSize: Size(55, 38),
                            foregroundColor: Colors.grey.withOpacity(0.6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 2,
                                child: SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: ClipOval(
                                    child: serviceLocator<LanguageController>()
                                        .language
                                        .image
                                        .svg(
                                          height: 32.0,
                                          width: 32.0,
                                        ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                body: PageBody(
                  controller: state.scrollController,
                  constraints: BoxConstraints(
                    minWidth: double.infinity,
                    minHeight: double.infinity,
                  ),
                  child: ListView(
                    controller: state.scrollController,
                    padding: EdgeInsets.fromLTRB(
                      margins,
                      topPadding,
                      margins,
                      bottomPadding,
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextField(
                          controller: state._controller,
                        ),
                      ),
                      const SizedBox(height: 15),
                      state._identifiedLanguage == ''
                          ? Container()
                          : Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                languageController.get(
                                  'Identified Language: ${state._identifiedLanguage}',
                                ),
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                      PlatformElevatedButton(
                        onPressed: state._identifyLanguage,
                        child: Text(
                          languageController.get('Identify Language'),
                        ),
                      ),
                      const SizedBox(height: 15),
                      PlatformElevatedButton(
                        onPressed: state._identifyPossibleLanguages,
                        child: Text(
                          languageController.get('Identify possible languages'),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state._identifiedLanguages.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              languageController.get(
                                'Language: ${state._identifiedLanguages[index].languageTag}  Confidence: ${state._identifiedLanguages[index].confidence.toString()}',
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Text(
                          'Enter text (source: ${state._sourceLanguage.name})',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                            ),
                          ),
                          child: TextField(
                            controller: state._controller1,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            maxLines: null,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Translated Text (target: ${state._targetLanguage.name})',
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.3,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                            ),
                          ),
                          child: Text(state._translatedText ?? ''),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PlatformElevatedButton(
                            onPressed: state._translateText,
                            child: Text(
                              'Translate',
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: PlatformElevatedButton(
                              onPressed: state._downloadSourceModel,
                              child: Text('Download Source Model'),
                            ),
                          ),
                          Flexible(
                            child: PlatformElevatedButton(
                              onPressed: state._downloadTargetModel,
                              child: Text('Download Target Model'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: PlatformElevatedButton(
                              onPressed: state._deleteSourceModel,
                              child: Text('Delete Source Model'),
                            ),
                          ),
                          Flexible(
                            child: PlatformElevatedButton(
                              onPressed: state._deleteTargetModel,
                              child: Text('Delete Target Model'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: PlatformElevatedButton(
                              onPressed: state._isSourceModelDownloaded,
                              child: Text('Source Downloaded?'),
                            ),
                          ),
                          Flexible(
                            child: PlatformElevatedButton(
                              onPressed: state._isTargetModelDownloaded,
                              child: Text('Target Downloaded?'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
