import 'package:json_annotation/json_annotation.dart';
import 'package:network_manager/network_manager.dart';

part 'base_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BaseResponseModel<T extends INetworkModel<T>>
    extends INetworkModel<BaseResponseModel<T>> {
  BaseResponseModel({
    this.message,
    this.data,
    this.result,
    this.success,
    this.remaining_attempts,
    this.correlationId,
  });
  factory BaseResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseModelFromJson(json, fromJsonT);

  final String? message;
  @JsonKey(name: 'data')
  final T? data;
  @JsonKey(name: 'result')
  final T? result;
  @JsonKey(
    name: 'success',
    defaultValue: true,
  )
  final bool? success;
  @JsonKey(
    name: 'remaining_attempts',
    defaultValue: 5,
  )
  final int? remaining_attempts;
  @JsonKey(name: 'correlationId')
  final String? correlationId;

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
