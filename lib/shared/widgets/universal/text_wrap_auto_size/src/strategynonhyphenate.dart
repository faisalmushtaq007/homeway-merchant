import 'package:homemakers_merchant/shared/widgets/universal/text_wrap_auto_size/solution.dart';
import 'package:homemakers_merchant/shared/widgets/universal/text_wrap_auto_size/src/strategy.dart';
import 'package:hyphenatorx/hyphenatorx.dart';
import 'package:hyphenatorx/token/wrapresult.dart';

import 'challenge.dart';

class StrategyNonHyphenate implements Strategy {
  @override
  Solution dimensions(Challenge task) {
    final WrapResult wrap =
        Hyphenator.wrapNoHyphen(task.text, task.style, task.sizeOuter.width);

    return Solution(wrap.text, wrap.style, wrap.size, task.sizeOuter);
  }
}
