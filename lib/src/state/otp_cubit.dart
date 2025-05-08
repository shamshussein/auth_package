import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/otp_response.dart';
import '../repos/auth_repo.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final AuthRepo _repo;

  OtpCubit(this._repo) : super(OtpInitial());

  Future<void> generateOtp({
    required String phoneNumber,
    required String countryCode,
  }) async {
    emit(OtpLoading());
    final res = await _repo.generateOtp(
      phoneNumber: phoneNumber,
      countryCode: countryCode,
    );

    res.fold(
          (fail) => emit(OtpFailure(fail.errMessage)),
          (resp) => emit(OtpSuccess(resp)),
    );
  }
}