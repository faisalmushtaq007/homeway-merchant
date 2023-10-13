import 'package:network_manager/src/interface/INetworkModel.dart';

abstract class IErrorModel<T extends INetworkModel?> {
  int? statusCode;
  String? description;
  T? model;
}
