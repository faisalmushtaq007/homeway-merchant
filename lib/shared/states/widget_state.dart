import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homemakers_merchant/core/network/http/failure/network_exception.dart';
part 'widget_state.freezed.dart';

@freezed
class WidgetState<T> with _$WidgetState<T> {
  const factory WidgetState.loading(
    BuildContext context,
    Widget? child,
  ) = _WidgetLoading<T>;

  const factory WidgetState.processing(BuildContext context, Widget? child) =
      _WidgetProcessing<T>;

  const factory WidgetState.success(
    BuildContext context,
    Widget? child, {
    required T data,
    @Default({}) Map<String, dynamic> otherData,
  }) = _WidgetSuccess<T>;

  const factory WidgetState.error(BuildContext context, Widget? child,
      {required String reason,
      Object? error,
      NetworkException? networkException,
      StackTrace? stackTrace}) = _WidgetError<T>;
}
