import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/features/chat/domain/entities/chat_types_entity.dart'
    as types;
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/universal/image_loader/image_helper.dart';
import 'package:homemakers_merchant/utils/image_type.dart';

import '../state/inherited_chat_theme.dart';

/// A class that represents a message status.
class MessageStatus extends StatelessWidget {
  /// Creates a message status widget.
  const MessageStatus({
    super.key,
    required this.status,
  });

  /// Status of the message.
  final types.Status? status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case types.Status.delivered:
      case types.Status.sent:
        return InheritedChatTheme.of(context).theme.deliveredIcon != null
            ? InheritedChatTheme.of(context).theme.deliveredIcon!
            : ImageHelper(
                image: 'assets/image/icon-delivered.png',
                filterQuality: FilterQuality.high,
                borderRadius: BorderRadiusDirectional.circular(10),
                imageType: findImageType('assets/image/icon-delivered.png'),
                imageShape: ImageShape.rectangle,
                color: context.colorScheme.primary,
                boxFit: BoxFit.cover,
                defaultErrorBuilderColor: Colors.blueGrey,
                errorBuilder: const Icon(
                  Icons.image_not_supported,
                  size: 10000,
                ),
                height: 10,
                width: 10,
                loaderBuilder: const CircularProgressIndicator(),
              );
      case types.Status.error:
        return InheritedChatTheme.of(context).theme.errorIcon != null
            ? InheritedChatTheme.of(context).theme.errorIcon!
            : ImageHelper(
                image: 'assets/image/icon-error.png',
                filterQuality: FilterQuality.high,
                borderRadius: BorderRadiusDirectional.circular(10),
                imageType: findImageType('assets/image/icon-error.png'),
                imageShape: ImageShape.rectangle,
                color: context.colorScheme.error,
                boxFit: BoxFit.cover,
                defaultErrorBuilderColor: Colors.blueGrey,
                errorBuilder: const Icon(
                  Icons.image_not_supported,
                  size: 10000,
                ),
                height: 10,
                width: 10,
                loaderBuilder: const CircularProgressIndicator(),
              );
      case types.Status.seen:
        return InheritedChatTheme.of(context).theme.seenIcon != null
            ? InheritedChatTheme.of(context).theme.seenIcon!
            : ImageHelper(
                image: 'assets/image/icon-seen.png',
                filterQuality: FilterQuality.high,
                borderRadius: BorderRadiusDirectional.circular(10),
                imageType: findImageType('assets/image/icon-seen.png'),
                imageShape: ImageShape.rectangle,
                color: context.colorScheme.primary,
                boxFit: BoxFit.cover,
                defaultErrorBuilderColor: Colors.blueGrey,
                errorBuilder: const Icon(
                  Icons.image_not_supported,
                  size: 10000,
                ),
                height: 10,
                width: 10,
                loaderBuilder: const CircularProgressIndicator(),
              );
      case types.Status.sending:
        return InheritedChatTheme.of(context).theme.sendingIcon != null
            ? InheritedChatTheme.of(context).theme.sendingIcon!
            : Center(
                child: SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    strokeWidth: 1.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      InheritedChatTheme.of(context).theme.primaryColor,
                    ),
                  ),
                ),
              );
      default:
        return const SizedBox(width: 8);
    }
  }
}
