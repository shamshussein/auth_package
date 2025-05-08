import 'package:dartz/dartz.dart';
import '../../auth_package.dart';

/// Interface for authentication operations
abstract class AuthRepo {
  /// Generate OTP for phone verification
  Future<Either<Failure, OtpResponse>> generateOtp({
    required String phoneNumber,
    required String countryCode,
  });

  /// Confirm OTP verification code
  Future<Either<Failure, ConfirmOtpResponse>> confirmOtp({
    required String phoneNumber,
    required String otp,
  });

  /// Sign up a new user
  Future<Either<Failure, SignUpResponse>> signUp({
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required DateTime dob,
    required int genderId,
    required String countryCode,
  });

  /// Refresh Firebase Cloud Messaging token
  Future<Either<Failure, void>> refreshFcmToken(String token);
}