part of 'package:homemakers_merchant/app/features/address/index.dart';

class AddressRemoteDataSource implements AddressDataSource {
  final client = serviceLocator<IRestApiManager>();

  @override
  Future<ApiResultState<bool>> deleteAddress(
      {required int addressID,
      AddressModel? addressEntity,
      AppUserEntity? appUserEntity}) async {
    try {
      final response = await client.send(
        GlobalApp.addressCollection,
        method: RequestType.DELETE,
      );

      final result = response.data;
      if (result != null && result != Null) {
        return ApiResultState<bool>.success(
          // Todo(prasant): add key name
          data: response.data?.data[''],
        );
      } else {
        final error = response.error;
        return ApiResultState<bool>.failure(
          reason: GetApiException()
              .handleApiFailure(
            error?.model,
            statusCode: error?.statusCode,
          )
              .message
              .toString(),
        );
      }
    } on Exception catch (e, s) {
      return ApiResultState<bool>.failure(
        reason:
        GetApiException().handleHttpApiException(e).message ?? e.toString(),
        stackTrace: s,
        //exception: GetApiException().handleHttpApiException(e),
        error: e,
      );
    }
  }

  @override
  Future<ApiResultState<bool>> deleteAllAddress(
      {AppUserEntity? appUserEntity}) {
    // TODO: implement deleteAllAddress
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<AddressModel>> editAddress(
          {required AddressModel addressEntity,
          required int addressID,
          AppUserEntity? appUserEntity}) async {
    try {
      final response = await client.send(
        GlobalApp.addressCollection,
        method: RequestType.PUT,
      );

      final result = response.data;
      if (result != null && result != Null) {
        return ApiResultState<AddressModel>.success(
          data: AddressModel.fromJson(response.data?.data),
        );
      } else {
        final error = response.error;
        return ApiResultState<AddressModel>.failure(
          reason: GetApiException()
              .handleApiFailure(
            error?.model,
            statusCode: error?.statusCode,
          )
              .message
              .toString(),
        );
      }
    } on Exception catch (e, s) {
      return ApiResultState<AddressModel>.failure(
        reason:
        GetApiException().handleHttpApiException(e).message ?? e.toString(),
        stackTrace: s,
        //exception: GetApiException().handleHttpApiException(e),
        error: e,
      );
    }
  }

  @override
  Future<ApiResultState<AddressModel>> getAddress(
      {required int addressID,
      AppUserEntity? appUserEntity,
      AddressModel? addressEntity}) async {
    try {
      final response = await client.send(
        GlobalApp.addressCollection,
        method: RequestType.GET,
      );

      final result = response.data;
      if (result != null && result != Null) {
        return ApiResultState<AddressModel>.success(
          data: AddressModel.fromJson(response.data?.data),
        );
      } else {
        final error = response.error;
        return ApiResultState<AddressModel>.failure(
          reason: GetApiException()
              .handleApiFailure(
            error?.model,
            statusCode: error?.statusCode,
          )
              .message
              .toString(),
        );
      }
    } on Exception catch (e, s) {
      return ApiResultState<AddressModel>.failure(
        reason:
        GetApiException().handleHttpApiException(e).message ?? e.toString(),
        stackTrace: s,
        //exception: GetApiException().handleHttpApiException(e),
        error: e,
      );
    }
  }

  @override
  Future<ApiResultState<List<AddressModel>>> getAllAddress(
      {AppUserEntity? appUserEntity}) async {
    try {
      final response = await client.send(
        GlobalApp.addressCollection,
        method: RequestType.GET,
      );

      final result = response.data;
      if (result != null && result != Null) {
        return ApiResultState<List<AddressModel>>.success(
          data: AddressModel.fromJsonList(response.data?.data),
        );
      } else {
        final error = response.error;
        return ApiResultState<List<AddressModel>>.failure(
          reason: GetApiException()
              .handleApiFailure(
            error?.model,
            statusCode: error?.statusCode,
          )
              .message
              .toString(),
        );
      }
    } on Exception catch (e, s) {
      return ApiResultState<List<AddressModel>>.failure(
        reason:
        GetApiException().handleHttpApiException(e).message ?? e.toString(),
        stackTrace: s,
        //exception: GetApiException().handleHttpApiException(e),
        error: e,
      );
    }
  }

  @override
  Future<ApiResultState<AddressModel>> saveAddress(
      {required AddressModel addressEntity,
      AppUserEntity? appUserEntity}) async {
    try {
      final response = await client.send(
        GlobalApp.addressCollection,
        method: RequestType.POST,
      );

      final result = response.data;
      if (result != null && result != Null) {
        return ApiResultState<AddressModel>.success(
          data: AddressModel.fromJson(response.data?.data),
        );
      } else {
        final error = response.error;
        return ApiResultState<AddressModel>.failure(
          reason: GetApiException()
              .handleApiFailure(
                error?.model,
                statusCode: error?.statusCode,
              )
              .message
              .toString(),
        );
      }
    } on Exception catch (e, s) {
      return ApiResultState<AddressModel>.failure(
        reason:
            GetApiException().handleHttpApiException(e).message ?? e.toString(),
        stackTrace: s,
        //exception: GetApiException().handleHttpApiException(e),
        error: e,
      );
    }
  }

  @override
  Future<ApiResultState<List<AddressModel>>> getAllAddressPagination(
      {int pageKey = 0,
      int pageSize = 10,
      String? searchText,
      AddressModel? addressEntity,
      String? filtering,
      String? sorting,
      Timestamp? startTime,
      Timestamp? endTime}) {
    // TODO: implement getAllAddressPagination
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<AddressModel>>> saveAllAddress(
      {required List<AddressModel> addressEntities,
      bool hasUpdateAll = false}) {
    // TODO: implement saveAllCategory
    throw UnimplementedError();
  }
}
