import 'package:flutter/material.dart';

/// Widget using [ToggleButtons) that can be used to toggle the theme mode
/// of an application.
///
/// This is a simple Flutter "Universal" Widget that only depends on the SDK and
/// can be dropped into any application.
class ThemeModeSwitch extends StatefulWidget {
  const ThemeModeSwitch({
    super.key,
    required this.themeMode,
    required this.onChanged,
  });
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onChanged;

  @override
  State<ThemeModeSwitch> createState() => _ThemeModeSwitchState();
}

class _ThemeModeSwitchState extends State<ThemeModeSwitch> {
  late ThemeMode themeMode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    themeMode = widget.themeMode;
  }

  @override
  Widget build(BuildContext context) {
    final List<bool> isSelected = <bool>[
      widget.themeMode == ThemeMode.light,
      widget.themeMode == ThemeMode.system,
      widget.themeMode == ThemeMode.dark,
    ];
    /*return SegmentedButton<ThemeMode>(
      onSelectionChanged: (Set<ThemeMode> i) {
        setState(() {
          themeMode = i.first;
          widget.onChanged(themeMode);
        });
      },
      showSelectedIcon: false,
      style: ButtonStyle(
        iconColor: MaterialStateProperty.all(Colors.white),
      ),
      segments: const <ButtonSegment<ThemeMode>>[
        ButtonSegment<ThemeMode>(
          value: ThemeMode.light,
          icon: Icon(Icons.wb_sunny),
        ),
        ButtonSegment<ThemeMode>(
          value: ThemeMode.system,
          icon: Icon(Icons.phone_iphone),
        ),
        ButtonSegment<ThemeMode>(
          value: ThemeMode.dark,
          icon: Icon(Icons.bedtime),
        ),
      ],
      selected: {themeMode},
    );*/
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        if (newIndex == 0) {
          widget.onChanged(ThemeMode.light);
        } else if (newIndex == 1) {
          widget.onChanged(ThemeMode.system);
        } else {
          widget.onChanged(ThemeMode.dark);
        }
      },
      children: const <Widget>[
        Icon(Icons.wb_sunny),
        Icon(Icons.phone_iphone),
        Icon(Icons.bedtime),
      ],
    );
  }
}
