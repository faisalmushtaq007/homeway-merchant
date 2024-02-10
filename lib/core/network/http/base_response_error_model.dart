import 'package:json_annotation/json_annotation.dart';
import 'package:network_manager/network_manager.dart';

part 'base_response_error_model.g.dart';

@JsonSerializable(explicitToJson: true,genericArgumentFactories: true)
class BaseResponseErrorModel extends INetworkModel<BaseResponseErrorModel> {
  BaseResponseErrorModel({
    this.status,
    this.message,
    this.error,
    this.code,
  });
  factory BaseResponseErrorModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$BaseResponseErrorModelFromJson(json);

  final dynamic status;
  final String? message;
  final dynamic error;
  final int? code;


  @override
  BaseResponseErrorModel fromJson(Map<String, dynamic> json) {
    return BaseResponseErrorModel.fromJson(
      json,
    );
  }

  Map<String, dynamic> toMap() => _$BaseResponseErrorModelToJson(this);
  @override
  Map<String, dynamic> toJson() => toMap();
}

