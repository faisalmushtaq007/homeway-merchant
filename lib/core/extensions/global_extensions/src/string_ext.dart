import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String? {
  bool isNull(dynamic value) => value == null;

  /// Returns whether a dynamic value PROBABLY
  /// has the isEmpty getter/method by checking
  /// standard dart types that contains it.
  ///
  /// This is here to for the 'DRY'
  bool? _isEmpty(dynamic value) {
    if (value is String) {
      return value.toString().trim().isEmpty;
    }
    if (value is Iterable || value is Map) {
      return value.isEmpty as bool?;
    }
    return false;
  }

  /// Checks if string is a valid username.
  bool isUsername(String s) =>
      hasMatch(s, r'^[a-zA-Z0-9][a-zA-Z0-9_.]+[a-zA-Z0-9]$');

  /// Checks if string is Palindrom.
  bool isPalindrom(String string) {
    final cleanString = string
        .toLowerCase()
        .replaceAll(RegExp(r"\s+"), '')
        .replaceAll(RegExp(r"[^0-9a-zA-Z]+"), "");

    for (var i = 0; i < cleanString.length; i++) {
      if (cleanString[i] != cleanString[cleanString.length - i - 1]) {
        return false;
      }
    }

    return true;
  }

  /// Checks if string is Currency.
  bool isCurrency(String s) => hasMatch(s,
      r'^(S?\$|\₩|Rp|\¥|\€|\₹|\₽|fr|R\$|R)?[ ]?[-]?([0-9]{1,3}[,.]([0-9]{3}[,.])*[0-9]{3}|[0-9]+)([,.][0-9]{1,2})?( ?(USD?|AUD|NZD|CAD|CHF|GBP|CNY|EUR|JPY|IDR|MXN|NOK|KRW|TRY|INR|RUB|BRL|ZAR|SGD|MYR))?$');

  /// Checks if string is phone number.
  bool isPhoneNumber(String s) {
    if (s.length > 16 || s.length < 9) return false;
    return hasMatch(s, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  }

  /// Checks if string is email.
  bool isEmail(String s) => hasMatch(s,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  /// Checks if string is an html file.
  bool isHTML(String filePath) {
    return filePath.toLowerCase().endsWith(".html");
  }

  /// Checks if string is an video file.
  bool isVideo(String filePath) {
    var ext = filePath.toLowerCase();

    return ext.endsWith(".mp4") ||
        ext.endsWith(".avi") ||
        ext.endsWith(".wmv") ||
        ext.endsWith(".rmvb") ||
        ext.endsWith(".mpg") ||
        ext.endsWith(".mpeg") ||
        ext.endsWith(".3gp");
  }

  /// Checks if string is an audio file.
  bool isAudio(String filePath) {
    final ext = filePath.toLowerCase();

    return ext.endsWith(".mp3") ||
        ext.endsWith(".wav") ||
        ext.endsWith(".wma") ||
        ext.endsWith(".amr") ||
        ext.endsWith(".ogg");
  }

  /// Checks if string is an image file.
  bool isImage(String filePath) {
    final ext = filePath.toLowerCase();

    return ext.endsWith(".jpg") ||
        ext.endsWith(".jpeg") ||
        ext.endsWith(".png") ||
        ext.endsWith(".gif") ||
        ext.endsWith(".bmp");
  }

  bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  // Check if the string has any number in it, not accepting double, so don't
  // use "."
  isNumericOnly(String s) => hasMatch(s, r'^\d+$');

  /// Checks if string consist only Alphabet. (No Whitespace)
  bool isAlphabetOnly(String s) => hasMatch(s, r'^[a-zA-Z]+$');

  /// Checks if string contains at least one Capital Letter
  bool hasCapitalletter(String s) => hasMatch(s, r'[A-Z]');

  /// Checks if data is null or blank (empty or only contains whitespace).
  bool? isBlank(dynamic value) {
    return _isEmpty(value);
  }

  /// Checks if string is boolean.
  bool isBool(String value) {
    if (isNull(value)) {
      return false;
    }

    return (value == 'true' || value == 'false');
  }

  Size get getTextSize {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this),
      maxLines: 1,
    )..layout(
        minWidth: 0,
        maxWidth: double.infinity,
      );
    return textPainter.size;
  }

  // Will add new line if the sentence is bigger the 2 words.
  /// [afterWords] will add new line after the selected word
  /// Example
  /// 'Hi, my name is'.wrapString(2)
  ///
  /// will print:
  /// Hi, my
  /// name is

  String wrapString(int afterWords) {
    final wordsArr = this?.split(' ') ?? [];

    if (wordsArr.length > 2) {
      final int middle = (this?.indexOf(wordsArr[afterWords]) ?? 0) - 1;
      final prefix = this?.substring(0, middle);
      final postfix = this?.substring(middle + 1);
      return '$prefix\n$postfix';
    }

    return this ?? '';
  }

  bool validateEmail() {
    if (this == null) return false;
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this!);
  }

  bool equalsIgnoreCase(String? other) =>
      (this == null && other == null) ||
      (this != null &&
          other != null &&
          this!.toLowerCase() == other.toLowerCase());

  /// Return the string only if the delimiter exists in both ends, otherwise it will return the current string
  String? removeSurrounding(String delimiter) {
    if (this == null) return null;
    final prefix = delimiter;
    final suffix = delimiter;

    if ((this!.length >= prefix.length + suffix.length) &&
        this!.startsWith(prefix) &&
        this!.endsWith(suffix)) {
      return this!.substring(prefix.length, this!.length - suffix.length);
    }
    return this;
  }

  /// Return a bool if the string is null or empty
  bool get isEmptyOrNull => this == null || this!.isEmpty;

  bool get isEmptyAndNull => this == null && this!.isEmpty;

  ///  Replace part of string after the first occurrence of given delimiter with the [replacement] string.
  ///  If the string does not contain the delimiter, returns [defaultValue] which defaults to the original string.
  String? replaceAfter(String delimiter, String replacement,
      [String? defaultValue]) {
    if (this == null) return null;
    final index = this!.indexOf(delimiter);
    return (index == -1)
        ? defaultValue.isEmptyOrNull
            ? this
            : defaultValue
        : this!.replaceRange(index + 1, this!.length, replacement);
  }

  ///
  /// Replace part of string before the first occurrence of given delimiter with the [replacement] string.
  ///  If the string does not contain the delimiter, returns [missingDelimiterValue?] which defaults to the original string.
  String? replaceBefore(String delimiter, String replacement,
      [String? defaultValue]) {
    if (this == null) return null;
    final index = this!.indexOf(delimiter);
    return (index == -1)
        ? defaultValue.isEmptyOrNull
            ? this
            : defaultValue
        : this!.replaceRange(0, index, replacement);
  }

  ///Returns `true` if at least one element matches the given [predicate].
  /// the [predicate] should have only one character
  bool anyChar(bool predicate(String element)) =>
      this.isEmptyOrNull ? false : this!.split('').any((s) => predicate(s));

  /// Returns the string if it is not `null`, or the empty string otherwise
  String get orEmpty => this ?? "";

