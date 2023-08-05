import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homemakers_merchant/core/network/http/failure/network_exception.dart';

part 'data_source_state.freezed.dart';

enum DataSourceFailure {
  remote,
  local,
  none,
  connectivity,
  ;

  @override
  String toString() {
    return name;
  }
}

@freezed
class DataSourceState<T> with _$DataSourceState<T> {
  const factory DataSourceState.remote({
    T? data,
    dynamic meta,
  }) = _DataSourceRemote<T>;

  const factory DataSourceState.localDb({
    T? data,
    dynamic meta,
  }) = _DataSourceLocalDb<T>;

  const factory DataSourceState.error({
    @Default(DataSourceFailure.none) DataSourceFailure dataSourceFailure,
    required String reason,
    Object? error,
    NetworkException? networkException,
    StackTrace? stackTrace,
    Exception? exception,
  }) = _DataSourceError<T>;
}
