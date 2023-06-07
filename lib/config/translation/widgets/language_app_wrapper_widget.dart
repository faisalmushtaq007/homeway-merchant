import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/translate_api.dart';
import 'package:homemakers_merchant/config/translation/widgets/constants.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_inherited_widget.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_screen_wrapper.dart';
import 'package:homemakers_merchant/core/mixins/lifecycle_mixin.dart';
import 'package:homemakers_merchant/shared/widgets/universal/multi_stream_builder/stream_builder_3.dart';
import 'package:provider/provider.dart';

///[LanguageyAppWrapper] is a StatelessWidget.
typedef LanguageWidgetBuilder = Widget Function(
  BuildContext context,
  LanguageModelStatus sourceLanguageModelStatus,
  LanguageDownloadStatus sourceLanguageDownloadStatus,
  NewLanguageDownloadStatus newLanguageDownloadStatus,
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
    return StreamBuilder3<LanguageModelStatus, LanguageDownloadStatus,
        NewLanguageDownloadStatus>(
      streams: StreamTuple3(
        serviceLocator<TranslateApi>().appSourceModelStream,
        serviceLocator<TranslateApi>().appDefaultSourceModelDownloadStream,
        serviceLocator<TranslateApi>().newSourceModelDownloadStream,
      ),
      initialData: InitialDataTuple3(
        LanguageModelStatus.notExists,
        LanguageDownloadStatus.downloading,
        NewLanguageDownloadStatus.notDownloaded,
      ),
      builder: (context, snapshots) {
        final child = widget.builder(
          context,
          snapshots.snapshot1.data ?? LanguageModelStatus.notExists,
          snapshots.snapshot2.data ?? LanguageDownloadStatus.downloading,
          snapshots.snapshot3.data ?? NewLanguageDownloadStatus.notDownloaded,
        );
        return LanguageInheritedWidget(
          isConnected: true,
          sourceModelStatus:
              snapshots.snapshot1.data ?? LanguageModelStatus.notExists,
          sourceLanguageDownloadStatus:
              snapshots.snapshot2.data ?? LanguageDownloadStatus.downloading,
          newSourceLanguageDownloadStatus: snapshots.snapshot3.data ??
              NewLanguageDownloadStatus.notDownloaded,
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
