import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homemakers_merchant/core/network/http/failure/network_exception_model.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:logger/logger.dart';
import 'package:network_manager/network_manager.dart';

part 'network_exception.freezed.dart';

Logger log = Logger();

@freezed
class NetworkException with _$NetworkException {
  const factory NetworkException.defaultError({
    @Default(000) int statusCode,
    ErrorBean? error,
  }) = DefaultError;

  const factory NetworkException.movedPermanently({
    @Default(HttpResponseCode.movedPermanently) int statusCode,
    ErrorBean? error,
  }) = MovedPermanently;

  const factory NetworkException.found({
    @Default(HttpResponseCode.found) int statusCode,
    ErrorBean? error,
  }) = Found;

  const factory NetworkException.movedTemporarily({
    @Default(HttpResponseCode.movedTemporarily) int statusCode,
    ErrorBean? error,
  }) = MovedTemporarily;

  const factory NetworkException.notModified({
    @Default(HttpResponseCode.notModified) int statusCode,
    ErrorBean? error,
  }) = NotModified;

  const factory NetworkException.useProxy({
    @Default(HttpResponseCode.useProxy) int statusCode,
    ErrorBean? error,
  }) = UseProxy;

  const factory NetworkException.temporaryRedirect({
    @Default(HttpResponseCode.temporaryRedirect) int statusCode,
    ErrorBean? error,
  }) = TemporaryRedirect;

  const factory NetworkException.permanentRedirect({
    @Default(HttpResponseCode.permanentRedirect) int statusCode,
    ErrorBean? error,
  }) = PermanentRedirect;

  const factory NetworkException.badRequest({
    @Default(HttpResponseCode.badRequest) int statusCode,
    ErrorBean? error,
  }) = BadRequest;

  const factory NetworkException.unauthorized({
    @Default(HttpResponseCode.unauthorized) int statusCode,
    ErrorBean? error,
  }) = Unauthorized;

  const factory NetworkException.forbidden({
    @Default(HttpResponseCode.forbidden) int statusCode,
    ErrorBean? error,
  }) = Forbidden;

  const factory NetworkException.notFound({
    @Default(HttpResponseCode.notFound) int statusCode,
    ErrorBean? error,
  }) = NotFound;

  const factory NetworkException.methodNotAllowed({
    @Default(HttpResponseCode.methodNotAllowed) int statusCode,
    ErrorBean? error,
  }) = MethodNotAllowed;

  const factory NetworkException.notAcceptable({
    @Default(HttpResponseCode.notAcceptable) int statusCode,
    ErrorBean? error,
  }) = NotAcceptable;

  const factory NetworkException.proxyAuthenticationRequired({
    @Default(HttpResponseCode.proxyAuthenticationRequired) int statusCode,
    ErrorBean? error,
  }) = ProxyAuthenticationRequired;

  const factory NetworkException.requestTimeout({
    @Default(HttpResponseCode.requestTimeout) int statusCode,
    ErrorBean? error,
  }) = RequestTimeout;

  const factory NetworkException.conflict({
    @Default(HttpResponseCode.conflict) int statusCode,
    ErrorBean? error,
  }) = Conflict;

  const factory NetworkException.lengthRequired({
    @Default(HttpResponseCode.lengthRequired) int statusCode,
    ErrorBean? error,
  }) = LengthRequired;

  const factory NetworkException.requestEntityTooLarge({
    @Default(HttpResponseCode.requestEntityTooLarge) int statusCode,
    ErrorBean? error,
  }) = RequestEntityTooLarge;

  const factory NetworkException.requestUriTooLong({
    @Default(HttpResponseCode.requestUriTooLong) int statusCode,
    ErrorBean? error,
  }) = RequestUriTooLong;

  const factory NetworkException.unsupportedMediaType({
    @Default(HttpResponseCode.unsupportedMediaType) int statusCode,
    ErrorBean? error,
  }) = UnsupportedMediaType;

  const factory NetworkException.expectationFailed({
    @Default(HttpResponseCode.expectationFailed) int statusCode,
    ErrorBean? error,
  }) = ExpectationFailed;

  const factory NetworkException.locked({
    @Default(HttpResponseCode.locked) int statusCode,
    ErrorBean? error,
  }) = Locked;

  const factory NetworkException.upgradeRequired({
    @Default(HttpResponseCode.upgradeRequired) int statusCode,
    ErrorBean? error,
  }) = UpgradeRequired;

  const factory NetworkException.tooManyRequests({
    @Default(HttpResponseCode.tooManyRequests) int statusCode,
    ErrorBean? error,
  }) = TooManyRequests;

  const factory NetworkException.requestHeaderFieldsTooLarge({
    @Default(HttpResponseCode.requestHeaderFieldsTooLarge) int statusCode,
    ErrorBean? error,
  }) = RequestHeaderFieldsTooLarge;

  const factory NetworkException.unavailableForLegalReasons({
    @Default(HttpResponseCode.unavailableForLegalReasons) int statusCode,
    ErrorBean? error,
  }) = UnavailableForLegalReasons;

