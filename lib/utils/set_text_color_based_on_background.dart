import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

Color setTextColorFromBackgroundColor({required Color backgroundColor, Color customTextColor = Colors.black87, bool useCustomColor = false}) {
  final colorDifference = backgroundColor.computeLuminance() - customTextColor.computeLuminance();
  if (colorDifference.abs() < 0.2) {
    return customTextColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  } else {
    return customTextColor;
  }
}

Future<Color> setTextColorFromBackgroundImage({required String networkImagePath, Color customTextColor = Colors.black87, bool useCustomColor = false}) async {
  PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
    NetworkImage(networkImagePath),

    filters: [],
// Images are square
    size: Size(300, 300),

// I want the dominant color of the top left section of the image
    region: Offset.zero & Size(40, 40),
  );

  final dominantColor = paletteGenerator.dominantColor?.color;
  if (dominantColor == null) {
    return customTextColor;
  } else {
    final colorDifference = dominantColor.computeLuminance() - customTextColor.computeLuminance();
    if (colorDifference.abs() < 0.2) {
      return customTextColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    } else {
      return customTextColor;
    }
  }
}
