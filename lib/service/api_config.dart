import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.3:5000',
    ),
  );

  static void setupInterceptors() {
    // Request interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print("Request Fireeeeeeeeeeeeeeee");
          // Modify request options before sending the request
          options.headers['Authorization'] = 'Bearer your_access_token';
          return handler.next(options);
        },
      ),
    );

    // Response interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          print("RESPONSE BLASTTTTTTTTTTTTTTTT");
          // Modify the response data before returning it
          // You can also handle errors here
          return handler.next(response);
        },
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) {
          print("ERROR DETECTED: $error.");
          // Handle the error here
          if (error.response?.statusCode == 401) {
            // Handle unauthorized error
            print("Unauthorized error");
          } else {
            // Handle other errors
            print("Other error: ${error.message}");
          }
          return handler.next(error);
        },
      ),
    );
  }

  static Dio get instance => _dio;
}