  const factory NetworkException.clientClosedRequest({
    @Default(HttpResponseCode.clientClosedRequest) int statusCode,
    ErrorBean? error,
  }) = ClientClosedRequest;

  const factory NetworkException.internalServerError({
    @Default(HttpResponseCode.internalServerError) int statusCode,
    ErrorBean? error,
  }) = InternalServerError;

  const factory NetworkException.notImplemented({
    @Default(HttpResponseCode.notImplemented) int statusCode,
    ErrorBean? error,
  }) = NotImplemented;

  const factory NetworkException.badGateway({
    @Default(HttpResponseCode.badGateway) int statusCode,
    ErrorBean? error,
  }) = BadGateway;

  const factory NetworkException.serviceUnavailable({
    @Default(HttpResponseCode.serviceUnavailable) int statusCode,
    ErrorBean? error,
  }) = ServiceUnavailable;

  const factory NetworkException.gatewayTimeout({
    @Default(HttpResponseCode.gatewayTimeout) int statusCode,
    ErrorBean? error,
  }) = GatewayTimeout;

  const factory NetworkException.httpVersionNotSupported({
    @Default(HttpResponseCode.httpVersionNotSupported) int statusCode,
    ErrorBean? error,
  }) = HttpVersionNotSupported;

  const factory NetworkException.insufficientStorage({
    @Default(HttpResponseCode.insufficientStorage) int statusCode,
    ErrorBean? error,
  }) = InsufficientStorage;

  const factory NetworkException.loopDetected({
    @Default(HttpResponseCode.loopDetected) int statusCode,
    ErrorBean? error,
  }) = LoopDetected;

  const factory NetworkException.bandwidthLimitExceeded({
    @Default(HttpResponseCode.bandwidthLimitExceeded) int statusCode,
    ErrorBean? error,
  }) = BandwidthLimitExceeded;

  const factory NetworkException.notExtended({
    @Default(HttpResponseCode.notExtended) int statusCode,
    ErrorBean? error,
  }) = NotExtended;

  const factory NetworkException.networkAuthenticationRequired({
    @Default(HttpResponseCode.networkAuthenticationRequired) int statusCode,
    ErrorBean? error,
  }) = NetworkAuthenticationRequired;

  const factory NetworkException.networkReadTimeoutError({
    @Default(HttpResponseCode.networkReadTimeoutError) int statusCode,
    ErrorBean? error,
  }) = NetworkReadTimeoutError;

  const factory NetworkException.networkConnectTimeoutError({
    @Default(HttpResponseCode.networkConnectTimeoutError) int statusCode,
    ErrorBean? error,
  }) = NetworkConnectTimeoutError;

  const factory NetworkException.formatException({
    @Default(001) int statusCode,
    ErrorBean? error,
  }) = FormatException;

  const factory NetworkException.unableToProcess({
    @Default(002) int statusCode,
    ErrorBean? error,
  }) = UnableToProcess;

  const factory NetworkException.unexpectedError({
    @Default(003) int statusCode,
    ErrorBean? error,
  }) = UnexpectedError;

  const factory NetworkException.sendTimeout({
    @Default(004) int statusCode,
    ErrorBean? error,
  }) = SendTimeout;

  const factory NetworkException.noInternetConnection({
    @Default(005) int statusCode,
    ErrorBean? error,
  }) = NoInternetConnection;

  const factory NetworkException.requestCancelled({
    @Default(006) int statusCode,
    ErrorBean? error,
  }) = RequestCancelled;

  const factory NetworkException.badCertificate({
    @Default(HttpResponseCode.badCertificateError) int statusCode,
    ErrorBean? error,
  }) = BadCertificate;

