import 'package:json_annotation/json_annotation.dart';

part 'base_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BaseRequestModel<T> {
  BaseRequestModel({
    this.jsonrpc = '2.0',
    this.data,
  });
  factory BaseRequestModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseRequestModelFromJson(json, fromJsonT);

  @JsonKey(name: 'jsonrpc')
  final String? jsonrpc;
  @JsonKey(name: 'params')
  final T? data;

  Map<String, dynamic> toJson(
    Object Function(T value) toJsonT,
  ) =>
      _$BaseRequestModelToJson(this, toJsonT);
}