// if the string is empty perform an action
  //String? ifEmpty(Function action) => this?.isEmpty == true ? action() : this;

  String get lastIndex {
    if (isEmptyOrNull) return "";
    return this![this!.length - 1];
  }

  /// prints to console this text if it's not empty or null
  void printThis() {
    if (isEmptyOrNull) return;
    print(toString());
  }

  /// Parses the string as an double or returns `null` if it is not a number.
  double? toDoubleOrNull() => this == null ? null : double.tryParse(this!);

  /// Parses the string as an int or returns `null` if it is not a number.
  int? toIntOrNull() => this == null ? null : int.tryParse(this!);

  /// Returns a String without white space at all
  /// "hello world" // helloworld
  String? removeAllWhiteSpace() =>
      this.isEmptyOrNull ? null : this!.replaceAll(RegExp(r"\s+\b|\b\s"), "");

  /// Returns true if s is neither null, empty nor is solely made of whitespace characters.
  bool get isNotBlank => this != null && this!.trim().isNotEmpty;

  /// Returns a list of chars from a String
  List<String> toCharArray() => isNotBlank ? this!.split('') : [];

  /// Returns a new string in which a specified string is inserted at a specified index position in this instance.
  String insert(int index, String str) =>
      (List<String>.from(this.toCharArray())..insert(index, str)).join();

  /// Indicates whether a specified string is `null`, `empty`, or consists only of `white-space` characters.
  bool get isNullOrWhiteSpace {
    var length = (this?.split('') ?? []).where((x) => x == ' ').length;
    return length == (this?.length ?? 0) || this.isEmptyOrNull;
  }

  /// Shrink a string to be no more than [maxSize] in length, extending from the end.
  /// For example, in a string with 10 charachters, a [maxSize] of 3 would return the last 3 charachters.
  String? limitFromEnd(int maxSize) => (this?.length ?? 0) < maxSize
      ? this
      : this!.substring(this!.length - maxSize);

  /// Shrink a string to be no more than [maxSize] in length, extending from the start.
  /// For example, in a string with 10 charachters, a [maxSize] of 3 would return the first 3 charachters.
  String? limitFromStart(int maxSize) =>
      (this?.length ?? 0) < maxSize ? this : this!.substring(0, maxSize);

  /// Convert this string into boolean.
  ///
  /// Returns `true` if this string is any of these values: `"true"`, `"yes"`, `"1"`, or if the string is a number and greater than 0, `false` if less than 1. This is also case insensitive.
  bool get asBool {
    var s = this?.trim().toLowerCase() ?? "false";
    num n;
    try {
      n = num.parse(s);
    } catch (e) {
      n = -1;
    }
    return s == 'true' || s == 'yes' || n > 0;
  }
}

