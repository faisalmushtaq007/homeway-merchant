import 'package:flutter/material.dart';

import 'package:homemakers_merchant/app/features/chat/presentation/pages/chat_ui/src/widgets/state/inherited_chat_theme.dart';
import 'package:homemakers_merchant/app/features/chat/presentation/pages/chat_ui/src/widgets/state/inherited_l10n.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/universal/image_loader/image_helper.dart';
import 'package:homemakers_merchant/utils/image_type.dart';

/// A class that represents attachment button widget.
class AttachmentButton extends StatelessWidget {
  /// Creates attachment button widget.
  const AttachmentButton({
    super.key,
    this.isLoading = false,
    this.onPressed,
    this.padding = EdgeInsets.zero,
  });

  /// Show a loading indicator instead of the button.
  final bool isLoading;

  /// Callback for attachment button tap event.
  final VoidCallback? onPressed;

  /// Padding around the button.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Container(
        margin: InheritedChatTheme.of(context).theme.attachmentButtonMargin ??
            const EdgeInsetsDirectional.fromSTEB(
              8,
              0,
              0,
              0,
            ),
        child: IconButton(
          constraints: const BoxConstraints(
            minHeight: 24,
            minWidth: 24,
          ),
          icon: isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    strokeWidth: 1.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      InheritedChatTheme.of(context).theme.inputTextColor,
                    ),
                  ),
                )
              : InheritedChatTheme.of(context).theme.attachmentButtonIcon ??
                  ImageHelper(
                    image: 'assets/image/icon-attachment.png',
                    filterQuality: FilterQuality.high,
                    borderRadius: BorderRadiusDirectional.circular(10),
                    imageType: findImageType('assets/image/icon-attachment.png'),
                    imageShape: ImageShape.rectangle,
                    color: context.colorScheme.primary,
                    boxFit: BoxFit.cover,
                    defaultErrorBuilderColor: Colors.blueGrey,
                    errorBuilder: const Icon(
                      Icons.image_not_supported,
                      size: 10000,
                    ),
                    height: 20,
                    width: 20,
                    loaderBuilder: const CircularProgressIndicator(),
                  ),
          onPressed: isLoading ? null : onPressed,
          padding: padding,
          splashRadius: 24,
          tooltip: InheritedL10n.of(context).l10n.attachmentButtonAccessibilityLabel,
        ),
      );
}
