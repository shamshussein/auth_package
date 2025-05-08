import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/confirm_otp_response.dart';
import '../repos/auth_repo.dart';
import 'auth_providers.dart';

abstract class ConfirmOtpState extends Equatable {
  const ConfirmOtpState();
  @override
  List<Object?> get props => [];
}

class ConfirmOtpInitial extends ConfirmOtpState {}
class ConfirmOtpLoading extends ConfirmOtpState {}
class ConfirmOtpSuccess extends ConfirmOtpState {
  final ConfirmOtpResponse response;
  const ConfirmOtpSuccess(this.response);
  @override
  List<Object?> get props => [response];
}
class ConfirmOtpFailure extends ConfirmOtpState {
  final String error;
  const ConfirmOtpFailure(this.error);
  @override
  List<Object?> get props => [error];
}

class ConfirmOtpNotifier extends StateNotifier<ConfirmOtpState> {
  final AuthRepo _repo;

  ConfirmOtpNotifier(this._repo) : super(ConfirmOtpInitial());

  Future<void> confirmOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    state = ConfirmOtpLoading();
    final res = await _repo.confirmOtp(
      phoneNumber: phoneNumber,
      otp: otp,
    );

    res.fold(
          (fail) => state = ConfirmOtpFailure(fail.errMessage),
          (resp) => state = ConfirmOtpSuccess(resp),
    );
  }
}

final confirmOtpProvider = StateNotifierProvider<ConfirmOtpNotifier, ConfirmOtpState>((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return ConfirmOtpNotifier(authRepo);
});