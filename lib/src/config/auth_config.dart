
/// Configuration class for the auth package
class AuthConfig {
  /// Base URL for API calls
  final String baseUrl;

  /// Map of endpoint names to their paths
  final Map<String, String> endpoints;

  /// Default constructor
  AuthConfig({
    required this.baseUrl,
    Map<String, String>? endpoints,
  }) : endpoints = endpoints ?? _defaultEndpoints;

  /// Default endpoints if none are provided
  static const Map<String, String> _defaultEndpoints = {
    'generateOtp': 'Accounts/GenerateOtp',
    'confirmOtp': 'Accounts/ConfirmOtp',
    'signUp': 'Accounts/SignUserUp',
    'refreshFcmToken': 'Accounts/RefreshFcmToken',
  };

  /// Get an endpoint by name
  String getEndpoint(String name) {
    return endpoints[name] ?? _defaultEndpoints[name] ?? '';
  }
}