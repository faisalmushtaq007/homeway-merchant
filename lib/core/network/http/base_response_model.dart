import 'package:json_annotation/json_annotation.dart';
import 'package:network_manager/network_manager.dart';

part 'base_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BaseResponseModel<T extends INetworkModel<T>>
    extends INetworkModel<BaseResponseModel<T>> {
  BaseResponseModel({
    this.status,
    this.message,
    this.data,
    this.code,
    this.result,
    this.id,
    this.jsonrpc = '2.0',
  });
  factory BaseResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseModelFromJson(json, fromJsonT);

  final dynamic status;
  final String? message;
  final T? data;
  final int? code;
  @JsonKey(name: 'jsonrpc')
  final String? jsonrpc;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'result')
  final T? result;

  @override
  BaseResponseModel<T> fromJson(Map<String, dynamic> json) {
    return BaseResponseModel<T>.fromJson(
      json,
      (json) => json as T,
    );
  }

  Map<String, dynamic> toMap(
    Object Function(T value) toJsonT,
  ) =>
      _$BaseResponseModelToJson(this, toJsonT);

  @override
  Map<String, dynamic>? toJson() {
    return BaseResponseModel<T>().toMap((value) => value);
  }
}
