import 'dart:ui';

import 'package:homemakers_merchant/utils/common/color_utils.dart';

export 'wonders_color_extensions.dart';

class AppColors {
  final bool isDark = false;

  Color shift(Color c, double d) =>
      ColorUtils.shiftHsl(c, d * (isDark ? -1 : 1));
}
