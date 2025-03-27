import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';

class NetworkException extends Equatable implements Exception {
  late final String message; // Error message describing the exception
  late final int?
      statusCode; // HTTP status code associated with the error, if available

  // Constructor to create a NetworkException from a DioException
  NetworkException.fromDioError(DioException dioException) {
    statusCode = dioException.response?.statusCode;

    // Handle different types of Dio exceptions
    switch (dioException.type) {
      case DioExceptionType.badResponse:
        // Error due to an invalid HTTP response
        message =
            'Received invalid response with status code: ${dioException.response?.statusCode}';
        break;

      case DioExceptionType.badCertificate:
        // Error due to an invalid SSL certificate
        message = 'The certificate provided is invalid';
        break;

      case DioExceptionType.connectionTimeout:
        // Error due to a connection timeout
        message = 'Connection to the server timed out';
        break;

      case DioExceptionType.sendTimeout:
        // Error due to a timeout while sending the request
        message = 'Timeout occurred while sending the request';
        break;

      case DioExceptionType.receiveTimeout:
        // Error due to a timeout while receiving data
        message = 'Timeout occurred while receiving data from the server';
        break;

      case DioExceptionType.cancel:
        // Error due to the request being cancelled
        message = 'The request to the server was cancelled';
        break;

      case DioExceptionType.connectionError:
        // Error due to a network connection issue
        if (dioException.error is SocketException) {
          message =
              'No internet connection. Please check your network settings';
        } else {
          message = 'Network connection error occurred';
        }
        break;

      case DioExceptionType.unknown:
        // Error due to an unknown issue
        message = 'An unknown error occurred';
        break;
    }
  }

  @override
  List<Object?> get props =>
      [message, statusCode]; // Equatable properties for comparison
}
