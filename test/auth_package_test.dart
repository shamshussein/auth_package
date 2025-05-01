import 'package:flutter_test/flutter_test.dart';
import 'package:auth_package/src/models/otp_response.dart';

void main() {
  test('OtpResponse.fromJson handles missing fields', () {
    final json = <String, dynamic>{};
    final obj = OtpResponse.fromJson(json);
    expect(obj.message, '');
    expect(obj.success, false);
  });
}