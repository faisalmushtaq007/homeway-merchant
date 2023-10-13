import 'package:network_manager/network_manager.dart';

abstract class IResponseModel<T, E extends INetworkModel<E>?> {
  T data;
  IErrorModel<E>? error;

  IResponseModel(this.data, this.error);
}
