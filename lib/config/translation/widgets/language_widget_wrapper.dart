import 'package:flutter/material.dart';
import 'package:homemakers_merchant/config/translation/widgets/constants.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_empty_container.dart';
import 'package:provider/provider.dart';

class LanguageWidgetWrapper extends StatelessWidget {
  /// The [child] contained by the ConnectivityWidgetWrapper.
  final Widget child;

  /// The [offlineWidget] contained by the ConnectivityWidgetWrapper.
  final Widget? offlineWidget;

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

  /// Use Stack or not stacked.
  final bool stacked;

  /// Disable the user interaction with child widget
  final bool disableInteraction;

  /// How to align the offline widget.
  final AlignmentGeometry? alignment;

  const LanguageWidgetWrapper({
    Key? key,
    required this.child,
    this.color,
    this.decoration,
    this.message,
    this.messageStyle,
    this.height,
    this.offlineWidget,
    this.stacked = true,
    this.alignment,
    this.disableInteraction = false,
  })  : assert(
          decoration == null || offlineWidget == null,
          'Cannot provide both a color and a offlineWidget\n',
        ),
        assert(
          height == null || offlineWidget == null,
          'Cannot provide both a height and a offlineWidget\n',
        ),
        assert(
          messageStyle == null || offlineWidget == null,
          'Cannot provide both a messageStyle and a offlineWidget\n',
        ),
        assert(
          message == null || offlineWidget == null,
          'Cannot provide both a message and a offlineWidget\n',
        ),
        assert(
            color == null || decoration == null,
            'Cannot provide both a color and a decoration\n'
            'The color argument is just a shorthand for "decoration: new BoxDecoration(color: color)".'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool hasDownload = Provider.of<bool>(context);
    Widget finalOfflineWidget = Align(
      alignment: alignment ?? Alignment.bottomCenter,
      child: offlineWidget ??
          Container(
            height: height ?? defaultHeight,
            width: MediaQuery.of(context).size.width,
            decoration: decoration ??
                BoxDecoration(color: color ?? Colors.red.shade300),
            child: Center(
              child: Text(
                message ?? disconnectedMessage,
                style: messageStyle ?? defaultMessageStyle,
              ),
            ),
          ),
    );

    if (stacked) {
      return Stack(
        children: (<Widget>[
          child,
          disableInteraction && hasDownload
              ? Column(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        decoration: decoration ??
                            const BoxDecoration(
                              color: Colors.black38,
                            ),
                      ),
                    )
                  ],
                )
              : const EmptyContainer(),
          hasDownload ? finalOfflineWidget : const EmptyContainer(),
        ]),
      );
    }

    return hasDownload ? finalOfflineWidget : child;
  }
}
