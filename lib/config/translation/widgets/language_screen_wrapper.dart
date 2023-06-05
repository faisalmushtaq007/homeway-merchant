import 'package:flutter/material.dart';
import 'package:homemakers_merchant/base/app_base.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';
import 'package:homemakers_merchant/config/translation/auto_locale_builder.dart';
import 'package:homemakers_merchant/config/translation/widgets/constants.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_inherited_widget.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:provider/provider.dart';

enum PositionOnScreen {
  TOP,
  BOTTOM,
}

class LanguageScreenWrapper extends StatelessWidget {
  const LanguageScreenWrapper({
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
    //
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    double height = this.height ?? defaultHeight;
    log('message ${hasNotDownloaded}, ${sourceModelNotStartDownload}, ${newSourceModelNotStartDownload}');
    final Widget offlineWidget = AnimatedPositioned(
      top: positionOnScreen.top(height, hasNotDownloaded),
      bottom: positionOnScreen.bottom(height, hasNotDownloaded),
      duration: duration ?? const Duration(milliseconds: 300),
      child: AnimatedContainer(
        height: height,
        width: MediaQuery.of(context).size.width,
        decoration:
            decoration ?? BoxDecoration(color: color ?? Colors.red.shade500),
        margin:
            EdgeInsets.only(top: media.padding.top + kToolbarHeight + margins),
        duration: duration ?? const Duration(milliseconds: 300),
        child: Center(
          child: Text(
            message ?? disconnectedMessage,
            style: messageStyle ?? defaultMessageStyle,
            textAlign: textAlign,
          ),
        ),
      ),
    );

    return AbsorbPointer(
      absorbing: (disableInteraction && hasNotDownloaded),
      child: AutoLocalBuilder(
        text: ['Language Screen Wrapper'],
        builder: (languageController) {
          return AutoDirection(
            text: languageController.get('Language Screen Wrapper'),
            child: Stack(
              children: [
                if (child != null) child!,
                if (disableInteraction && hasNotDownloaded)
                  if (disableWidget != null) disableWidget!,
                offlineWidget,
              ],
            ),
          );
        },
      ),
    );
  }
}