  static NetworkException getDioException(dynamic error) {
    if (error is Exception) {
      try {
        NetworkException networkException = const NetworkException.notFound();
        // Dio Error
        if (error is DioError) {
          var errorData = error.response?.data;
          if (errorData == null) {
            errorData = const ErrorBean(
              code: 000,
              message: 'Something went wrong, error is null',
              data: DataBean(),
            );
          } else if (error.response?.headers != null &&
              error.response?.headers.value('content-type') ==
                  'text/html; charset=utf-8') {
            final htmlDocument = html_parser.parse(errorData);
            var currentMessage =
                htmlDocument.getElementsByTagName('pre').first.innerHtml;
            log.e('NetworkException -> $currentMessage');
            errorData = ErrorBean(
              code: 000,
              message: currentMessage,
              data: const DataBean(),
            );
          }
          switch (error.type) {
            case DioErrorType.cancel:
              networkException = NetworkException.requestCancelled(
                error: errorData,
              );
              break;
            case DioErrorType.sendTimeout:
              networkException = NetworkException.requestTimeout(
                error: errorData,
              );
              break;
            case DioErrorType.unknown:
              networkException = NetworkException.noInternetConnection(
                error: errorData,
              );
              break;
            case DioErrorType.receiveTimeout:
              networkException = NetworkException.sendTimeout(
                error: errorData,
              );
              break;
            case DioErrorType.connectionTimeout:
              networkException = NetworkException.networkConnectTimeoutError(
                error: errorData,
              );
              break;
            case DioErrorType.badCertificate:
              networkException = NetworkException.badCertificate(
                error: errorData,
              );
              break;
            case DioErrorType.connectionError:
              networkException = NetworkException.serviceUnavailable(
                error: errorData,
              );
              break;
            case DioErrorType.badResponse:
              switch (error.response?.statusCode) {
                case HttpResponseCode.movedPermanently:
                  networkException = NetworkException.movedPermanently(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.movedTemporarily:
                  networkException = NetworkException.movedTemporarily(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.temporaryRedirect:
                  networkException = NetworkException.temporaryRedirect(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.permanentRedirect:
                  networkException = NetworkException.permanentRedirect(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.badRequest:
                  networkException = NetworkException.badRequest(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.unauthorized:
                  networkException = NetworkException.unauthorized(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.forbidden:
                  networkException = NetworkException.forbidden(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.notFound:
                  networkException = NetworkException.notFound(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.methodNotAllowed:
                  networkException = NetworkException.methodNotAllowed(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.notAcceptable:
                  networkException = NetworkException.notAcceptable(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.requestTimeout:
                  networkException = NetworkException.requestTimeout(
                    error: errorData,
                  );
                  break;
                case 409:
                  networkException = NetworkException.conflict(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.requestEntityTooLarge:
                  networkException = NetworkException.requestEntityTooLarge(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.requestUriTooLong:
                  networkException = NetworkException.requestUriTooLong(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.unsupportedMediaType:
                  networkException = NetworkException.unsupportedMediaType(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.locked:
                  networkException = NetworkException.locked(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.tooManyRequests:
                  networkException = NetworkException.tooManyRequests(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.clientClosedRequest:
                  networkException = NetworkException.clientClosedRequest(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.internalServerError:
                  networkException = NetworkException.internalServerError(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.notImplemented:
                  networkException = NetworkException.notImplemented(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.badGateway:
                  networkException = NetworkException.badGateway(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.serviceUnavailable:
                  networkException = NetworkException.serviceUnavailable(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.gatewayTimeout:
                  networkException = NetworkException.gatewayTimeout(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.httpVersionNotSupported:
                  networkException = NetworkException.httpVersionNotSupported(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.insufficientStorage:
                  networkException = NetworkException.insufficientStorage(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.bandwidthLimitExceeded:
                  networkException = NetworkException.bandwidthLimitExceeded(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.notExtended:
                  networkException = NetworkException.notExtended(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.networkAuthenticationRequired:
                  networkException =
                      NetworkException.networkAuthenticationRequired(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.networkReadTimeoutError:
                  networkException = NetworkException.networkReadTimeoutError(
                    error: errorData,
                  );
                  break;
                case HttpResponseCode.networkConnectTimeoutError:
                  networkException =
                      NetworkException.networkConnectTimeoutError(
                    error: errorData,
                  );
                  break;
                default:
                  var responseCode = error.response?.statusCode;
                  networkException = NetworkException.defaultError(
                    error: ErrorBean(
                      code: 000,
                      message:
                          'Received invalid status code: ${responseCode ?? 000}',
                      data: const DataBean(),
                    ),
                    statusCode: responseCode ?? 000,
                  );
              }
              break;
            case DioErrorType.sendTimeout:
              networkException = NetworkException.sendTimeout(
                error: errorData,
              );
              break;
          }
        }
        // Socket Exception
        else if (error is SocketException) {
          networkException = NetworkException.noInternetConnection(
            error: ErrorBean(
              code: 000,
              message: error.message,
              data: const DataBean(),
            ),
            statusCode: 000,
          );
        } else {
          networkException = const NetworkException.unexpectedError(
            error: ErrorBean(
              code: 000,
              message: 'Something went wrong, unexpectedError',
              data: DataBean(),
            ),
            statusCode: 000,
          );
        }
        return networkException;
      } on FormatException catch (e) {
        // Helper.printError(e.toString());
        return NetworkException.formatException(
          error: ErrorBean(
            code: 000,
            message: e.toString(),
            data: const DataBean(),
          ),
          statusCode: 000,
        );
      } on Exception catch (e) {
        return NetworkException.unexpectedError(
          error: ErrorBean(
            code: 000,
            message: e.toString(),
            data: const DataBean(),
          ),
          statusCode: 000,
        );
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return NetworkException.unableToProcess(
          error: ErrorBean(
            code: 000,
            message: error.toString(),
            data: const DataBean(),
          ),
          statusCode: 000,
        );
      } else {
        return const NetworkException.unexpectedError(
          error: ErrorBean(
            code: 000,
            message: 'Something went wrong, unexpectedError',
            data: DataBean(),
          ),
          statusCode: 000,
        );
      }
    }
  }
}
