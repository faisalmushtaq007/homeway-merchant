import 'transforms/click_translate.dart';
import 'package:flutter/material.dart';

extension TransformExtensions on Widget {
  Widget get pushEffectOnClick => TranslateOnClick(child: this);
}
