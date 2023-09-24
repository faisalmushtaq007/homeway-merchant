import 'package:flutter/material.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/universal/image_loader/image_helper.dart';
import 'package:homemakers_merchant/utils/image_type.dart';

import '../state/inherited_chat_theme.dart';
import '../state/inherited_l10n.dart';

/// A class that represents send button widget.
class SendButton extends StatelessWidget {
  /// Creates send button widget.
  const SendButton({
    super.key,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
  });

  /// Callback for send button tap event.
  final VoidCallback onPressed;

  /// Padding around the button.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Container(
        margin: InheritedChatTheme.of(context).theme.sendButtonMargin ??
            const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
        child: IconButton(
          constraints: const BoxConstraints(
            minHeight: 24,
            minWidth: 24,
          ),
          icon: LayoutBuilder(
            builder: (context, constraints) {
              return InheritedChatTheme.of(context).theme.sendButtonIcon ??
                  ImageHelper(
                    image: 'assets/image/icon-send.png',
                    filterQuality: FilterQuality.high,
                    borderRadius: BorderRadiusDirectional.circular(10),
                    imageType: findImageType('assets/image/icon-send.png'),
                    imageShape: ImageShape.rectangle,
                    color: context.colorScheme.primary,
                    boxFit: BoxFit.cover,
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    defaultErrorBuilderColor: Colors.blueGrey,
                    errorBuilder: const Icon(
                      Icons.image_not_supported,
                      size: 10000,
                    ),
                    loaderBuilder: const CircularProgressIndicator(),
                  );
            },
          ),
          onPressed: onPressed,
          padding: padding,
          splashRadius: 24,
          tooltip: InheritedL10n.of(context).l10n.sendButtonAccessibilityLabel,
        ),
      );
}
