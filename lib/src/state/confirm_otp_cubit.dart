import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/confirm_otp_response.dart';
import '../repos/auth_repo.dart';

part 'confirm_otp_state.dart';

class ConfirmOtpCubit extends Cubit<ConfirmOtpState> {
  final AuthRepo _repo;

  ConfirmOtpCubit(this._repo) : super(ConfirmOtpInitial());

  Future<void> confirmOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    emit(ConfirmOtpLoading());
    final res = await _repo.confirmOtp(
      phoneNumber: phoneNumber,
      otp: otp,
    );

    res.fold(
          (fail) => emit(ConfirmOtpFailure(fail.errMessage)),
          (resp) => emit(ConfirmOtpSuccess(resp)),
    );
  }
}