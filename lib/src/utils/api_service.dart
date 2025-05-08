import 'package:dio/dio.dart';

/// Service for handling API requests
class ApiService {
  final Dio _dio;

  /// Create a new API service with a configured Dio instance
  ApiService(this._dio);

  /// Factory constructor that creates a new instance with a base URL
  factory ApiService.withBaseUrl(String baseUrl, {List<Interceptor>? interceptors}) {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));
    if (interceptors != null) {
      dio.interceptors.addAll(interceptors);
    }
    return ApiService(dio);
  }

  /// Get the underlying Dio instance
  Dio get dio => _dio;

  /// Make a GET request
  Future<Map<String, dynamic>> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final resp = await _dio.get(
      endPoint,
      queryParameters: queryParameters,
      options: options,
    );
    return resp.data as Map<String, dynamic>;
  }

  /// Make a POST request
  Future<Map<String, dynamic>> post({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final resp = await _dio.post(
      endPoint,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return resp.data as Map<String, dynamic>;
  }

  /// Make a PUT request
  Future<Map<String, dynamic>> put({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final resp = await _dio.put(
      endPoint,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return resp.data as Map<String, dynamic>;
  }

  /// Make a DELETE request
  Future<Map<String, dynamic>> delete({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final resp = await _dio.delete(
      endPoint,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return resp.data as Map<String, dynamic>;
  }
}