part of 'confirm_otp_cubit.dart';

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