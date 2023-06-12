import 'package:flutter/widgets.dart';

List<String> getTextsFromSpan(InlineSpan textSpan) {
  List<String> list = [];
  if (textSpan is TextSpan && textSpan.text != null) {
    list.add(textSpan.text);
  }
  if (textSpan is TextSpan && textSpan.children != null) {
    textSpan.children?.forEach((e) {
      list.addAll(getTextsFromSpan(e));
    });
  }
  return list;
}

TextSpan getSpansFromTexts(List<String> texts, InlineSpan original) {
  TextSpan span = TextSpan();
  if (texts.length > 0 && original is TextSpan) {
    String text = '';
    if (original.text != null) {
      text = "${texts.first}";
      texts.removeAt(0);
    }
    List<InlineSpan> children = [];
    if (original.children != null) {
      original.children?.forEach((child) {
        children.add(getSpansFromTexts(texts, child));
      });
    }
    children.removeWhere((e) => e == null);
    span = TextSpan(
        text: text,
        children: children,
        style: original.style,
        recognizer: original.recognizer,
        semanticsLabel: original.semanticsLabel);
  }
  return span;
}
