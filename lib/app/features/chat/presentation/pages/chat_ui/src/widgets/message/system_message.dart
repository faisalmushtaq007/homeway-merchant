import 'package:flutter/material.dart';

import 'package:homemakers_merchant/app/features/chat/presentation/pages/chat_ui/src/widgets/state/inherited_chat_theme.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';

/// A class that represents system message widget.
class SystemMessage extends StatelessWidget {
  const SystemMessage({
    super.key,
    required this.message,
  });

  /// System message.
  final String message;

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        margin: InheritedChatTheme.of(context).theme.systemMessageTheme.margin,
        child: Text(
          message,
          style: InheritedChatTheme.of(context).theme.systemMessageTheme.textStyle,
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
        ),
      );
}

@immutable
class SystemMessageTheme {
  const SystemMessageTheme({
    required this.margin,
    required this.textStyle,
  });

  /// Margin around the system message.
  final EdgeInsets margin;

  /// Text style for the system message.
  final TextStyle textStyle;
}
