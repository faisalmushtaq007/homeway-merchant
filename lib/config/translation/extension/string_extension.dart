import 'package:homemakers_merchant/config/translation/app_translator.dart';
import 'package:homemakers_merchant/core/extensions/aync_extension/src/async_extension_base.dart';

extension StringTranslateExtension on String {
  String tr([bool usePlaceholder = false, String placeholder = "..."]) {
    String data = this;

    final translate = AppTranslator.instance.translate(data);
    String response = data;
    String result = data;
    // Resolve and map with a `Future`:
    var translateResolveMapped = translate.resolveMapped((text) => text);
    translateResolveMapped.onResolve((text) => result = text);
    if (usePlaceholder) {
      response = placeholder;
    }
    if (result != null && result.isNotEmpty) {
      response = result;
    }
    return response;
  }
}
