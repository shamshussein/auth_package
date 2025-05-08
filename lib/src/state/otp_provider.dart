import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/otp_response.dart';
import '../repos/auth_repo.dart';
import 'auth_providers.dart';

abstract class OtpState extends Equatable {
  const OtpState();
  @override
  List<Object?> get props => [];
}

class OtpInitial extends OtpState {}
class OtpLoading extends OtpState {}
class OtpSuccess extends OtpState {
  final OtpResponse response;
  const OtpSuccess(this.response);
  @override
  List<Object?> get props => [response];
}
class OtpFailure extends OtpState {
  final String error;
  const OtpFailure(this.error);
  @override
  List<Object?> get props => [error];
}

class OtpNotifier extends StateNotifier<OtpState> {
  final AuthRepo _repo;

  OtpNotifier(this._repo) : super(OtpInitial());

  Future<void> generateOtp({
    required String phoneNumber,
    required String countryCode,
  }) async {
    state = OtpLoading();
    final res = await _repo.generateOtp(
      phoneNumber: phoneNumber,
      countryCode: countryCode,
    );

    res.fold(
          (fail) => state = OtpFailure(fail.errMessage),
          (resp) => state = OtpSuccess(resp),
    );
  }
}

final otpProvider = StateNotifierProvider<OtpNotifier, OtpState>((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return OtpNotifier(authRepo);
});