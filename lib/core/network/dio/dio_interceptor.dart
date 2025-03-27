import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // This method is called before the request is sent.
    // Add common headers or modify the request if needed.
    options.headers.addAll({
      'Content-Type':
          'application/json', // Ensures all requests use JSON content type.
    });
    super.onRequest(options, handler); // Pass the request to the next handler.
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // This method is called when a response is received.
    // You can handle or modify the response globally if needed.
    super.onResponse(
        response, handler); // Pass the response to the next handler.
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // This method is called when an error occurs during the request or response.
    // Handle errors globally, such as logging or showing error messages.
    super.onError(err, handler); // Pass the error to the next handler.
  }
}