extension StringEnhanceExtensions on String {
  String? getInitials({int limitTo = 2}) {
    var buffer = StringBuffer();
    var wordList = trim().split(' ');

    if (isEmpty) {
      return this;
    }

    // Take first character if string is a single word
    if (wordList.length <= 1) {
      return characters.first;
    }

    /// Fallback to actual word count if
    /// expected word count is greater
    if (limitTo > wordList.length) {
      for (var i = 0; i < wordList.length; i++) {
        buffer.write(wordList[i][0]);
      }
      return buffer.toString();
    }

    // Handle all other cases
    for (var i = 0; i < (wordList.length); i++) {
      buffer.write(wordList[i][0]);
    }
    return buffer.toString();
  }
}

extension StringWordCapitalize on String {
  /// Returns a copy of this string having its first letter uppercased, or the
  /// original string, if it's empty or already starts with an upper case
  /// letter.
  ///
  /// ```dart
  /// print('abcd'.capitalize()) // Abcd
  /// print('Abcd'.capitalize()) // Abcd
  /// ```
  String capitalize() {
    switch (length) {
      case 0:
        return this;
      case 1:
        return toUpperCase();
      default:
        return substring(0, 1).toUpperCase() + substring(1);
    }
  }

  /// Returns a copy of this string having its first letter lowercased, or the
  /// original string, if it's empty or already starts with a lower case letter.
  ///
  /// ```dart
  /// print('abcd'.decapitalize()) // abcd
  /// print('Abcd'.decapitalize()) // abcd
  /// ```
  String decapitalize() {
    switch (length) {
      case 0:
        return this;
      case 1:
        return toLowerCase();
      default:
        return substring(0, 1).toLowerCase() + substring(1);
    }
  }

  String wordFormatCapitalize() {
    final result = split(' ');
    final buffer = StringBuffer();
    buffer.write(result.map((e) => e.capitalize()).join(' '));
    return buffer.toString();
  }

  /// Returns a copy of this string in PascalCase style, or the original string,
  /// if it's empty.
  ///
  /// ```dart
  /// print('Hello World'.pascal()) // HelloWorld
  /// print('helloWorld'.pascal()) // HelloWorld
  /// print('long   space'.pascal()) // LongSpace
  /// ```
  String pascal() {
    switch (length) {
      case 0:
        return this;
      case 1:
        return toUpperCase();
      default:
        return splitMapJoin(
          RegExp(r'\s+'),
          onMatch: (m) => '',
          onNonMatch: (n) => n.capitalize(),
        );
    }
  }

  /// Returns a copy of this string in snake_case style, or the original string,
  /// if it's empty.
  ///
  /// ```dart
  /// print('Hello World'.pascal()) // hello_world
  /// print('helloWorld'.pascal()) // hello_world
  /// print('long   space'.pascal()) // long_space
  /// ```
  String snake() {
    switch (length) {
      case 0:
        return this;
      case 1:
        return toLowerCase();
      default:
        return splitMapJoin(
          RegExp('[A-Z]'),
          onMatch: (m) => ' ${m[0]}'.toLowerCase(),
          onNonMatch: (n) => n.decapitalize(),
        ).trim().splitMapJoin(
              RegExp(r'\s+'),
              onMatch: (m) => '_',
              onNonMatch: (n) => n.decapitalize(),
            );
    }
  }

  /// Returns a copy of this string in kebab-case style, or the original string,
  /// if it's empty.
  ///
  /// ```dart
  /// print('Hello World'.pascal()) // hello-world
  /// print('helloWorld'.pascal()) // hello-world
  /// print('long   space'.pascal()) // long-space
  /// ```
  String kebab() {
    return snake().replaceAll('_', '-');
  }

  /// Returns a copy of this string in dot.case style, or the original string,
  /// if it's empty.
  ///
  /// ```dart
  /// print('Hello World'.dot()) // hello.world
  /// print('helloWorld'.dot()) // hello.world
  /// print('long   space'.dot()) // long.space
  /// ```
  String dot() {
    return snake().replaceAll('_', '.');
  }

  /// Checks if the `String` is Blank (null, empty or only white spaces).
  bool get isBlank => this.trim().isEmpty;

  /// Checks if the `String` is not blank (null, empty or only white spaces).
  bool get isNotBlank => isBlank == false;

  /// Appends a [suffix] to the `String`.
  ///
  /// ### Example
  ///
  /// ```dart
  /// String foo = 'hello';
  /// String newFoo = foo1.append(' world'); // returns 'hello world'
  /// ```
  String append(String suffix) {
    if (this.isBlank) {
      return suffix;
    }

    return this + suffix;
  }

  /// Prepends a [prefix] to the `String`.
  ///
  /// ### Example
  ///
  /// ```dart
  /// String foo = 'world';
  /// String newFoo = foo1.prepend('hello '); // returns 'hello world'
  /// ```
  String prepend(String prefix) {
    if (this.isBlank) {
      return prefix;
    }

    return prefix + this;
  }
}
