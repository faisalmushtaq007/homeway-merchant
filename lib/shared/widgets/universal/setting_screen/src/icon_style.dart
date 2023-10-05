import 'package:flutter/material.dart';

class IconStyle {
  const IconStyle({
    this.iconsColor = Colors.white,
    this.withBackground = true,
    this.backgroundColor = Colors.blue,
    this.borderRadius = 8,
  }) ;
  final Color? iconsColor;
  final bool? withBackground;
  final Color? backgroundColor;
  final double? borderRadius;

  IconStyle copyWith({
    Color? iconsColor,
    bool? withBackground,
    Color? backgroundColor,
    double? borderRadius,
  }) {
    return IconStyle(
      iconsColor: iconsColor ?? this.iconsColor,
      withBackground: withBackground ?? this.withBackground,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
