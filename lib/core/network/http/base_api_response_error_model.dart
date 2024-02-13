import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:network_manager/network_manager.dart';

part 'base_api_response_error_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  genericArgumentFactories: true,
)
class BaseApiResponseErrorModel
    extends INetworkModel<BaseApiResponseErrorModel> {
  @JsonKey(name: "correlationId")
  final String? correlationId;
  @JsonKey(name: "error")
  final BaseResponseError? error;
  @JsonKey(name: "success")
  final int? success;

  const BaseApiResponseErrorModel({
    this.correlationId,
    this.error,
    this.success,
  });

  factory BaseApiResponseErrorModel.fromJson(Map<String, dynamic> json) =>
      _$BaseApiResponseErrorModelFromJson(json);

  Map<String, dynamic> toMap() => _$BaseApiResponseErrorModelToJson(
        this,
      );

  @override
  BaseApiResponseErrorModel fromJson(Map<String, dynamic> json) {
    return BaseApiResponseErrorModel.fromJson(
      json,
    );
  }

  @override
  Map<String, dynamic>? toJson() => toMap();
}

@JsonSerializable(
  explicitToJson: true,
  genericArgumentFactories: true,
)
class BaseResponseError {
  @JsonKey(name: "code")
  final String code;
  @JsonKey(name: "message")
  final String message;

  BaseResponseError({
    required this.code,
    required this.message,
  });

  factory BaseResponseError.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseErrorFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseErrorToJson(this);
}
