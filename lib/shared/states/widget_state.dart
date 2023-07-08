import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homemakers_merchant/core/network/http/failure/network_exception.dart';

part 'widget_state.freezed.dart';

@freezed
class WidgetState<T> with _$WidgetState<T> {
  const factory WidgetState.loading({required BuildContext context, Widget? child, @Default('Loading...') String message, @Default(false) isLoading}) =
      _WidgetLoading<T>;

  const factory WidgetState.processing({required BuildContext context, Widget? child, @Default('Loading...') String message, @Default(false) isLoading}) =
      _WidgetProcessing<T>;

  const factory WidgetState.success({
    required BuildContext context,
    Widget? child,
    required T data,
    @Default({}) Map<String, dynamic> otherData,
  }) = _WidgetSuccess<T>;

  const factory WidgetState.error(
      {required BuildContext context,
      Widget? child,
      required String reason,
      Object? error,
      NetworkException? networkException,
      StackTrace? stackTrace}) = _WidgetError<T>;

  const factory WidgetState.empty({required BuildContext context, Widget? child, @Default('Empty') String message, @Default([]) List<T> data}) =
      _WidgetEmpty<T>;

  const factory WidgetState.allData({required BuildContext context, Widget? child, @Default('All Data') String message, @Default([]) List<T> data}) =
      _WidgetAllData<T>;
}
