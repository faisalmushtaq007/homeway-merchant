//import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homemakers_merchant/app/shared/network/http/failure/network_exception.dart';
part 'result_state.freezed.dart';

@freezed
class ResultState<T> with _$ResultState<T> {
  const factory ResultState.idle() = _ResultIdle<T>;

  const factory ResultState.loading() = _ResultLoading<T>;

  const factory ResultState.success({required T data}) = _ResultSuccess<T>;

  const factory ResultState.error(
      {required String reason,
      Object? error,
      NetworkException? networkException,
      StackTrace? stackTrace}) = _ResultError<T>;
}
