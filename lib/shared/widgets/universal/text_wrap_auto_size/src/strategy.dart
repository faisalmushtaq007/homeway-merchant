import 'package:homemakers_merchant/shared/widgets/universal/text_wrap_auto_size/src/challenge.dart';
import 'package:homemakers_merchant/shared/widgets/universal/text_wrap_auto_size/solution.dart';

abstract class Strategy {
  Solution dimensions(Challenge task);
}
