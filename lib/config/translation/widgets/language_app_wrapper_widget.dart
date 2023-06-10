import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/translate_api.dart';
import 'package:homemakers_merchant/config/translation/widgets/constants.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_inherited_widget.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_screen_wrapper.dart';
import 'package:homemakers_merchant/core/mixins/lifecycle_mixin.dart';
import 'package:homemakers_merchant/shared/widgets/universal/multi_stream_builder/stream_builder_3.dart';
import 'package:homemakers_merchant/shared/widgets/universal/multi_stream_builder/stream_builder_4.dart';
import 'package:provider/provider.dart';

///[LanguageyAppWrapper] is a StatelessWidget.
typedef LanguageWidgetBuilder = Widget Function(
  BuildContext context,
  LanguageModelStatus sourceLanguageModelStatus,
  LanguageDownloadStatus sourceLanguageDownloadStatus,
  LanguageDownloadStatus newLanguageDownloadStatus,
  (
    LanguageModelStatus,
    LanguageDownloadStatus
  ) secondarySourceLanguageDownloadStatus,
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
    return StreamBuilder4<
        LanguageModelStatus,
        LanguageDownloadStatus,
        (LanguageModelStatus, LanguageDownloadStatus),
        (LanguageModelStatus, LanguageDownloadStatus)>(
      streams: StreamTuple4(
        TranslateApi.instance.appSourceModelStream,
        TranslateApi.instance.appDefaultSourceModelDownloadStream,
        TranslateApi.instance.targetLanguageModelDownloadStream,
        TranslateApi.instance.secondaryLanguageModelDownloadStream,
      ),
      initialData: InitialDataTuple4(
        LanguageModelStatus.notExists,
        LanguageDownloadStatus.downloading,
        (LanguageModelStatus.notExists, LanguageDownloadStatus.notDownloaded),
        (LanguageModelStatus.notExists, LanguageDownloadStatus.notDownloaded),
      ),
      builder: (context, snapshots) {
        final child = widget.builder(
          context,
          snapshots.snapshot1.data ?? LanguageModelStatus.notExists,
          snapshots.snapshot2.data ?? LanguageDownloadStatus.downloading,
          snapshots.snapshot3.data?.$2 ?? LanguageDownloadStatus.notDownloaded,
          snapshots.snapshot4.data ??
              (
                LanguageModelStatus.notExists,
                LanguageDownloadStatus.notDownloaded
              ),
        );
        return LanguageInheritedWidget(
          isConnected: true,
          sourceModelStatus:
              snapshots.snapshot1.data ?? LanguageModelStatus.notExists,
          sourceLanguageDownloadStatus:
              snapshots.snapshot2.data ?? LanguageDownloadStatus.downloading,
          newSourceLanguageDownloadStatus: snapshots.snapshot3.data?.$2 ??
              LanguageDownloadStatus.notDownloaded,
          secondarySourceLanguageDownloadStatus: snapshots.snapshot4.data ??
              (
                LanguageModelStatus.notExists,
                LanguageDownloadStatus.notDownloaded
              ),
          child: LanguageScreenWrapper(child: child),
        );
      },
    );
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }

  @override
  void onResume() {
    // TODO: implement onResume
  }
}
