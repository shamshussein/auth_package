import 'package:dartz/dartz.dart';
import '../errors/failure.dart';
import '../models/otp_response.dart';
import '../models/confirm_otp_response.dart';
import '../models/sign_up_response.dart';

abstract class AuthRepo {
  Future<Either<Failure, OtpResponse>> generateOtp({
    required String phoneNumber,
    required String countryCode,
  });

  Future<Either<Failure, ConfirmOtpResponse>> confirmOtp({
    required String phoneNumber,
    required String otp,
  });

  Future<Either<Failure, SignUpResponse>> signUp({
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required DateTime dob,
    required int genderId,
    required String countryCode,
  });

  Future<Either<Failure, void>> refreshFcmToken(String token);
}