import 'package:flutter/material.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:intl/intl.dart' as intl;

class AutoDirection extends StatefulWidget {
  const AutoDirection({
    super.key,
    required this.text,
    required this.child,
    this.onDirectionChange,
    this.hasTextDirection = true,
    this.forceTextDirection = TextDirection.ltr,
  });
  final String text;
  final Widget child;
  final bool hasTextDirection;
  final TextDirection forceTextDirection;
  final void Function(bool isRTL)? onDirectionChange;

  @override
  _AutoDirectionState createState() => _AutoDirectionState();
}

class _AutoDirectionState extends State<AutoDirection> {
  late String text;
  late Widget childWidget;

  @override
  Widget build(BuildContext context) {
    text = widget.text;
    childWidget = widget.child;
    return Directionality(
        textDirection: isRTL(text) ? TextDirection.rtl : TextDirection.ltr,
        child: childWidget);
  }

  @override
  void didUpdateWidget(AutoDirection oldWidget) {
    if (isRTL(oldWidget.text) != isRTL(widget.text)) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => widget.onDirectionChange?.call(isRTL(widget.text)));
    }
    super.didUpdateWidget(oldWidget);
  }

  bool isRTL(String text) {
    if (text.isEmpty)
      return Directionality.of(context) ==
          serviceLocator<LanguageController>()
              .targetTextDirection; //TextDirection.rtl;
    return intl.Bidi.detectRtlDirectionality(text);
  }
}
