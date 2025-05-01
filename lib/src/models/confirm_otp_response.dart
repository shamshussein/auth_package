class ConfirmOtpResponse {
  final String token;
  final bool isNewUser;
  final String phoneNumber;

  ConfirmOtpResponse({
    required this.token,
    required this.isNewUser,
    required this.phoneNumber,
  });

  factory ConfirmOtpResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data']['data'];
    return ConfirmOtpResponse(
      token: data['token'] ?? '',
      isNewUser: data['isNewUser'] ?? true,
      phoneNumber: data['phoneNumber'] ?? '',
    );
  }
}