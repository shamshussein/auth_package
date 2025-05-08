import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../repos/auth_repo.dart';
import '../repos/auth_repo_impl.dart';
import '../utils/api_service.dart';
import '../config/auth_config.dart';

final authConfigProvider = Provider<AuthConfig>((ref) {
  throw UnimplementedError('authConfigProvider needs to be overridden');
});

final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(authConfigProvider);
  return Dio(BaseOptions(baseUrl: config.baseUrl));
});

final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

final authRepoProvider = Provider<AuthRepo>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthRepoImpl(apiService, ref.read(authConfigProvider));
});