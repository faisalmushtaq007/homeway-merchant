import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';

import '../src/component_settings_item.dart';
import '../src/settings_screen_utils.dart';
import 'package:flutter/material.dart';

/// This component group the Settings items (BabsComponentSettingsItem)
/// All one BabsComponentSettingsGroup have a title and the developper can improve the design.
class SettingsGroup extends StatelessWidget {
  const SettingsGroup({
    super.key,
    this.settingsGroupTitle,
    this.settingsGroupTitleStyle,
    required this.items,
    this.iconItemSize = 25,
    this.margin,
  });
  final String? settingsGroupTitle;
  final TextStyle? settingsGroupTitleStyle;
  final List<SettingsItem> items;
  // Icons size
  final double? iconItemSize;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    if (this.iconItemSize != null)
      SettingsScreenUtils.settingsGroupIconSize = iconItemSize;

    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: Container(
        margin: margin ?? const EdgeInsetsDirectional.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
          children: [
            // The title
            (settingsGroupTitle != null)
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      settingsGroupTitle!,
                      style: (settingsGroupTitleStyle == null)
                          ? const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)
                          : settingsGroupTitleStyle,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ).translate(),
                  )
                : Container(),
            // The SettingsGroup sections
            DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return items[index];
                },
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const ScrollPhysics(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
