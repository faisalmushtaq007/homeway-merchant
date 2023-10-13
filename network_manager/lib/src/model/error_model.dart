import 'package:network_manager/src/interface/IErrorModel.dart';
import 'package:network_manager/src/interface/INetworkModel.dart';

class ErrorModel<T extends INetworkModel<T>?> extends IErrorModel<T> {
  @override
  final int? statusCode;

  @override
  final String? description;

  ErrorModel({this.statusCode, this.description, this.model});

  @override
  final T? model;

  ErrorModel<T> copyWith({
    int? statusCode,
    String? description,
    T? model,
  }) {
    return ErrorModel<T>(
      statusCode: statusCode ?? this.statusCode,
      description: description ?? this.description,
      model: model ?? this.model,
    );
  }
}
