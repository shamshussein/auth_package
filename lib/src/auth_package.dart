import 'package:dio/dio.dart';
import '../auth_package.dart';

/// Main entry point for configuring and initializing the auth package
class AuthPackage {
  static late final AuthConfig _config;
  static late final ApiService _apiService;
  static late final AuthRepo _authRepo;

  /// Initialize the auth package with configuration
  static void initialize({
    required String baseUrl,
    Map<String, String>? endpoints,
    List<Interceptor>? interceptors,
  }) {
    // Set up configuration
    _config = AuthConfig(
      baseUrl: baseUrl,
      endpoints: endpoints,
    );

    // Create API service with optional interceptors
    final dio = Dio(BaseOptions(baseUrl: _config.baseUrl));
    if (interceptors != null) {
      dio.interceptors.addAll(interceptors);
    }
    _apiService = ApiService(dio);

    // Initialize repositories
    _authRepo = AuthRepoImpl(_apiService, _config);
  }

  /// Get the configured auth repository
  static AuthRepo getAuthRepo() {
    _ensureInitialized();
    return _authRepo;
  }

  /// Get the configured API service
  static ApiService getApiService() {
    _ensureInitialized();
    return _apiService;
  }

  /// Get the current configuration
  static AuthConfig getConfig() {
    _ensureInitialized();
    return _config;
  }

  /// Ensure the package has been initialized
  static void _ensureInitialized() {
    if (!isInitialized) {
      throw StateError('AuthPackage not initialized. Call AuthPackage.initialize() first.');
    }
  }

  /// Check if the package has been initialized
  static bool get isInitialized =>
      _config != null && _apiService != null && _authRepo != null;
}