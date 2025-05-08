import 'package:dio/dio.dart';

/// Base failure class for all errors
abstract class Failure {
  /// Error message
  final String errMessage;

  /// Constructor
  Failure(this.errMessage);
}

/// Server-related failures
class ServerFailure extends Failure {
  /// HTTP status code (if applicable)
  final int? statusCode;

  /// Raw response data
  final dynamic responseData;

  /// Constructor
  ServerFailure(
      String errMessage, {
        this.statusCode,
        this.responseData,
      }) : super(errMessage);

  /// Create a failure from a DioError
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with API server');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with API server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with API server');
      case DioExceptionType.badCertificate:
        return ServerFailure('Invalid SSL certificate');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response!.statusCode!,
          dioError.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request to API server was canceled');
      case DioExceptionType.connectionError:
        return ServerFailure('Connection error. Please check your internet connection');
      case DioExceptionType.unknown:
        if (dioError.message != null && dioError.message!.contains('Socket Exception')) {
          return ServerFailure('No internet connection');
        }
        return ServerFailure('Unexpected error: ${dioError.message}');
    }
  }

  /// Create a failure from an HTTP response
  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      String message = 'Authorization error';
      if (response is Map && response.containsKey('error')) {
        if (response['error'] is Map && response['error'].containsKey('errorMessage')) {
          message = response['error']['errorMessage'];
        } else if (response['error'] is String) {
          message = response['error'];
        }
      } else if (response is Map && response.containsKey('message')) {
        message = response['message'];
      }
      return ServerFailure(message, statusCode: statusCode, responseData: response);
    } else if (statusCode == 404) {
      return ServerFailure(
        'Resource not found, please try again later',
        statusCode: statusCode,
        responseData: response,
      );
    } else if (statusCode == 500) {
      return ServerFailure(
        'Internal server error, please try again later',
        statusCode: statusCode,
        responseData: response,
      );
    } else {
      return ServerFailure(
        'Unexpected error occurred (Status code: $statusCode)',
        statusCode: statusCode,
        responseData: response,
      );
    }
  }
}

/// Network-related failures
class NetworkFailure extends Failure {
  NetworkFailure(String errMessage) : super(errMessage);
}

/// Validation-related failures
class ValidationFailure extends Failure {
  ValidationFailure(String errMessage) : super(errMessage);
}