import 'package:dio/dio.dart';

import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(Exception error) {
    if (error is DioError) {
      failure = _handleError(error);
    } else {
      failure = ErrorType.unKnown.getFailure();
    }
  }

  Failure _handleError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectTimeout:
        return ErrorType.connectTimeOut.getFailure();
      case DioErrorType.sendTimeout:
        return ErrorType.sendTimeOut.getFailure();
      case DioErrorType.receiveTimeout:
        return ErrorType.receiveTimeOut.getFailure();
      case DioErrorType.response:
        {
          if (dioError.response?.statusMessage != null &&
              dioError.response?.statusCode != null) {
            return Failure(
              dioError.response!.statusCode!,
              dioError.response!.data["message"],
            );
          } else {
            return ErrorType.unKnown.getFailure();
          }
        }
      case DioErrorType.cancel:
        return ErrorType.cancel.getFailure();
      case DioErrorType.other:
        return ErrorType.unKnown.getFailure();
    }
  }
}

enum ErrorType {
  success,
  noContent,
  badRequest,
  unAuthorized,
  forbidden,
  notFound,
  internalServerError,
  connectTimeOut,
  cancel,
  receiveTimeOut,
  sendTimeOut,
  cacheError,
  noInternetConnection,
  wrongOTP,
  unKnown,
}

extension ErrorTypeExtension on ErrorType {
  Failure getFailure() {
    switch (this) {
      case ErrorType.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case ErrorType.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);
      case ErrorType.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case ErrorType.unAuthorized:
        return Failure(ResponseCode.unAuthorized, ResponseMessage.unAuthorized);
      case ErrorType.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case ErrorType.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case ErrorType.internalServerError:
        return Failure(
          ResponseCode.internalServerError,
          ResponseMessage.internalServerError,
        );
      case ErrorType.connectTimeOut:
        return Failure(
            ResponseCode.connectTimeOut, ResponseMessage.connectTimeOut);
      case ErrorType.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case ErrorType.receiveTimeOut:
        return Failure(
          ResponseCode.receiveTimeOut,
          ResponseMessage.receiveTimeOut,
        );
      case ErrorType.sendTimeOut:
        return Failure(ResponseCode.sendTimeOut, ResponseMessage.sendTimeOut);
      case ErrorType.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case ErrorType.noInternetConnection:
        return Failure(
          ResponseCode.noInternetConnection,
          ResponseMessage.noInternetConnection,
        );
      case ErrorType.unKnown:
        return Failure(ResponseCode.unKnown, ResponseMessage.unKnown);
      case ErrorType.wrongOTP:
        return Failure(ResponseCode.wrongOTP, ResponseMessage.wrongOTP);
    }
  }
}

class ResponseCode {
  static const int success = 200; // success with response having data
  static const int noContent = 201; // success with response not having data
  static const int badRequest = 400; // failure, API rejected request
  static const int unAuthorized = 401; // failure, user is not authorized
  static const int forbidden = 403; // failure, API rejected request
  static const int notFound = 404; // failure, not found
  static const int internalServerError = 500; // failure, crash in server side

  /// local status codes (didn't reach server)
  static const int connectTimeOut = -1;
  static const int cancel = -2;
  static const int receiveTimeOut = -3;
  static const int sendTimeOut = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int wrongOTP = -7;
  static const int unKnown = -8;
}

class ResponseMessage {
  static const String success = "Success";
  static const String noContent = "Success";
  static const String badRequest = "Bad request, try again later.";
  static const String unAuthorized = "User is unauthorized, try again later";
  static const String forbidden = "Forbidden request, try again later.";
  static const String notFound = "Not found, try again later.";
  static const String internalServerError = "Something went wrong, try again.";

  /// local status codes (didn't reach server)
  static const String connectTimeOut = "Time out error, try again.";
  static const String cancel = "Request was cancelled, try again.";
  static const String receiveTimeOut = "Receive time error, try again.";
  static const String sendTimeOut = "Time out error, try again.";
  static const String cacheError = "Cache error, try again later.";
  static const String noInternetConnection =
      "Please check your internet connection.";
  static const String wrongOTP = "The code you entered isn't correct!!";
  static const String unKnown = "Something went wrong, try again.";
}

class APIInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
