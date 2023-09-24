import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/features/chat/domain/entities/chat_types_entity.dart'
    as types;

import 'package:homemakers_merchant/app/features/chat/presentation/pages/chat_ui/src/util.dart';
import 'package:homemakers_merchant/app/features/chat/presentation/pages/chat_ui/src/widgets/state/inherited_chat_theme.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';

/// Renders user's name as a message heading according to the theme.
class UserName extends StatelessWidget {
  /// Creates user name.
  const UserName({
    super.key,
    required this.author,
  });

  /// Author to show name from.
  final types.ChatUser author;

  @override
  Widget build(BuildContext context) {
    final theme = InheritedChatTheme.of(context).theme;
    final color = getUserAvatarNameColor(author, theme.userAvatarNameColors);
    final name = getUserName(author);

    return name.isEmpty
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.userNameTextStyle.copyWith(color: color),
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
            ),
          );
  }
}
