//import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homemakers_merchant/core/network/http/failure/network_exception.dart';

part 'api_result_state.freezed.dart';

@freezed
class ApiResultState<T> with _$ApiResultState<T> {
  const factory ApiResultState.success({required T data}) = ApiSuccess<T>;

  const factory ApiResultState.failure(
      {required String reason,
      Object? error,
      NetworkException? exception,
      StackTrace? stackTrace,}) = ApiFailure<T>;
}
