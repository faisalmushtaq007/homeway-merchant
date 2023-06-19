import 'package:flutter/material.dart';

/// Conditional rendering class
class ConditionalData {
  ConditionalData._();

  /// A function which returns a single `Generic`
  ///
  /// - [conditionBuilder] is a function which returns a boolean.
  /// - [widgetBuilder] is a function which returns a `Generic`,
  ///  when [conditionBuilder] returns `true`.
  /// - [fallbackBuilder] is a function which returns a `Generic`,
  ///  when [conditionBuilder] returns `false`.
  static R single<R>({
    required bool Function() conditionBuilder,
    required R Function() widgetBuilder,
    required R Function() fallbackBuilder,
  }) {
    if (conditionBuilder() == true) {
      return widgetBuilder();
    } else {
      return fallbackBuilder();
    }
  }

  /// A function which returns a `List<Generic>`
  ///
  /// - [conditionBuilder] is the function which returns a boolean.
  /// - [widgetBuilder] is a function which returns a `List<Generic>`,
  ///  when [conditionBuilder] returns `true`.
  /// - [fallbackBuilder] is a function which returns a `List<Generic>`,
  ///  when [conditionBuilder] returns `false`.
  static List<R> list<R>({
    required bool Function() conditionBuilder,
    required List<R> Function() widgetBuilder,
    required List<R> Function() fallbackBuilder,
  }) {
    if (conditionBuilder() == true) {
      return widgetBuilder();
    } else {
      return fallbackBuilder();
    }
  }
}
