import 'transforms/click_translate.dart';
import 'package:flutter/material.dart';

extension GestureDetectorExtensions on Widget {
  Widget get onTapAddJumpEffect => TranslateOnClick(child: this);

  Widget onDoubleTap(Function() function) => GestureDetector(
        onDoubleTap: function,
        child: this,
      );

  Widget onTap(Function() function) => GestureDetector(
        onTap: function,
        child: this,
      );

  Widget onLongPress(Function() function) => GestureDetector(
        onLongPress: function,
        child: this,
      );
}
