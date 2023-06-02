import 'dart:convert';

import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/network/http/base_response_error_model.dart';
import 'package:homemakers_merchant/core/network/http/failure/network_exception.dart';
import 'package:network_manager/network_manager.dart';

mixin class ExceptionMixins {
  void handleUnCaughtException(Exception exception) {}

  BaseResponseErrorModel handleHttpApiException(Exception exception) {
    final NetworkException networkException =
        NetworkException.getDioException(exception);
    return networkException.when(
      defaultError: _getHttpApiExceptionResponse,
      movedPermanently: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'movedPermanently', data),
      found: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'found', data),
      movedTemporarily: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'movedTemporarily', data),
      notModified: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'notModified', data),
      useProxy: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'useProxy', data),
      temporaryRedirect: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'temporaryRedirect', data),
      permanentRedirect: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'permanentRedirect', data),
      badRequest: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'badRequest', data),
      unauthorized: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'unauthorized', data),
      forbidden: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'forbidden', data),
      notFound: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'notFound', data),
      methodNotAllowed: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'methodNotAllowed', data),
      notAcceptable: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'notAcceptable', data),
      proxyAuthenticationRequired: (statusCode, data) =>
          _getHttpApiExceptionResponse(
              statusCode, 'proxyAuthenticationRequired', data),
      requestTimeout: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'requestTimeout', data),
      conflict: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'conflict', data),
      lengthRequired: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'lengthRequired', data),
      requestEntityTooLarge: (statusCode, data) => _getHttpApiExceptionResponse(
          statusCode, 'requestEntityTooLarge', data),
      requestUriTooLong: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'requestUriTooLong', data),
      unsupportedMediaType: (statusCode, data) => _getHttpApiExceptionResponse(
          statusCode, 'unsupportedMediaType', data),
      expectationFailed: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'expectationFailed', data),
      locked: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'locked', data),
      upgradeRequired: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'upgradeRequired', data),
      tooManyRequests: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'tooManyRequests', data),
      requestHeaderFieldsTooLarge: (statusCode, data) =>
          _getHttpApiExceptionResponse(
              statusCode, 'requestHeaderFieldsTooLarge', data),
      unavailableForLegalReasons: (statusCode, data) =>
          _getHttpApiExceptionResponse(
              statusCode, 'unavailableForLegalReasons', data),
      clientClosedRequest: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'clientClosedRequest', data),
      internalServerError: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'internalServerError', data),
      notImplemented: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'notImplemented', data),
      badGateway: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'badGateway', data),
      serviceUnavailable: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'serviceUnavailable', data),
      gatewayTimeout: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'gatewayTimeout', data),
      httpVersionNotSupported: (statusCode, data) =>
          _getHttpApiExceptionResponse(
              statusCode, 'httpVersionNotSupported', data),
      insufficientStorage: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'insufficientStorage', data),
      loopDetected: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'loopDetected', data),
      bandwidthLimitExceeded: (statusCode, data) =>
          _getHttpApiExceptionResponse(
              statusCode, 'bandwidthLimitExceeded', data),
      notExtended: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'notExtended', data),
      networkAuthenticationRequired: (statusCode, data) =>
          _getHttpApiExceptionResponse(
              statusCode, 'networkAuthenticationRequired', data),
      networkReadTimeoutError: (statusCode, data) =>
          _getHttpApiExceptionResponse(
              statusCode, 'networkReadTimeoutError', data),
      networkConnectTimeoutError: (statusCode, data) =>
          _getHttpApiExceptionResponse(
              statusCode, 'networkConnectTimeoutError', data),
      formatException: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'formatException', data),
      unableToProcess: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'unableToProcess', data),
      unexpectedError: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'unexpectedError', data),
      sendTimeout: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'sendTimeout', data),
      noInternetConnection: (statusCode, data) => _getHttpApiExceptionResponse(
          statusCode, 'noInternetConnection', data),
      requestCancelled: (statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'requestCancelled', data),
      badCertificate: (int statusCode, data) =>
          _getHttpApiExceptionResponse(statusCode, 'badCertificate', data),
    );
  }

  BaseResponseErrorModel handleApiFailure(BaseResponseErrorModel? responseModel,
      {String? defaultMessage}) {
    if (responseModel != null &&
        responseModel.error != null &&
        responseModel.error!.model != null) {
      return responseModel.error?.model as BaseResponseErrorModel;
    } else {
      return BaseResponseErrorModel(
        code: 0,
        message: defaultMessage ?? GlobalApp.defaultSomethingWentWrong,
        status: GlobalApp.defaultFailure,
        error: <String, dynamic>{},
      );
    }
  }

  BaseResponseErrorModel _getHttpApiExceptionResponse(
    int statusCode,
    String error,
    dynamic data,
  ) {
    BaseResponseErrorModel baseResponseErrorModel = BaseResponseErrorModel();
    if (data == null) {
      baseResponseErrorModel = BaseResponseErrorModel(
        code: 0,
        message: GlobalApp.defaultSomethingWentWrong,
        status: 'Failure',
        error: <String, dynamic>{},
      );
    } else if (data is String || data is Map<String, dynamic>) {
      final json =
          data is String ? jsonDecode(data) : data as Map<String, dynamic>;
      baseResponseErrorModel = BaseResponseErrorModel(
        code: statusCode,
        message: error,
        status: 'Failure',
        error: json,
      );
    }
    return baseResponseErrorModel;
  }
}

class GetApiException with ExceptionMixins {}
