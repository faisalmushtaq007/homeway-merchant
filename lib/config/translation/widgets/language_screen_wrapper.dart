import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:homemakers_merchant/base/app_base.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';
import 'package:homemakers_merchant/config/translation/auto_locale_builder.dart';
import 'package:homemakers_merchant/config/translation/widgets/constants.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_inherited_widget.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/mixins/lifecycle_mixin.dart';
import 'package:provider/provider.dart';

enum PositionOnScreen {
  TOP,
  BOTTOM,
}

class LanguageScreenWrapper extends StatefulWidget
    with GetItStatefulWidgetMixin {
  LanguageScreenWrapper({
    super.key,
    this.child,
    this.color,
    this.decoration,
    this.message,
    this.messageStyle,
    this.height,
    this.textAlign,
    this.duration,
    this.positionOnScreen = PositionOnScreen.TOP,
    this.disableInteraction = false,
    this.disableWidget,
  }) : assert(
            color == null || decoration == null,
            'Cannot provide both a color and a decoration\n'
            'The color argument is just a shorthand for "decoration: new BoxDecoration(color: color)".');

  /// The [child] contained by the ConnectivityScreenWrapper.
  final Widget? child;

  /// The decoration to paint behind the [child].
  final Decoration? decoration;

  /// The color to paint behind the [child].
  final Color? color;

  /// Disconnected message.
  final String? message;

  /// If non-null, the style to use for this text.
  final TextStyle? messageStyle;

  /// widget height.
  final double? height;

  /// How to align the offline widget.
  final PositionOnScreen positionOnScreen;

  /// How to align the offline widget.
  final Duration? duration;

  /// Disable the user interaction with child widget
  final bool disableInteraction;

  /// Disable the user interaction with child widget
  final Widget? disableWidget;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  @override
  State<LanguageScreenWrapper> createState() => _LanguageScreenWrapperState();
}

class _LanguageScreenWrapperState extends State<LanguageScreenWrapper>
    with LifecycleMixin, GetItStateMixin {
  @override
  Widget build(BuildContext context) {
    // hasNotDownloaded
    final bool hasNotDownloaded =
        LanguageInheritedWidget.of(context)?.sourceModelStatus !=
                (LanguageModelStatus.exists) ||
            LanguageInheritedWidget.of(context)?.sourceModelStatus !=
                (LanguageModelStatus.downloaded);
    // sourceModelNotStartDownload
    final bool sourceModelNotStartDownload =
        LanguageInheritedWidget.of(context)?.sourceLanguageDownloadStatus !=
            LanguageDownloadStatus.downloaded;
    // newSourceModelNotStartDownload
    final bool newSourceModelNotStartDownload =
        LanguageInheritedWidget.of(context)?.newSourceLanguageDownloadStatus !=
                NewLanguageDownloadStatus.downloaded ||
            LanguageInheritedWidget.of(context)
                    ?.newSourceLanguageDownloadStatus !=
                NewLanguageDownloadStatus.exists;
    final bool secondarySourceLanguageDownload =
        LanguageInheritedWidget.of(context)
                ?.secondarySourceLanguageDownloadStatus !=
            (LanguageModelStatus.exists, LanguageDownloadStatus.downloaded);
    //
    log('LanguageInheritedWidget.of(context)?.sourceModelStatus - ${LanguageInheritedWidget.of(context)?.sourceModelStatus}');
    log('LanguageInheritedWidget.of(context)?.sourceLanguageDownloadStatus - ${LanguageInheritedWidget.of(context)?.sourceLanguageDownloadStatus}');
    log('LanguageInheritedWidget.of(context)?.newSourceLanguageDownloadStatus ${LanguageInheritedWidget.of(context)?.newSourceLanguageDownloadStatus}');
    log('LanguageInheritedWidget.of(context)?.secondarySourceLanguageDownloadStatus ${LanguageInheritedWidget.of(context)?.secondarySourceLanguageDownloadStatus}');
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    double height = this.widget.height ?? defaultHeight;
    log('message ${hasNotDownloaded}, ${sourceModelNotStartDownload}, ${newSourceModelNotStartDownload}');
    final Widget offlineWidget = AnimatedPositioned(
      top: widget.positionOnScreen.top(height, hasNotDownloaded),
      bottom: widget.positionOnScreen.bottom(height, hasNotDownloaded),
      duration: widget.duration ?? const Duration(milliseconds: 300),
      child: AnimatedContainer(
        height: height,
        width: MediaQuery.of(context).size.width,
        decoration: widget.decoration ??
            BoxDecoration(color: widget.color ?? Colors.red.shade500),
        margin:
            EdgeInsets.only(top: media.padding.top + kToolbarHeight + margins),
        duration: widget.duration ?? const Duration(milliseconds: 300),
        child: Center(
          child: Text(
            widget.message ?? disconnectedMessage,
            style: widget.messageStyle ?? defaultMessageStyle,
            textAlign: widget.textAlign,
          ),
        ),
      ),
    );

    return AbsorbPointer(
      absorbing: (widget.disableInteraction && hasNotDownloaded),
      child: AutoLocalBuilder(
        text: ['Language Screen Wrapper'],
        builder: (languageController) {
          return AutoDirection(
            text: languageController.get('Language Screen Wrapper'),
            child: Stack(
              children: [
                if (widget.child != null) widget.child!,
                if (widget.disableInteraction && hasNotDownloaded)
                  if (widget.disableWidget != null) widget.disableWidget!,
                offlineWidget,
              ],
            ),
          );
        },
      ),
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
