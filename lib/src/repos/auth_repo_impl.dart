import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../../auth_package.dart';

/// Implementation of the AuthRepo interface
class AuthRepoImpl implements AuthRepo {
  final ApiService _apiService;
  final AuthConfig _config;

  /// Constructor
  AuthRepoImpl(this._apiService, this._config);

  @override
  Future<Either<Failure, OtpResponse>> generateOtp({
    required String phoneNumber,
    required String countryCode,
  }) async {
    try {
      final res = await _apiService.post(
        endPoint: _config.getEndpoint('generateOtp'),
        data: {
          'PhoneNumber': phoneNumber,
          'CountryCode': countryCode,
        },
      );
      return Right(OtpResponse.fromJson(res));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ConfirmOtpResponse>> confirmOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      final res = await _apiService.post(
        endPoint: _config.getEndpoint('confirmOtp'),
        data: {
          'phoneNumber': phoneNumber,
          'otp': otp,
        },
      );
      return Right(ConfirmOtpResponse.fromJson(res));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
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
      final res = await _apiService.post(
        endPoint: _config.getEndpoint('signUp'),
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
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> refreshFcmToken(String token) async {
    try {
      await _apiService.put(
        endPoint: _config.getEndpoint('refreshFcmToken'),
        data: {
          'fcmToken': token,
        },
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}