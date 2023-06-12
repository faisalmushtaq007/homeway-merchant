import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:homemakers_merchant/base/app_base.dart';
import 'package:homemakers_merchant/bootup/bootstrap.dart';
import 'package:homemakers_merchant/config/translation/auto_locale_builder.dart';
import 'package:homemakers_merchant/config/translation/language.dart';
import 'package:homemakers_merchant/config/translation/widgets/constants.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_inherited_widget.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/mixins/lifecycle_mixin.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
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
    LanguageInheritedWidget.of(context)
        ?.allLanguageModelStatus
        .entries
        .forEach((element) {
      appLog.d(
          'LanguageInheritedWidget.of(context)?.sourceModelStatus - ${element.key}-${element.value.languageDownloadStatus}');
    });
    LanguageInheritedWidget.of(context)
        ?.arabicLanguage
        .entries
        .forEach((element) {
      appLog.d(
          'LanguageInheritedWidget.of(context)?.sourceModelStatus - ${element.key}-${element.value.languageDownloadStatus}');
    });
    final bool hasAtleastSourceLanguage = LanguageInheritedWidget.of(context)
            ?.allLanguageModelStatus
            .entries
            .any((element) {
          if (element.value.languageDownloadStatus !=
              LanguageDownloadStatus.downloaded) {
            return true;
          }
          return false;
        }) ??
        false;
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    double height = this.widget.height ?? defaultHeight;

    final Widget offlineWidget = AnimatedPositioned(
      top: widget.positionOnScreen.top(height, hasAtleastSourceLanguage),
      bottom: widget.positionOnScreen.bottom(height, hasAtleastSourceLanguage),
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
      absorbing: (hasAtleastSourceLanguage),
      child: AutoLocalBuilder(
        text: ['Language Screen Wrapper'],
        builder: (languageController) {
          return AutoDirection(
            text: languageController.get('Language Screen Wrapper'),
            child: Stack(
              children: [
                if (widget.child != null) widget.child!,
                if (hasAtleastSourceLanguage) offlineWidget,
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
