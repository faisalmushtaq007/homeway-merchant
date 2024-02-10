import 'package:json_annotation/json_annotation.dart';

part 'base_request_model.g.dart';

@JsonSerializable(explicitToJson: true,genericArgumentFactories: true)
class BaseRequestModel<T> {
  BaseRequestModel({
    this.correlationId,
    this.data,
  });
  factory BaseRequestModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseRequestModelFromJson(json, fromJsonT);

  T? data;
  @JsonKey(name: 'correlationId')
  final String? correlationId;

  Map<String, dynamic> toJson(
    Object Function(T value) toJsonT,
  ) =>
      _$BaseRequestModelToJson(this, toJsonT);
}
