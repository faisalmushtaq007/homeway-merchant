import 'package:dio/src/cancel_token.dart';
import 'package:dio/src/dio_mixin.dart';
import 'package:dio/src/form_data.dart';
import 'package:dio/src/options.dart';
import 'package:dio/src/response.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/core/network/http/base_api_response_error_model.dart';
import 'package:homemakers_merchant/core/network/http/base_response_model.dart';
import 'package:homemakers_merchant/core/service/restApiClient/IRestApiManager.dart';
import 'package:network_manager/network_manager.dart';
import 'package:network_manager/src/interface/IResponseModel.dart';
import 'package:network_manager/src/model/enum/request_type.dart';

class RestApiClient implements IRestApiManager {
  const RestApiClient({required this.client});
  final INetworkManager<BaseApiResponseErrorModel> client;

  @override
  void addBaseHeader(MapEntry<String, String> key) => client.addBaseHeader;

  @override
  // TODO: implement allHeaders
  Map<String, dynamic> get allHeaders => client.allHeaders;

  @override
  void clearHeader() => client.clearHeader;

  @override
  Interceptors get dioInterceptors => client.dioInterceptors;

  @override
  Future<Response<List<int>?>> downloadFile(
          String path, ProgressCallback? callback,
          {RequestType? method, Options? options, data}) async=>
      await client.downloadFile;

  @override
  Future<Response<List<int>?>> downloadFileSimple(
          String path, ProgressCallback? callback) async=>
      await client.downloadFileSimple;

  @override
  Future<bool> removeAllCache() async=> await client.removeAllCache;

  @override
  void removeHeader(String key) => client.removeHeader;

  @override
  Future<IResponseModel<BaseResponseModel?, BaseApiResponseErrorModel?>> send(
      String path,
      {BaseResponseModel parseModel = BaseResponseModel(),
      required RequestType method,
      String? urlSuffix,
      Map<String, dynamic>? queryParameters,
      Options? options,
      Duration? expiration,
      data,
      ProgressCallback? onReceiveProgress,
      CancelToken? cancelToken,
      bool isErrorDialog = false,
      bool? forceUpdateDecode}) async {
    final response = await client.send<BaseResponseModel, BaseResponseModel>(
      path,
      parseModel: parseModel,
      method: method,
      data: data,
    );
    return response;
  }

  @override
  Future<BaseResponseModel?> sendPrimitive(String path,
          {Map<String, dynamic>? headers}) async =>
      await client.sendPrimitive<BaseResponseModel>(path);

  @override
  Future<Response<BaseResponseModel>> uploadFile(String path, FormData data,
          {Map<String, dynamic>? headers}) async =>
      await client.uploadFile<BaseResponseModel>(path, data);
}
