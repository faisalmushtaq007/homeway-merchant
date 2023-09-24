import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/features/chat/domain/entities/chat_types_entity.dart'
    as types;
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/universal/image_loader/image_helper.dart';
import 'package:homemakers_merchant/utils/image_type.dart';

import '../../models/bubble_rtl_alignment.dart';
import '../../util.dart';
import '../state/inherited_chat_theme.dart';

/// Renders user's avatar or initials next to a message.
class UserAvatar extends StatelessWidget {
  /// Creates user avatar.
  const UserAvatar({
    super.key,
    required this.author,
    this.bubbleRtlAlignment,
    this.imageHeaders,
    this.onAvatarTap,
  });

  /// Author to show image and name initials from.
  final types.ChatUser author;

  /// See [Message.bubbleRtlAlignment].
  final BubbleRtlAlignment? bubbleRtlAlignment;

  /// See [Chat.imageHeaders].
  final Map<String, String>? imageHeaders;

  /// Called when user taps on an avatar.
  final void Function(types.ChatUser)? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final color = getUserAvatarNameColor(
      author,
      InheritedChatTheme.of(context).theme.userAvatarNameColors,
    );
    final hasImage = author.imageUrl != null;
    final initials = getUserInitials(author);
    return Container(
      margin: bubbleRtlAlignment == BubbleRtlAlignment.left
          ? const EdgeInsetsDirectional.only(end: 8)
          : const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => onAvatarTap?.call(author),
        child: CircleAvatar(
          backgroundColor: hasImage
              ? InheritedChatTheme.of(context)
                  .theme
                  .userAvatarImageBackgroundColor
              : color,
          //backgroundImage: hasImage ? NetworkImage(author.imageUrl!, headers: imageHeaders) : null,
          radius: 16,
          child: hasImage
              ? ImageHelper(
                  image: author.imageUrl!,
                  filterQuality: FilterQuality.high,
                  borderRadius: BorderRadiusDirectional.circular(10),
                  imageType: findImageType(author.imageUrl!),
                  imageShape: ImageShape.rectangle,
                  boxFit: BoxFit.cover,
                  defaultErrorBuilderColor: Colors.blueGrey,
                  errorBuilder: const Icon(
                    Icons.image_not_supported,
                    size: 10000,
                  ),
                  loaderBuilder: const CircularProgressIndicator(),
                  matchTextDirection: true,
                  placeholderText: initials ?? '',
                  placeholderTextStyle: context.labelLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )
              : Text(
                  initials,
                  style:
                      InheritedChatTheme.of(context).theme.userAvatarTextStyle,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                ),
        ),
      ),
    );
  }
}
