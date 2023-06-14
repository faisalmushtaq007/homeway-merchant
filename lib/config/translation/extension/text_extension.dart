import 'package:flutter/widgets.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/app_translator.dart';
import 'package:homemakers_merchant/config/translation/utils/text_span_function.dart';
import 'package:homemakers_merchant/shared/widgets/universal/async_builder/src/async_builder.dart';

import '../language_controller.dart';

extension TranslateText on Text {
  /// Translate the text to the defined language using
  /// the `app_translator` using the `FutureBuilder` widget.
  ///
  /// If the [usePlaceholder] arguments is false then it will show the original while awaits.
  /// If the [placeholder] arguments is null then it will show three dots.
  Widget translate([bool usePlaceholder = false, String placeholder = "..."]) {
    String? data;
    String? splitKeyWord;
    if (this.textSpan != null) {
      splitKeyWord = "(}[";
      data = getTextsFromSpan(this.textSpan!).join(splitKeyWord);
    } else {
      data = this.data;
    }
    /*serviceLocator<LanguageController>().set([data ?? '']);
    serviceLocator<LanguageController>().run(useCache: true);
    String response = serviceLocator<LanguageController>().get(data ?? '');
    if (this.textSpan == null) {
      return Text(response,
          key: this.key,
          locale: this.locale,
          maxLines: this.maxLines,
          overflow: this.overflow,
          semanticsLabel: this.semanticsLabel,
          softWrap: this.softWrap,
          strutStyle: this.strutStyle,
          style: this.style,
          textAlign: this.textAlign,
          textDirection: this.textDirection,
          textHeightBehavior: this.textHeightBehavior,
          textScaleFactor: this.textScaleFactor,
          textWidthBasis: this.textWidthBasis);
    } else {
      return Text.rich(
          getSpansFromTexts(response.split(splitKeyWord!), this.textSpan!),
          key: this.key,
          locale: this.locale,
          maxLines: this.maxLines,
          overflow: this.overflow,
          semanticsLabel: this.semanticsLabel,
          softWrap: this.softWrap,
          strutStyle: this.strutStyle,
          style: this.style,
          textAlign: this.textAlign,
          textDirection: this.textDirection,
          textHeightBehavior: this.textHeightBehavior,
          textScaleFactor: this.textScaleFactor,
          textWidthBasis: this.textWidthBasis);
    }*/
    return AsyncBuilder<String>(
      future: AppTranslator.instance.translate(data!),
      builder: (context, value) {
        String response = '';
        if (usePlaceholder) {
          response = placeholder;
        } else if (this.textSpan != null) {
          response = getTextsFromSpan(this.textSpan!).join("");
        } else {
          response = this.data ?? "";
        }
        if (value != null && value.isNotEmpty) {
          response = value;
        }

        if (this.textSpan == null) {
          return Text(response,
              key: this.key,
              locale: this.locale,
              maxLines: this.maxLines,
              overflow: this.overflow,
              semanticsLabel: this.semanticsLabel,
              softWrap: this.softWrap,
              strutStyle: this.strutStyle,
              style: this.style,
              textAlign: this.textAlign,
              textDirection: this.textDirection,
              textHeightBehavior: this.textHeightBehavior,
              textScaleFactor: this.textScaleFactor,
              textWidthBasis: this.textWidthBasis);
        } else {
          return Text.rich(
              getSpansFromTexts(response.split(splitKeyWord!), this.textSpan!),
              key: this.key,
              locale: this.locale,
              maxLines: this.maxLines,
              overflow: this.overflow,
              semanticsLabel: this.semanticsLabel,
              softWrap: this.softWrap,
              strutStyle: this.strutStyle,
              style: this.style,
              textAlign: this.textAlign,
              textDirection: this.textDirection,
              textHeightBehavior: this.textHeightBehavior,
              textScaleFactor: this.textScaleFactor,
              textWidthBasis: this.textWidthBasis);
        }
      },
    );
    /*return FutureBuilder<String>(
        future: UniversalTranslatorController().translateText(data ?? ""),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          String response;
          if (usePlaceholder) {
            response = placeholder;
          } else if (this.textSpan != null) {
            response = getTextsFromSpan(this.textSpan).join("");
          } else {
            response = this.data ?? "";
          }
          if (snapshot.hasData) {
            if (snapshot.data != null &&
                snapshot.data.isNotEmpty &&
                snapshot.data != "null") {
              response = snapshot.data;
            }
          }
          if (this.textSpan == null || !snapshot.hasData)
            return Text(response,
                key: this.key,
                locale: this.locale,
                maxLines: this.maxLines,
                overflow: this.overflow,
                semanticsLabel: this.semanticsLabel,
                softWrap: this.softWrap,
                strutStyle: this.strutStyle,
                style: this.style,
                textAlign: this.textAlign,
                textDirection: this.textDirection,
                textHeightBehavior: this.textHeightBehavior,
                textScaleFactor: this.textScaleFactor,
                textWidthBasis: this.textWidthBasis);
          else
            return Text.rich(
                getSpansFromTexts(
                    response.split(splitKeyWord!), this.textSpan!),
                key: this.key,
                locale: this.locale,
                maxLines: this.maxLines,
                overflow: this.overflow,
                semanticsLabel: this.semanticsLabel,
                softWrap: this.softWrap,
                strutStyle: this.strutStyle,
                style: this.style,
                textAlign: this.textAlign,
                textDirection: this.textDirection,
                textHeightBehavior: this.textHeightBehavior,
                textScaleFactor: this.textScaleFactor,
                textWidthBasis: this.textWidthBasis);
        });*/
  }
}
