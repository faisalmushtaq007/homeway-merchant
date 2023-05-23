import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exception_model.freezed.dart';
part 'network_exception_model.g.dart';

@freezed
class NetworkExceptionModel with _$NetworkExceptionModel {
  const factory NetworkExceptionModel({
    @JsonKey(name: 'jsonrpc') String? jsonrpc,
    @JsonKey(name: 'id') dynamic? id,
    @JsonKey(name: 'error') ErrorBean? error,
  }) = _NetworkExceptionModel;

  factory NetworkExceptionModel.fromJson(Map<String, Object?> json) =>
      _$NetworkExceptionModelFromJson(json);
}

@freezed
class ErrorBean with _$ErrorBean {
  const factory ErrorBean({
    @JsonKey(name: 'code') int? code,
    @JsonKey(name: 'message') String? message,
    @JsonKey(name: 'data') DataBean? data,
    @JsonKey(name: 'http_status') int? httpStatus,
  }) = _ErrorBean;

  factory ErrorBean.fromJson(Map<String, Object?> json) =>
      _$ErrorBeanFromJson(json);
}

@freezed
class DataBean with _$DataBean {
  const factory DataBean({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'debug') String? debug,
    @JsonKey(name: 'message') String? message,
    @JsonKey(name: 'arguments') List<dynamic>? arguments,
    @JsonKey(name: 'context') ContextBean? context,
  }) = _DataBean;

  factory DataBean.fromJson(Map<String, Object?> json) =>
      _$DataBeanFromJson(json);
}

@freezed
class ContextBean with _$ContextBean {
  const factory ContextBean() = _ContextBean;

  factory ContextBean.fromJson(Map<String, Object?> json) =>
      _$ContextBeanFromJson(json);
}
