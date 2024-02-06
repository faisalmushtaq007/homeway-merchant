import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';

import '../src/icon_style.dart';
import '../src/settings_screen_utils.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem(
      {super.key,
      required this.icons,
      this.iconStyle,
      required this.title,
      this.titleStyle,
      this.subtitle,
      this.subtitleStyle,
      this.backgroundColor,
      this.trailing,
      this.onTap,
      this.titleMaxLine,
      this.subtitleMaxLine,
      this.overflow = TextOverflow.ellipsis,
      this.hasDense});
  final IconData icons;
  final IconStyle? iconStyle;
  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final int? titleMaxLine;
  final int? subtitleMaxLine;
  final TextOverflow? overflow;
  final bool? hasDense;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ListTile(
          onTap: onTap,
          dense: hasDense,
          leading: (iconStyle != null && iconStyle!.withBackground!)
              ? Container(
                  decoration: BoxDecoration(
                    color: iconStyle!.backgroundColor,
                    borderRadius:
                        BorderRadius.circular(iconStyle!.borderRadius!),
                  ),
                  padding: const EdgeInsetsDirectional.all(5),
                  child: Icon(
                    icons,
                    size: SettingsScreenUtils.settingsGroupIconSize,
                    color: iconStyle!.iconsColor,
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                  ),
                )
              : Padding(
                  padding: const EdgeInsetsDirectional.all(5),
                  child: Icon(
                    icons,
                    size: SettingsScreenUtils.settingsGroupIconSize,
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                  ),
                ),
          title: Text(
            title,
            style: titleStyle ?? const TextStyle(fontWeight: FontWeight.bold),
            maxLines: titleMaxLine,
            overflow: titleMaxLine != null ? overflow : null,
            softWrap: true,
            textDirection:
                serviceLocator<LanguageController>().targetTextDirection,
          ).translate(),
          subtitle: (subtitle != null)
              ? Text(
                  subtitle!,
                  style:
                      subtitleStyle ?? Theme.of(context).textTheme.bodyMedium!,
                  maxLines: subtitleMaxLine,
                  overflow:
                      subtitleMaxLine != null ? TextOverflow.ellipsis : null,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  softWrap: true,
                ).translate()
              : null,
          trailing: (trailing != null)
              ? trailing
              : Icon(
                  Icons.navigate_next,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                ),
        ),
      ),
    );
  }
}
