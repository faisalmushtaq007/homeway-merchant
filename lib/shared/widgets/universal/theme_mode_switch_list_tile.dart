import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:homemakers_merchant/shared/widgets/universal/theme_mode_switch.dart';
import 'package:homemakers_merchant/theme/theme_controller.dart';

class ThemeModeSwitchListTile extends StatelessWidget {
  const ThemeModeSwitchListTile(
      {super.key, required this.controller, this.contentPadding});

  final EdgeInsetsGeometry? contentPadding;
  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: contentPadding,
      title: const Text('Theme mode'),
      subtitle: Text('Theme ${controller.themeMode.name}'),
      trailing: ThemeModeSwitch(
        themeMode: controller.themeMode,
        onChanged: controller.setThemeMode,
      ),
      // Toggle theme mode also via the ListTile tap.
      onTap: () {
        if (Theme.of(context).brightness == Brightness.light) {
          controller.setThemeMode(ThemeMode.dark);
        } else {
          controller.setThemeMode(ThemeMode.light);
        }
      },
    );
  }
}
