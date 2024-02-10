import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:network_manager/network_manager.dart';

import 'generic_json_parser/src/types.dart';

part 'base_response_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  genericArgumentFactories: true,
)
class BaseResponseModel extends INetworkModel<BaseResponseModel>
    with EquatableMixin {
  BaseResponseModel({
    this.data,
    this.success,
    this.correlationId,
  });

  @JsonKey(
    name: 'data',
  )
  final dynamic data;
  @JsonKey(
    name: 'success',
    defaultValue: 0,
  )
  final int? success;
  @JsonKey(name: 'correlationId')
  final String? correlationId;

  factory BaseResponseModel.fromMap(
      Map<String, dynamic> json,
      ) {
    return BaseResponseModel(
      data: json['data'] as dynamic,
      success: json['success'],
      correlationId: json['correlationId'],
    );
  }

  @override
  BaseResponseModel fromJson(Map<String, dynamic> json) {
    return BaseResponseModel.fromMap(json,);
  }

  @override
  List<Object?> get props => [correlationId, data, success];

  @override
  bool? get stringify => true;

  Map<String, dynamic> toMap() => <String, dynamic>{
    'data': this.data,
    'success': this.success,
    'correlationId': this.correlationId,
  };

  @override
  Map<String, dynamic>? toJson() {
    return toMap();
  }

  T parseJsonObject<T, F>(
      dynamic data, FromJsonCallback<T, F> fromJson) {
// ignore: prefer_typing_uninitialized_variables

    final parsed = jsonDecode(data);
    return fromJson(parsed);
  }

  List<T> parseJsonList<T, F>(
      dynamic data,
      FromJsonCallback<T, F> fromJson,
      ) {
// ignore: prefer_typing_uninitialized_variables

    final parsed = jsonDecode(data).cast<Map<String, dynamic>>();
    return parsed.map<T>(fromJson).toList();
  }

}





