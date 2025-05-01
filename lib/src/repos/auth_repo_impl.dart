import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../errors/failure.dart';
import '../models/otp_response.dart';
import '../models/confirm_otp_response.dart';
import '../models/sign_up_response.dart';
import '../utils/api_service.dart';
import 'auth_repo.dart';
import 'package:intl/intl.dart';
class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;
  AuthRepoImpl(this.apiService);

  @override
  Future<Either<Failure, OtpResponse>> generateOtp({
    required String phoneNumber,
    required String countryCode,
  }) async {
    try {
      final res = await apiService.post(
        endPoint: 'Accounts/GenerateOtp',
        data: { 'PhoneNumber': phoneNumber, 'CountryCode': countryCode },
      );
      return Right(OtpResponse.fromJson(res));
    } catch (e) {
      if (e is DioError) return Left(ServerFailure.fromDioError(e));
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ConfirmOtpResponse>> confirmOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      final res = await apiService.post(
        endPoint: 'Accounts/ConfirmOtp',
        data: { 'phoneNumber': phoneNumber, 'otp': otp },
      );
      return Right(ConfirmOtpResponse.fromJson(res));
    } catch (e) {
      if (e is DioError) return Left(ServerFailure.fromDioError(e));
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SignUpResponse>> signUp({
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required DateTime dob,
    required int genderId,
    required String countryCode,
  }) async {
    try {
      final dobStr = DateFormat('yyyy-MM-dd').format(dob);
      final res = await apiService.post(
        endPoint: 'Accounts/SignUserUp',
        data: {
          'PhoneNumber': phoneNumber,
          'FirstName': firstName,
          'LastName': lastName,
          'DOB': dobStr,
          'GenderId': genderId,
          'CountryCode': countryCode,
        },
      );
      return Right(SignUpResponse.fromJson(res));
    } catch (e) {
      if (e is DioError) return Left(ServerFailure.fromDioError(e));
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> refreshFcmToken(String token) async {
    try {
      await apiService.put(
        endPoint: 'Accounts/RefreshFcmToken',
        data: { 'fcmToken': token },
      );
      return const Right(null);
    } catch (e) {
      if (e is DioError) return Left(ServerFailure.fromDioError(e));
      return Left(ServerFailure(e.toString()));
    }
  }
}