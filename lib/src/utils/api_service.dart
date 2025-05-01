import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;
  ApiService(String baseUrl)
      : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    final resp = await _dio.get(endPoint);
    return resp.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    final resp = await _dio.post(endPoint, data: data);
    return resp.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    final resp = await _dio.put(endPoint, data: data);
    return resp.data as Map<String, dynamic>;
  }
}