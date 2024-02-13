import 'package:homemakers_merchant/core/network/http/base_api_response_error_model.dart';
import 'package:homemakers_merchant/core/network/http/base_response_model.dart';
import 'package:homemakers_merchant/core/service/restApiClient/IRestApiManager.dart';
import 'package:network_manager/network_manager.dart';
import 'package:dio/dio.dart' as dio;

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
  Future<dio.Response<List<int>?>> downloadFile(
          String path, ProgressCallback? callback,
          {RequestType? method, Options? options, data}) async =>
      await client.downloadFile(
        path,
        callback,
        data: data,
        method: method,
        options: options,
      );

  @override
  Future<dio.Response<List<int>?>> downloadFileSimple(
          String path, ProgressCallback? callback) async =>
      await client.downloadFileSimple(path, callback);

  @override
  Future<bool> removeAllCache() async=> await client.removeAllCache();

  @override
  void removeHeader(String key) => client.removeHeader;

  @override
  Future<IResponseModel<BaseResponseModel?, BaseApiResponseErrorModel?>> send(
      String path,
      {BaseResponseModel parseModel = const BaseResponseModel(),
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
      await client.sendPrimitive<BaseResponseModel>(
        path,
        headers: headers,
      );

  @override
  Future<dio.Response<BaseResponseModel>> uploadFile(String path, FormData data,
          {Map<String, dynamic>? headers}) async =>
      await client.uploadFile<BaseResponseModel>(
        path,
        data,
        headers: headers,
      );
}
