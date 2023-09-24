import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/app_translator.dart';
import 'package:homemakers_merchant/config/translation/language.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/multiple_language_download.dart';
import 'package:homemakers_merchant/config/translation/translate_api.dart';
import 'package:homemakers_merchant/config/translation/widgets/constants.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_inherited_widget.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_screen_wrapper.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/mixins/lifecycle_mixin.dart';
import 'package:homemakers_merchant/shared/widgets/universal/multi_stream_builder/stream_builder_2.dart';
import 'package:homemakers_merchant/shared/widgets/universal/multi_stream_builder/stream_builder_3.dart';
import 'package:homemakers_merchant/shared/widgets/universal/multi_stream_builder/stream_builder_4.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:provider/provider.dart';

///[LanguageyAppWrapper] is a StatelessWidget.
typedef LanguageWidgetBuilder = Widget Function(
  BuildContext context,
  Map<TranslateLanguage, Language> allLanguages,
  Map<TranslateLanguage, Language> arabicLanguage,
);

class LanguageAppWrapper extends StatefulWidget with GetItStatefulWidgetMixin {
  LanguageAppWrapper({required this.builder, super.key});

  final LanguageWidgetBuilder builder;

  @override
  State<LanguageAppWrapper> createState() => _LanguageAppWrapperState();
}

class _LanguageAppWrapperState extends State<LanguageAppWrapper>
    with GetItStateMixin, LifecycleMixin {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder2<Map<TranslateLanguage, Language>,
        Map<TranslateLanguage, Language>>(
      streams: StreamTuple2(
          MultipleLanguageDownload.instance.allLanguageSteam
              .map((event) => event),
          MultipleLanguageDownload.instance.allLanguageSteam
              .map((event) => event)
              .where(
                (event) => event.containsKey(TranslateLanguage.arabic),
              )),
      initialData: InitialDataTuple2({
        TranslateLanguage.english: GlobalApp.defaultLanguages[0],
      }, {
        TranslateLanguage.arabic: GlobalApp.defaultLanguages[1],
      }),
      builder: (context, snapshots) {
        final child = widget.builder(
            context,
            snapshots.snapshot1.data ??
                {
                  TranslateLanguage.english: GlobalApp.defaultLanguages[0],
                },
            snapshots.snapshot2.data ??
                {
                  TranslateLanguage.arabic: GlobalApp.defaultLanguages[1],
                });
        return LanguageInheritedWidget(
          isConnected: true,
          allLanguageModelStatus: snapshots.snapshot1.data ??
              {
                TranslateLanguage.english: GlobalApp.defaultLanguages[0],
              },
          arabicLanguage: snapshots.snapshot2.data ??
              snapshots.snapshot2.data ??
              {
                TranslateLanguage.arabic: GlobalApp.defaultLanguages[1],
              },
          child: LanguageScreenWrapper(child: child),
        );
      },
    );
  }

  @override
  void onPause() {
    // TODO(prasant): implement onPause
  }

  @override
  void onResume() {
    // TODO(prasant): implement onResume
  }
}
