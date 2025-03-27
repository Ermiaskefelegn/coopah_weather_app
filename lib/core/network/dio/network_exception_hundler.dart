import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';

class NetworkException extends Equatable implements Exception {
  late final String message;
  late final int? statusCode;

  NetworkException.fromDioError(DioException dioException) {
    statusCode = dioException.response?.statusCode;

    switch (dioException.type) {
      case DioExceptionType.badResponse:
        message =
            'Received invalid response with status code: ${dioException.response?.statusCode}';
        break;

      case DioExceptionType.badCertificate:
        message = 'The certificate provided is invalid';
        break;

      case DioExceptionType.connectionTimeout:
        message = 'Connection to the server timed out';
        break;

      case DioExceptionType.sendTimeout:
        message = 'Timeout occurred while sending the request';
        break;

      case DioExceptionType.receiveTimeout:
        message = 'Timeout occurred while receiving data from the server';
        break;

      case DioExceptionType.cancel:
        message = 'The request to the server was cancelled';
        break;

      case DioExceptionType.connectionError:
        if (dioException.error is SocketException) {
          message =
              'No internet connection. Please check your network settings';
        } else {
          message = 'Network connection error occurred';
        }
        break;

      case DioExceptionType.unknown:
        message = 'An unknown error occurred';
        break;
    }
  }

  @override
  List<Object?> get props => [message, statusCode];
}
