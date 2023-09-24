import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/features/chat/domain/entities/chat_types_entity.dart'
    as types;
import 'package:homemakers_merchant/app/features/chat/presentation/pages/chat_ui/src/util.dart';
import 'package:homemakers_merchant/app/features/chat/presentation/pages/chat_ui/src/widgets/state/inherited_chat_theme.dart';
import 'package:homemakers_merchant/app/features/chat/presentation/pages/chat_ui/src/widgets/state/inherited_l10n.dart';
import 'package:homemakers_merchant/app/features/chat/presentation/pages/chat_ui/src/widgets/state/inherited_user.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/universal/image_loader/image_helper.dart';
import 'package:homemakers_merchant/utils/image_type.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';

/// A class that represents file message widget.
class FileMessage extends StatelessWidget {
  /// Creates a file message widget based on a [types.FileMessage].
  const FileMessage({
    super.key,
    required this.message,
  });

  /// [types.FileMessage].
  final types.FileMessage message;

  @override
  Widget build(BuildContext context) {
    final user = InheritedUser.of(context).user;
    final color = user.id == message.author.id
        ? InheritedChatTheme.of(context).theme.sentMessageDocumentIconColor
        : InheritedChatTheme.of(context).theme.receivedMessageDocumentIconColor;

    return Semantics(
      label: InheritedL10n.of(context).l10n.fileButtonAccessibilityLabel,
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(
          InheritedChatTheme.of(context).theme.messageInsetsVertical,
          InheritedChatTheme.of(context).theme.messageInsetsVertical,
          InheritedChatTheme.of(context).theme.messageInsetsHorizontal,
          InheritedChatTheme.of(context).theme.messageInsetsVertical,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(21),
              ),
              height: 42,
              width: 42,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (message.isLoading ?? false)
                    Positioned.fill(
                      child: CircularProgressIndicator(
                        color: color,
                        strokeWidth: 2,
                      ),
                    ),
                  InheritedChatTheme.of(context).theme.documentIcon != null
                      ? InheritedChatTheme.of(context).theme.documentIcon!
                      : ImageHelper(
                          image: 'assets/image/icon-document.png',
                          filterQuality: FilterQuality.high,
                          borderRadius: BorderRadiusDirectional.circular(10),
                          imageType:
                              findImageType('assets/image/icon-document.png'),
                          imageShape: ImageShape.rectangle,
                          color: context.colorScheme.primary,
                          boxFit: BoxFit.cover,
                          defaultErrorBuilderColor: Colors.blueGrey,
                          errorBuilder: const Icon(
                            Icons.image_not_supported,
                            size: 10000,
                          ),
                          height: 42,
                          width: 42,
                          loaderBuilder: const CircularProgressIndicator(),
                        ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsetsDirectional.only(
                  start: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.name,
                      style: user.id == message.author.id
                          ? InheritedChatTheme.of(context)
                              .theme
                              .sentMessageBodyTextStyle
                          : InheritedChatTheme.of(context)
                              .theme
                              .receivedMessageBodyTextStyle,
                      textWidthBasis: TextWidthBasis.longestLine,
                      textDirection: serviceLocator<LanguageController>()
                          .targetTextDirection,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 4,
                      ),
                      child: Text(
                        formatBytes(message.size.truncate()),
                        style: user.id == message.author.id
                            ? InheritedChatTheme.of(context)
                                .theme
                                .sentMessageCaptionTextStyle
                            : InheritedChatTheme.of(context)
                                .theme
                                .receivedMessageCaptionTextStyle,
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
