//import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homemakers_merchant/core/network/http/failure/network_exception.dart';
part 'result_state.freezed.dart';

@freezed
class ResultState<T> with _$ResultState<T> {
  const factory ResultState.idle() = _ResultIdle<T>;

  const factory ResultState.loading(
      {@Default('Loading...') String message,
      @Default(false) isLoading}) = _ResultLoading<T>;
  const factory ResultState.processing(
      {@Default('Processing...') String message,
      @Default(false) isProcessing}) = _ResultProcessing<T>;
  const factory ResultState.success({required T data}) = _ResultSuccess<T>;
  const factory ResultState.empty(
      {@Default('Empty') String message,
      @Default([]) List<T> data}) = _ResultEmpty<T>;
  const factory ResultState.allData(
      {@Default('All data') String message,
      @Default([]) List<T> data}) = _ResultAllData<T>;

  const factory ResultState.error(
      {required String reason,
      Object? error,
      NetworkException? networkException,
      StackTrace? stackTrace}) = _ResultError<T>;
}
