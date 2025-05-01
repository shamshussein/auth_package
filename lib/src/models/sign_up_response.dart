class SignUpResponse {
  final String token;
  final String clientName;
  final bool isNewUser;
  final String phoneNumber;

  SignUpResponse({
    required this.token,
    required this.clientName,
    required this.isNewUser,
    required this.phoneNumber,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data']['data'];
    return SignUpResponse(
      token: data['token'] ?? '',
      clientName: data['clientName'] ?? '',
      isNewUser: data['isNewUser'] ?? false,
      phoneNumber: data['phoneNumber'] ?? '',
    );
  }
}